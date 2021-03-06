defmodule Slides.Parser do
  import NimbleParsec

  @space 0x0020
  @tab 0x009
  # @newline 10

  spacechar = utf8_char([@space, @tab])
  sp = optional(times(spacechar, min: 1))
  tag = ascii_string([?a..?z, ?A..?Z], min: 1)

  non_indented_space = [@space] |> utf8_char() |> times(max: 3)

  atx_start =
    non_indented_space
    |> optional()
    |> ignore()
    |> ascii_char([?#])
    |> times(min: 1, max: 6)
    |> reduce(:length)
    |> unwrap_and_tag(:level)

  atx_end =
    [@space]
    |> utf8_char()
    |> times(ascii_char([?#]), min: 1)
    |> concat(sp)
    |> choice([ascii_char([?\n]), eos()])

  heading =
    atx_start
    |> choice([
      [?\n] |> ascii_char() |> ignore(),
      [@space]
      |> utf8_char()
      |> ignore()
      |> repeat([not: ?\n] |> utf8_char() |> lookahead_not(string(" #")))
      |> optional([not: ?\n, not: ?\s] |> utf8_char() |> ignore(atx_end))
      |> optional(ascii_char([?\n]))
      |> reduce({List, :to_string, []})
      |> reduce(:trim)
    ])
    |> tag(:heading)

  defp trim([string]), do: String.trim(string)

  md_italic =
    ignore(string("_"))
    |> concat(tag)
    |> ignore(string("_"))
    |> tag(:italic)

  md_image =
    Slides.Utils.around_with_spaces("![", "]", ?])
    |> concat(Slides.Utils.around_with_spaces("(", ")", ?)))
    |> tag(:image)

  md_link =
    Slides.Utils.around_with_spaces("[", "]", ?])
    |> concat(Slides.Utils.around_with_spaces("(", ")", ?)))
    |> tag(:link)

  md_bold =
    ignore(string("*"))
    |> concat(tag)
    |> ignore(string("*"))
    |> tag(:bold)

  text = ascii_string([not: ?\n], min: 1) |> tag(:paragraph)

  defparsec(
    :from_md,
    choice([
      md_image,
      md_italic,
      md_bold,
      md_link,
      heading,
      atx_end,
      text
    ])
  )
end

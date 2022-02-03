defmodule Slides.Utils do
  import NimbleParsec

  def around_with_spaces(a, b, c) do
    ignore(string(a))
    |> concat(ascii_string([not: c], min: 1))
    |> ignore(string(b))
  end

  def around_without_spaces(a) do
    ignore(string(a))
    |> concat(ascii_string([?a..?z, ?A..?Z], min: 1))
    |> ignore(string(a))
  end
end

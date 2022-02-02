defmodule Slides.Utils do
  import NimbleParsec

  def around(a, b, c) do
    ignore(string(a))
    |> concat(ascii_string([not: c], min: 1))
    |> ignore(string(b))
  end
end

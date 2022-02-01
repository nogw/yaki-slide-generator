defmodule Yaki do
  def convertToHtml(input) do
    md = Yaki.Parser.from_md(input)
    |> elem(1)
    |> Enum.at(0)

    { a, b } = md
    Yaki.Generate.to_html(a, b)
  end

  def getFiles do
    files = Path.wildcard("./templates/*.md")

    for file <- files do
      IO.puts("\nfile: #{file}\n")
      File.stream!(file)
      |> Stream.map(fn (line) -> String.trim(line) |> convertToHtml end)
      |> Stream.run
    end
  end
end

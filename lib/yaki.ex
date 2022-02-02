defmodule Yaki do
  def convertToHtml(input) do
    md = Yaki.Parser.from_md(input)
    |> elem(1)
    |> Enum.at(0)

    { a, b } = md
    Yaki.Generate.to_html(a, b)
  end

  def getLines(file) do
    {:ok, contents} = File.read(file)
    String.split(contents, "\n", trim: true)
  end

  def getFiles, do: Path.wildcard("./templates/*.md")
end

Yaki.getFiles()
  |> Enum.map(&Yaki.getLines/1)
  |> Enum.at(1)
  |> Enum.map(&Yaki.Parser.from_md/1)
  |> IO.inspect()

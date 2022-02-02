defmodule SlidesWeb.Core do
  def convertToHtml(input) do
    md =
      SlidesWeb.Parser.from_md(input)
      |> elem(1)
      |> Enum.at(0)

    {a, b} = md
    SlidesWeb.Generate.to_html(a, b)
  end

  def getLines(file) do
    {:ok, contents} = File.read(file)
    String.split(contents, "\n", trim: true)
  end

  def getFiles, do: Path.wildcard("./templates/*.md")
end

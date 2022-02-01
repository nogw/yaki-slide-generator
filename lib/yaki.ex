defmodule Yaki do
  # alias Yaki.Parser, as: Parser
end

inputs = [
  "###### other text",
  "##### other text",
  "#### other text",
  "### other text",
  "## other text",
  "# other text",
  "_nic_",
  "*oomaga*",
  "![imageofnic](image)",
  "[nics](http)"
]

for input <- inputs do
  md = Yaki.Parser.from_md(input)
  |> elem(1)
  |> Enum.at(0)

  { a, b } = md
  Yaki.Generate.to_html(a, b)
end

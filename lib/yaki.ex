defmodule Yaki do
  # alias Yaki.Parser, as: Parser
end

inputs = [
  "### other text",
  "### ocaml",
  "_nic_",
  "*oomaga*",
  "![imageofnic](image)",
  "[nics](http)"
]

for input <- inputs do
  IO.inspect(Yaki.Parser.from_md(input) |> elem(1) |> Enum.at(0) |> elem(0))
end

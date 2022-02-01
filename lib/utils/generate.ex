defmodule Yaki.Generate do
  def to_html(type, content) do
    case { type, content } do
      {:heading, [{ _, n }, b]} -> IO.puts("<h#{n}>#{b}</h#{n}>")
      {:image, [alt, src]} -> IO.puts("<img alt=\"#{alt}\" src=\"#{src}\"/>")
      {:link, [txt, src]} -> IO.puts("<a href=\"#{src}\">#{txt}</a>")
      {:italic, [txt]} -> IO.puts("<em>#{txt}<em>")
      {:bold, [txt]} -> IO.puts("<strong>#{txt}<strong>")
      _ -> IO.puts("sexo fail")
    end
  end
end

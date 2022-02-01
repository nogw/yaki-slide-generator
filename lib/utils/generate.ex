defmodule Yaki.Generate do
  def to_html(type, content) do
    case { type, content } do
      {:heading, [{ _, n }, b]} -> IO.puts("<h#{n}>#{b}</h#{n}>")
      {:image, [alt, src]} -> IO.puts("<img alt=\"#{alt}\" src=\"#{src}\"/>")
      {:link, [txt, src]} -> IO.puts("<a href=\"#{src}\">#{txt}</a>")
      {:bold, [txt]} -> IO.puts("<strong>#{txt}<strong>")
      {:paragraph, [txt]} -> IO.puts("<p>#{txt}<p>")
      {:italic, [txt]} -> IO.puts("<em>#{txt}<em>")
      _ -> IO.puts("sexo fail")
    end
  end
end

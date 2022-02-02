defmodule SlidesWeb.Generate do
  def to_html(type, content) do
    case {type, content} do
      {:heading, [{_, n}, b]} -> "<h#{n}>#{b}</h#{n}>"
      {:image, [alt, src]} -> "<img alt=\"#{alt}\" src=\"#{src}\"/>"
      {:link, [txt, src]} -> "<a href=\"#{src}\">#{txt}</a>"
      {:bold, [txt]} -> "<strong>#{txt}</strong>"
      {:paragraph, [txt]} -> "<p>#{txt}</p>"
      {:italic, [txt]} -> "<em>#{txt}</em>"
      _ -> "sexo fail"
    end
  end
end

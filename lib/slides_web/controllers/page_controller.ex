defmodule SlidesWeb.PageController do
  use SlidesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def slide(conn, %{"slide" => slide}) do
    pages = SlidesWeb.Core.getFiles()

    content =
      SlidesWeb.Core.getLines("./templates/slide0#{slide}.md")
      |> Enum.map(&SlidesWeb.Core.convertToHtml/1)

    conn
    |> assign(:slide, slide)
    |> assign(:content, content)
    |> assign(:pages, pages)
    |> render("slide.html")
  end
end

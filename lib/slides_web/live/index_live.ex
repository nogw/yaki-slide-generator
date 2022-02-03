defmodule SlidesWeb.IndexLive do
  use SlidesWeb, :live_view

  def getContent(slide),
    do:
      SlidesWeb.Core.getLines("./templates/slide0#{slide}.md")
      |> Enum.map(&SlidesWeb.Core.convertToHtml/1)

  @impl true
  def mount(_params, _session, socket) do
    pages = SlidesWeb.Core.getFiles()

    content = getContent(1)

    {:ok,
     assign(
       socket,
       slide: 0,
       content: content,
       pages: pages,
       isOpen: true,
       error: ""
     )}
  end

  @impl true
  def handle_event("change_slide", %{"ref" => ref}, socket) do
    IO.puts(ref)
    {:noreply, assign(socket, content: getContent(ref))}
  end

  def handle_event("toggle_menu", _, socket) do
    {:noreply, assign(socket, isOpen: !socket.assigns.isOpen)}
  end
end

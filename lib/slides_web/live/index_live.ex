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
       slide: 1,
       content: content,
       pages: pages,
       isOpen: false,
       error: ""
     )}
  end

  @impl true
  def handle_event("change_slide", %{"ref" => ref}, socket) do
    {:noreply, assign(socket, content: getContent(ref), slide: String.to_integer(ref))}
  end

  def handle_event("toggle_menu", _, socket) do
    {:noreply, assign(socket, isOpen: !socket.assigns.isOpen)}
  end

  def handle_event("key_change_slide", %{"key" => "ArrowUp"}, socket) do
    slideS = socket.assigns.slide
    slideN = if slideS >= 2, do: slideS - 1, else: length(socket.assigns.pages)
    IO.inspect(slideS)
    {:noreply, assign(socket, content: getContent(slideN), slide: slideN)}
  end

  def handle_event("key_change_slide", %{"key" => "ArrowDown"}, socket) do
    slideS = socket.assigns.slide
    slideN = if slideS == length(socket.assigns.pages), do: 1, else: slideS + 1
    {:noreply, assign(socket, content: getContent(slideN), slide: slideN)}
  end

  def handle_event("key_change_slide", _key, socket) do
    {:noreply, socket}
  end
end

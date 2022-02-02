defmodule Slides.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SlidesWeb.Telemetry,
      {Phoenix.PubSub, name: Slides.PubSub},
      SlidesWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Slides.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    SlidesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

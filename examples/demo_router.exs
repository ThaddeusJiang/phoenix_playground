#!/usr/bin/env elixir
Mix.install([
  {:phoenix_playground, "~> 0.1.5"}
])

defmodule CounterLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <span><%= @count %></span>
    <button phx-click="inc">+</button>
    <button phx-click="dec">-</button>

    <style type="text/css">
      body { padding: 1em; }
    </style>
    """
  end

  def handle_event("inc", _params, socket) do
    {:noreply, assign(socket, count: socket.assigns.count + 1)}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, assign(socket, count: socket.assigns.count - 1)}
  end
end

defmodule DemoRouter do
  use Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_root_layout, html: {PhoenixPlayground.Layouts, :root}
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :browser

    live_session :default, layout: {PhoenixPlayground.Layouts, :live} do
      live "/", CounterLive
    end
  end
end

PhoenixPlayground.start(plug: DemoRouter)

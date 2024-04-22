#!/usr/bin/env elixir
Mix.install([
  {:phoenix_playground, "~> 0.1.0"}
])

defmodule DemoLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <span><%= @count %></span>
    <button phx-click="inc">+</button>
    <button phx-click="dec">-</button>

    <p>Now edit <code><%= __ENV__.file %>:<%= __ENV__.line %></code> in your editor...</p>

    <style type="text/css">
      body { padding: 1em; }
      span { font-family: monospace; }
      p { margin-top: 1em; }
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

PhoenixPlayground.start(live: DemoLive)
unless IEx.started?(), do: Process.sleep(:infinity)

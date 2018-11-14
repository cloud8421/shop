defmodule Front.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Adapters.Cowboy, scheme: :http, plug: Front.Router, options: [port: port()]}
    ]

    opts = [strategy: :one_for_one, name: Front.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port do
    Application.get_env(:front, :http_port, 4000)
  end
end

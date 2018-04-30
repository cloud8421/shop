defmodule Front.AssignStore do
  def init(opts), do: opts

  def call(conn, _opts) do
    if Map.get(conn.private, :store) do
      conn
    else
      Plug.Conn.put_private(conn, :store, Store)
    end
  end
end

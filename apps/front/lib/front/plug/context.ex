defmodule Front.Plug.Context do
  def init(opts), do: opts

  def call(conn, _opts), do: with_defaults(conn)

  def with_defaults(conn) do
    Plug.Conn.put_private(conn, :context, Front.Context.new())
  end

  def with_overrides(conn, overrides) do
    Plug.Conn.put_private(conn, :context, Front.Context.new(overrides))
  end
end

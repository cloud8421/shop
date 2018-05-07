defmodule Front.Plug.Context do
  def init(opts), do: opts

  def call(conn, _opts), do: with_defaults(conn)

  def with_defaults(conn) do
    Plug.Conn.put_private(conn, :context, %Front.Context{})
  end

  def with_overrides(conn, overrides) do
    context = struct(Front.Context, overrides)
    Plug.Conn.put_private(conn, :context, context)
  end

  def assign(conn, key, value) do
    new_context = %{conn.private.context | key => value}
    Plug.Conn.put_private(conn, :context, new_context)
  end
end

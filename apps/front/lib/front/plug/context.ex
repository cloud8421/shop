defmodule Front.Plug.Context do
  def init(opts), do: opts

  def call(conn, _opts) do
    Plug.Conn.put_private(conn, :context, %Front.Context{})
  end

  def assign(conn, key, value) do
    new_context = %{conn.private.context | key => value}
    Plug.Conn.put_private(conn, :context, new_context)
  end
end

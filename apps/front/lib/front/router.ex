defmodule Front.Router do
  @moduledoc false

  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  forward "/products", to: Front.Router.Product
  forward "/reports", to: Front.Router.Report

  match _ do
    send_resp(conn, 404, "not found")
  end
end

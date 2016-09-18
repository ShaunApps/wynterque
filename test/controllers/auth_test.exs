defmodule Wynterque.AuthTest do
  use Wynterque.ConnCase
  alias Wynterque.Auth

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(Wynterque.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "authenticate_user halts when no current_user exists",
    %{conn: conn} do
      conn = Auth.authenticate_user(conn, [])
      assert conn.halted
  end

  test "authenticate_user continues when the current_user exists",
    %{conn: conn} do

    conn =
      conn
      |> assign(:current_user, %Wynterque.User{})
      |> Auth.authenticate_user([])

    refute conn.halted
  end
end

defmodule Wynterque.JobpostControllerTest do
  use Wynterque.ConnCase

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, jobpost_path(conn, :new)),
      get(conn, jobpost_path(conn, :index)),
      get(conn, jobpost_path(conn, :show, "123")),
      get(conn, jobpost_path(conn, :edit, "123")),
      put(conn, jobpost_path(conn, :update, "123", %{})),
      post(conn, jobpost_path(conn, :create, %{})),
      delete(conn, jobpost_path(conn, :delete, "123")),
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end)
  end
end

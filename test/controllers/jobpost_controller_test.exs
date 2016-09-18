defmodule Wynterque.JobpostControllerTest do
  use Wynterque.ConnCase

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  @tag login_as: "max"
  test "lists all user's videos on index", %{conn: conn, user: user} do
    user_jobpost = insert_jobpost(user, title: "Javascript Developer")
    other_jobpost = insert_jobpost(insert_user(username: "other"), title: "another job")

    conn = get conn, jobpost_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Job Postings/
    assert String.contains?(conn.resp_body, user_jobpost.title)
    refute String.contains?(conn.resp_body, other_jobpost.title)
  end

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

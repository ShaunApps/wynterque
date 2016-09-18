defmodule Wynterque.JobpostControllerTest do
  use Wynterque.ConnCase

  alias Wynterque.Jobpost
  @valid_attrs %{url: "www.indeed.com", title: "job", description: "a job"}
  @invalid_attrs %{title: "invalid"}

  defp job_count(query), do: Repo.one(from v in query, select: count(v.id))


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
  test "authorizes actions against access by other users",
    %{user: owner, conn: conn} do

    jobpost = insert_jobpost(owner, @valid_attrs)
    non_owner = insert_user(username: "sneaky")
    conn = assign(conn, :current_user, non_owner)

    assert_error_sent :not_found, fn ->
      get(conn, jobpost_path(conn, :show, jobpost))
    end
    assert_error_sent :not_found, fn ->
      get(conn, jobpost_path(conn, :edit, jobpost))
    end
    assert_error_sent :not_found, fn ->
      put(conn, jobpost_path(conn, :update, jobpost, jobpost: @valid_attrs))
    end
    assert_error_sent :not_found, fn ->
      delete(conn, jobpost_path(conn, :delete, jobpost))
    end
  end

  @tag login_as: "max"
  test "lists all user's jobposts on index", %{conn: conn, user: user} do
    user_jobpost = insert_jobpost(user, title: "Javascript Developer")
    other_jobpost = insert_jobpost(insert_user(username: "other"), title: "another job")

    conn = get conn, jobpost_path(conn, :index)
    assert html_response(conn, 200) =~ ~r/Job Postings/
    assert String.contains?(conn.resp_body, user_jobpost.title)
    refute String.contains?(conn.resp_body, other_jobpost.title)
  end

  @tag login_as: "max"
  test "creates user jobpost and redirects", %{conn: conn, user: user} do
    conn = post conn, jobpost_path(conn, :create), jobpost: @valid_attrs
    assert redirected_to(conn) == jobpost_path(conn, :index)
    assert Repo.get_by!(Jobpost, @valid_attrs).user_id == user.id
  end

  @tag login_as: "max"
  test "does not create video and renders errors when invalid", %{conn: conn} do
    count_before = job_count(Jobpost)
    conn = post conn, jobpost_path(conn, :create), jobpost: @invalid_attrs
    assert html_response(conn, 200) =~ "check the errors"
    assert job_count(Jobpost) == count_before
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

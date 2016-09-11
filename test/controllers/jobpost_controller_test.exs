defmodule Wynterque.JobpostControllerTest do
  use Wynterque.ConnCase

  alias Wynterque.Jobpost
  @valid_attrs %{" title": "some content", contact: "some content", description: "some content", email: "some content", location: "some content", organization: "some content", url: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, jobpost_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing jobposts"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, jobpost_path(conn, :new)
    assert html_response(conn, 200) =~ "New jobpost"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, jobpost_path(conn, :create), jobpost: @valid_attrs
    assert redirected_to(conn) == jobpost_path(conn, :index)
    assert Repo.get_by(Jobpost, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, jobpost_path(conn, :create), jobpost: @invalid_attrs
    assert html_response(conn, 200) =~ "New jobpost"
  end

  test "shows chosen resource", %{conn: conn} do
    jobpost = Repo.insert! %Jobpost{}
    conn = get conn, jobpost_path(conn, :show, jobpost)
    assert html_response(conn, 200) =~ "Show jobpost"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, jobpost_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    jobpost = Repo.insert! %Jobpost{}
    conn = get conn, jobpost_path(conn, :edit, jobpost)
    assert html_response(conn, 200) =~ "Edit jobpost"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    jobpost = Repo.insert! %Jobpost{}
    conn = put conn, jobpost_path(conn, :update, jobpost), jobpost: @valid_attrs
    assert redirected_to(conn) == jobpost_path(conn, :show, jobpost)
    assert Repo.get_by(Jobpost, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    jobpost = Repo.insert! %Jobpost{}
    conn = put conn, jobpost_path(conn, :update, jobpost), jobpost: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit jobpost"
  end

  test "deletes chosen resource", %{conn: conn} do
    jobpost = Repo.insert! %Jobpost{}
    conn = delete conn, jobpost_path(conn, :delete, jobpost)
    assert redirected_to(conn) == jobpost_path(conn, :index)
    refute Repo.get(Jobpost, jobpost.id)
  end
end

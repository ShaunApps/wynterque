defmodule Wynterque.JobpostViewTest do
  use Wynterque.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    jobposts = [%Wynterque.Jobpost{id: "1", title: "ruby developer"},
                %Wynterque.Jobpost{id: "2", title: "javascript developer"}]
    content = render_to_string(Wynterque.JobpostView, "index.html",
                               conn: conn, jobposts: jobposts)

    assert String.contains?(content, "Job Postings")
    for jobpost <- jobposts do
      assert String.contains?(content, jobpost.title)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Wynterque.Jobpost.changeset(%Wynterque.Jobpost{})
    categories = [{"python", 123}]
    content = render_to_string(Wynterque.JobpostView, "new.html",
      conn: conn, changeset: changeset, categories: categories)

    assert String.contains?(content, "New Job Post")
  end
end

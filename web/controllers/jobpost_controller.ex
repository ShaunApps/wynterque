defmodule Wynterque.JobpostController do
  use Wynterque.Web, :controller

  alias Wynterque.Jobpost

  def index(conn, _params, user) do
    jobposts = Repo.all(user_jobposts(user))
    render(conn, "index.html", jobposts: jobposts)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> build_assoc(:jobposts)
      |> Jobpost.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"jobpost" => jobpost_params}, user) do
    changeset =
      user
      |> build_assoc(:jobposts)
      |> Jobpost.changeset(jobpost_params)

    case Repo.insert(changeset) do
      {:ok, _jobpost} ->
        conn
        |> put_flash(:info, "Jobpost created successfully.")
        |> redirect(to: jobpost_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, conn.assigns.current_user])
  end

  def show(conn, %{"id" => id}, user) do
    jobpost = Repo.get!(user_jobposts(user), id)
    render(conn, "show.html", jobpost: jobpost)
  end

  def edit(conn, %{"id" => id}) do
    jobpost = Repo.get!(Jobpost, id)
    changeset = Jobpost.changeset(jobpost)
    render(conn, "edit.html", jobpost: jobpost, changeset: changeset)
  end

  def update(conn, %{"id" => id, "jobpost" => jobpost_params}) do
    jobpost = Repo.get!(Jobpost, id)
    changeset = Jobpost.changeset(jobpost, jobpost_params)

    case Repo.update(changeset) do
      {:ok, jobpost} ->
        conn
        |> put_flash(:info, "Jobpost updated successfully.")
        |> redirect(to: jobpost_path(conn, :show, jobpost))
      {:error, changeset} ->
        render(conn, "edit.html", jobpost: jobpost, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    jobpost = Repo.get!(user_jobposts(user), id)
    Repo.delete!(jobpost)

    conn
    |> put_flash(:info, "Jobpost deleted successfully.")
    |> redirect(to: jobpost_path(conn, :index))
  end

  defp user_jobposts(user) do
    assoc(user, :jobposts)
  end
end

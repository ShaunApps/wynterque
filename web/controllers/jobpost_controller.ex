defmodule Wynterque.JobpostController do
  use Wynterque.Web, :controller

  alias Wynterque.Jobpost

  def index(conn, _params) do
    jobposts = Repo.all(Jobpost)
    render(conn, "index.html", jobposts: jobposts)
  end

  def new(conn, _params) do
    changeset = Jobpost.changeset(%Jobpost{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"jobpost" => jobpost_params}) do
    changeset = Jobpost.changeset(%Jobpost{}, jobpost_params)

    case Repo.insert(changeset) do
      {:ok, _jobpost} ->
        conn
        |> put_flash(:info, "Jobpost created successfully.")
        |> redirect(to: jobpost_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    jobpost = Repo.get!(Jobpost, id)
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

  def delete(conn, %{"id" => id}) do
    jobpost = Repo.get!(Jobpost, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(jobpost)

    conn
    |> put_flash(:info, "Jobpost deleted successfully.")
    |> redirect(to: jobpost_path(conn, :index))
  end
end

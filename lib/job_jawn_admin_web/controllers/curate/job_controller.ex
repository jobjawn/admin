defmodule JJWeb.Curate.JobController do
  use JJWeb, :controller

  alias JJ.Curate
  alias JJ.Curate.Job

  def index(conn, _params) do
    jobs = Curate.list_jobs()
    render(conn, "index.html", jobs: jobs)
  end

  def new(conn, %{"company_id" => slug}) do
    company = Curate.get_company_by_slug!(slug)
    changeset = Curate.change_job(%Job{})
    render(conn, "new.html", changeset: changeset, company: company)
  end

  def create(conn, %{"company_id" => slug, "job" => job_params}) do
    company = Curate.get_company_by_slug!(slug)

    job_params
    |> Map.put("company_id", company.id)
    |> Map.put("user_id", conn.assigns.current_user.id)
    |> Curate.create_job()
    |> case do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job created successfully.")
        |> redirect(to: Routes.curate_company_path(conn, :show, company.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    job = Curate.get_job!(id)
    render(conn, "show.html", job: job)
  end

  def edit(conn, %{"id" => id}) do
    job = Curate.get_job!(id)
    changeset = Curate.change_job(job)
    render(conn, "edit.html", job: job, changeset: changeset)
  end

  def update(conn, %{"id" => id, "job" => job_params}) do
    job = Curate.get_job!(id)

    case Curate.update_job(job, job_params) do
      {:ok, job} ->
        conn
        |> put_flash(:info, "Job updated successfully.")
        |> redirect(to: Routes.curate_job_path(conn, :show, job))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", job: job, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    job = Curate.get_job!(id)
    {:ok, _job} = Curate.delete_job(job)

    conn
    |> put_flash(:info, "Job deleted successfully.")
    |> redirect(to: Routes.curate_job_path(conn, :index))
  end
end

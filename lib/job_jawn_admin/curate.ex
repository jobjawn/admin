defmodule JJ.Curate do
  @moduledoc """
  The Curate context.
  """

  import Ecto.Query, warn: false

  alias JJ.Curate.Company
  alias JJ.Curate.CompanyData
  alias JJ.Repo

  @doc """
  Returns the list of company_data.

  ## Examples

      iex> list_companies()
      [%CompanyData{}, ...]

  """
  def list_companies do
    Company
    |> join(:inner, [c], d in subquery(most_recent_company_data_query()), on: d.company_id == c.id)
    |> select([c, d], %{c | jobs_url: d.jobs_url, name: d.name, url: d.url})
    |> Repo.all()
  end

  @doc """
  Gets a single company_data.

  Raises `Ecto.NoResultsError` if the Company data does not exist.

  ## Examples

      iex> get_company_by_slug!(123)
      %CompanyData{}

      iex> get_company_by_slug!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company_by_slug!(slug) do
    Company
    |> where([c], c.slug == ^slug)
    |> join(:inner, [c], d in CompanyData, on: d.company_id == c.id)
    |> order_by([c, d], desc: d.inserted_at)
    |> limit(1)
    |> select([c, d], %{c | jobs_url: d.jobs_url, name: d.name, url: d.url})
    |> Repo.one()
  end

  @doc """
  Creates a company_data.

  ## Examples

      iex> create_company_data(%{field: value})
      {:ok, %CompanyData{}}

      iex> create_company_data(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company_data(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company_data.

  ## Examples

      iex> update_company_data(company_data, %{field: new_value})
      {:ok, %CompanyData{}}

      iex> update_company_data(company_data, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company_data(attrs, company) do
    %CompanyData{company_id: company.id}
    |> CompanyData.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a CompanyData.

  ## Examples

      iex> delete_company_data(company_data)
      {:ok, %CompanyData{}}

      iex> delete_company_data(company_data)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company_data(%CompanyData{} = company_data) do
    Repo.delete(company_data)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company_data changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{source: %Company{}}

  """
  def change_company(%Company{} = company_data) do
    Company.changeset(company_data, %{})
  end

  def edit_company_changeset(%Company{} = company) do
    %CompanyData{
      jobs_url: company.jobs_url,
      name: company.name,
      url: company.url,
      company_id: company.id
    }
    |> CompanyData.changeset(%{})
  end

  alias JJ.Curate.Job

  @doc """
  Returns the list of jobs.

  ## Examples

      iex> list_jobs()
      [%Job{}, ...]

  """
  def list_jobs do
    Repo.all(Job)
  end

  @doc """
  Gets a single job.

  Raises `Ecto.NoResultsError` if the Job does not exist.

  ## Examples

      iex> get_job!(123)
      %Job{}

      iex> get_job!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job!(id), do: Repo.get!(Job, id)

  @doc """
  Creates a job.

  ## Examples

      iex> create_job(%{field: value})
      {:ok, %Job{}}

      iex> create_job(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job(attrs \\ %{}) do
    %Job{}
    |> Job.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job.

  ## Examples

      iex> update_job(job, %{field: new_value})
      {:ok, %Job{}}

      iex> update_job(job, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job(%Job{} = job, attrs) do
    job
    |> Job.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Job.

  ## Examples

      iex> delete_job(job)
      {:ok, %Job{}}

      iex> delete_job(job)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job(%Job{} = job) do
    Repo.delete(job)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job changes.

  ## Examples

      iex> change_job(job)
      %Ecto.Changeset{source: %Job{}}

  """
  def change_job(%Job{} = job) do
    Job.changeset(job, %{})
  end

  defp most_recent_company_data_query do
    CompanyData
    |> where(
      [d],
      d.inserted_at ==
        fragment(
          "select max(dat.inserted_at) from company_data dat where dat.company_id = ?",
          d.company_id
        )
    )
    |> select([d], d)
  end
end

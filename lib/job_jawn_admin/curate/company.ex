defmodule JJ.Curate.Company do
  @moduledoc """
  Represents a company.

  jobs_url, name, and url come from the CompanyData relagtionship - which is
  has_many but we typically just count the most recent entry.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias JJ.Curate.CompanyData

  schema "companies" do
    field :active, :boolean, default: true
    field :last_scan, :utc_datetime
    field :slug, :string
    field :jobs_url, :string, virtual: true
    field :name, :string, virtual: true
    field :url, :string, virtual: true

    has_many :company_data, CompanyData

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:slug])
    |> validate_required([:slug])
    |> validate_exclusion(:slug, [:edit, :new])
    |> unique_constraint(:slug)
    |> put_change(:last_scan, current_time())
    |> Ecto.Changeset.put_assoc(:company_data, new_company_data(attrs))
  end

  defp current_time do
    "Etc/UTC"
    |> DateTime.now()
    |> elem(1)
    |> DateTime.truncate(:second)
  end

  defp new_company_data(attrs) do
    [CompanyData.changeset(%CompanyData{}, attrs)]
  end
end

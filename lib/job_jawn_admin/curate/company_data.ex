defmodule JJ.Curate.CompanyData do
  @moduledoc """
  Company data.

  It's expected the data here would be accessed through the related
  company. This setup allows us to accomodates examples like Electronic Ink
  (which became Liquid Hub and later Capgemini) and allows us to continue to
  track jobs for that organization through the original slug separately from the
  new parent organization.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias JJ.Curate.Admin
  alias JJ.Curate.Company

  schema "company_data" do
    field :jobs_url, :string
    field :name, :string
    field :url, :string

    belongs_to :company, Company
    belongs_to :user, Admin

    timestamps()
  end

  @doc false
  def changeset(company_data, attrs) do
    company_data
    |> cast(attrs, [:name, :url, :jobs_url, :user_id])
    |> validate_required([:name, :url, :jobs_url, :user_id])
  end
end

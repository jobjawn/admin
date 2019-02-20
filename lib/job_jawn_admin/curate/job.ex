defmodule JJ.Curate.Job do
  @moduledoc """
  Information for job openings
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias JJ.Curate.Company
  alias JJ.Curate.User

  schema "jobs" do
    field :active, :boolean, default: false
    field :employment_type, :string
    field :found, :utc_datetime
    field :name, :string
    field :url, :string
    belongs_to :company, Company
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :url, :company_id, :user_id])
    |> validate_required([:name, :url, :company_id, :user_id])
    |> put_change(:found, current_time())
  end

  defp current_time do
    "Etc/UTC"
    |> DateTime.now()
    |> elem(1)
    |> DateTime.truncate(:second)
  end
end

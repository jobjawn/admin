defmodule JJ.Curate.Job do
  @moduledoc """
  Information for job openings
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :active, :boolean, default: false
    field :employment_type, :string
    field :found, :utc_datetime
    field :name, :string
    field :url, :string
    field :company_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :url, :found, :active, :employment_type])
    |> validate_required([:name, :url, :found, :active, :employment_type])
  end
end

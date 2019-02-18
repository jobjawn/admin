defmodule JJ.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :name, :string
      add :url, :string
      add :found, :utc_datetime
      add :active, :boolean, default: false, null: false
      add :employment_type, :string
      add :company_id, references(:companies, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:jobs, [:company_id])
    create index(:jobs, [:user_id])
  end
end

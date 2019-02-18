defmodule JJ.Repo.Migrations.CreateCompanyData do
  use Ecto.Migration

  def change do
    create table(:company_data) do
      add :name, :string
      add :url, :string
      add :jobs_url, :string
      add :company_id, references(:companies, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:company_data, [:company_id])
    create index(:company_data, [:user_id])
  end
end

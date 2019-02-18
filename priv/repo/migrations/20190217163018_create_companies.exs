defmodule JJ.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :slug, :string
      add :last_scan, :utc_datetime
      add :active, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:companies, [:slug])
  end
end

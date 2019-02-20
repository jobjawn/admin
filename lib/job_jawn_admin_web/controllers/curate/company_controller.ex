defmodule JJWeb.Curate.CompanyController do
  use JJWeb, :controller

  alias JJ.Curate
  alias JJ.Curate.Company

  def index(conn, _params) do
    companies = Curate.list_companies()
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Curate.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    company_params
    |> Map.put("user_id", conn.assigns.current_user.id)
    |> Curate.create_company_data()
    |> case do
      {:ok, company_data} ->
        conn
        |> put_flash(:info, "Company data created successfully.")
        |> redirect(to: Routes.curate_company_path(conn, :show, company_data))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Curate.get_company_by_slug!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company_data = Curate.get_company_by_slug!(id)
    changeset = Curate.edit_company_changeset(company_data)
    render(conn, "edit.html", company_data: company_data, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company_data" => company_data_params}) do
    company = Curate.get_company_by_slug!(id)

    company_data_params
    |> Map.put("user_id", conn.assigns.current_user.id)
    |> Curate.update_company_data(company)
    |> case do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Company data updated successfully.")
        |> redirect(to: Routes.curate_company_path(conn, :show, company.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company_data: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Curate.get_company_by_slug!(id)
    {:ok, _company_data} = Curate.delete_company(company)

    conn
    |> put_flash(:info, "Company data deleted successfully.")
    |> redirect(to: Routes.curate_company_path(conn, :index))
  end
end

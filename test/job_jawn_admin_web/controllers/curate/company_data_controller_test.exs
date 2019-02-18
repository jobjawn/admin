defmodule JJWeb.Curate.CompanyDataControllerTest do
  use JJWeb.ConnCase

  alias JJ.Curate

  @create_attrs %{jobs_url: "some jobs_url", name: "some name", url: "some url"}
  @update_attrs %{
    jobs_url: "some updated jobs_url",
    name: "some updated name",
    url: "some updated url"
  }
  @invalid_attrs %{jobs_url: nil, name: nil, url: nil}

  def fixture(:company_data) do
    {:ok, company_data} = Curate.create_company_data(@create_attrs)
    company_data
  end

  describe "index" do
    test "lists all company_data", %{conn: conn} do
      conn = get(conn, Routes.curate_company_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Company data"
    end
  end

  describe "new company_data" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.curate_company_path(conn, :new))
      assert html_response(conn, 200) =~ "New Company data"
    end
  end

  describe "create company_data" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.curate_company_path(conn, :create), company_data: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.curate_company_path(conn, :show, id)

      conn = get(conn, Routes.curate_company_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Company data"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.curate_company_path(conn, :create), company_data: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Company data"
    end
  end

  describe "edit company_data" do
    setup [:create_company_data]

    test "renders form for editing chosen company_data", %{conn: conn, company_data: company_data} do
      conn = get(conn, Routes.curate_company_path(conn, :edit, company_data))
      assert html_response(conn, 200) =~ "Edit Company data"
    end
  end

  describe "update company_data" do
    setup [:create_company_data]

    test "redirects when data is valid", %{conn: conn, company_data: company_data} do
      conn =
        put(conn, Routes.curate_company_path(conn, :update, company_data),
          company_data: @update_attrs
        )

      assert redirected_to(conn) == Routes.curate_company_path(conn, :show, company_data)

      conn = get(conn, Routes.curate_company_path(conn, :show, company_data))
      assert html_response(conn, 200) =~ "some updated jobs_url"
    end

    test "renders errors when data is invalid", %{conn: conn, company_data: company_data} do
      conn =
        put(conn, Routes.curate_company_path(conn, :update, company_data),
          company_data: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Company data"
    end
  end

  describe "delete company_data" do
    setup [:create_company_data]

    test "deletes chosen company_data", %{conn: conn, company_data: company_data} do
      conn = delete(conn, Routes.curate_company_path(conn, :delete, company_data))
      assert redirected_to(conn) == Routes.curate_company_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.curate_company_path(conn, :show, company_data))
      end
    end
  end

  defp create_company_data(_) do
    company_data = fixture(:company_data)
    {:ok, company_data: company_data}
  end
end

defmodule JJ.CurateTest do
  use JJ.DataCase

  alias JJ.Curate

  describe "company_data" do
    alias JJ.Curate.CompanyData

    @valid_attrs %{jobs_url: "some jobs_url", name: "some name", url: "some url"}
    @update_attrs %{
      jobs_url: "some updated jobs_url",
      name: "some updated name",
      url: "some updated url"
    }
    @invalid_attrs %{jobs_url: nil, name: nil, url: nil}

    def company_data_fixture(attrs \\ %{}) do
      {:ok, company_data} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Curate.create_company_data()

      company_data
    end

    test "list_company_data/0 returns all company_data" do
      company_data = company_data_fixture()
      assert Curate.list_company_data() == [company_data]
    end

    test "get_company_data!/1 returns the company_data with given id" do
      company_data = company_data_fixture()
      assert Curate.get_company_data!(company_data.id) == company_data
    end

    test "create_company_data/1 with valid data creates a company_data" do
      assert {:ok, %CompanyData{} = company_data} = Curate.create_company_data(@valid_attrs)
      assert company_data.jobs_url == "some jobs_url"
      assert company_data.name == "some name"
      assert company_data.url == "some url"
    end

    test "create_company_data/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Curate.create_company_data(@invalid_attrs)
    end

    test "update_company_data/2 with valid data updates the company_data" do
      company_data = company_data_fixture()

      assert {:ok, %CompanyData{} = company_data} =
               Curate.update_company_data(company_data, @update_attrs)

      assert company_data.jobs_url == "some updated jobs_url"
      assert company_data.name == "some updated name"
      assert company_data.url == "some updated url"
    end

    test "update_company_data/2 with invalid data returns error changeset" do
      company_data = company_data_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Curate.update_company_data(company_data, @invalid_attrs)

      assert company_data == Curate.get_company_data!(company_data.id)
    end

    test "delete_company_data/1 deletes the company_data" do
      company_data = company_data_fixture()
      assert {:ok, %CompanyData{}} = Curate.delete_company_data(company_data)
      assert_raise Ecto.NoResultsError, fn -> Curate.get_company_data!(company_data.id) end
    end

    test "change_company_data/1 returns a company_data changeset" do
      company_data = company_data_fixture()
      assert %Ecto.Changeset{} = Curate.change_company_data(company_data)
    end
  end

  describe "jobs" do
    alias JJ.Curate.Job

    @valid_attrs %{
      active: true,
      employment_type: "some employment_type",
      found: "2010-04-17T14:00:00Z",
      name: "some name",
      url: "some url"
    }
    @update_attrs %{
      active: false,
      employment_type: "some updated employment_type",
      found: "2011-05-18T15:01:01Z",
      name: "some updated name",
      url: "some updated url"
    }
    @invalid_attrs %{active: nil, employment_type: nil, found: nil, name: nil, url: nil}

    def job_fixture(attrs \\ %{}) do
      {:ok, job} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Curate.create_job()

      job
    end

    test "list_jobs/0 returns all jobs" do
      job = job_fixture()
      assert Curate.list_jobs() == [job]
    end

    test "get_job!/1 returns the job with given id" do
      job = job_fixture()
      assert Curate.get_job!(job.id) == job
    end

    test "create_job/1 with valid data creates a job" do
      assert {:ok, %Job{} = job} = Curate.create_job(@valid_attrs)
      assert job.active == true
      assert job.employment_type == "some employment_type"
      assert job.found == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert job.name == "some name"
      assert job.url == "some url"
    end

    test "create_job/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Curate.create_job(@invalid_attrs)
    end

    test "update_job/2 with valid data updates the job" do
      job = job_fixture()
      assert {:ok, %Job{} = job} = Curate.update_job(job, @update_attrs)
      assert job.active == false
      assert job.employment_type == "some updated employment_type"
      assert job.found == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert job.name == "some updated name"
      assert job.url == "some updated url"
    end

    test "update_job/2 with invalid data returns error changeset" do
      job = job_fixture()
      assert {:error, %Ecto.Changeset{}} = Curate.update_job(job, @invalid_attrs)
      assert job == Curate.get_job!(job.id)
    end

    test "delete_job/1 deletes the job" do
      job = job_fixture()
      assert {:ok, %Job{}} = Curate.delete_job(job)
      assert_raise Ecto.NoResultsError, fn -> Curate.get_job!(job.id) end
    end

    test "change_job/1 returns a job changeset" do
      job = job_fixture()
      assert %Ecto.Changeset{} = Curate.change_job(job)
    end
  end
end

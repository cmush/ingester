defmodule Powergen.CustomerTest do
  use ExUnit.Case
  alias Powergen.Customer

  describe "validate customer attributes" do
    @valid_customer %{
      "CountryID" => "1",
      "DoB" => "1963-08-15",
      "Name" => "Simon Kamau",
      "NationalID" => "13424422",
      "Phone" => "+254705611231",
      "SiteCode" => "235"
    }
    @invalid_customer %{
      "CountryID" => "2",
      "DoB" => "1978-01-02",
      "Name" => "Mohammed Issay",
      "NationalID" => "28372821",
      "Phone" => "+23221345678",
      "SiteCode" => "657"
    }

    test "valid" do
      assert {:ok, %Customer{}} = @valid_customer |> Customer.new() |> Customer.validate()
    end

    test "invalid site code " do
      assert {:error,
              [{:error, :SiteCode, :site_codes, "Site code 657 does not exist in Sierra Leone."}]} =
               @invalid_customer |> Customer.new() |> Customer.validate()
    end
  end
end

defmodule PowergenTest do
  use ExUnit.Case
  # doctest Powergen

  test "ingest and validate the data from the csv file" do
    assert Powergen.parse("priv/test.csv") ==
             [
               %{
                 Name: "Simon Kamau",
                 DoB: "1963-08-15",
                 Phone: "254705611231",
                 NationalID: "13424422",
                 CountryID: 1,
                 SiteCode: 235
               },
               %{
                 error: "Site code 657 does not exist in Sierra Leone.",
                 line: 2
               }
             ]
  end
end

defmodule Ingester do
  @moduledoc """
  Documentation for `Ingester`
  - CSV Data parser for Powergen customer data
  """

  alias NimbleCSV.RFC4180, as: CSV
  alias Ingester.Ingest

  @doc """
  Functionality:
  1. ingest a *.csv with customer data
  2. validate ingested data

  ## Examples

      iex> Ingester.csv("priv/test.csv")
      [%{SiteCode: 235, DoB: "1963-08-15", Phone: "254705611231", Name: "Simon Kamau", NationalID: "13424422", CountryID: 1}, %{error: "Site code 657 does not exist in Sierra Leone.", line: 2}]

  """
  def csv(path) when is_binary(path) do
    path
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Ingest.map_rows()
  end
end

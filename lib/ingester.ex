defmodule Ingester do
  @moduledoc """
  Documentation for `Ingester`
  - CSV Data parser Powergen customer data
  """

  alias NimbleCSV.RFC4180, as: CSV
  alias Ingester.Ingest

  @doc """
  Functionality:
  1. ingest *.csv
  2. validate ingested data

  ## Examples

      iex> Ingester.csv("priv/test.csv")
      %{}

  """
  def csv(path) do
    path
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Ingest.map_rows()
  end
end

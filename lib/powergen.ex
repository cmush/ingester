defmodule Powergen do
  @moduledoc """
  Documentation for `Powergen` Customer Data parser
  """

  alias NimbleCSV.RFC4180, as: CSV
  alias Powergen.Ingest

  @doc """
  Functionality:
  1. ingest *.csv
  2. validate ingested data

  ## Examples

      iex> Powergen.parse("priv/test.csv")
      %{}

  """
  def parse(source_csv) do
    source_csv
    |> File.stream!()
    |> CSV.parse_stream(skip_headers: false)
    |> Ingest.map_rows()
  end
end

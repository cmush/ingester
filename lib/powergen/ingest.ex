defmodule Powergen.Ingest do
  alias Powergen.Customer

  defp get_columns(file_stream) do
    file_stream
    |> Enum.fetch!(0)
    |> Enum.with_index()
    |> Map.new(fn {val, num} -> {num, val} end)
  end

  def map_rows(file_stream) do
    columns = get_columns(file_stream)

    file_stream
    |> Stream.drop(1)
    |> Stream.with_index(1)
    |> Enum.map(fn row ->
      case row
           |> elem(0)
           |> Enum.with_index()
           |> Map.new(fn {val, num} -> {columns[num], val} end)
           |> Customer.new()
           |> Customer.validate() do
        {:ok, customer} ->
          Customer.render_map(customer)

        {:error, [{:error, _, _, message}]} ->
          %{error: message, line: elem(row, 1)}
      end
    end)
  end
end

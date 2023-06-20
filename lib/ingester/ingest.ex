defmodule Ingester.Ingest do
  alias Ingester.Customer

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
    |> Enum.map(fn row_with_index ->
      {row, idx} = row_with_index

      case row
           |> Enum.with_index()
           |> Map.new(fn {val, num} -> {columns[num], val} end)
           |> Customer.new()
           |> Customer.validate() do
        {:ok, customer} ->
          Customer.render_map(customer)

        {:error, [{:error, _, _, message}]} ->
          Customer.render_error(message, idx)

        _ ->
          Customer.render_error("unknown error", idx)
      end
    end)
  end
end

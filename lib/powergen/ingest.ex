defmodule Powergen.Ingest do
  alias Powergen.{Customer, Validator.PhoneNumber}

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
    |> Enum.map(fn row ->
      case row
           |> Enum.with_index()
           |> Map.new(fn {val, num} -> {columns[num], val} end)
           |> Customer.new()
           |> Customer.validate() do
        {:ok,
         %Customer{
           CountryID: country_id,
           DoB: d_o_b,
           Name: name,
           NationalID: national_id,
           Phone: phone,
           SiteCode: site_code
         }} ->
          %{
            CountryID: String.to_integer(country_id),
            DoB: d_o_b,
            Name: name,
            NationalID: national_id,
            Phone: "#{PhoneNumber.clean(phone)}",
            SiteCode: String.to_integer(site_code)
          }

          {:error, [{:error, _, _, message}]} ->
          %{error: message}
      end
    end)
  end
end

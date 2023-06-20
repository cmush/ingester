defmodule Ingester.Validator.SiteCode do
  alias Ingester.Customer

  def validate(
        %Customer{
          CountryID: country_id
        } = customer
      ) do
    cond do
      country_id == "1" ->
        country_site_codes("Kenya", customer, [235, 657, 887])

      country_id == "2" ->
        country_site_codes("Sierra Leone", customer, [772, 855])

      country_id == "3" ->
        country_site_codes("Nigeria", customer, [465, 811, 980])
    end
  end

  defp country_site_codes(
         country,
         %Customer{
           SiteCode: site_code
         } = customer,
         site_codes
       ) do
    site_code = String.to_integer(site_code)

    if site_code in site_codes do
      {:ok, customer}
    else
      {:error,
       [{:error, :SiteCode, :site_codes, "Site code #{site_code} does not exist in #{country}."}]}
    end
  end
end

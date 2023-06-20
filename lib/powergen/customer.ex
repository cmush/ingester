defmodule Powergen.Customer do
  defstruct [:Name, :DoB, :Phone, :NationalID, :CountryID, :SiteCode]

  use ExConstructor
  use Vex.Struct

  alias Powergen.Validator.{SiteCode, PhoneNumber}

  validates(:Name, presence: true)
  validates(:DoB, presence: true, iso_8601: true)
  validates(:Phone, presence: true, phone_number: true)
  validates(:NationalID, presence: true)
  validates(:CountryID, presence: true)
  validates(:SiteCode, presence: true)

  def validate(customer) do
    with {:ok, customer} <- SiteCode.validate(customer),
         {:ok, customer} <- Vex.validate(customer) do
      {:ok, customer}
    end
  end

  def render_map(%__MODULE__{
        CountryID: country_id,
        DoB: d_o_b,
        Name: name,
        NationalID: national_id,
        Phone: phone,
        SiteCode: site_code
      }) do
    %{
      CountryID: String.to_integer(country_id),
      DoB: d_o_b,
      Name: name,
      NationalID: national_id,
      Phone: "#{PhoneNumber.clean(phone)}",
      SiteCode: String.to_integer(site_code)
    }
  end

  def render_error(message, line), do: %{error: message, line: line}
end

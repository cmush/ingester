defmodule Powergen.Customer do
  defstruct [:Name, :DoB, :Phone, :NationalID, :CountryID, :SiteCode]

  use ExConstructor
  use Vex.Struct

  alias Powergen.Validator.SiteCode

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
    else
      errors ->
        errors
    end
  end
end

defmodule Powergen.Customer do
  defstruct [:Name, :DoB, :Phone, :NationalID, :CountryID, :SiteCode]

  use ExConstructor
  use Vex.Struct

  alias Powergen.Validator.SiteCode

  validates(:Name, presence: true)
  validates(:DoB, presence: true)
  validates(:Phone, presence: true)
  validates(:NationalID, presence: true)
  validates(:CountryID, presence: true)
  validates(:SiteCode, presence: true)

  def validate(customer) do
    case Vex.validate(customer) do
      {:ok, customer} ->
        SiteCode.validate(customer)

      errors ->
        errors
    end
  end
end

defmodule Powergen.Customer do
  defstruct [:Name, :DoB, :Phone, :NationalID, :CountryID, :SiteCode]
  use ExConstructor
  use Vex.Struct

  validates(:Name, presence: true)
  validates(:DoB, presence: true)
  validates(:Phone, presence: true)
  validates(:NationalID, presence: true)
  validates(:CountryID, presence: true)
  validates(:SiteCode, presence: true)
end

defmodule Ingester.Validator.PhoneNumber do
  use Vex.Validator

  def validate(value, _options) do
    number = clean(value)

    if Regex.match?(~r/^\d{12}$/, number) do
      :ok
    else
      {:error, "Phone Number #{value} format incorrect"}
    end
  end

  def clean(phone_number) do
    with true <- String.contains?(phone_number, "+"),
         [_, number] <- String.split(phone_number, "+") do
      number
    else
      false -> phone_number
    end
  end
end

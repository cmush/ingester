defmodule Powergen.Validator.PhoneNumber do
  use Vex.Validator

  def validate(value, _options) do
    number =
      with true <- String.contains?(value, "+"),
           [_, number] <- String.split(value, "+") do
        number
      else
        false -> value
      end

    if Regex.match?(~r/^\d{12}$/, number) do
      :ok
    else
      {:error, "Phone Number #{value} format incorrect"}
    end
  end
end

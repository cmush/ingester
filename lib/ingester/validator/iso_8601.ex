defmodule Ingester.Validator.Iso8601 do
  use Vex.Validator

  def validate(value, _options) do
    case Date.from_iso8601(value) do
      {:ok, _} -> :ok
      _ -> {:error, "Date #{value} is not a valid ISO 8601 date string."}
    end
  end
end

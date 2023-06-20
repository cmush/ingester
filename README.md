# Ingester

Ingester is a simplified elixir library whose purpose is to ingest customer data csv files into an elixir application.  

The customer data in the CSV file must be in the following format / have the following column names:  

`Name,DoB,Phone,NationalID,CountryID,SiteCode` 

## Format rules

The returned records must conform to the following:

- Name: a non-empty string
- Date of birth: An ISO 8601 date string
- Telephone number: a string of the format `254759635432`
- ID number: optional. a string.
- Country ID: an integer, on of `1: Kenya, 2: Sierra Leone, 3: Nigeria`
- With the following site codes:
Kenya: 235, 657, 887
Sierra Leone: 772, 855
Nigeria: 465, 811, 980

It returns an elixir data structure consisting of a list with valid customer data or error maps with the csv line number.

For a more detailed example, see the [`Ingester.csv/1` function's documentation](https://github.com/cmush/ingester/blob/8543654ed283771675111f4f7600b9aba082a1ef/lib/ingester.ex#L21).

## Installation

Since this package is not yet [available in Hex](https://hex.pm/docs/publish), it can be installed
by adding `ingester` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ingester, git: "https://github.com/cmush/ingester.git"}
  ]
end
```
Then running `mix deps.get`.

## Configuration
Paste the following configuration into your app's `config/config.exs`

```elixir
config :vex,
  sources: [
    [
      iso_8601: Ingester.Validator.Iso8601,
      phone_number: Ingester.Validator.PhoneNumber
    ],
    Vex.Validators
  ]
```
This configures the customer data validation done using Vex.  

## Test Drive on **iex**

_PS: a test csv file is provided at [`priv/test.csv`](https://github.com/cmush/ingester/blob/master/priv/test.csv). You may use it as a template for creating your own customer data csv files_ 
_which this library will parse and validate for you._

1. clone this repository to your local workspace.
2. `cd` into `ingester`
3. [**assuming you have elixir installed**](https://elixir-lang.org/install.html), run `mix deps.get` followed by `iex -S mix`. This should open up the elixir terminal where our library will already loaded.
4. As per [`Ingester.csv/1`'s documentation]((https://github.com/cmush/ingester/blob/8543654ed283771675111f4f7600b9aba082a1ef/lib/ingester.ex#L21)), paste the following into your iex terminal prompt: `Ingester.csv("priv/test.csv")`. It will render the following output:
```
[
  %{
    Name: "Simon Kamau",
    DoB: "1963-08-15",
    Phone: "254705611231",
    NationalID: "13424422",
    CountryID: 1,
    SiteCode: 235
  },
  %{
    error: "Site code 657 does not exist in Sierra Leone.",
    line: 2
  }
]
```

## Tests

Run all tests as follows:
`MIX_ENV=test mix do deps.get, test`

Customer validation is tested under [`test/ingester/customer_test.exs`](https://github.com/cmush/ingester/blob/master/test/ingester/customer_test.exs) while api boundary tests are at [`test/ingester_test.exs`](https://github.com/cmush/ingester/blob/master/test/ingester_test.exs).
You may run them individually as follows: 
```
$ mix deps.get
$ mix test test/ingester/customer_test.exs
$ mix test test/ingester_test.exs
```
## Using it in your own app
Finally, you may use this functionality in your elixir app by adding it to your app's list of dependencies as discussed in the [Installation section](#installation) and configuring it as shown in the [Configuration](#configuration). You will then call `Ingester.csv/1` with your own custom file system path (pointing to a valid customer data csv file whose format matches the sample provided).

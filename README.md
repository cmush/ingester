# Ingester

Ingester is a simplified elixir library whose purpose is to ingest customer data csv files into an elixir application.  

The customer data in the CSV file must be in the following format / have the following column names:  

`Name,DoB,Phone,NationalID,CountryID,SiteCode`  

It returns an elixir data structure consisting of a list with valid customer data or error maps with the csv line number.

For a more detailed example, see the `Ingester.csv/1` function's documentation.

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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ingester>.

## Tests

Run all tests as follows:
`MIX_ENV=test mix do deps.get, test`

Customer validation is tested under `test/ingester/customer_test.exs` while api boundary tests are at `test/ingester_test.exs`.
You may run them individually as follows: 
```
$ mix test test/ingester/customer_test.exs
$ mix test test/ingester_test.exs
```

## Test Drive on **iex**

_PS: a test csv file is provided at `priv/test.csv`. You may use it as a template for creating your own customer data csv files_ 
_which this library will parse and validate for you._

1. clone this repository to your local workspace.
2. `cd` into `ingester`
3. **assuming you have elixir installed**, run `mix deps.get` followed by `iex -S mix`. This should open up the elixir terminal where our library will already loaded.
4. As per `Ingester.csv/1`'s documentation, paste the following into your iex terminal prompt: `Ingester.csv("priv/test.csv")`. It will render the following output:
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

## Parting shot
Finally, you may use this functionality in your elixir app by adding its dependency to your app's list of dependencies as discussed in the Installation section. You will then call `Ingester.csv/1` with your own custom file system path (pointing to a valid customer data csv file whose format matches the sample provided).
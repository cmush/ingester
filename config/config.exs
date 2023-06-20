import Config

config :vex,
  sources: [
    [
      iso_8601: Ingester.Validator.Iso8601,
      phone_number: Ingester.Validator.PhoneNumber
    ],
    Vex.Validators
  ]

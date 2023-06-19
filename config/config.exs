import Config

config :vex,
  sources: [
    [
      iso_8601: Powergen.Validator.Iso8601,
      phone_number: Powergen.Validator.PhoneNumber
    ],
    Vex.Validators
  ]

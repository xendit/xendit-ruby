# frozen_string_literal: true

require_relative './xendit'


begin
  data_params =   {        
    amount: 10_000    
    card_data: [
      account_number: "4456530000001096",        
      exp_month: "12",        
      exp_year: "2020"
    ],
    card_cvn: "123",
    is_multiple_use: false,
    should_authenticate: true,
    billing_details: [
      given_names: "John",
      surname: "Hudson",
      email: "john@xendit.co",
      mobile_number: "+6208123123123",
      phone_number: "+6208123123123",
      address: [
        country: "ID",
        street_line1: "Panglima Polim IV",
        street_line1: "Ruko Grand Panglima Polim, Blok E",
        city: "Jakarta Selatan",
        province_state: "DKI Jakarta",
        province_state: "12345"
      ]
    ]
}
  token = Xendit::CreditCard.create_token data_params
  puts "\nCreditCard::"
  puts token
rescue Xendit::APIError => e
  puts e
end
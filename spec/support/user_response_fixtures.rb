module UserResponseFixtures
  extend self

  def successful_verify_rules_matched_response
    %!{"data":{"rules":[{"state":"matched","description":"if bin_country == UK than return EU_GATEWAY","alias":"card_bin_country"}],"object":"125"}}!
  end

  def successful_verify_rules_not_matched_response
    %!{"data":{"rules":[{"state":"not_matched","description":"if bin_country == UK than return EU_GATEWAY","alias":"bin_country_1"},{"state":"not_matched","description":"if bin_country == UK than return EU_GATEWAY","alias":"card_bin_country"}],"object":null}}!
  end

  def failed_verify_rules_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.begateway.com/codes/validation_error","friendly_message":"Bin_country must be string.","errors":{"bin_country":["must be string"]},"code":"validation_error"}}!
  end

  def successful_creation_set_response
    %!{"data":{"value":["UK","FR","DE"],"updated_at":"2018-10-31T09:42:59.481017","read_only":false,"name":"AllowedCountries","id":"9959bd69-50a9-44a6-8691-deb41f6d3bc5","created_at":"2018-10-31T09:42:59.478386","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}}!
  end

  def failed_creation_set_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.begateway.com/codes/validation_error","friendly_message":"Name can't be blank. Value can't be blank.","errors":{"value":["can't be blank"],"name":["can't be blank"]},"code":"validation_error"}}!
  end

  def successful_update_set_response
    successful_creation_set_response
  end

  def failed_update_set_response
    failed_creation_set_response
  end

  def successful_get_set_response
    successful_creation_set_response
  end

  def successful_all_set_response
     %!{"data":[{"value":["UK","FR","DE"],"updated_at":"2018-10-31T09:42:59.481017","read_only":false,"name":"AllowedCountries","id":"9959bd69-50a9-44a6-8691-deb41f6d3bc5","created_at":"2018-10-31T09:42:59.478386","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"value":["PL","LT","LV"],"updated_at":"2018-09-03T13:03:52.961448","read_only":false,"name":"EUCountries","id":"321cb140-f492-48e4-bf17-ccd90146b084","created_at":"2018-09-03T13:03:52.961438","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"value":["AZ","AF"],"updated_at":"2018-09-03T13:03:34.457478","read_only":false,"name":"BlockCountries","id":"c763e2a8-8bc7-44cb-bbd0-172a7a17fb5e","created_at":"2018-09-03T13:03:34.457466","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}]}!
  end

end

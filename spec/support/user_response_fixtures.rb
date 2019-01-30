module UserResponseFixtures
  extend self

  # rule
  def successful_verify_rules_matched_response
    %!{"data":{"rules":[{"state":"matched","description":"if bin_country == UK than return EU_GATEWAY","alias":"card_bin_country"}],"object":"125"}}!
  end

  def successful_verify_rules_not_matched_response
    %!{"data":{"rules":[{"state":"not_matched","description":"if bin_country == UK than return EU_GATEWAY","alias":"bin_country_1"},{"state":"not_matched","description":"if bin_country == UK than return EU_GATEWAY","alias":"card_bin_country"}],"object":null}}!
  end

  def failed_verify_rules_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.begateway.com/codes/validation_error","friendly_message":"Bin_country must be string.","errors":{"bin_country":["must be string"]},"code":"validation_error"}}!
  end

  def successful_creation_rule_response
    %!{"data":{"weights":{"54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90":10},"objects":["54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90"],"handing_out_method":"weight","updated_at":"2018-11-01T11:25:22.126709","priority":5,"id":"abac3693-3758-4039-a91a-c4157d931814","description":"if bin_country == UK than return EU_GATEWAY","created_at":"2018-11-01T11:25:22.126687","conditions":[{"value":"UK","operation":"equal","field":"bin_country"}],"alias":"bin_country","active":true,"account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}}!
  end

  def failed_creation_rule_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.ecomcharge.com/codes/validation_error","friendly_message":"Alias can't be blank.","errors":{"alias":["can't be blank"]},"code":"validation_error"}}!
  end

  def successful_update_rule_response
    successful_creation_rule_response.sub(/"alias":"bin_country"/, '"alias":"bin_country_uk"')
  end

  def failed_update_rule_response
    failed_creation_rule_response
  end

  def successful_get_rule_response
    successful_creation_rule_response
  end

  def successful_all_rule_response
     %!{"data":[{"weights":{"54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90":10},"objects":["54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90"],"handing_out_method":"weight","updated_at":"2018-11-01T11:25:22.126709","priority":5,"id":"abac3693-3758-4039-a91a-c4157d931814","description":"if bin_country == UK than return EU_GATEWAY","created_at":"2018-11-01T11:25:22.126687","conditions":[{"value":"UK","operation":"equal","field":"bin_country"}],"alias":"bin_country","active":true,"account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"weights":{"b2ff52fb-6bc3-49c9-902f-620e3732131c":15,"2df0ba21-9af5-49c6-8b82-9028f9bbf883":10},"objects":["2df0ba21-9af5-49c6-8b82-9028f9bbf883","b2ff52fb-6bc3-49c9-902f-620e3732131c"],"handing_out_method":"weight","updated_at":"2018-09-15T05:19:37.804102","priority":5,"id":"1866be8d-60b8-4942-830f-c36f69db086f","description":"if bin_country == UK than return EU_GATEWAY","created_at":"2018-09-15T05:19:37.800809","conditions":[{"value":"UK","operation":"equal","field":"bin_country"}],"alias":"bin_country_1","active":true,"account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"weights":{"b2ff52fb-6bc3-49c9-902f-620e3732131c":5,"2df0ba21-9af5-49c6-8b82-9028f9bbf883":10},"objects":["2df0ba21-9af5-49c6-8b82-9028f9bbf883","b2ff52fb-6bc3-49c9-902f-620e3732131c"],"handing_out_method":"weight","updated_at":"2018-09-13T12:44:58.249690","priority":5,"id":"f57142da-8615-4571-a9a2-0ca0b0d162a0","description":"if bin_country == UK than return EU_GATEWAY","created_at":"2018-09-13T12:40:16.323965","conditions":[{"value":"UK","operation":"equal","field":"bin_country"}],"alias":"card_bin_country","active":true,"account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}]}!
  end

  # set
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

  # object_type
  def successful_creation_object_type_response
    %!{"data":{"updated_at":"2018-11-01T08:25:10.368248","name":"gw_EU","id":"1da2d4f0-ba1f-4ec2-aea4-10c9b791a2c8","created_at":"2018-11-01T08:25:10.368200","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}}!
  end

  def failed_creation_object_type_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.ecomcharge.com/codes/validation_error","friendly_message":"Name can't be blank.","errors":{"name":["can't be blank"]},"code":"validation_error"}}!
  end

  def successful_update_object_type_response
    successful_creation_object_type_response.sub(/gw_EU/, "gw_Europe")
  end

  def failed_update_object_type_response
    failed_creation_object_type_response
  end

  def successful_get_object_type_response
    successful_creation_object_type_response
  end

  def successful_all_object_type_response
     %!{"data":[{"updated_at":"2018-11-01T08:25:10.368248","name":"gw_EU","id":"1da2d4f0-ba1f-4ec2-aea4-10c9b791a2c8","created_at":"2018-11-01T08:25:10.368200","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"updated_at":"2018-09-13T12:25:13.975479","name":"gateway","id":"02c07bce-3a10-418e-9d77-d2c57c9bc71c","created_at":"2018-09-13T12:25:13.975468","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}]}!
  end

  # object
  def successful_creation_object_response
    %!{"data":{"updated_at":"2018-11-01T10:24:23.308025","type_id":"02c07bce-3a10-418e-9d77-d2c57c9bc71c","output_value":"1288","name":"gw_UK","id":"54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90","created_at":"2018-11-01T10:24:23.308016","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}}!
  end

  def failed_creation_object_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.ecomcharge.com/codes/validation_error","friendly_message":"Output_value can't be blank.","errors":{"output_value":["can't be blank"]},"code":"validation_error"}}!
  end

  def successful_update_object_response
    successful_creation_object_response.sub(/gw_UK/, "gw_BY").
      sub(/1288/, "1599")
  end

  def failed_update_object_response
    failed_creation_object_response
  end

  def successful_get_object_response
    successful_creation_object_response
  end

  def successful_all_object_response
     %!{"data":[{"updated_at":"2018-11-01T10:24:23.308025","type_id":"02c07bce-3a10-418e-9d77-d2c57c9bc71c","output_value":"1288","name":"gw_UK","id":"54a8b3c0-2b59-4d5d-b9a6-329dc7a78f90","created_at":"2018-11-01T10:24:23.308016","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"updated_at":"2018-09-13T12:31:14.705757","type_id":"02c07bce-3a10-418e-9d77-d2c57c9bc71c","output_value":"525","name":"gw_2","id":"b2ff52fb-6bc3-49c9-902f-620e3732131c","created_at":"2018-09-13T12:31:14.705746","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"},{"updated_at":"2018-09-13T12:31:00.046856","type_id":"02c07bce-3a10-418e-9d77-d2c57c9bc71c","output_value":"125","name":"gw_1","id":"2df0ba21-9af5-49c6-8b82-9028f9bbf883","created_at":"2018-09-13T12:31:00.046845","account_id":"10429c03-a343-4b24-9b03-7e1c360f7467"}]}!
  end

  # data
  def failed_adding_data_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.ecomcharge.com/codes/validation_error","friendly_message":"Created_at can't be blank.","errors":{"created_at":["can't be blank"]},"code":"validation_error"}}!
  end

end

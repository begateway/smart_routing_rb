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

end

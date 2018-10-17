module AdminResponseFixtures
  extend self

  def successful_creation_account_response
    %!{"data":{"updated_at":"2018-10-15T13:06:09.177614","token":"9FHPid4dvvwLc1km2deoApIZshKpXvGOO1Jj4ktmyHWAvGpjicaq7ziZT7Pm3arC","name":"Shop #1","id":"10429c03-a343-4b24-9b03-7e1c360f7467","created_at":"2018-10-15T11:29:39.811426"}}!
  end

  def failed_creation_account_response
    %!{"error":{"message":"Parameters are invalid","help":"https://doc.ecomcharge.com/codes/validation_error","friendly_message":"Name can't be blank.","errors":{"name":["can't be blank"]},"code":"validation_error"}}!
  end

  def successful_update_account_response
    successful_creation_account_response
  end

  def failed_update_account_response
    failed_creation_account_response
  end
end

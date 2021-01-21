module ClientHelpers
  def admin_client
    SmartRouting::Admin.new(auth_login: 'login', auth_password: 'password')
  end

  def admin_client_with_request_id(request_id)
    SmartRouting::Admin.new(auth_login: 'login', auth_password: 'password', headers: {'X-Request-Id' => request_id})
  end

  def user_client
    SmartRouting::User.new(auth_login: 'login', auth_password: 'password')
  end
end

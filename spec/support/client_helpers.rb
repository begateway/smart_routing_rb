module ClientHelpers
  def admin_client
    SmartRouting::Admin.new(auth_login: 'login', auth_password: 'password')
  end
end

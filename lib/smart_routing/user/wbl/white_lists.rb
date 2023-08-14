module SmartRouting
  class User::Wbl::WhiteLists
    include SmartRouting::User::Wbl::Base

    private

    def resource_path
      "/api/user/white-list"
    end
  end
end

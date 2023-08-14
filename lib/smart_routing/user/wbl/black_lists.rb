module SmartRouting
  class User::Wbl::BlackLists
    include SmartRouting::User::Wbl::Base

    private

    def resource_path
      "/api/user/black-list"
    end
  end
end

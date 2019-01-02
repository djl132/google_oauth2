module Api::V1
    class ApiController << ::ApplicationController
    private
        # check if we have a authentiacted user
        def current_resource
            User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        end 


    end
end
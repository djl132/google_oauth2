module Api::V1
    class ApiController < ::ApplicationController
    private

        # get user who is authorized to access desired resource

        # does the doorkeeper token get initialized when the authorization grant is sent by doorkeeper?
        def current_resource_owner
            binding.pry_remote
            puts doorkeeper_token
            User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
        end 


    end
end


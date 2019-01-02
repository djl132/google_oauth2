module Api::V1
    class UsersController < ApiController
        before_action :doorkeeper_authorize!

        def me 
        end
    end
end
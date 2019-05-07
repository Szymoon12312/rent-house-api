module Api
  module V1
    class GroupsController < ApplicationController

    def create
      group = Groups::CreateService.call(current_user, gropu_params)
      render_success(group, Api::GroupSerializer)
    end


    private

    def gropu_params
      params.require(:group).permit!
    end

    end
  end
end

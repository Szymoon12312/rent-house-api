module Api
  module V1
    class GroupsController < ApplicationController
    load_and_authorize_resource :only => [:destroy, :update]

    def create
      group = Groups::CreateService.call(current_user, group_params)
      render_success(group, Api::GroupSerializer)
    end

    def destroy
      group = Group.find(params[:id])
      return render :json, { error: "smth went wrong"} unless group.destroy
      head :ok
    end

    def update
      group = Group.find(params[:id])
      redner_success(group, Api::GroupSerializer) if group.update!(group_params)
    end

    def add_user
      group = Group.find_by!(uuid: params[:uuid])
      data = Groups::AddUserService.call(group, current_user)
      render_success(data, Api::GroupSerializer)
    end

    private

    def group_params
      params.require(:group).permit(:name)
    end

    end
  end
end

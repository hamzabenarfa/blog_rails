class ProfileController < ApplicationController

    def show
        @user = User.find_by_slug(params[:slug])
        redirect_to root_path, alert: "User not found for this link #{params[:slug]}" if !@user
    end


end
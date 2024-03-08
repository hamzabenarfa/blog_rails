class ProfileController < ApplicationController
    def index
        @posts = Post.includes(:user).all
    end
end

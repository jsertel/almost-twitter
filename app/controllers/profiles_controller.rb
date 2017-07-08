class ProfilesController < ApplicationController
  before_action :set_user, only: :show

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user_tweets = @user.tweets.order(created_at: :desc).paginate(:page => params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


end

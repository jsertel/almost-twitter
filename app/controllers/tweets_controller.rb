class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :ownership]
  before_action :check_owner, only: [:update, :edit, :destroy]

  def index
    @tweets = Tweet.order(created_at: :desc).paginate(:page => params[:page])
    @tweet = Tweet.new
  end

  def show

  end

  def edit

  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html {redirect_to tweets_url, notice: 'Tweet was updated'}
      else
        format.html { render :edit}
      end
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html {redirect_to tweets_url, notice: 'You tweeter you'}
      else
        format.html { render :new }
      end #end if
    end  #end respond to
  end # create action

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html {redirect_to tweets_url, notice: 'Eradicated!'}
    end
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:message, :user_id)
  end #end params method

  def check_owner
    unless current_user == @tweet.user
        redirect_to tweets_url, notice: 'You can not edit this Tweet' and return
    end
  end




end #end controller

class TweetsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
  end

  def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy if tweet.user_id == current_user.id # 後置ifで記述
  end

  def edit
    @tweet = Tweet.find(params[:id]) #既に存在しているレコードを選択して中身を置き換えたいので、編集したいレコードを@tweetに代入して編集画面で利用できるようにする
  end

  def update
    tweet = Tweet.find(params[:id])
    #ビューから受け取ったパラメータからidを受け取り、それを元にtweetsテーブルからレコードを取得
    tweet.update(tweet_params) if tweet.user_id ==current_user.id
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user) #ツイートと結びつくコメントのレコードをデータベースから取得する。アソシエーションを利用して@tweetについて投稿された全てのコメントのレコードを取得する。誰のコメントなのかを明らかにする為ユーザーのレコードを取得する処理をする時にn+1問題発生！
  end

  private
  def tweet_params
    params.permit(:image, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

class CommentsController < ApplicationController
  def create
    @comment = Comment.create(text: params[:text], tweet_id: params[:tweet_id], user_id: current_user.id)
    redirect_to "/tweets/#{@comment.tweet.id}"   #コメントと結びつくツイートの詳細画面に遷移する
  end

  private
  def comment_params
    params.permit(:text, :tweet_id)
  end
end

#クラスに対してcreateメソッドを使ってインスタンスを作成しデータベースに保存する。引数では、カラムと、カラムの値を指定。まずtextカラムにはparamsの中の"text"という情報を保存します。user_idカラムにはcurrent_user.id（＝ログインしているユーザーのid）を保存しています。tweet_idカラムはネストしてurlに@tweet.id（ツイートのid）を記述してあるのでparams[:tweet_id]とするだけで簡単に情報が取ってこられる。

class UsersController < ApplicationController

  def show
    user = User.find(params[:id]) #コメント欄に表示されるユーザーをクリックすることで送られたidをparamsで取得してそのレコードをuserに代入
    @nickname = user.nickname
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
  end
end

#最初はcurrent_user.tweets~~だったが、それだとツイートの詳細ページからコメントをしたユーザー名をクリックしても自分自身のユーザーページしか表示されない。ユーザーのページに遷移できるようにuserに変更した。

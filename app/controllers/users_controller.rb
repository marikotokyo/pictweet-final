#$ rails g controller usersで作成された
class UsersController < ApplicationController

  def show #マイページに表示したい情報を定義。ビューに情報を受け渡す時はインスタンス変数をアクションにで定義するよ
    user = User.find(params[:id])
    #コメント欄に表示されるユーザーをクリックすることで送られたidをparamsで取得してそのレコードをuserに代入
    @nickname = user.nickname
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
    #アソシエーションが設定されているのでuser.tweetsとするだけでユーザーが投稿したツイート全てを取得できる
  end
end


#最初はこれ
# def show
#  @nickname = current_user.nickname
#  @tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
# end
# @nicknameには、現在ログインしているユーザーのレコードのインスタンスが代入されているcurrent_userを利用し、そのnicknameカラムの値を取得している
# @tweetsには、whereメソッドを利用して、引数を(カラム名: そのカラムの値)とすることでその条件に当てはまるレコードを全て取得している。

#最初はcurrent_user.tweets~~だったが、それだとツイートの詳細ページからコメントをしたユーザー名をクリックしても自分自身のユーザーページしか表示されない。ユーザーのページに遷移できるようにuserに変更した。

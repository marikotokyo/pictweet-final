class TweetsController < ApplicationController  #$ rails g controller tweetsコマンドで作成

  before_action :move_to_index, except: [:index, :show] #ログインしていないユーザーが/tweets/new/にアクセスできないように、newアクションを動かす前に強制的にindexアクションにリダイレクトさせるメソッドmove_to_indexを定義。indexアクションとshowアクションの時は実行しない

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
    # allメソッドが省略されている。allメソッドは通常id順でレコードを取得するがorderメソッドで並び替えている。
    #pageメソッドでページネーションにおけるページ数を指定、perメソッドで１ページあたりに表示する件数を指定。
    #全ツイートを取得しアソシエーションを利用してツイートの数だけユーザー情報を呼び出しているのでn+1問題発生！それを回避するためにinclederメソッドを利用。指定された関連モデルをまとめて取得することで、tweetsテーブルのレコードを取得する段階でusersテーブルのレコードも一度に取得できる。
  end

  def new
  end

  def create #createアクションが動いた時にtweetsテーブルに新たなレコードが保存される。投稿画面でフォームから送信された情報を元にしてツイートを作成する。paramsメソッドを利用してparams[:キー名]で値を取り出すことできる。
    #追加したuser_idカラムにそのツイートを投稿した人のid（つまりログイン中のユーザーのid）を保存したい。current_userには現在ログイン中のユーザーのレコードがまるごとインスタンスとして代入されているのでusersテーブルのカラム名(id)という形でを取得できる。
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    # createメソッドの引数でtweet_paramsメソッドを呼び出しているので、この部分に入る値はtweet_paramsメソッドの返り値になる。
  end

  def destroy
    tweet = Tweet.find(params[:id]) #どのツイートを削除するかparamsを使い削除したいツイートの情報を取得して特定
    tweet.destroy if tweet.user_id == current_user.id # 後置ifで記述。そのツイートを投稿したユーザーでなければ削除できないよう条件付け。
  end

  def edit #ツイートを編集
    @tweet = Tweet.find(params[:id]) #既に存在しているレコードを選択して中身を置き換えたいので、編集したいレコードを@tweetに代入して編集画面で利用できるようにする
  end

  def update
    tweet = Tweet.find(params[:id])
    #ビューから受け取ったパラメータからidを受け取り、それを元にtweetsテーブルからレコードを取得
    tweet.update(tweet_params) if tweet.user_id ==current_user.id #updateメソッドを利用してレコードの値を更新。paramsから:imageと:textというキーだけを残したハッシュ。
  end

  def show #ツイートの詳細ページ
    @tweet = Tweet.find(params[:id]) #viewから送られてくるparamsからfindメソッドで編集したいツイートを取得
    @comments = @tweet.comments.includes(:user) #ツイートと結びつくコメントのレコードをデータベースから取得する。アソシエーションを利用して@tweetについて投稿された全てのコメントのレコードを取得する。誰のコメントなのかを明らかにする為ユーザーのレコードを取得する処理をする時にn+1問題発生！
  end

  private #privateメソッドによりここ以降に定義したメソッドはクラスの外部から呼び出されないようになる。
  def tweet_params #ストロングパラメータの設定。指定したキーを持つパラメータのみを受け取る。
    params.permit(:image, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
    #ユーザーがサインインしていなければindexアクションに遷移させる
  end
end

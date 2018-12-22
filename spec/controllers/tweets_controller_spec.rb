require 'rails_helper'

describe TweetsController, type: :controller do

  describe 'GET #new' do
    it "renders the :new template" do
      get :new #newアクションをリクエストするには引数は必要ない
      expect(response).to render_template :new #メソッドの返り値を比較
    end
  end

  describe 'GET #edit' do
    it "assigns the requested tweet to @tweet" do #インスタンスの変数の値を確かめる
      tweet = create(:tweet) #factory_girlでレコードを作成
      # get :edit,  id: tweet #上で作成したインスタンスのidを設定
      get :edit, params: { id: tweet.id }#これ新しい書き方
      expect(assigns(:tweet)).to eq tweet #editアクションで取得しているインスタンス変数が上記で生成したtweetと一致しているかassignsメソッドでテスト
    end

    it "renders the :edit template" do #editアクションをリクエストした後edit.html.erbに遷移するかテスト
      tweet = create(:tweet)
      # get :edit, id: tweet
      get :edit, params: { id: tweet.id } #これ新しい書き方

      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it "populates an array of tweets ordered by created_at DESC" do #インスタンス変数の値を確かめる
      tweets = create_list(:tweet, 3) #テストの際も複数のレコードが存在しなければならないので、create_listメソッドで3つレコードを作成
      get :index
      expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at }) #matchマッチャで引数に配列クラスのインスタンスをとりexpectの引数と比較して配列の中身の順番もチェック。
    end

    it "renders the :index template" do #indexアクションをリクエストした後index.html.erbに遷移するかテスト
      get :index
      expect(response).to render_template :index
    end
  end
end

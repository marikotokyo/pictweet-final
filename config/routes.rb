Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index' #ルートパス(パスを付けないホスト名だけのURL)にアクセスした際、ツイート一覧ページを表示
  resources :tweets do   #tweets_controllerに対してのresourcesメソッドで7つのアクション名に対してのルーティングを自動生成
    resources :comments, only: [:create] #commentsのルーティングパスの中に、コメントに結びつくツイートのid情報が含まれるようになる。どのツイートに対するコメントなのかツイートのidを取得したい為、ネストさせている
  end
  resources :users, only: [:show]  #users_controllerに対してのresourcesメソッド
end

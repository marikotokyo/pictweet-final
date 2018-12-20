Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index' #ルートパスの設定
  resources :tweets do   #tweets_controllerに対してのresourcesメソッド
    resources :comments, only: [:create] #commentsのルーティングパスの中に、コメントに結びつくツイートのid情報が含まれるようになる。どのツイートに対するコメントなのかツイートのidを取得したい為、ネストさせている
  end
  resources :users, only: [:show]  #users_controllerに対してのresourcesメソッド
end

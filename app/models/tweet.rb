class Tweet < ApplicationRecord  # $ rails g model tweetコマンドで作成
  belongs_to :user, optional: true #usersテーブルとのアソシエーション
  #oputional:trueはコントローラのテストのため追記
  has_many :comments #commentsテーブルとのアソシエーション
end

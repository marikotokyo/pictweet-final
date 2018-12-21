class Tweet < ApplicationRecord  # $ rails g model tweetコマンドで作成
  belongs_to :user #usersテーブルとのアソシエーション
  has_many :comments #commentsテーブルとのアソシエーション
end

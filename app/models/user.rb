class User < ApplicationRecord  # $ rails g devise userでsユーザーで悪性される
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets #tweetsテーブルとのアソシエーション
  has_many :comments #commentsテーブルとのアソシエーション
end

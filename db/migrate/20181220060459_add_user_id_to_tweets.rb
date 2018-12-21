# $ rails g migration AddUserIdToTweets user_id:integerで作成された
class AddUserIdToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :user_id, :integer #tweetsテーブルにuser_idというカラムをinteger型で追加するよ
  end
end

# $ rake db:migrate マイグレーションファイルの実行忘れずに

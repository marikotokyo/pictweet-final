# $ rails g migration AddNicknameToUsers nickname:stringで作成された
class AddNicknameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname, :string #usersテーブルにnicknameというカラムをstring型で保存するよ
  end
end

# $ rake db:migrateで実行を忘れずに

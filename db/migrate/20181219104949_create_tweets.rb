class CreateTweets < ActiveRecord::Migration[5.2]  # $ rails g model tweetで作成される
  def change
    create_table :tweets do |t| #作成するカラムと型をchangeメソッド内で定義
      t.string      :name
      t.text        :text
      t.text        :image
      t.timestamps null: true
    end
  end
end

#編集したら$ rake db:migrateでマイグレーションファイルを実行（tweetsテーブルの作成）

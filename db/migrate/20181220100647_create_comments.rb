# $ rails g model commentで作成された
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id #誰が投稿したツイートかわかるように
      t.integer :tweet_id #どのツイートに対するコメントなのか
      t.text :text
      t.timestamps
    end
  end
end


# $ rake db:migrateで実行を忘れずに

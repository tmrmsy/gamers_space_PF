class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id, null: false #ユーザーIDが入る
      t.string :title, null: false #投稿タイトル
      t.string :content, null: false #投稿内容

      t.timestamps
    end
  end
end

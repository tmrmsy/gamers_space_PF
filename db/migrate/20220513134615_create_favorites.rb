class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false #ユーザーID
      t.integer :post_id, null: false #投稿ID

      t.timestamps
    end
  end
end

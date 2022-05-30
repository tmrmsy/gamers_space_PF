class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|

      t.integer :user_id, null: false #ユーザーID
      t.integer :room_id, null: false #グループID
      t.string :content, null: false #メッセージ内容

      t.timestamps
    end
  end
end

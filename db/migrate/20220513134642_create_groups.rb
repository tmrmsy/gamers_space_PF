class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      
      t.integer :user_id, null: false #送信ユーザーID
      t.integer :second_user_id, null: false #受信ユーザーID

      t.timestamps
    end
  end
end

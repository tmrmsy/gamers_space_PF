class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|

      t.integer :first_user_id, null: false #一人目のユーザー
      t.integer :second_user_id,null: false #二人目のユーザー


      t.timestamps
    end
  end
end

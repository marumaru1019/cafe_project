class CreateUserRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :user_requests do |t|
      t.references :user, foreign_key: true
      t.references :user_request_tag, foreign_key: true
      t.integer :tag_id, null: false
      t.text :text, null:false
      t.boolean :confirm, null:false

      t.timestamps
    end
  end
end

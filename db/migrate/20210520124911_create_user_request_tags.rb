class CreateUserRequestTags < ActiveRecord::Migration[6.1]
  def change
    create_table :user_request_tags do |t|
      t.string :tag_name

      t.timestamps
    end
  end
end

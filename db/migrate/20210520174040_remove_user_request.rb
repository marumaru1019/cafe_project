class RemoveUserRequest < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_requests, :tag_id
  end
end

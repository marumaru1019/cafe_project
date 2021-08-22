# == Schema Information
#
# Table name: user_request_tags
#
#  id         :bigint           not null, primary key
#  tag_name   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserRequestTag < ApplicationRecord
  has_many :user_requests
end

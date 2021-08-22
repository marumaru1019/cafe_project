# == Schema Information
#
# Table name: user_requests
#
#  id                  :bigint           not null, primary key
#  confirm             :boolean          not null
#  text                :text             not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tag_id              :integer          not null
#  user_id             :bigint
#  user_request_tag_id :bigint
#
# Indexes
#
#  index_user_requests_on_user_id              (user_id)
#  index_user_requests_on_user_request_tag_id  (user_request_tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (user_request_tag_id => user_request_tags.id)
#
class UserRequest < ApplicationRecord
  belongs_to :user
  belongs_to :user_request_tag

  validates :text, length: { minimum: 10}
end

# == Schema Information
#
# Table name: user_request_tags
#
#  id         :bigint           not null, primary key
#  tag_name   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :user_request_tag do
    tag_name { "MyString" }
  end
end

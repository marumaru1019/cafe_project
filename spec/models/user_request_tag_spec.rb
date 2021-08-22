# == Schema Information
#
# Table name: user_request_tags
#
#  id         :bigint           not null, primary key
#  tag_name   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe UserRequestTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

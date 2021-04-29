# == Schema Information
#
# Table name: event_joins
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  user_id    :integer
#
require 'rails_helper'

RSpec.describe EventJoin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

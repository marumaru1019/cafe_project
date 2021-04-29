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
class EventJoin < ApplicationRecord
  belongs_to :event
  belongs_to :user
end

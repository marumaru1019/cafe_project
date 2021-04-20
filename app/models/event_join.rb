# == Schema Information
#
# Table name: event_joins
#
#  id                                               :bigint(8)        not null, primary key
#  event_id(イベントID)                               :integer
#  user_id(ユーザーID)                               　:integer
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#
class EventJoin < ApplicationRecord
  belongs_to :event
  belongs_to :user
end

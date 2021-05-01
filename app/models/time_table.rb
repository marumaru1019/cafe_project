# == Schema Information
#
# Table name: time_tables
#
#  id         :bigint           not null, primary key
#  time       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TimeTable < ApplicationRecord
    # 時間が削除されてもイベントは残す
    has_many :events
    has_many :event_joins, dependent: :destroy
end

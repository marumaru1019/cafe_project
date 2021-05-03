# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  adress               :text
#  comment              :text
#  date                 :date
#  max_num              :integer
#  name                 :string
#  place                :text
#  recommend_menu       :text
#  recommend_menu_price :integer
#  store_url            :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  time_id              :integer
#

class Event < ApplicationRecord
    # 写真を添付できる許可
    has_one_attached :image
    has_many :event_joins, dependent: :destroy
    belongs_to :time_table, foreign_key: "time_id"

    scope :top5, -> { order(date: :asc).limit(5) }
    scope :top30,  -> { order(date: :asc).limit(30) }
    scope :holded, -> { where("date < ?", Time.current.at_beginning_of_day) }
    scope :will_hold, -> { where("date >= ?", Time.current.at_beginning_of_day) }

    # concernのput_time.rbを呼びだす
    include PutTime

    def join_by?(user)
        event_joins.where(user_id: user.id).exists?
    end

    # event hold within 1 week or finish?
    def hold_day?
        if date-7 < Time.zone.today && date >= Time.zone.today
            "week_in"
        elsif date < Time.zone.today
            "finished"
        end
    end

    def cancel_able?
        if date-3 >  Time.zone.today
            "day_in"
        elsif date-3 <=  Time.zone.today && date >= Time.zone.today
            "day_out"
        end
    end

    def over_participant?
        event_joins.count < max_num
    end
end

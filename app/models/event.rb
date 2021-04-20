class Event < ApplicationRecord
    # 写真を添付できる許可
    has_one_attached :image
    has_many :event_joins, dependent: :destroy
    belongs_to :time_table, foreign_key: "time_id"

    # concernのput_time.rbを呼びだす
    include PutTime

    def join_by?(user)
        event_joins.where(user_id: user.id).exists?
    end

    # event hold within 1 week or finish?
    def hold_day?
        if self.date-7 < Time.zone.today && self.date > Time.zone.today
            return "week_in"
        elsif self.date < Time.zone.today
            return "finished"
        end
    end

    def cancel_able?
        if self.date-3 >  Time.zone.today
            return "day_in"
        elsif self.date-3 <=  Time.zone.today && self.date >= Time.zone.today
            return "day_out"
        end
    end

end

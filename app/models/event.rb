# == Schema Information
#
# Table name: events
#
#  id                                            :bigint(8)        not null, primary key
#  name(イベント名)                                :string(255)      not null
#  date(開催日)                                   :date
#  max_num(最大参加人数)                           :integer
#  time_id(時間テーブルのid)                        :integer
#  recommend_menu(推奨メニュー)                     :text(65535)
#  recommend_menu_price(推奨メニューの値段)          :integer
#  place(エリア)                                   :text(65535)
#  adress(住所)                                   :text(65535)
#  comment(コメント)                                :text(65535)
#  store_url(ストアURL)                             :string(255)
#  created_at                                       :datetime         not null
#  updated_at                                       :datetime         not null
#

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

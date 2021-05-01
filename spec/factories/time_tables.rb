# == Schema Information
#
# Table name: time_tables
#
#  id         :bigint           not null, primary key
#  time       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
    factory :time_table do
        time {"18:00 ~ 20:00"}
    end
end

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
#  quote                :string
#  recommend_menu       :text
#  recommend_menu_price :integer
#  store_url            :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  time_id              :integer
#
FactoryBot.define do
  factory :event do
    name { Faker::Lorem.characters(number: 10) }
    date { Faker::Date.between(from: '2019-09-23', to: '2022-09-25') }
    time_id {1}
    recommend_menu { Faker::Lorem.characters(number: 10) }
    recommend_menu_price { Faker::Number.number(digits: 4) }
    place { Faker::Lorem.characters(number: 10) }
    max_num { Faker::Number.within(range: 3..9) }
    comment { Faker::Lorem.characters }
    store_url { Faker::Internet.url }
    quote  { Faker::Internet.url }
    after(:build) do |event|
      # carrierwaveの場合
      # item.images << build(:event)
      # ActiveStorageの場合
      event.image.attach(io: File.open('spec/fixtures/afternoon.jpg'), filename: 'afternoon.jpg', content_type: 'image/jpg')
    end
  end
end


# require 'faker'
# puts Faker::Number.within(range: 3..9)  #=> loremな文章

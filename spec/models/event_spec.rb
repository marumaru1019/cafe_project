# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  adress               :text
#  comment              :text
#  date                 :date
#  image                :string
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
require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

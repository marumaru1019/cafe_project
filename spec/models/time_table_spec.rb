# == Schema Information
#
# Table name: time_tables
#
#  id         :bigint           not null, primary key
#  time       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe TimeTable, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

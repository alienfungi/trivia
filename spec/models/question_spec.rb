# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  type       :string
#  body       :text             not null
#  options    :hstore           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'rails_helper'

RSpec.describe Question do
  it { should validate_presence_of(:type) }

  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(255) }
end

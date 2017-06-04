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
#

require 'rails_helper'

RSpec.describe Question do
  it { should validate_presence_of(:body) }
end

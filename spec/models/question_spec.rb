require 'rails_helper'

RSpec.describe Question do
  it { should validate_presence_of(:body) }
end

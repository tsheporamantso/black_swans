require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:name).is_at_least(5) }
  it { should validate_length_of(:description).is_at_least(15) }
  it { should_not allow_values("").for(:name) }
  it { should_not allow_values("").for(:description) }

end

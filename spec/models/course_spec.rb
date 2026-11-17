require "rails_helper"

RSpec.describe Course, type: :model do

  describe "course" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:name).is_at_least(5) }
    it { should validate_length_of(:description).is_at_least(15) }
  end
end

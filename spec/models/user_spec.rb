require 'spec_helper'

describe User do
  subject(:user) {create(:logist)}
  it "has valid factory" do
    expect(user).to be_valid
  end
end

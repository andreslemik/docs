require 'spec_helper'

describe Nomenclature, :type => :model do
  it "invalid without name" do
    expect(build(:nomenclature, name: nil)).not_to be_valid
  end
  it "invalid without partner_number" do
    expect(build(:nomenclature, partner_number: nil)).not_to be_valid
  end

end

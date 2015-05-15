require 'spec_helper'
 
describe RgFactoryGem do
  context "#name" do
    it "should return gem name" do
      expect(RgFactoryGem.name).to eq "RG Factory Gem"
    end
  end
end
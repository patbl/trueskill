# -*- encoding : utf-8 -*-
require File.expand_path('spec/spec_helper.rb')

describe TrueSkill::Factors::Prior do
  
  before :each do
    @variable = Gauss::Distribution.new
    @factor = TrueSkill::Factors::Prior.new(22.0, 0.3, @variable)
  end
  
  describe "#update_message_at" do
    
    it "should return a difference of 73.33333" do
      expect(@factor.update_message_at(0)).to be_within(tolerance).of(73.33333)
    end
  
  end
  
  describe "#log_normalization" do
    
    it "should be 0.0" do
      expect(@factor.log_normalization).to eq(0.0)
    end
  
  end
  
end

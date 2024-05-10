# -*- encoding : utf-8 -*-
require File.expand_path('spec/spec_helper.rb')

describe TrueSkill::Factors::GreaterThan do
  
  before :each do
    @variable = Gauss::Distribution.new(0.1, 1.1)
    @factor = TrueSkill::Factors::GreaterThan.new(0.1, @variable)
  end
  
  describe "#update_message_at" do
    
    it "should return a difference of 2.1409" do
      expect(@factor.update_message_at(0)).to be_within(tolerance).of(2.1409)
    end
  
  end
  
  describe "#log_normalization" do
    
    it "should be -0.69314" do
      expect(@factor.log_normalization).to be_within(tolerance).of(-0.69314)
    end
  
  end
  
end

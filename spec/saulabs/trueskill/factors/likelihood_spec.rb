# -*- encoding : utf-8 -*-
require File.expand_path('spec/spec_helper.rb')

describe TrueSkill::Factors::Likelihood do
  
  before :each do
    @variable1 = Gauss::Distribution.new(26, 1.1)
    @variable2 = Gauss::Distribution.new
    @factor = TrueSkill::Factors::Likelihood.new(30, @variable1, @variable2)
  end
  
  describe "#update_message_at" do
    
    it "should return a difference of 0.0" do
      expect(@factor.update_message_at(0)).to be_within(tolerance).of(0.0)
    end
    
    it "should return a difference of 0.833066 for the second message" do
      @factor.update_message_at(0)
      expect(@factor.update_message_at(1)).to be_within(tolerance).of(0.833066)
    end
  
  end
  
  describe "#log_normalization" do
    
    it "should be 0.0" do
      expect(@factor.log_normalization).to eq(0.0)
    end
  
  end
  
end

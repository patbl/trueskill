# -*- encoding : utf-8 -*-
require File.expand_path('spec/spec_helper.rb')

describe TrueSkill::Factors::Prior do
  
  before :each do
    @variable = Gauss::Distribution.with_variance(0.0, 0.0)
    @variables = [
      Gauss::Distribution.new(22, 1.6),
      Gauss::Distribution.new(26, 2.5),
      Gauss::Distribution.new(31, 3.6)
    ]
    @factor = TrueSkill::Factors::WeightedSum.new(@variable, @variables, [0.5, 0.7, 0.8])
  end
  
  describe "weights" do
    
    it "should setup the weights correctly" do
      expect(@factor.weights[0][0]).to be_within(tolerance).of(0.5)
      expect(@factor.weights[1][0]).to be_within(tolerance).of(-1.4)
      expect(@factor.weights[2][0]).to be_within(tolerance).of(-0.7142)
      expect(@factor.weights[2][1]).to be_within(tolerance).of(-1.14285)
      expect(@factor.weights[3][0]).to be_within(tolerance).of(-0.625)
      expect(@factor.weights[3][2]).to be_within(tolerance).of(1.25)
    end
    
  end
  
  describe "weights_squared" do
    
    it "should setup the squared weights correctly" do
      expect(@factor.weights_squared[0][0]).to be_within(tolerance).of(0.25)
      expect(@factor.weights_squared[1][0]).to be_within(tolerance).of(1.96)
      expect(@factor.weights_squared[2][0]).to be_within(tolerance).of(0.51)
      expect(@factor.weights_squared[2][1]).to be_within(tolerance).of(1.3061)
      expect(@factor.weights_squared[3][0]).to be_within(tolerance).of(0.3906)
      expect(@factor.weights_squared[3][2]).to be_within(tolerance).of(1.5625)
    end
    
  end
  
  describe "index_order" do
    
    it "should setup the index order correctly" do
      expect(@factor.index_order[0][0]).to eq(0)
      expect(@factor.index_order[1][0]).to eq(1)
      expect(@factor.index_order[2][0]).to eq(2)
      expect(@factor.index_order[2][1]).to eq(1)
      expect(@factor.index_order[2][2]).to eq(3)
      expect(@factor.index_order[3][1]).to eq(1)
    end
    
  end
  
  describe "#update_message_at" do
    
    it "should return a difference of 4.50116 for message 0" do
      expect(@factor.update_message_at(0)).to be_within(tolerance).of(4.50116)
    end
  
  end
  
end

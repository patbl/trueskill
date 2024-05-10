# -*- encoding : utf-8 -*-
require File.expand_path('spec/spec_helper.rb')

describe Gauss::Distribution, "#initialize" do

  it "should set the mean to 10.1" do
    expect(Gauss::Distribution.new(10.1, 0.4).mean).to eq(10.1)
  end
  
  it "should set the deviation to 0.4" do
    expect(Gauss::Distribution.new(10.1, 0.4).deviation).to eq(0.4)
  end
  
  it "should set the mean to 0.0 if the given mean is not finite" do
    expect(Gauss::Distribution.new(1 / 0.0, 0.4).mean).to eq(0.0)
  end
  
  it "should set the deviation to 0.0 if the given deviation is not finite" do
    expect(Gauss::Distribution.new(10.1, 1 / 0.0).deviation).to eq(0.0)
  end
  
end

describe Gauss::Distribution, "#with_deviation" do
  
  before :each do 
    @dist = Gauss::Distribution.with_deviation(25.0, 8.333333)
  end

  it "should have a default mean value of 25.0" do
    expect(@dist.mean).to eq(25.0)
  end

  it "should have a default deviation of 8.333333" do
    expect(@dist.deviation).to be_within(0.000001).of(8.333333)
  end

  it "should set the variance to 69.444438" do
    expect(@dist.variance).to be_within(0.0001).of(69.4444)
  end

  it "should set the precision to 0.0144" do
    expect(@dist.precision).to be_within(0.0001).of(0.0144)
  end

  it "should set the precision_mean to 0.36" do
    expect(@dist.precision_mean).to be_within(0.0001).of(0.36)
  end
  
end
  
describe Gauss::Distribution, "#with_precision" do
  
  before :each do 
    @dist = Gauss::Distribution.with_precision(0.36, 0.0144)
  end

  it "should have a default mean value of 25.0" do
    expect(@dist.mean).to eq(25.0)
  end

  it "should have a default deviation of 8.333333" do
    expect(@dist.deviation).to be_within(0.000001).of(8.333333)
  end

  it "should set the variance to 69.444438" do
    expect(@dist.variance).to be_within(0.0001).of(69.4444)
  end

  it "should set the precision to 0.0144" do
    expect(@dist.precision).to be_within(0.0001).of(0.0144)
  end

  it "should set the precision_mean to 0.36" do
    expect(@dist.precision_mean).to be_within(0.0001).of(0.36)
  end
  
end

describe Gauss::Distribution, "absolute difference (-)" do
  
  before :each do 
    @dist = Gauss::Distribution.with_deviation(25.0, 8.333333)
  end
  
  it "should be 0.0 for the same distribution" do
    expect(@dist - @dist).to eq(0.0)
  end
  
  it "should equal the precision mean if the 0-distribution is subtracted" do
    expect(@dist - Gauss::Distribution.new).to eq(@dist.precision_mean)
  end
  
  it "should be 130.399408 for (22, 0.4) - (12, 1.3)" do
    expect(Gauss::Distribution.new(22, 0.4) - Gauss::Distribution.new(12, 1.3)).to be_within(tolerance).of(130.399408)
  end
  
end

describe Gauss::Distribution, "#value_at" do
  
  it "should have a value of 0.073654 for x = 2" do
    expect(Gauss::Distribution.new(4,5).value_at(2)).to be_within(tolerance).of(0.073654)
  end
  
end

describe Gauss::Distribution, "multiplication (*)" do
  
  it "should have a mean of 0.2" do
    expect((Gauss::Distribution.new(0,1) * Gauss::Distribution.new(2,3)).mean).to be_within(0.00001).of(0.2)
  end
  
  it "should have a deviation of 3.0 / Math.sqrt(10)" do
    expect((Gauss::Distribution.new(0,1) * Gauss::Distribution.new(2,3)).deviation).to be_within(0.00001).of(3.0 / Math.sqrt(10))
  end
  
end

describe Gauss::Distribution, "#log_product_normalization" do
  
  it "should have calculate -3.0979981" do
    lp = Gauss::Distribution.log_product_normalization(Gauss::Distribution.new(4,5), Gauss::Distribution.new(6,7))
    expect(lp).to be_within(0.000001).of(-3.0979981)
  end
  
end

describe Gauss::Distribution, "functions" do
  
  describe 'value = 0.27' do
    
    it "#cumulative_distribution_function should return 0.6064198 for 0.27" do
      expect(Gauss::Distribution.cumulative_distribution_function(0.27)).to be_within(0.00001).of(0.6064198)
      expect(Gauss::Distribution.cdf(2.0)).to be_within(0.00001).of(0.9772498)
    end
    
    it "#probability_density_function should return 0.384662" do
      expect(Gauss::Distribution.probability_density_function(0.27)).to be_within(0.0001).of(0.384662)
    end
    
    it "#quantile_function should return ~ -0.6128123 at 0.27" do
      expect(Gauss::Distribution.quantile_function(0.27)).to be_within(0.00001).of(-0.6128123)
    end
    
    it "#quantile_function should return ~ 1.281551 at 0.9" do
      expect(Gauss::Distribution.quantile_function(0.9)).to be_within(0.00001).of(1.281551)
    end
    
    it "#erf_inv should return 0.0888559 at 0.9" do
      expect(Gauss::Distribution.inv_erf(0.9)).to be_within(0.00001).of(0.0888559)
    end
    
    it "#erf_inv should return 0.779983 at 0.27" do
      expect(Gauss::Distribution.inv_erf(0.27)).to be_within(0.00001).of(0.779983)
    end
    
    it "#erf_inv should return 100 at -0.5" do
      expect(Gauss::Distribution.inv_erf(-0.5)).to be_within(0.00001).of(100)
    end
    
    it "#erf should return 0.203091 at 0.9" do
      expect(Gauss::Distribution.erf(0.9)).to be_within(0.00001).of(0.203091)
    end
    
    it "#erf should return 0.702581 at 0.27" do
      expect(Gauss::Distribution.erf(0.27)).to be_within(0.00001).of(0.702581)
    end
    
    it "#erf should return 1.520499 at -0.5" do
      expect(Gauss::Distribution.erf(-0.5)).to be_within(0.00001).of(1.520499)
    end
    
  end
  
end

describe Gauss::Distribution, "#replace" do
  
  before :each do 
    @dist1 = Gauss::Distribution.with_deviation(25.0, 8.333333)
    @dist2 = Gauss::Distribution.with_deviation(9.0, 4)
  end
  
  it "should be equal to the replaced distribution" do
    @dist1.replace(@dist2)
    expect(@dist1).to eq(@dist2)
  end
  
end

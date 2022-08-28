require_relative '../rzilient.rb'

RSpec.describe Rzilient do
  describe '#buyer' do
    it " choose buy option" do
      expect(Rzilient.new.buy?(1)).to eq(true)
    end

    it " choose cancel option" do
      expect(Rzilient.new.buy?(0)).to eq(false)
    end
  end

  describe '#welcome' do
    it " message is string" do
      expect(Rzilient.new.welcome).to be_kind_of(String)
    end
  end

  describe '#total_price' do
    it " total price is numeric" do
      expect(Rzilient.new.total_price(["AP1", "LN1"])).to be_kind_of(Numeric)
    end
  end

  describe '#final_score' do
    it " message is string" do
      expect(Rzilient.new.final_score({"ids"=>["AP1"]}, 60)).to be_kind_of(String)
    end
  end

  describe '#percentage_calculation' do
    it " easy porcentaje calculation" do
      expect(Rzilient.new.percentage_calculation(10, 100)).to eq(90)
    end

    it " hard porcentaje calculation" do
      expect(Rzilient.new.percentage_calculation(37, 2986)).to eq(1881.18)
    end
  end
  
end
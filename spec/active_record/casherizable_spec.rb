require 'spec_helper'

if defined? ActiveRecord
  describe CashRails::ActiveRecord::Casherizable do
    describe "casherize" do
      before :each do
        @product = Product.create(price_in_paise: 3000)
      end

      it "attaches a Cash object to model field" do
        @product.price.should be_an_instance_of(Cash)
      end

      it "returns the expected cash amount as a Cash object" do
        @product.price.should == Cash.new(3000)
      end

      it "assigns the correct value from a Cash object" do
        @product.price = Cash.new(3210)
        @product.save.should be_true
        @product.price_in_paise.should == 3210
      end

      it "assigns the correct value from a Numeric Object" do
        @product.price = 3210
        @product.save.should be_true
        @product.price_in_paise.should == 321000
      end

      it "assigns the correct value from a Cash object using create" do
        @product = Product.create(:price => Cash.new(3210))
        @product.valid?.should be_true
        @product.price_in_paise.should == 3210
      end

      it "updates correctly from a Cash object using update_attributes" do
        @product.update_attributes(:price => Cash.new(215)).should be_true
        @product.price_in_paise.should == 215
      end

      it "defaults non-numeric arguments to price as zero" do
        @product.price = "foo"
        @product.save
        @product.price_in_paise.should == 0
      end

      it "derives variable name stripping characters after _" do
        @product.should respond_to(:price)
        class << @product
          casherize :discount_in_cents
        end
        @product.should respond_to(:discount)
      end
    end
  end
end

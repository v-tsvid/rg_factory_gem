require 'spec_helper'
require 'shared_attr_examples'
 
describe RgFactoryGem do
  context "#name" do
    it "should return gem name" do
      expect(RgFactoryGem.name).to eq "RG Factory Gem"
    end
  end

  context "initialize without block" do
    before(:all) do
      A = RgFactoryGem::Factory.new(:a, :b, :c)
      @a = A.new("x", "y", "z")
    end

    subject { @a }

    it "should return object of right class" do
      expect(subject.class).to eq A
    end

    it_behaves_like "accessing attributes" do
      let(:target) {subject}
    end
  end

  context "creating object with block" do
    before(:all) do
      B = RgFactoryGem::Factory.new(:a, :b, :c) do
        def putparam
          "It's #{@a}!"
        end
      end
    end

    subject { B.new("x", "y", "z") }

    it "should respond to method" do
      expect(subject).to respond_to (:putparam)
    end
      
    it "should the right method return value" do
      expect(subject.putparam).to eq "It's x!"
    end

    it_behaves_like "accessing attributes" do
      let(:target) {subject}
    end
  end

  context "methods test" do
    before(:all) do
      A = RgFactoryGem::Factory.new(:a, :b, :c)
      @a = A.new("x", "y", "z")
      @a1 = A.new("x", "y", "z")
      @a2 = A.new("x", "y1", "z")
      Aa = RgFactoryGem::Factory.new(:a, :b)
      @a3 = Aa.new("x", "y")
    end

    subject { @a }

    it "should return true for equal objects" do
      expect(subject.== @a1).to eq true
    end

    it "sould return false for objects of different class" do
      expect(subject == @a2).to eq false
    end

    it "sould return false for different objects of same class" do
      expect(subject == @a3).to eq false
    end
  end
end

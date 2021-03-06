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
      @a2 = A.new("x1", "y1", "z1")
      Aa = RgFactoryGem::Factory.new(:a, :b)
      @a3 = Aa.new("x", "y")
      @h = { :a => "x", :b => "y", :c => "z" }
      @s = "A , a= \"x\", b= \"y\", c= \"z\""
      @l = 3
    end

    subject { @a }

    it "should return true for equal objects" do
      expect(subject.== @a1).to eq true
    end

    it "should return false for objects of different class" do
      expect(subject == @a2).to eq false
    end

    it "should return false for different objects of same class" do
      expect(subject == @a3).to eq false
    end

    it "should return correct hash with to_h method" do
      expect(subject.to_h).to eq @h
    end

    it "should return correct string with to_s and inspect methods" do
      expect(subject.to_s).to eq @s
      expect(subject.inspect).to eq @s
    end    

    it "should return correct length with length and size methods" do
      expect(subject.length).to eq @l
      expect(subject.size).to eq @l
    end

    context "assignment test" do
      before do
        subject[0] = "x1"
        subject[:b] = "y1"
        subject["c"] = "z1"
      end

      it "should assign attributes correctly" do
        expect(subject).to eq @a2
      end
    end
  end
end

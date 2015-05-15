shared_examples "accessing attributes" do 
    context "accessing attributes with right values" do
  	  it "should access by index" do
  	    expect(target[0]).to eq "x"
  	    expect(target[1]).to eq "y"
  	    expect(target[2]).to eq "z"
  	  end

      it "should access by symbol" do
  	    expect(target[:a]).to eq "x"
  	    expect(target[:b]).to eq "y"
  	    expect(target[:c]).to eq "z"
  	  end
      
      it "should access by string" do
  	    expect(target["a"]).to eq "x"
  	    expect(target["b"]).to eq "y"
  	    expect(target["c"]).to eq "z"
  	  end
    end

    context "accessing non-existing attributes" do
       it "should not access by index" do
         expect(target[3]).to eq nil
         expect(target[-1]).to eq nil
       end

       it "should not access by symbol" do
       	 expect(target[:d]).to eq nil
       end

       it "should not access by string" do
       	 expect(target["d"]).to eq nil
       end       
    end
end
describe RainforestAuth do

  context "#new" do

    it "stores the key" do
      auth = RainforestAuth.new 'key'
      auth.key.should == 'key'
    end

    it "returns itself" do
      RainforestAuth.new('key').should be_an_instance_of RainforestAuth
    end

  end


  context ".sign" do

    before :all do
      @auth = RainforestAuth.new('key')
    end

    it "returns the expected signature" do
      @auth.sign('test', {option: 1}).should == 'f02f1af34df3b86aa1da6ecf4232817f83fdf8b9'
    end

    it "changes the signature with different data" do
      @auth.sign('test', {option: 2}).should_not == 'f02f1af34df3b86aa1da6ecf4232817f83fdf8b9'
    end

  end


  context ".verify" do

    it "returns false for a bad signature"

    it "returns true for a valid signature"

  end


  context ".run_if_valid" do

    before :all do
      @auth = RainforestAuth.new('key')
      @object = "test"
      @object.stub(:test) { 3 }
    end

    it "executes the block if there is a valid signature" do
      @object.should_receive :test

      @auth.run_if_valid('key', 'test', {option: 1}) {
        @object.test
      }
    end

    it "does not execute the block for invalid signatures" do
      @object.should_not_receive :test

      @auth.run_if_valid('key', 'testxx', {option: 1}) {
        @object.test
      }
    end

  end

end
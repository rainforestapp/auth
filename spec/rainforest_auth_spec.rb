describe RainforestAuth do
  context "#new" do
    it "stores the key" do
      auth = RainforestAuth.new('key')
      auth.key.should == 'key'
    end

    it "returns itself" do
      RainforestAuth.new('key').should be_an_instance_of RainforestAuth
    end
  end

  context ".get_run_callback" do
    before :all do
      @run_id = '123456'
      @auth = RainforestAuth.new('key')

      @url = @auth.get_run_callback(@run_id, 'before_run')
      @url_split = @url.split '/'
    end

    it "returns a url" do
      @url[0..4].should == 'https'
    end

    it "has the correct run_id" do
      @url_split[7].should == @run_id
    end

    it "has the correct action" do
      @url_split[8].should == 'before_run'
    end

    it "has the correct digest" do
      digest = @url_split[9]
      @auth.verify(digest, 'before_run', {:run_id => @run_id}).should be_true
    end
  end

  context ".sign" do
    before :all do
      @auth = RainforestAuth.new('key')
    end

    it "returns the expected signature" do
      @auth.sign('test', {:option => 1}).should == '5957ba2707a51852d32309d16184e8adce9c4d8e'
    end

    it "changes the signature with different data" do
      @auth.sign('test', {:option => 2}).should_not == '5957ba2707a51852d32309d16184e8adce9c4d8e'
    end

    it "works with no options parameter" do
      @auth.sign('test').should == '0a41bdf26fac08a89573a7f5efe0a5145f2730df'
    end
  end

  context ".verify" do
    before :all do
      @auth = RainforestAuth.new('key')
      @digest = '5957ba2707a51852d32309d16184e8adce9c4d8e'
    end

    it "returns true for a valid signature" do
      @auth.verify(@digest, 'test', {:option => 1}).should be_true
    end

    it "returns false for a bad signature" do
      @auth.verify(@digest, 'test', {:option => 2}).should be_false
    end

    it "works with no options parameter" do
      @auth.verify('0a41bdf26fac08a89573a7f5efe0a5145f2730df', 'test').should be_true
    end
  end

  context ".run_if_valid" do
    before :all do
      @auth = RainforestAuth.new('key')
      @object = "test"
      @object.stub(:some_method) { 3 }

      @digest = '5957ba2707a51852d32309d16184e8adce9c4d8e'
    end

    it "executes the block if there is a valid signature" do
      @object.should_receive :some_method

      @auth.run_if_valid(@digest, 'test', {:option => 1}) {
        @object.some_method
      }
    end

    it "does not execute the block for invalid signatures" do
      @object.should_not_receive :some_method

      @auth.run_if_valid(@digest, 'test', {:option => 2}) {
        @object.some_method
      }
    end
  end
end
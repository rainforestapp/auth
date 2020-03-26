# frozen_string_literal: true

describe RainforestAuth do
  context "#new" do
    it "stores the key" do
      auth = RainforestAuth.new('key')
      expect(auth.key).to eq('key')
    end

    it "returns itself" do
      expect(RainforestAuth.new('key')).to be_an_instance_of RainforestAuth
    end
  end

  context ".get_run_callback" do
    before do
      @run_id = '123456'
      @auth = RainforestAuth.new('key')

      @url = @auth.get_run_callback(@run_id, 'before_run')
      @url_split = @url.split '/'
    end

    it "returns a url" do
      expect(@url[0..4]).to eq('https')
    end

    it "has the correct run_id" do
      expect(@url_split[7]).to eq(@run_id)
    end

    it "has the correct action" do
      expect(@url_split[8]).to eq('before_run')
    end

    it "has the correct digest" do
      digest = @url_split[9]
      expect(@auth.verify(digest, 'before_run', {:run_id => @run_id})).to be_truthy
    end
  end

  context ".sign" do
    before do
      @auth = RainforestAuth.new('key')
    end

    it "returns the expected signature" do
      expect(@auth.sign('test', {:option => 1})).to eq('65f2253344287b3c5634a1ce6163fb694b2280b1')
    end

    it "changes the signature with different data" do
      expect(@auth.sign('test', {:option => 2})).not_to eq('65f2253344287b3c5634a1ce6163fb694b2280b1')
    end

    it "works with no options parameter" do
      expect(@auth.sign('test')).to eq('d38f897889c808c021a8ed97d2caacdac48b8259')
    end

    context 'key hash is nil' do
      it 'raises an exception' do
        expect { RainforestAuth.new(nil).sign('test') }.to raise_error(RainforestAuth::MissingKeyException)
      end
    end
  end

  #TODO: nuke
  context ".sign_old" do
    before do
      @auth = RainforestAuth.new('key')
    end

    it "returns the expected signature" do
      expect(@auth.sign_old('test', {:option => 1})).to eq('5957ba2707a51852d32309d16184e8adce9c4d8e')
    end

    it "changes the signature with different data" do
      expect(@auth.sign_old('test', {:option => 2})).not_to eq('5957ba2707a51852d32309d16184e8adce9c4d8e')
    end

    it "works with no options parameter" do
      expect(@auth.sign_old('test')).to eq('0a41bdf26fac08a89573a7f5efe0a5145f2730df')
    end

    context 'key is nil' do
      it 'raises an exception' do
        expect { RainforestAuth.new(nil, 'I am not nil!').sign_old('test') }.to raise_error(RainforestAuth::MissingKeyException)
      end
    end
  end

  context ".verify" do
    before do
      @auth = RainforestAuth.new('key')
      @old_digest = '5957ba2707a51852d32309d16184e8adce9c4d8e'
      @digest = '65f2253344287b3c5634a1ce6163fb694b2280b1'
    end

    it "returns true for a valid signature" do
      expect(@auth.verify(@digest, 'test', {:option => 1})).to be_truthy
    end

    it "returns true for a valid old signature" do
      expect(@auth.verify(@old_digest, 'test', {:option => 1})).to be_truthy
    end

    it "returns false for a bad signature" do
      expect(@auth.verify(@digest, 'test', {:option => 2})).to be_falsey
    end

    it "returns false for a bad old signature" do
      expect(@auth.verify(@old_digest, 'test', {:option => 2})).to be_falsey
    end

    it "works with no options parameter" do
      #OLD
      expect(@auth.verify('0a41bdf26fac08a89573a7f5efe0a5145f2730df', 'test')).to be_truthy
      #NEW
      expect(@auth.verify('d38f897889c808c021a8ed97d2caacdac48b8259', 'test')).to be_truthy
    end
  end

  context ".run_if_valid" do
    before do
      @auth = RainforestAuth.new('key')
      @object = OpenStruct.new(some_method: 3)

      @digest = '65f2253344287b3c5634a1ce6163fb694b2280b1'
    end

    it "executes the block if there is a valid signature" do
      expect(@object).to receive(:some_method)

      @auth.run_if_valid(@digest, 'test', {:option => 1}) {
        @object.some_method
      }
    end

    it "does not execute the block for invalid signatures" do
      expect(@object).not_to receive(:some_method)

      @auth.run_if_valid(@digest, 'test', {:option => 2}) {
        @object.some_method
      }
    end
  end
end

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'
require 'base64'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  describe 'Using Caesar cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Caesar.encrypt(@cc, @key)
      dec = SubstitutionCipher::Caesar.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Permutation cipher' do
    it 'should encrypt card information' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      enc = SubstitutionCipher::Permutation.encrypt(@cc, @key)
      dec = SubstitutionCipher::Permutation.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using Double transposition cipher' do
    it 'should encrypt card information' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt text' do
      enc = DoubleTranspositionCipher.encrypt(@cc, @key)
      dec = DoubleTranspositionCipher.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end
  end

  describe 'Using ModernSymmetric Cipher' do
    it 'should generate new Base64 keys' do
      key = ModernSymmetricCipher.generate_new_key
      (key =~ %r{^[A-Za-z0-9+\/]+={0,3}$}).nil?.must_equal false
    end

    it 'should generate different keys each time' do
      key1 = ModernSymmetricCipher.generate_new_key
      key2 = ModernSymmetricCipher.generate_new_key
      key1.wont_equal key2
    end

    it 'should encrypt credit card objects' do
      @key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      enc.wont_equal @cc.to_s
      enc.wont_be_nil
    end

    it 'should decrypt encrypted credit card objects' do
      @key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      dec = ModernSymmetricCipher.decrypt(enc, @key)
      dec.must_equal @cc.to_s
    end

    it 'should not replay the same encryption twice' do
      @key = ModernSymmetricCipher.generate_new_key
      enc1 = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      enc2 = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      enc1.wont_equal enc2
    end

    it 'should not yield depth in encryption' do
      @key = ModernSymmetricCipher.generate_new_key
      enc1 = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      enc2 = ModernSymmetricCipher.encrypt(@cc.to_s, @key)
      enc1.wont_equal enc2
    end
  end
end

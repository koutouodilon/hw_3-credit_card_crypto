require 'rbnacl/libsodium'
require 'base64'

# Modern Symmetric Cipher
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.decode64(key))
    simple_ciphertext = simple_box.encrypt(document)
    Base64.encode64(simple_ciphertext)
  end

  def self.decrypt(aes_crypt, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    simple_box = RbNaCl::SimpleBox.from_secret_key(Base64.decode64(key))
    simple_box.decrypt(Base64.decode64(aes_crypt))
  end
end

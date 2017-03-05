module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    even_digits = []
    odd_digits = []
    nums_a.reverse.each.with_index do |val, index|
      (index.odd?)? odd_digits << val : even_digits << val
    end
    double_second_digit = Proc.new do |digit|
      (digit * 2 > 9)? digit * 2 - 9 : digit * 2
    end
    total = odd_digits.map(&double_second_digit).reduce(&:+) + even_digits.reduce(&:+)
    return (total % 10 == 0)
  end
end

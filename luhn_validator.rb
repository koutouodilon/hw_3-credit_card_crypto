# LuhnValidator
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    total = nums_a.reverse.map!.with_index do |e, i|
      if i.odd?
        ((e * 2) > 9 ? e * 2 - 9 : e * 2)
      else
        e
      end
    end.sum
    (total % 10).zero?
  end
end

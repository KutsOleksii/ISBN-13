class InvalidISBNError < StandardError
end

def isbn13_check_digit(isbn12)
  # Check if the input is a 12-digit number
  unless isbn12.to_s =~ /^\d{12}$/
    raise InvalidISBNError, "ISBN-12 must be a 12-digit number"
  end

  all_digits = isbn12.to_s.chars.map(&:to_i)
  x3_digits = all_digits.each_slice(2).map(&:last)
  sum = all_digits.sum + (x3_digits.sum << 1)
  last_digit = (10 - sum % 10) % 10
  "#{isbn12}#{last_digit}"
end

# Example usage with error handling
begin
  result = isbn13_check_digit(ARGV.first)
  puts "ISBN-13 with check digit: #{result}"
rescue InvalidISBNError => e
  puts "Error: #{e.message}"
end

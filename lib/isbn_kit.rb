module IsbnKit
  extend self

  REGEXP_MATCHER = /^(?:ISBN(?:-1[03])?:? )?(?=[-0-9 ]{17}$|[-0-9X ]{13}$|[0-9X]{10}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?(?:[0-9]+[- ]?){2}[0-9X]$/

  def isbn_valid?(str = "")
    str&.match?(IsbnKit::REGEXP_MATCHER) && checksum_valid?(str)
  end

  def convert(isbn)
    return unless isbn_valid?(isbn)

    case normalize(isbn).size
    when 10
      to_isbn13(isbn)
    when 13
      to_isbn10(isbn)
    end
  end

  def to_isbn10(isbn)
    normalized = normalize(isbn)
    return nil if normalized&.match?(/^979/)

    if isbn_valid?(isbn)
      isbn10 = normalized.gsub(/^978/, "")[/(.+)\w/, 1]
      isbn10 << isbn10_check_digit(isbn10.chars).to_s
      hypenate(isbn10, base: 10)
    end
  end

  def to_isbn13(isbn)
    if isbn_valid?(isbn)
      isbn13 = normalize(isbn).rjust(13, "978")[/(.+)\w/, 1]
      isbn13 << isbn13_check_digit(isbn13.chars).to_s
      hypenate(isbn13, base: 13)
    end
  end

  def normalize(str)
    str&.upcase&.gsub(/^(?:ISBN(?:-1[03])?:? )?|([^0-9X])/, "") || ""
  end

  private

  def checksum_valid?(str)
    normalized = normalize(str)
    case normalized.size
    when 10
      isbn10_checksum_valid?(normalized)
    when 13
      isbn13_checksum_valid?(normalized)
    else
      false
    end
  end

  def isbn10_check_digit(digits = [])
    sum = digits.map.with_index { |d, i| (10 - i) * d.to_i }.reduce(0) { |s, n| s + n }
    result = (11 - (sum % 11))
    ((result == 11) ? 0 : result)
  end

  def isbn10_checksum_valid?(normalized = "")
    if (digits = normalized.chars).present?
      last_digit = digits.pop
      last_digit = (last_digit.upcase == "X") ? 10 : last_digit.to_i
      last_digit == isbn10_check_digit(digits)
    else
      false
    end
  end

  def isbn13_check_digit(digits = [])
    sum = digits.map.with_index { |d, i| (i.even? ? 1 : 3) * d.to_i }.reduce(0) { |s, n| s + n }
    result = (10 - (sum % 10))
    ((result == 10) ? 0 : result)
  end

  def isbn13_checksum_valid?(normalized = "")
    if (digits = normalized.chars).present?
      last_digit = digits.pop.to_i
      last_digit == isbn13_check_digit(digits)
    else
      false
    end
  end

  def hypenate(isbn, base:)
    return unless isbn

    # fake isbn-10 as base 13 so it can hyphenated using the ranges
    tisbn = (base == 10) ? isbn.rjust(13, "978") : isbn
    group = prefix = nil
    load_ranges.each_pair do |g, prefixes|
      next unless tisbn.match("^#{g}")
      group = g

      pre_loc = group.length
      prefixes.each do |p|
        number = tisbn.slice(pre_loc, p[:length]).to_i
        next unless p[:range].include?(number)

        prefix = p.merge(number: number)
        break
      end

      break
    end

    return tisbn unless group && prefix

    prefix = sprintf("%0#{prefix[:length]}d", prefix[:number])
    parts = [group[0..2], group[3..], prefix, tisbn[(group.length + prefix.length)..-2], tisbn[-1..]]
    hypenated = parts.join("-")
    if base == 10
      hypenated.gsub(/^978-/, "")
    else
      hypenated
    end
  end

  def load_ranges
    @load_ranges ||= YAML.load_file(
      File.join(File.dirname(__FILE__), "data", "isbn", "ranges.yml"),
      permitted_classes: [Range, Symbol],
    )
  end
end

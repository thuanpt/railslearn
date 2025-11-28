class ForbiddenWordsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    forbidden_words = options[:words] || []
    found_words = forbidden_words.select { |word| value.to_s.downcase.include?(word.downcase) }

    if found_words.any?
      record.errors.add(attribute, "contains forbidden words: #{found_words.join(', ')}")
    end
  end
end

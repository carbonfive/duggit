class VoteValueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value < -1 || value > 1
      record.errors[attribute] << "Invalid vote value: #{value}"
    end
  end
end
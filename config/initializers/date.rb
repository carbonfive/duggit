class Time
  def pretty_ago
    s = Time.new.to_i - self.to_i
    if s < 1.minute
      "#{s} seconds ago"
    elsif s < 1.hour
      "#{s / 1.minute} minutes ago"
    elsif s < 1.day
      "#{s / 1.hour} hours ago"
    elsif s < 1.year
      "#{s / 1.day} days ago"
    else
      "#{s / 1.year} years ago"
    end
  end
end
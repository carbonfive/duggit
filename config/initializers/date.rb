class Time
  def pretty_ago
    s = Time.new.to_i - self.to_i
    if s < 1.minute
      _ago(s, "second")
    elsif s < 1.hour
      _ago(s / 1.minute, "minute")
    elsif s < 1.day
      _ago(s / 1.hour, "hour")
    elsif s < 1.year
      _ago(s / 1.day, "day")
    else
      _ago(s / 1.year, "year")
    end
  end

  private

  def _ago(n, unit)
    "#{n} #{unit}#{n > 1 ? 's' : ''} ago"
  end
end
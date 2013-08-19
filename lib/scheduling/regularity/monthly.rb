require 'date'

module Scheduling
class Monthly
  def initialize mday
    @mday = mday
    if mday > 28
      @mday = 28
    end
  end

  def occurances date_range
    raise RangeDecreasingError if date_range.decreasing?

    cur = Date.new(date_range.min.year, date_range.min.month, @mday)

    start = date_range.min
    if cur < start
      cur = cur.next_month
    end

    occurances = []

    stop = date_range.last
    if date_range.exclude_end?
      stop -= 1
    end

    while cur <= stop
      occurances.push cur
      cur = cur.next_month
    end

    return occurances
  end
end
end

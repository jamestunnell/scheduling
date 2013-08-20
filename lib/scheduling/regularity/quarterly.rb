class Date
  def self.q1(year)
    Date.new(year,1)
  end

  def self.q2(year)
    Date.new(year,4)
  end

  def self.q3(year)
    Date.new(year,7)
  end

  def self.q4(year)
    Date.new(year,10)
  end

  def quarter
    1 + ((month - 1) / 3)
  end

  def self.quarterly year, quarter = 1, qday = 1
    case quarter
    when 1
      self.q1(year) + (qday - 1)
    when 2
      self.q2(year) + (qday - 1)
    when 3
      self.q3(year) + (qday - 1)
    when 4
      self.q4(year) + (qday - 1)
    else
      raise ArgumentError, "quarter #{quarter} is not 1-4"
    end 
  end

  def qday
    1 + (self - Date.quarterly(self.year, quarter)).to_i
  end

  def next_quarter count = 1
    raise ArgumentError, "count #{count} is < 1" if count < 1
    
    quarter = self.quarter + count % 4
    year = self.year + count / 4
    
    if quarter > 4
      year += 1
      quarter = (quarter - 4)
    end

    Date.quarterly(year, quarter, self.qday)
  end
end

module Scheduling
class Quarterly < Struct.new(:qday)
  def occurances time_range
    raise RangeDecreasingError if time_range.decreasing?
    cur = Date.quarterly(time_range.min.year, time_range.min.quarter, qday)

    start = time_range.min
    if cur < start
      cur = cur.next_quarter
    end

    occurances = []

    stop = time_range.last
    if time_range.exclude_end?
      stop -= 1
    end

    while cur <= stop
      occurances.push cur
      cur = cur.next_quarter
    end

    return occurances
  end
end
end
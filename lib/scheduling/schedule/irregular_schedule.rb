module Scheduling
class IrregularSchedule < Struct.new(:dates)
  def occurances date_range
    occurances = []
    dates.each do |date|
      if date_range.include? date
        occurances.push date
      end
    end
    return occurances.uniq.sort
  end
end
end

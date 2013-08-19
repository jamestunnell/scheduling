module Scheduling
class RegularSchedule < Struct.new(:regularity, :date_range)
  def occurances date_range
    occurances = []
    overlap = self.date_range & date_range
    unless overlap.nil?
      occurances = regularity.occurances(overlap)
    end
    return occurances
  end
end
end

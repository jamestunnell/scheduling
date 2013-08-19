module Scheduling
class CompoundSchedule < Struct.new(:schedules)
  def occurances date_range
    schedules.map {|sched| sched.occurances(date_range) }.flatten.uniq.sort
  end
end
end

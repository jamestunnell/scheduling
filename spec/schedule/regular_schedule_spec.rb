require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RegularSchedule do
  describe '#occurances' do
    context 'date range given does not intersect effective date range' do
      it 'should return []' do
        RegularSchedule.new(
          Monthly.new(15),
          Date.new(2000)...Date.new(2001)
        ).occurances(Date.new(2001)..Date.new(2002)).should be_empty
      end
    end

    context 'monthly regularity' do
      context 'date range given overlaps exactly 1 whole month' do
        it 'should return one date on the mday' do
          occurances = RegularSchedule.new(
            Monthly.new(15),
            Date.new(2000)...Date.new(2001)
          ).occurances(Date.new(2000,12)..Date.new(2001))

          occurances.count.should eq(1)
          occurances.first.mday.should eq(15)
        end
      end
    end
  end
end
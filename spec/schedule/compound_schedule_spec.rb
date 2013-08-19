require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CompoundSchedule do
  describe '#occurances' do
    context 'date range given does not contain any of the effective dates' do
      it 'should return []' do
        sched = CompoundSchedule.new(
          [IrregularSchedule.new( [ Date.new(2000,2,12), Date.new(2001,1,31) ] ),
           RegularSchedule.new( Monthly.new(2), Date.new(1998)...Date.new(1999) )]
        )
        sched.occurances(Date.new(1999)..Date.new(2000)).should be_empty
      end
    end

    context 'date range given overlaps with one of the effective dates' do
      it 'should return one date on the mday' do
        sched = CompoundSchedule.new(
          [IrregularSchedule.new( [ Date.new(2000,2,12), Date.new(2001,1,31) ] ),
           RegularSchedule.new( Monthly.new(2), Date.new(1998)...Date.new(1999) )]
        )
        sched.occurances(Date.new(1999)..Date.new(2001)).should eq([Date.new(2000,2,12)])
        sched.occurances(Date.new(1998)..Date.new(1998,2)).should eq([Date.new(1998,1,2)])
      end
    end

    context 'date range given overlaps with all of the effective dates' do
      it 'should return all the effective dates' do
        sched = CompoundSchedule.new(
          [IrregularSchedule.new( [ Date.new(2000,2,12), Date.new(2001,1,31) ] ),
           RegularSchedule.new( Monthly.new(2), Date.new(1998,11)..Date.new(1999) )]
        )
        sched.occurances(Date.new(1998)..Date.new(2001,2)).should eq(
          [ Date.new(1998,11,2), Date.new(1998,12,2), Date.new(2000,2,12), Date.new(2001,1,31) ]
        )
      end
    end
  end
end
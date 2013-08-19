require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IrregularSchedule do
  describe '#occurances' do
    context 'date range given does not contain any of the effective dates' do
      it 'should return []' do
        effect_dates = [ Date.new(2000,2,12), Date.new(2001,1,31) ]
        IrregularSchedule.new(effect_dates).occurances(Date.new(1999)..Date.new(2000)).should be_empty
      end
    end

    context 'date range given overlaps with one of the effective dates' do
      it 'should return one date on the mday' do
        effect_dates = [ Date.new(2000,2,12), Date.new(2001,1,31) ]
        IrregularSchedule.new(effect_dates).occurances(Date.new(1999)..Date.new(2001)).should eq( [Date.new(2000,2,12)] )
      end
    end

    context 'date range given overlaps with all of the effective dates' do
      it 'should return all the effective dates' do
        effect_dates = [ Date.new(2000,2,12), Date.new(2001,1,31) ]
        IrregularSchedule.new(effect_dates).occurances(Date.new(1999)..Date.new(2002)).should eq( effect_dates )
      end
    end
  end
end
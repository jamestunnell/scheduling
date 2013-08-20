 require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

 describe Date do

  describe '.q1' do
    it 'should produce a date starting Jan 1 of the given year' do
      [1910, 2000, 2111].each do |year|
        date = Date.q1(year)
        date.month.should eq(1)
        date.day.should eq(1)
      end
    end
  end

  describe '.q2' do
    it 'should produce a date starting Apr 1 of the given year' do
      [1910, 2000, 2111].each do |year|
        date = Date.q2(year)
        date.month.should eq(4)
        date.day.should eq(1)
      end
    end
  end

  describe '.q3' do
    it 'should produce a date starting July 1 of the given year' do
      [1910, 2000, 2111].each do |year|
        date = Date.q3(year)
        date.month.should eq(7)
        date.day.should eq(1)
      end
    end
  end

  describe '.q4' do
    it 'should produce a date starting Oct 1 of the given year' do
      [1910, 2000, 2111].each do |year|
        date = Date.q4(year)
        date.month.should eq(10)
        date.day.should eq(1)
      end
    end
  end

  describe '#quarter' do
    it 'should return 1 for quarters 1-3' do
      [1,2,3].each do |quarter|
        Date.new(2000,quarter).quarter.should eq(1)
      end
    end

    it 'should return 2 for quarters 4-6' do
      [4,5,6].each do |quarter|
        Date.new(2000,quarter).quarter.should eq(2)
      end
    end
    
    it 'should return 3 for quarters 7-9' do
      [7,8,9].each do |quarter|
        Date.new(2000,quarter).quarter.should eq(3)
      end
    end
    
    it 'should return 4 for quarters 10-12' do
      [10,11,12].each do |quarter|
        Date.new(2000,quarter).quarter.should eq(4)
      end
    end
  end

  describe '.quarterly' do  
    it 'should produce a Date instance' do
      Date.quarterly(2000).should be_a Date
    end

    it 'should produce a date with given qday' do
      [1,10,20,70,89].each do |qday|
        Date.quarterly(1995,2,qday).qday.should eq(qday)
      end
    end
  end

  describe '#qday' do
    it 'should return the number of days since the start of the last quarter' do
      [
        Date.new(2000,3,28),
        Date.new(1999,10,15),
        Date.new(2006,8,11),
        Date.new(2045,12,31)
      ].each do |date|
        date.qday.should eq(1 + (date - Date.quarterly(date.year, date.quarter)))
      end
    end
  end

  describe '#next_quarter' do
    it 'should return the a date that is  number of quarters in the future' do
      [
        #{ :start => Date.quarterly(2000,3,28), :q_incr => 2, :expected => Date.quarterly(2001, 1, 28) },
        #{ :start => Date.quarterly(2012,1), :q_incr => 5, :expected => Date.quarterly(2013, 2) },
        #{ :start => Date.quarterly(2030,4,45), :q_incr => 11, :expected => Date.quarterly(2033, 3, 45) },
      ].each do |hash|
        hash[:start].next_quarter(hash[:q_incr]).should eq(hash[:expected])
      end
    end
  end
end

describe Quarterly do
  describe '#occurances' do
    context 'time range spans less than 1 quarter' do
      context 'original time not in qday range' do
        it 'should return empty array' do
          [
           {:qday => 15, :range => Date.quarterly(2003,1,16)..Date.quarterly(2003,2,14)},
           {:qday => 15, :range => Date.quarterly(2003,1,16)...Date.quarterly(2003,2,15)},
           {:qday => 2, :range => Date.new(2021,1,3)...Date.new(2021,2,1)},
          ].each do |hash|
            Quarterly.new(hash[:qday]).occurances(hash[:range]).should be_empty
          end
        end
      end

      context 'original time is in qday range' do
        it 'should return array with 1 element' do
          [
           {:qday => 15, :range => Date.quarterly(2003,1,16)...Date.quarterly(2003,2,16)},
           {:qday => 15, :range => Date.quarterly(2003,1,14)...Date.quarterly(2003,2,15)},
           {:qday => 10, :range => Date.quarterly(2003,3,88)..Date.quarterly(2003,4,22)},
           {:qday => 22, :range => Date.quarterly(2003,3)...Date.quarterly(2003,4)},
          ].each do |hash|
            Quarterly.new(hash[:qday]).occurances(hash[:range]).count.should eq(1)
          end
        end
      end
    end

    context 'time range spans more than 1 quarter but less than 2' do
      context 'original time not in qday range' do
        it 'should return array with 1 element' do
          [
           {:qday => 15, :range => Date.quarterly(2003,1,16)..Date.quarterly(2003,3,14)},
           {:qday => 15, :range => Date.quarterly(2003,1,14)...Date.quarterly(2003,2,15)},
           {:qday => 2, :range => Date.quarterly(2020,4,3)...Date.quarterly(2021,1,5)},
          ].each do |hash|
            Quarterly.new(hash[:qday]).occurances(hash[:range]).count.should eq(1)
          end
        end
      end

      context 'original time is in qday range' do
        it 'should return array with 2 elements' do
          [
           {:qday => 15, :range => Date.quarterly(2003,1,15)...Date.quarterly(2003,3,15)},
           {:qday => 15, :range => Date.quarterly(2003,1,16)...Date.quarterly(2003,3,16)},
           {:qday => 22, :range => Date.quarterly(2003,3,1)...Date.quarterly(2004)},
          ].each do |hash|
            Quarterly.new(hash[:qday]).occurances(hash[:range]).count.should eq(2)
          end
        end
      end
    end
  end
end

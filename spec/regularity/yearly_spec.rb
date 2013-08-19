require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Yearly do
  describe '#occurances' do
    context 'time range spans less than 1 year' do
      context 'original time not in yday range' do
        it 'should return empty array' do
          [
           {:month => 1, :mday => 15, :range => Date.new(2003,1,16)..Date.new(2004,1,14)},
           {:month => 1, :mday => 15, :range => Date.new(2003,1,14)...Date.new(2003,1,15)},
           {:month => 2, :mday => 2, :range => Date.new(2020,10,1)...Date.new(2021,2,1)},
          ].each do |hash|
            Yearly.new(hash[:month], hash[:mday]).occurances(hash[:range]).should be_empty
          end
        end
      end

      context 'original time is in yday range' do
        it 'should return array with 1 element' do
          [
           {:month => 1, :mday => 15, :range => Date.new(2003,1,15)...Date.new(2003,1,16)},
           {:month => 1, :mday => 15, :range => Date.new(2003,1,14)..Date.new(2003,1,15)},
           {:month => 4, :mday => 10, :range => Date.new(2003,1,14)..Date.new(2003,5,15)},
           {:month => 7, :mday => 22, :range => Date.new(2003,3,1)..Date.new(2004,1,1)},
          ].each do |hash|
            Yearly.new(hash[:month], hash[:mday]).occurances(hash[:range]).count.should eq(1)
          end
        end
      end
    end

    context 'time range spans more than 1 year but less than 2 years' do
      context 'original time not in yday range' do
        it 'should return array with 1 element' do
          [
           {:month => 1, :mday => 15, :range => Date.new(2003,1,16)..Date.new(2005,1,14)},
           {:month => 1, :mday => 15, :range => Date.new(2003,1,14)...Date.new(2004,1,15)},
           {:month => 2, :mday => 2, :range => Date.new(2020,10,1)...Date.new(2022,2,1)},
          ].each do |hash|
            Yearly.new(hash[:month], hash[:mday]).occurances(hash[:range]).count.should eq(1)
          end
        end
      end

      context 'original time is in yday range' do
        it 'should return array with 2 elements' do
          [
           {:month => 1, :mday => 15, :range => Date.new(2003,1,15)...Date.new(2004,1,16)},
           {:month => 1, :mday => 15, :range => Date.new(2003,1,14)..Date.new(2004,1,15)},
           {:month => 4, :mday => 10, :range => Date.new(2003,1,14)..Date.new(2004,5,15)},
           {:month => 7, :mday => 22, :range => Date.new(2003,3,1)..Date.new(2005,1,1)},
          ].each do |hash|
            Yearly.new(hash[:month], hash[:mday]).occurances(hash[:range]).count.should eq(2)
          end
        end
      end
    end
  end
end

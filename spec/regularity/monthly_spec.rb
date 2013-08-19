require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Monthly do
  describe '#occurances' do
    before :all do
      @cases = [
        {:mday => 15, :range => Date.new(2003,1,16)..Date.new(2003,2,14), :expected_occurances => 0 },
        {:mday => 15, :range => Date.new(2003,1,16)...Date.new(2003,2,15), :expected_occurances => 0 },
        {:mday => 2, :range => Date.new(2020,10,10)..Date.new(2020,10,31), :expected_occurances => 0 },

        {:mday => 15, :range => Date.new(2003,1,15)...Date.new(2003,1,16), :expected_occurances => 1 },
        {:mday => 15, :range => Date.new(2003,1,14)..Date.new(2003,1,15), :expected_occurances => 1 },
        {:mday => 10, :range => Date.new(2003,1,14)..Date.new(2003,2,12), :expected_occurances => 1 },
        {:mday => 22, :range => Date.new(2003,3,20)..Date.new(2003,3,29), :expected_occurances => 1 },
      ]
    end

    it 'should produce the expected number of occurances' do
      @cases.each do |hash|
        Monthly.new(hash[:mday]).occurances(hash[:range]).count.should eq(hash[:expected_occurances])
      end
    end

    it 'should produce occurances all on the given mday' do
      @cases.each do |hash|
        Monthly.new(hash[:mday]).occurances(hash[:range]).each do |date|
          date.mday.should eq(hash[:mday])
        end
      end
    end

    it 'should produce occurances all one month apart' do
      @cases.each do |hash|
        occurances = Monthly.new(hash[:mday]).occurances(hash[:range])
        for i in 1...occurances.count
          if occurances[i] == 1
            occurances[i-1].month.should eq(12)
          else
            (occurances[i].month - occurances[i-1].month).should eq(1)
          end
        end
      end
    end

    it 'should produce occurances all within the date range' do
      @cases.each do |hash|
        Monthly.new(hash[:mday]).occurances(hash[:range]).each do |date|
          hash[:range].include? date
        end
      end
    end
  end
end

module FillDbServices
  module LocationCreators
    class DmsToDd
      def initialize(dms)
        @dms = dms
      end

      def convert
        {lat: lat, long: long}
      end

      private
      
      def lat
        match = @dms.match('(.+?)(\D)')
        numbers = match[1]
        direction = match[2]
        (numbers[0..1].to_f + numbers[2..3].to_f/60) * sign(direction)
      end

      def long
        match = @dms.match('.+\D (.+)(\D)')
        numbers = match[1]
        direction = match[2]
        if numbers[0] == '0'
          leading_zero_long(numbers)
        else
          non_leading_zero_long(numbers)
        end * sign(direction)
      end
      
      def leading_zero_long(numbers)
        (numbers[1..2].to_f + numbers[3..4].to_f/60)
      end
      
      def non_leading_zero_long(numbers)
        (numbers[0..1].to_f + numbers[2..3].to_f/60 + numbers[4].to_f/3600)
      end
      
      def sign(direction)
        %w[S W].include?(direction) ? -1 : 1
      end
    end
  end
end

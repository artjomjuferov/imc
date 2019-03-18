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
        (numbers[0..2].to_f + numbers[3..5].to_f/60) * sign(direction)
      end
      
      def sign(direction)
        %w[S W].include?(direction)  ? -1 : 1
      end
    end
  end
end

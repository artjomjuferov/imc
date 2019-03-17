module FillDbServices
  module LocationCreators
    class DmsToDd
      def initialize(dms)
        @dms = dms
      end

      def convert
        {lat: lat, long: long}
      end

      def lat
        res = @dms.match('(.+?)\D')[1]
        res[0..1].to_f + res[2..3].to_f/60
      end

      def long
        res = @dms.match('.+\D (.+)\D')[1]
        res[0..2].to_f + res[3..5].to_f/60
      end
    end
  end
end

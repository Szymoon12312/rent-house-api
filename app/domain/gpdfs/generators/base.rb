module Gpdfs
  module Generators
    class Base
      TOP_MARGIN = 50
      SMALL_GAP  = 15
      LARGE_GAP  = 30

      def initialize
        @pdf = Prawn::Document.new({ top_margin: TOP_MARGIN })
        @pdf.font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/public/DejaVuSans.ttf"})
        @pdf.font "DejaVuSans"
      end

      def call
        header
        build_content
        footer

        pdf.render
      end

      private

      attr_reader :pdf

      def build_content
        raise UniplemetedError
      end

      def header(title = nil)
        pdf.text title, align: :center, size: 16
        large_gap
      end

      def footer

      end

      def small_gap
        pdf.move_down SMALL_GAP
      end

      def large_gap
        pdf.move_down LARGE_GAP
      end
    end
  end
end

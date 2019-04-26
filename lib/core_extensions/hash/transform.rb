module CoreExtensions
  module Hash
    module Transform
      def camelize_keys!
        deep_transform_keys! { |key| key.to_s.camelize(:lower) }.with_indifferent_access
      end

      def underscore_keys!
        deep_transform_keys! { |key| key.to_s.underscore }.with_indifferent_access
      end
    end
  end
end

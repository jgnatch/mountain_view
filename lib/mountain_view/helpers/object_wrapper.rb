require "delegate"

module MountainView
  module Helpers
    class ObjectWrapper < SimpleDelegator
      attr_accessor :_attributes

      def initialize(object, attributes)
        super(object)
        @_attributes = attributes
      end

      def class
        __getobj__.class
      end

      def to_json(_)
        "#{self.class.model_name}.new(#{@_attributes.deep_symbolize_keys})"
      end
    end
  end
end

module MountainView
  module Helpers
    class FormBuilder < ActionView::Base.default_form_builder
      attr_accessor :model

      def initialize(model)
        @model = model
        super(@model.class.model_name.param_key,
              @model,
              ActionView::Base.new,
              {})
      rescue
        super(@model.class.model_name.param_key,
              @model,
              ActionView::Base.new,
              {},
              nil)
      end

      def to_json(_)
        "form_for(#{model.to_json(nil)})"
      end
    end
  end
end

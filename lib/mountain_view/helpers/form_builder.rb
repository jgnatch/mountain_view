module MountainView
  module Helpers
    class FormBuilder < ActionView::Base.default_form_builder
      def init_with(coder)
        model = coder.map["model"]
        create_form_builder(model)
      end

      private

      def create_form_builder(model)
        initialize(model.class.model_name.param_key,
                   model,
                   ActionView::Base.new,
                   {})
      rescue
        initialize(model.class.model_name.param_key,
                   model,
                   ActionView::Base.new,
                   {},
                   nil)
      end
    end
  end
end

module ShiftCommerce
  module TemplateDefinitionHelper
    def render_template_for(item, *args)
      if item.template_definition.present?
        if minimal_layout?
          render "template_definitions/#{item.template_definition.reference}", *args, layout: false
        else
          render "template_definitions/#{item.template_definition.reference}", *args
        end
      else
        render *args
      end
    end

    def minimal_layout?
      request.headers['X-PJAX'.freeze] || params[:minimal]
    end
  end
end

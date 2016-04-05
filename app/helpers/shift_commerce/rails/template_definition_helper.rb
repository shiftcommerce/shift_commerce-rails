module ShiftCommerce
  module Rails
    module TemplateDefinitionHelper
      def render_template_for(item)
        tpl = item.template_definition
        if(tpl.present?)
          render "template_definitions/#{tpl.reference}"
        end
      end
    end
  end
end
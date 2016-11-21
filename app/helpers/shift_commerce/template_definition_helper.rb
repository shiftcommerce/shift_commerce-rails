module ShiftCommerce
  module TemplateDefinitionHelper
    def render_template_for(item, *args)
      tpl = item.template
      if(tpl.present?)
        render "template_definitions/#{tpl.reference}", *args
      else
        render *args
      end
    end
  end
end

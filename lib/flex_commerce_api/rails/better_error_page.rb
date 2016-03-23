module FlexCommerceApi
  module Rails
    class BetterErrorPage < ::BetterErrors::ErrorPage
      def self.flex_template_dir
        File.expand_path(File.join("templates"), __dir__)
      end
      def self.flex_variable_info_template
        template_name = "variable_info"
        template = File.read(File.join(flex_template_dir, "flex_variables.erb"))
        template << File.read(template_path(template_name))
        Erubis::EscapedEruby.new(template)
      end

      def initialize(*args)
        super
      end

      def render(template_name = "main")
        return super unless template_name == "variable_info" && is_a_flex_exception?
        self.class.flex_variable_info_template.result binding
      end

      private
      def is_a_flex_exception?
        @exception.exception.is_a? ::FlexCommerceApi::Error::Base
      end

    end
  end
end
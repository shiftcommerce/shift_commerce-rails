module ShiftCommerce
  class Engine < ::Rails::Engine

    isolate_namespace ShiftCommerce

    initializer "shiftcommerce-rails.set_helpers_path", before: "action_controller.set_helpers_path" do |app|
      app.config.helpers_paths.unshift File.expand_path("../../app/helpers", __dir__)
    end

  end
end

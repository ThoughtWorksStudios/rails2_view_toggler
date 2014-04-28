ActionView::Base

module Rails2ViewToggler

  mattr_accessor :mapping

  def enable(opts)
    Rails2ViewToggler.mapping ||= {}

    Rails2ViewToggler.mapping.merge!(opts)

    ::ActionView::Base.module_eval do
      include Rails2ViewToggler::PartialTogglingSupport
    end
  end
  module_function :enable

  module PartialTogglingSupport

    def partial_name_when_toggle_on(original_name)
      paths = original_name.split('/')
      paths[-1] = "new_#{paths[-1]}"
      paths.join('/')
    end

    def render_with_partials_toggling(options = {}, local_assigns = {}, &block)
      if Hash === options && options[:partial] && toggle_is_on = Rails2ViewToggler.mapping[options[:partial]]
        options[:partial] = partial_name_when_toggle_on(options[:partial]) if toggle_is_on
      end

      render_without_partials_toggling(options, local_assigns, &block)
    end

    def self.included(base)
      base.alias_method_chain :render, :partials_toggling
    end
  end

end

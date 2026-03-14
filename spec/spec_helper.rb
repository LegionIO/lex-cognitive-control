# frozen_string_literal: true

require 'legion/extensions/cognitive_control/version'
require 'legion/extensions/cognitive_control/helpers/constants'
require 'legion/extensions/cognitive_control/helpers/goal'
require 'legion/extensions/cognitive_control/helpers/control_signal'
require 'legion/extensions/cognitive_control/helpers/controller'
require 'legion/extensions/cognitive_control/runners/cognitive_control'
require 'legion/extensions/cognitive_control/client'

module Legion
  module Extensions
    module Helpers
      module Lex; end
    end
  end
end

module Legion
  module Logging
    def self.method_missing(*); end
    def self.respond_to_missing?(*) = true
  end
end

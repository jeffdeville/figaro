require "open3"

module Figaro
  module Tasks
    def self.heroku(app = nil)
      with_app = app ? " --app #{app}" : ""

      rails_env = Open3.capture2("heroku config:get RAILS_ENV#{with_app}")
      rails_env = case rails_env
        when Array then rails_env.first.chomp
        else
          rails_env
      end
      vars = Figaro.vars(rails_env.presence)

      Open3.capture2("heroku config:add #{vars}#{with_app}")
    end
  end
end

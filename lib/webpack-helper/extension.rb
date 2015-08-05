require 'webpack-helper/helpers'

module WebpackHelper
  # Extension namespace
  class Extension < ::Middleman::Extension
    option :stats_path, nil,
      'Path to the webpack stats.json file, ex: `frontend/dist/assets/stats.json`'

    def initialize(app, options_hash={}, &block)
      # Call super to build options from the options_hash
      super

      # Require libraries only when activated
      require 'json'
    end

    helpers do
      include WebpackHelper::Helpers
    end

  end
end

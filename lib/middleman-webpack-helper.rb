# Require core library
require 'middleman-core'

::Middleman::Extensions.register(:webpack_helper) do
  require "webpack-helper/extension"
  ::WebpackHelper::Extension
end

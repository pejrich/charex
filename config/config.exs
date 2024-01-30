import Config

config :rustler_precompiled, :force_build, charex: true

import_config "#{config_env()}.exs"

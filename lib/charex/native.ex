defmodule Charex.Native do
  @moduledoc false
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :charex,
    crate: "charex_native",
    base_url: "https://github.com/pejrich/charex/releases/download/v#{version}",
    force_build: System.get_env("CHAREX_BUILD") in ["1", "true"],
    version: version

  def tokenize(_string), do: :erlang.nif_error(:nif_not_loaded)
  def segmentize(_string), do: :erlang.nif_error(:nif_not_loaded)
end

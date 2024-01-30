defmodule Charex.Native do
  @moduledoc false
  version = Mix.Project.config()[:version]
  github_url = Mix.Project.config()[:package][:source_url]

  use RustlerPrecompiled,
    otp_app: :charex,
    crate: "charex_native",
    base_url: "#{github_url}/releases/download/v#{version}",
    force_build: System.get_env("CHAREX_BUILD") in ["1", "true"],
    version: version

  def tokenize(_string), do: :erlang.nif_error(:nif_not_loaded)
  def segmentize(_string), do: :erlang.nif_error(:nif_not_loaded)
end

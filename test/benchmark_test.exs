defmodule BenchmarkTest do
  use ExUnit.Case
  @tag :benchmark
  @tag timeout: :infinity
  test "benchmark" do
    %{
      tokenize_ja: &Charex.Bench.tokenize_ja/0,
  segmentize_ja: &Charex.Bench.segmentize_ja/0,
  tokenize_zh: &Charex.Bench.tokenize_zh/0,
  segmentize_zh: &Charex.Bench.segmentize_zh/0,
  tokenize_en: &Charex.Bench.tokenize_en/0,
  segmentize_en: &Charex.Bench.segmentize_en/0,
  tokenize_ko: &Charex.Bench.tokenize_ko/0,
  segmentize_ko: &Charex.Bench.segmentize_ko/0,
  tokenize_ar: &Charex.Bench.tokenize_ar/0,
  segmentize_ar: &Charex.Bench.segmentize_ar/0,
    }
    |> Benchee.run(memory_time: 1, reduction_time: 1)
    |> IO.inspect()
  end

end

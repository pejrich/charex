# Charex

Elixir NIF wrapper of the Rust Charabia string tokenization/segmentation library

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `charex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:charex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/charex>.

## Usage

```elixir
iex> Charex.tokenize("これは一例です。")
[
  %Charex.Token{
    kind: :word,
    lemma: "これ",
    char_start: 0,
    char_end: 2,
    byte_start: 0,
    byte_end: 6,
    char_map: nil,
    script: :jpan,
    language: :ja
  },
  %Charex.Token{
    kind: :word,
    lemma: "は",
    char_start: 2,
    char_end: 3,
    byte_start: 6,
    byte_end: 9,
    char_map: nil,
    script: :jpan,
    language: :ja
  },
  %Charex.Token{
    kind: :word,
    lemma: "一",
    char_start: 3,
    char_end: 4,
    byte_start: 9,
    byte_end: 12,
    char_map: nil,
    script: :jpan,
    language: :ja
  },
  %Charex.Token{
    kind: :word,
    lemma: "例",
    char_start: 4,
    char_end: 5,
    byte_start: 12,
    byte_end: 15,
    char_map: nil,
    script: :jpan,
    language: :ja
  },
  %Charex.Token{
    kind: :word,
    lemma: "です",
    char_start: 5,
    char_end: 7,
    byte_start: 15,
    byte_end: 21,
    char_map: nil,
    script: :jpan,
    language: :ja
  },
  %Charex.Token{
    kind: {:separator, :hard},
    lemma: "。",
    char_start: 7,
    char_end: 8,
    byte_start: 21,
    byte_end: 24,
    char_map: nil,
    script: :jpan,
    language: :ja
  }
]

iex> Charex.segmentize("这是一个例子。")
["这", "是", "一个", "例子", "。"]

```

## Benchmarks

These are all roughly 100 byte strings. These are not the only supported languages, but just a mixture to show some rough results.

```
Operating System: macOS
CPU Information: Apple M1 Pro
Number of Available Cores: 10
Available memory: 16 GB
Elixir 1.16.0
Erlang 26.2.1
JIT enabled: true

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 1 s
reduction time: 1 s
parallel: 1
inputs: none specified
Estimated total run time: 1 min 30 s

Benchmarking tokenize_ja ...
Benchmarking segmentize_ja ...
Benchmarking tokenize_zh ...
Benchmarking segmentize_zh ...
Benchmarking tokenize_en ...
Benchmarking segmentize_en ...
Benchmarking tokenize_ko ...
Benchmarking segmentize_ko ...
Benchmarking tokenize_ar ...
Benchmarking segmentize_ar ...
Calculating statistics...
Formatting results...

Name                    ips        average  deviation         median         99th %
segmentize_ar      215.97 K        4.63 μs   ±749.72%        3.50 μs        5.71 μs
segmentize_en      141.26 K        7.08 μs   ±566.37%        5.21 μs        9.33 μs
segmentize_zh      121.84 K        8.21 μs   ±247.33%        7.29 μs           9 μs
tokenize_ar         84.90 K       11.78 μs   ±101.33%       10.88 μs       23.88 μs
tokenize_en         58.16 K       17.19 μs    ±50.91%       15.92 μs       44.17 μs
segmentize_ja       58.12 K       17.21 μs    ±88.31%       16.42 μs       25.17 μs
tokenize_zh         55.84 K       17.91 μs    ±47.74%       16.96 μs       58.08 μs
segmentize_ko       49.17 K       20.34 μs   ±103.65%       19.25 μs       32.08 μs
tokenize_ja         39.60 K       25.25 μs    ±35.18%       24.25 μs       54.92 μs
tokenize_ko         32.28 K       30.97 μs    ±17.23%       30.13 μs       49.46 μs

Comparison:
segmentize_ar      215.97 K
segmentize_en      141.26 K - 1.53x slower +2.45 μs
segmentize_zh      121.84 K - 1.77x slower +3.58 μs
tokenize_ar         84.90 K - 2.54x slower +7.15 μs
tokenize_en         58.16 K - 3.71x slower +12.56 μs
segmentize_ja       58.12 K - 3.72x slower +12.58 μs
tokenize_zh         55.84 K - 3.87x slower +13.28 μs
segmentize_ko       49.17 K - 4.39x slower +15.71 μs
tokenize_ja         39.60 K - 5.45x slower +20.62 μs
tokenize_ko         32.28 K - 6.69x slower +26.34 μs

Memory usage statistics:

Name             Memory usage
segmentize_ar         1.64 KB
segmentize_en         1.64 KB - 1.00x memory usage +0 KB
segmentize_zh         1.64 KB - 1.00x memory usage +0 KB
tokenize_ar           1.64 KB - 1.00x memory usage +0 KB
tokenize_en           1.64 KB - 1.00x memory usage +0 KB
segmentize_ja         1.64 KB - 1.00x memory usage +0 KB
tokenize_zh           1.66 KB - 1.01x memory usage +0.0234 KB
segmentize_ko         1.65 KB - 1.00x memory usage +0.00781 KB
tokenize_ja           1.63 KB - 0.99x memory usage -0.01563 KB
tokenize_ko           1.66 KB - 1.01x memory usage +0.0156 KB

**All measurements for memory usage were the same**

Reduction count statistics:

Name          Reduction count
segmentize_ar              13
segmentize_en              32 - 2.46x reduction count +19
segmentize_zh              18 - 1.38x reduction count +5
tokenize_ar                85 - 6.54x reduction count +72
tokenize_en               146 - 11.23x reduction count +133
segmentize_ja              19 - 1.46x reduction count +6
tokenize_zh                97 - 7.46x reduction count +84
segmentize_ko              16 - 1.23x reduction count +3
tokenize_ja               101 - 7.77x reduction count +88
tokenize_ko                92 - 7.08x reduction count +79

**All measurements for reduction count were the same**
```

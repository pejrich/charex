defmodule Charex.Bench do
  import Charex.BenchSupport
  @ja string_bytes("これは一例です。 ", 100)
  @zh string_bytes("这是一个例子。 ", 100)
  @en string_bytes("This is an example. ", 100)
  @ko string_bytes("이것은 예입니다. ", 100)
  @ar string_bytes("هذا مثال. ", 100)
  def tokenize_ja, do: Charex.tokenize(@ja)
  def segmentize_ja, do: Charex.segmentize(@ja)
  def tokenize_zh, do: Charex.tokenize(@zh)
  def segmentize_zh, do: Charex.segmentize(@zh)
  def tokenize_en, do: Charex.tokenize(@en)
  def segmentize_en, do: Charex.segmentize(@en)
  def tokenize_ko, do: Charex.tokenize(@ko)
  def segmentize_ko, do: Charex.segmentize(@ko)
  def tokenize_ar, do: Charex.tokenize(@ar)
  def segmentize_ar, do: Charex.segmentize(@ar)
end

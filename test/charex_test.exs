defmodule CharexTest do
  use ExUnit.Case

  @data %{
    "This is an example." => ["This", " ", "is", " ", "an", " ", "example", "."],
    "これは一例です。" => ["これ", "は", "一", "例", "です", "。"],
    "这是一个例子。" => ["这", "是", "一个", "例子", "。"],
    "이것은 예입니다." => ["이것", "은", " ", "예", "입니다", "."]
  }

  test "tokenize" do
    Enum.each(@data, fn {k, v} ->
      result = [%Charex.Token{} | _] = Charex.tokenize(k)
      assert length(result) == length(v)
    end)
  end

  test "segmentize" do
    Enum.each(@data, fn {k, v} ->
      assert Charex.segmentize(k) == v
    end)
  end
end

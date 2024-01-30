defmodule Charex.BenchSupport do
  defmacro string_bytes(string, n) do
    quote do
      String.duplicate(unquote(string), unquote(n))
      |> to_charlist()
      |> Enum.reduce_while("", fn i, acc ->
        {if(byte_size(acc) > unquote(n), do: :halt, else: :cont), acc <> <<i::utf8>>}
      end)
    end
  end
end

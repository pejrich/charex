defmodule Charex do
  @moduledoc """
  This library mostly wraps the Charabia library from Rust.

  - [docs](https://docs.rs/charabia/latest/charabia/)
  - [crate](https://crates.io/crates/charabia)
  - [github](https://github.com/meilisearch/charabia)

  This library mostly just calls that library, and passes the response back through to Elixir.

  The only slight changes are that the scripts have been converted to their (closest) ISO codes:

  - `Latin` to `latn`
  - `Greek` to `grek`
  - `Arabic` to `arab`
  - etc.

  The languages have been converted from 3 letter codes to 2 letter ISO codes, mostly because this is the form I needed them in.

  - `eng` to `en`
  - `spa` to `es`
  - `cmn` to `zh`
  - etc.

  ## Some caveats/notes:

  ### Hans / Hant
  - The original library doesn't distinguish between simplified or traditional chinese, and tags them all as just CJ(chinese/japanese) for the script, and CMN for the language. On the Elixir side, you will see, `:zh` for the language, and `:hans` for the script.

  ### Jpan / Hans
  - The original library combines Chinese/Han and Japanese scripts into CJ which doesn't have a direct ISO code. However the Rust lib does usually correctly tag the language. Currently if the language is correctly tagged as `Language::Jpn`/`:ja` then the script will correctly be tagged as `:jpan`. However, if the language isn't tagged correctly as Japanese, the script will fallback to `:hans`.

  ### Disclaimer
  Those choice to use `:hans` instead of `:hant` was chosen purely based on number of speakers, and is in no way intended as a political statement.
  """

  @spec tokenize(String.t()) :: [Charex.Token.t()]
  @doc """
  Tokenizes a string into a list of `Charex.Token` structs.

  ```elixir
  iex> tokenize("This is an example.")
  [%Charex.Token{kind: :word, lemma: "this", char_start: 0, char_end: 4, byte_start: 0, byte_end: 4, char_map: nil, script: :latn, language: :other}, ...]
  iex> tokenize("これは一例です。")
  [%Charex.Token{ kind: :word, lemma: "これ", char_start: 0, char_end: 2, byte_start: 0, byte_end: 6, char_map: nil, script: :jpan, language: :ja}, ...]
  iex> tokenize("这是一个例子。")
  [%Charex.Token{kind: :word, lemma: "zhè", char_start: 0, char_end: 1, byte_start: 0, byte_end: 3, char_map: nil, script: :hans, language: :zh}, ...]
  iex> tokenize("이것은 예입니다.")
  [%Charex.Token{kind: :word, lemma: "이것", char_start: 0, char_end: 2, byte_start: 0, byte_end: 6, char_map: nil, script: :hang, language: :ko}, %Charex.Token{kind: :word, lemma: "은", ...}, ...]
  ```
  """
  def tokenize(string), do: Charex.Native.tokenize(string)

  @spec segmentize(String.t()) :: [String.t()]
  @doc """
  A slightly faster version that segments the string into a list of strings.

  ```elixir
  iex> segmentize("This is an example.")
  ["This", " ", "is", " ", "an", " ", "example", "."]
  iex> segmentize("これは一例です。")
  ["これ", "は", "一", "例", "です", "。"]
  iex> segmentize("这是一个例子。")
  ["这", "是", "一个", "例子", "。"]
  ```
  """
  def segmentize(string), do: Charex.Native.segmentize(string)
end

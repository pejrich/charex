defmodule Charex.Token do
  @moduledoc """
  Wrapper of the Charabia Token.

  ## Notes:
  ### `char_map`
  seems to always be nil from what I can tell, but there might be some languages that use it, so it's here for compatibility, but don't be surprised if it's nil for you.
  ### `char_start`/`char_end`
  These are not really char indexes like you'd get from `String.length/1` in Elixir.
  They are really codepoint indexes.
  For example `"👨‍👩‍👧‍👦"` would have a `start`/`end` that is 7 numbers apart instead of 1 number apart.
  This is the same as you'd get from `String.codepoints/1`, or `to_charlist/1`
  ### `byte_start`/`byte_end`
  These are as you'd expect, byte offsets, and could be used to slice the string with `:binary.part/3`, but *NOT* with `String.slice/3`(if you use this function it may appear to work for latin/ascii characters, but will break your code as soon as non-ascii characters are used. `:binary.part/3` is the correct function to use)
  """
  defstruct [
    :kind,
    :lemma,
    :char_start,
    :char_end,
    :byte_start,
    :byte_end,
    :char_map,
    :script,
    :language
  ]

  @scripts ~w(arab armn beng cyrl deva ethi geor grek gujr guru hang hebr knda jpan khmr latn mlym mymr orya sinh taml telu thai hans other)a
  @langs ~w(eo en ru zh es pt it bn fr de uk ka ar hi ja he yi pl am jv ko nb da sv fi tr nl hu cs el bg be mr kn ro sl hr sr mk lt lv et ta vi ur th gu uz pa az id te fa ml or my ne si km tk ak zu sn af la sk ca tl hy other)a

  @type script :: unquote(Enum.reduce(@scripts, &{:|, [], [&1, &2]}))
  @type lang :: unquote(Enum.reduce(@langs, &{:|, [], [&1, &2]}))
  @type t :: %__MODULE__{
          kind: :word | :stop_word | {:separator, :hard} | {:separator, :soft},
          lemma: String.t(),
          char_start: pos_integer(),
          char_end: pos_integer(),
          byte_start: pos_integer(),
          byte_end: pos_integer(),
          char_map: %{pos_integer() => pos_integer()} | nil,
          script: script(),
          language: lang()
        }

  @spec all_scripts() :: [script()]
  def all_scripts, do: @scripts

  @spec all_langs() :: [lang()]
  def all_langs, do: @langs
end

use crate::tokenizer::CharexToken;
mod tokenizer;

#[rustler::nif]
fn tokenize(string: &str) -> Vec<CharexToken> {
    return tokenizer::tokenize(string);
}

#[rustler::nif]
fn segmentize(string: &str) -> Vec<&str> {
    return tokenizer::segmentize(string);
}

rustler::init!("Elixir.Charex.Native", [tokenize, segmentize]);

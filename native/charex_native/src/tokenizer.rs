use charabia::{Language, Script, Segment, SeparatorKind, Token, TokenKind, Tokenize};
use enum_to_enum::FromEnum;
use rustler::{NifStruct, NifTaggedEnum, NifUnitEnum};

#[derive(FromEnum, NifTaggedEnum, Debug, Clone, Copy, PartialEq, Eq)]
#[from_enum(TokenKind)]
pub enum CHTokenKind {
    Word,
    /// the token is a stop word,
    /// meaning that it can be ignored to optimize size and performance or be indexed as a Word
    StopWord,
    /// the token is a separator,
    /// meaning that it shouldn't be indexed but used to determine word proximity
    Separator(CHSeparatorKind),
    Unknown,
}

#[derive(FromEnum, NifUnitEnum, Debug, Clone, Copy, PartialEq, Eq)]
#[from_enum(SeparatorKind)]
pub enum CHSeparatorKind {
    Hard,
    Soft,
}

#[derive(Debug, NifStruct)]
#[module = "Charex.Token"]
pub struct CharexToken {
    pub kind: CHTokenKind,
    pub lemma: String,
    pub char_start: usize,
    pub char_end: usize,
    pub byte_start: usize,
    pub byte_end: usize,
    pub char_map: Option<Vec<(u8, u8)>>,
    pub script: CHScript,
    pub language: CHLanguage,
}

impl<'a> From<Token<'a>> for CharexToken {
    fn from(p: Token) -> Self {
        Self {
            kind: CHTokenKind::from(p.kind),
            lemma: p.lemma.to_string(),
            char_start: p.char_start,
            char_end: p.char_end,
            byte_start: p.byte_start,
            byte_end: p.byte_end,
            char_map: p.char_map,
            script: CHScript::from_script_and_lang(p.script, p.language),
            language: CHLanguage::from_maybe(p.language, p.script),
        }
    }
}

#[derive(NifUnitEnum, Debug, PartialEq, Eq, Hash, Clone, Copy)]
pub enum CHScript {
    Arab,
    Armn,
    Beng,
    Cyrl,
    Deva,
    Ethi,
    Geor,
    Grek,
    Gujr,
    Guru,
    Hang,
    Hebr,
    Jpan,
    Knda,
    Khmr,
    Latn,
    Mlym,
    Mymr,
    Orya,
    Sinh,
    Taml,
    Telu,
    Thai,
    Hans,
    Other,
}

impl CHScript {
    pub fn from_script_and_lang(p: Script, lang: Option<Language>) -> Self {
        match p {
            Script::Arabic => CHScript::Arab,
            Script::Armenian => CHScript::Armn,
            Script::Bengali => CHScript::Beng,
            Script::Cyrillic => CHScript::Cyrl,
            Script::Devanagari => CHScript::Deva,
            Script::Ethiopic => CHScript::Ethi,
            Script::Georgian => CHScript::Geor,
            Script::Greek => CHScript::Grek,
            Script::Gujarati => CHScript::Gujr,
            Script::Gurmukhi => CHScript::Guru,
            Script::Hangul => CHScript::Hang,
            Script::Hebrew => CHScript::Hebr,
            Script::Kannada => CHScript::Knda,
            Script::Khmer => CHScript::Khmr,
            Script::Latin => CHScript::Latn,
            Script::Malayalam => CHScript::Mlym,
            Script::Myanmar => CHScript::Mymr,
            Script::Oriya => CHScript::Orya,
            Script::Sinhala => CHScript::Sinh,
            Script::Tamil => CHScript::Taml,
            Script::Telugu => CHScript::Telu,
            Script::Thai => CHScript::Thai,
            Script::Cj => match lang {
                Some(Language::Jpn) => CHScript::Jpan,
                _ => CHScript::Hans,
            },
            _ => CHScript::Other,
        }
    }
}

#[derive(NifUnitEnum, Debug, PartialEq, Eq, Hash, Clone, Copy)]
// #[from_enum(Language)]
pub enum CHLanguage {
    Eo,
    En,
    Ru,
    Zh,
    Es,
    Pt,
    It,
    Bn,
    Fr,
    De,
    Uk,
    Ka,
    Ar,
    Hi,
    Ja,
    He,
    Yi,
    Pl,
    Am,
    Jv,
    Ko,
    Nb,
    Da,
    Sv,
    Fi,
    Tr,
    Nl,
    Hu,
    Cs,
    El,
    Bg,
    Be,
    Mr,
    Kn,
    Ro,
    Sl,
    Hr,
    Sr,
    Mk,
    Lt,
    Lv,
    Et,
    Ta,
    Vi,
    Ur,
    Th,
    Gu,
    Uz,
    Pa,
    Az,
    Id,
    Te,
    Fa,
    Ml,
    Or,
    My,
    Ne,
    Si,
    Km,
    Tk,
    Ak,
    Zu,
    Sn,
    Af,
    La,
    Sk,
    Ca,
    Tl,
    Hy,
    Other,
}
impl CHLanguage {
    fn from_maybe(lang: Option<Language>, script: Script) -> CHLanguage {
        match lang {
            Some(Language::Other) => CHLanguage::Other,
            Some(lang) => CHLanguage::from(lang),
            _ => match script {
                Script::Hangul => CHLanguage::Ko,
                _ => CHLanguage::Other,
            },
        }
    }
}
impl From<Language> for CHLanguage {
    fn from(p: Language) -> Self {
        match p {
            Language::Afr => CHLanguage::Af,
            Language::Aka => CHLanguage::Ak,
            Language::Amh => CHLanguage::Am,
            Language::Ara => CHLanguage::Ar,
            Language::Aze => CHLanguage::Az,
            Language::Bel => CHLanguage::Be,
            Language::Ben => CHLanguage::Bn,
            Language::Bul => CHLanguage::Bg,
            Language::Cat => CHLanguage::Ca,
            Language::Ces => CHLanguage::Cs,
            Language::Slk => CHLanguage::Sk,
            Language::Cmn => CHLanguage::Zh,
            Language::Dan => CHLanguage::Da,
            Language::Deu => CHLanguage::De,
            Language::Ell => CHLanguage::El,
            Language::Eng => CHLanguage::En,
            Language::Epo => CHLanguage::Eo,
            Language::Est => CHLanguage::Et,
            Language::Fin => CHLanguage::Fi,
            Language::Fra => CHLanguage::Fr,
            Language::Guj => CHLanguage::Gu,
            Language::Heb => CHLanguage::He,
            Language::Hin => CHLanguage::Hi,
            Language::Hrv => CHLanguage::Hr,
            Language::Hun => CHLanguage::Hu,
            Language::Hye => CHLanguage::Hy,
            Language::Ind => CHLanguage::Id,
            Language::Ita => CHLanguage::It,
            Language::Jav => CHLanguage::Jv,
            Language::Jpn => CHLanguage::Ja,
            Language::Kan => CHLanguage::Kn,
            Language::Kat => CHLanguage::Ka,
            Language::Khm => CHLanguage::Km,
            Language::Kor => CHLanguage::Ko,
            Language::Lat => CHLanguage::La,
            Language::Lav => CHLanguage::Lv,
            Language::Lit => CHLanguage::Lt,
            Language::Mal => CHLanguage::Ml,
            Language::Mar => CHLanguage::Mr,
            Language::Mkd => CHLanguage::Mk,
            Language::Mya => CHLanguage::My,
            Language::Nep => CHLanguage::Ne,
            Language::Nld => CHLanguage::Nl,
            Language::Nob => CHLanguage::Nb,
            Language::Ori => CHLanguage::Or,
            Language::Pan => CHLanguage::Pa,
            Language::Pes => CHLanguage::Fa,
            Language::Pol => CHLanguage::Pl,
            Language::Por => CHLanguage::Pt,
            Language::Ron => CHLanguage::Ro,
            Language::Rus => CHLanguage::Ru,
            Language::Sin => CHLanguage::Si,
            Language::Slv => CHLanguage::Sl,
            Language::Sna => CHLanguage::Sn,
            Language::Spa => CHLanguage::Es,
            Language::Srp => CHLanguage::Sr,
            Language::Swe => CHLanguage::Sv,
            Language::Tam => CHLanguage::Ta,
            Language::Tel => CHLanguage::Te,
            Language::Tgl => CHLanguage::Tl,
            Language::Tha => CHLanguage::Th,
            Language::Tuk => CHLanguage::Tk,
            Language::Tur => CHLanguage::Tr,
            Language::Ukr => CHLanguage::Uk,
            Language::Urd => CHLanguage::Ur,
            Language::Uzb => CHLanguage::Uz,
            Language::Vie => CHLanguage::Vi,
            Language::Yid => CHLanguage::Yi,
            Language::Zul => CHLanguage::Zu,
            Language::Other => CHLanguage::Other,
        }
    }
}

pub fn tokenize(string: &str) -> Vec<CharexToken> {
    return string
        .tokenize()
        .into_iter()
        .map(|x| CharexToken::from(x))
        .collect::<Vec<CharexToken>>()
        .try_into()
        .unwrap();
}

pub fn segmentize(string: &str) -> Vec<&str> {
    let segments = string.segment_str();
    return segments.collect::<Vec<&str>>();
}

import Std.Data.HashSet

-- ---------------------
inductive TokenType where
  | Ident
  | Int
  | RadixInt
  | Float
  | String
  | Byte
  | Char
  | ENotationFloat
  | Plus
  | Minus
  | Star
  | Slash
  | Percent
  | Amp
  | Pipe
  | Caret
  | Not
  | Tilde
  | Eq
  | EqEq
  | Ne
  | Lt
  | Gt
  | Le
  | Ge
  | And
  | Or
  | Shl
  | Shr
  | PlusEq
  | MinusEq
  | StarEq
  | SlashEq
  | PercentEq
  | AmpEq
  | PipeEq
  | CaretEq
  | ShlEq
  | ShrEq
  | Arrow
  | FatArrow
  | Dot
  | DotDot
  | DotDotDot
  | Lparen
  | Rparen
  | Lbrace
  | Rbrace
  | Lbracket
  | Rbracket
  | Comma
  | Colon
  | Semicolon
  | Hash
  | At
  | Question
  | Underline
  | PPStart
  | PPEnd
  | Eof
  | NewLine
  | Error
  deriving Repr, BEq, DecidableEq, Hashable, Inhabited

-- ---------------------
structure Span where
  start_off : Nat
  end_off   : Nat
  deriving Repr, BEq, DecidableEq, Hashable, Inhabited

-- ---------------------
structure Token where
  kind    : TokenType
  span    : Span
  text    : String
  hide    : Std.HashSet String
  file_id : Nat
  deriving Repr, BEq, Inhabited

def Token.WellFormed (t : Token) : Prop :=
  t.span.start_off <= t.span.end_off

-- ---------------------
structure TokenStream where
  tokens : Array Token
  deriving Repr, BEq, Inhabited

namespace TokenStream

def isMonotonic (ts : TokenStream) : Prop :=
  ∀ (i j : Nat), i < j → j < ts.tokens.size →
    (ts.tokens[i]!).span.end_off <= (ts.tokens[j]!).span.start_off

def WellFormed (ts : TokenStream) : Prop :=
  (∀ (i : Nat), i < ts.tokens.size → Token.WellFormed (ts.tokens[i]!)) ∧
  isMonotonic ts

end TokenStream
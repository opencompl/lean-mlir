/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Framework.Trace

/-! ## `def_signature` elaborator
This file defines `def_signature` elaborator that makes it easier to define the
signature of operations in a LeanMLIR dialect.

For example, `PaperExamples.lean` defines a signature as follows:
```lean
def_signature for SimpleReg
  | .const _    => () → .int
  | .add        => (.int, .int) → .int
  | .iterate _  => { (.int) → .int } → (.int) -[.pure]-> .int
```

Read as: "iterate" has one region, of type `(int) -> int`, and one regular argument,
of type `int`, returning an `int`, without performing any side-effects (i.e., it is pure).
Note that the purity annotation on the last line is redundant: the default assumption
when using regular arrows (->) is that the operations is pure. We just used the
other arrow to showcase the syntax.

-/
open Lean

namespace LeanMLIR.Parser
open Lean.Parser

/-!
## Syntax parsers
We will use `Lean.Parser.Term.matchAlts` to parse the match arms in `def_signature`.
This works, despite the custom syntax for the RHS because  `matchAlts` takes in
an optional `rhsParser` argument.

Unfortunately, the type of this argument is `Parser`, whereas the convenient
`syntax` macro gives us a `ParserDescr`. There is in theory a way to compile
a `ParserDescr`, but we choose rather to define our signature syntax in
lower-level primitives that directly give a `Parser`.
-/

def plainArrow := leading_parser unicodeSymbol " → " " -> "
def effectArrow := leading_parser " -[" >> termParser >> "]-> "
def arrow := leading_parser plainArrow <|> effectArrow

def concreteArgumentList : Parser :=
  leading_parser "(" >> (sepBy termParser ",") >> ")"
def antiquotArgumentList : Parser :=
  leading_parser "${" >> termParser >> "}"
def argumentList : Parser :=
  leading_parser concreteArgumentList <|> antiquotArgumentList

/-- An mlir function type: `( term,* ) → term`,
with optional effect annotation on the arrow -/
def function : Parser :=
  leading_parser argumentList >> arrow >> termParser

/-- An mlir function type: `( term,* ) → term`, without effect annotation. -/
def plainFunction : Parser :=
  leading_parser argumentList >> plainArrow >> termParser

/-- An mlir region arguments signature: `{ function,* }` -/
def region : Parser :=
  leading_parser "{" >> sepBy plainFunction "," >> "}"

def signature : Parser :=
  leading_parser optional (region >> plainArrow) >> function

def matchAltSig : Parser := Lean.Parser.Term.matchAlt signature
def matchAltsSig : Parser := Lean.Parser.Term.matchAlts signature

protected def matchAltsExpr : Parser := Lean.Parser.Term.matchAlts
instance : Coe (TSyntax ``Parser.matchAltsExpr) (TSyntax ``Lean.Parser.Term.matchAlts) where
  coe x := ⟨x.raw⟩

end Parser



/-!
## MetaSignature Datastructures and Environment Extension
-/

namespace Elab
open Qq
open LeanMLIR.Parser
open Lean.Parser.Term (matchAltExpr)
open Lean.Meta Lean.Elab.Command Lean.Elab.Term

/-- Based on Lean.Elab.Term.MatchAltView, but adapted for our purposes -/
structure MatchAltView (rhsKind : SyntaxNodeKinds) where
  ref : Syntax
  patterns : Array Term
  rhs : TSyntax rhsKind

/--
Given `e` a Lean expression of type `List α`, return an array of
expressions `es : Array Expr` where `es[i]` is the `i`th element of `e`.

Returns `none` if `e` does not reduce to a sequence of `List` constructors. -/
partial def listExprToArray : Expr → MetaM (Option <| Array Expr) :=
  go #[]
where go (es : Array Expr) (e : Expr) : (OptionT MetaM _) := do
  let e ← whnf e
  match_expr e with
  | List.cons _ a as => do
      let es := es.push a
      go es as
  | List.nil _  => return es
  | _           => OptionT.fail

/-!
## `def_signature` Elaboration
-/

/-- Given `stx` a match-expression, return its alternatives. -/
-- Based on `Lean.Elab.Match.getMatchAlts` and `expandMatchAlt`
private def getMatchAlts (alts : TSyntax ``matchAltsSig) :
    Array (MatchAltView ``Parser.signature) :=
  let alts := alts.raw[0].getArgs
  alts.flatMap fun
    | ref@`(matchAltSig| | $[$patss,*]|* => $rhs) =>
        patss.map fun patterns => {
            ref := ref,
            patterns := patterns.getElems,
            rhs := rhs
          }
    | stx => #[⟨.missing, #[], ⟨.missing⟩⟩]

private def getMatchAltsExpr (alts : TSyntax ``LeanMLIR.Parser.matchAltsExpr) :
    Array (MatchAltView `term) :=
  let alts := alts.raw[0].getArgs
  alts.flatMap fun
    | ref@`(matchAltExpr| | $[$patss,*]|* => $rhs) =>
        patss.map fun patterns => {
            ref := ref,
            patterns := patterns.getElems,
            rhs := rhs
          }
    | stx => #[⟨.missing, #[], ⟨.missing⟩⟩]

variable {m} [Monad m] [MonadRef m] [MonadQuotation m] [MonadError m]

/-- Reassemble an array of alternatives into a `matchAlts` syntax,
    assuming that the rhs of each match arm is a `Term`.  -/
protected def mkMatchAltsExpr (alts : Array (MatchAltView `term)) :
    m (TSyntax ``LeanMLIR.Parser.matchAltsExpr) := do
  let alts ← alts.mapM fun view => do
    let patterns : Syntax.TSepArray [`term] "," :=
      ⟨(Syntax.SepArray.ofElems (sep := ",") view.patterns).elemsAndSeps⟩
    let rhs : Term := ⟨view.rhs⟩
    `(Parser.Term.matchAltExpr| | $patterns,* => $rhs)
  `(LeanMLIR.Parser.matchAltsExpr| $alts:matchAlt*)

/-- Generic error to be used for fallback match patterns that should be unreachable.
If this error is thrown, it indicates a bug in the implementation. -/
def throwUnexpectedSyntax (stx : Syntax) : m α :=
  throwErrorAt stx "Unexpected syntax: {stx}\nThis is an internal bug"

def parseSignature (ref : TSyntax ``LeanMLIR.Parser.signature) : m Term :=
  withRef ref <| match ref with
  | `(signature| { $regions,* } → $fn:function ) => do
      let regions ← regions.getElems.mapM fun fn => withRef fn do
        let `(plainFunction| $args → $outTy) := fn
          | throwUnexpectedSyntax fn
        let args ← parseArgumentList args
        `(⟨$args, $outTy⟩)
      parseFunction regions fn
  | `(signature| $fn:function) => parseFunction #[] fn
  | ref => throwUnexpectedSyntax ref
  where
    parseArgumentList : TSyntax ``argumentList → m Term
      | `(argumentList| ${$args})  => pure args
      | `(argumentList| ($args,*)) => `([$args,*])
      | ref => throwUnexpectedSyntax ref
    mkSignature (argumentTypes : TSyntax ``argumentList) (regions : Array Term)
        (returnType : Term) (effectKind : Term) :
        m Term := do
      let argumentTypes ← parseArgumentList argumentTypes
      `(_root_.Signature.mkEffectful $argumentTypes [$regions,*] $returnType $effectKind)
    parseFunction (regions : Array Term)
        (ref : TSyntax ``LeanMLIR.Parser.function) :
        m Term := withRef ref <| do
      match ref with
      | `(function| $argumentTypes -[$effectKind]-> $returnType) =>
          mkSignature argumentTypes regions returnType effectKind
      | `(function| $argumentTypes → $returnType) => do
          let effectKind ← `(_root_.EffectKind.pure)
          mkSignature argumentTypes regions returnType effectKind
      | _ => throwUnexpectedSyntax ref

def elabDefSignatureFor (dialect : Term) (alts : TSyntax ``matchAltsSig) : CommandElabM Unit := do
  let msg := (return m!"{exceptEmoji ·} Defining operation signature for {dialect} dialect")
  withTraceNode `LeanMLIR.Elab msg (collapsed := false) <| do
    let alts := getMatchAlts alts
    let alts ← do
      alts.mapM fun view => do
        trace[LeanMLIR.Elab] m!"Parsing match alternative with\n\
          \tpatterns: {view.patterns}\n\
          \tsignature: {view.rhs}"
        let rhs ← parseSignature view.rhs
        return { view with rhs }

    -- Define instance
    let matchAlts ← Elab.mkMatchAltsExpr alts
    elabCommand <|← `(command|
      instance : DialectSignature $dialect where
        signature := fun op => match op with $matchAlts:matchAlts
    )

/--
  `def_signature for FooDialect where ...` defines an instance of
    `DialectSignature FooDialect` via an easier to read syntax.

  `def_signature for FooDialect, BarDialect, ... where ...` defines signatures
    for both `FooDialect` and `BarDialect`. Of course, the definition has to
    constitute a valid signature for both dialects, so this is generally only
    applicable if one dialect is a specialization or alias of the other.

  For example, `PaperExamples.lean` defines a signature as follows:
  ```lean
  def_signature for SimpleReg
    | .const _    => () → .int
    | .add        => (.int, .int) → .int
    | .iterate _  => { (.int) → .int } → (.int) -[.pure]-> .int
  ```
-/
elab "def_signature" " for " dialects:term,* (" where ")? alts:matchAltsSig : command =>
  for dialect in dialects.getElems do
    elabDefSignatureFor dialect alts

/-!
## `def_semantics`
-/
open Parser (matchAltsExpr)
open Qq

def elabHVectorFun (fn : Term) (expectedType : Expr) : TermElabM Expr := do
  let origLCtx ← getLCtx
  let origLocalInst ← getLocalInstances
  forallTelescope expectedType fun args returnType => do
    for arg in args do
      if returnType.containsFVar arg.fvarId! then
        throwError "Return type {returnType} depends on argument {arg}.\n\
          Only non-dependent arrow are supported."
    let argVecTypes ← args.mapM (inferType ·)
    let argTypes ← argVecTypes.mapM fun arg => do
      let_expr HVector _α f as := arg
        | throwError "Expected HVector, found: {arg}"
      let some as ← listExprToArray as
        | throwError "Failed to reflect:\n\t{as}\nExpected a sequence of `List` constructors"
      as.mapM (whnf <| mkApp f ·)
    let returnType ← whnf returnType
    let altExpectedType := argTypes.flatten.foldr (init := returnType) fun binderType body =>
      Expr.forallE .anonymous binderType body .default

    let fn ← withLCtx origLCtx origLocalInst <|
      elabTermEnsuringType fn altExpectedType
    let fn ← (args.zip argTypes).foldlM (init := fn) fun fn (vecArg, argTypes) => do
      let mut fn := fn
      for i in [0:argTypes.size] do
        let arg ← mkAppM ``HVector.getN #[vecArg, toExpr i]
        fn := mkApp fn arg
      return fn

    mkLambdaFVars args fn

local elab "hvectorFun(" fn:term ")" : term <= expectedType => do
  elabHVectorFun fn expectedType

elab "def_semantics" " for " dialect:term (" where ")? alts:matchAltsExpr : command => do
  let matchAlts := getMatchAltsExpr alts
  let matchAlts ← matchAlts.mapM fun altView => withRef altView.rhs <| do
    return { altView with
      rhs := ←`(hvectorFun($altView.rhs))
    }
  -- Re-assemble match alternatives
  let matchAlts ← Elab.mkMatchAltsExpr matchAlts

  elabCommand <|← `(command| -- Declare instance
    instance : DialectDenote $dialect where
      denote := fun op => match op with $matchAlts:matchAlts
  )

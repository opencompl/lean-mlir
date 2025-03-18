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

/-- An mlir function type: `( term,* ) → term`,
with optional effect annotation on the arrow -/
def function : Parser :=
  leading_parser "(" >> (sepBy termParser ",") >> ")" >> arrow >> termParser

/-- An mlir function type: `( term,* ) → term`, without effect annotation. -/
def plainFunction : Parser :=
  leading_parser "(" >> (sepBy termParser ",") >> ")" >> plainArrow >> termParser

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

/-! ## `def_signature` Elaboration  -/
namespace Elab
open LeanMLIR.Parser
open Lean.Parser.Term (matchAltExpr)
open Lean.Elab.Term (MatchAltView)
open Lean.Elab.Command (CommandElabM elabCommand)

/-
TODO: automatically open the `Ty` namespace when elaborating the signature.
This requires us to figure out what namespace this is, by:
* Fetching the constant info corresponding to the Dialect,
* Looking up the definition of the `Ty` field
* Checking that `Ty` is the application of a constant, and finally
* Bringing the namespace of that constant into scope
-/

/-- Given `stx` a match-expression, return its alternatives. -/
-- Based on `Lean.Elab.Match.getMatchAlts`
private def getMatchAlts (alts : TSyntax ``matchAltsSig) : Array MatchAltView :=
  let alts := alts.raw[0].getArgs
  alts.filterMap fun alt => match alt with
    | `(matchAltSig| | $patterns,* => $rhs) => some {
        ref      := alt,
        patterns := patterns,
        rhs      := rhs
      }
    | stx =>
        dbg_trace "Unknown syntax: {stx}"
        some ⟨.missing, #[], .missing⟩

variable {m} [Monad m] [MonadRef m] [MonadQuotation m] in
/-- Reassemble an array of alternatives into a `matchAlts` syntax,
    assuming that the rhs of each match arm is a `Term`.  -/
protected def mkMatchAltsExpr (alts : Array MatchAltView) :
    m (TSyntax ``LeanMLIR.Parser.matchAltsExpr) := do
  let alts ← alts.mapM fun view => do
    let patterns : Syntax.TSepArray [`term] "," :=
      ⟨(Syntax.SepArray.ofElems (sep := ",") view.patterns).elemsAndSeps⟩
    let rhs : Term := ⟨view.rhs⟩
    `(Parser.Term.matchAltExpr| | $patterns,* => $rhs)
  `(LeanMLIR.Parser.matchAltsExpr| $alts:matchAlt*)

/-- Generic error to be used for fallback match patterns that should be unreachable.
If this error is thrown, it indicates a bug in the implementation. -/
def throwUnexpectedSyntax (stx : Syntax) : CommandElabM α :=
  throwErrorAt stx "Unexpected syntax: {stx}\nThis is an internal bug"

/-- Transforms an mlir function signature to a Lean function.

For example, `(int, nat) -> int` becomes `⟦int⟧ → ⟦int⟧ → ⟦nat⟧`. -/
def functionSignatureToTermFunction : TSyntax ``function → CommandElabM Term
  | `(function| ($args,*) → $outTy:term) => do
    let outTy ← `(⟦$outTy⟧)
    args.getElems.foldlM (init := outTy) fun ty acc =>
      `(⟦$ty⟧ → $acc)
  | ref => throwUnexpectedSyntax ref

partial def transformSignature : TSyntax ``LeanMLIR.Parser.signature → CommandElabM Term
  | `(signature| { $regions,* } → $fn:function ) => do
      -- TODO: figure out how to get the regions in here
      let regions ← regions.getElems.mapM fun fn => do
        let `(plainFunction| ($args,*) → $outTy) := fn
          | throwUnexpectedSyntax fn
        `(⟨[$args,*], $outTy⟩)
      parseFunction regions fn
  | `(signature| $fn:function) => parseFunction #[] fn
  | ref => throwUnexpectedSyntax ref
  where
    parseFunction (regions : Array Term) : TSyntax ``LeanMLIR.Parser.function → CommandElabM Term
      | `(function| ($args,*) -[$eff]-> $outTy) => do
        let args ← `([$args,*])
        `(_root_.Signature.mkEffectful ($args) [$regions,*] ($outTy) ($eff))
      | `(function| ($args,*) → $outTy) => do
        let args ← `([$args,*])
        `(_root_.Signature.mkEffectful ($args) [$regions,*] ($outTy) (_root_.EffectKind.pure))
      | ref => throwUnexpectedSyntax ref

elab "def_signature" "for" dialect:term ("where")? alts:matchAltsSig : command => do
  trace[LeanMLIR.Elab] "Dialect: {dialect}"
  let alts := getMatchAlts alts
  let alts ← alts.mapM fun view => do return {view with
      rhs := ←transformSignature ⟨view.rhs⟩
    }
  let matchAlts ← Elab.mkMatchAltsExpr alts
  elabCommand <|← `(command|
    instance : DialectSignature $dialect where
      signature := fun op => match op with $matchAlts:matchAlts
  )
  return ()

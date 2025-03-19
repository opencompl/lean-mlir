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
## MetaSignature Datastructures and Environment Extension
-/
namespace Elab

/-- A meta region signature stores a list of expressions describing the argument
types and an expression describing the return type.

All expressions are expected to be of type `d.Ty` for some fixed `d : Dialect`.
-/
structure MetaRegionSignature where
  /-- `argumentTypes?` gives a list of expressions, where each describes the
    type of one argument. This field is `none` if the `${...}` escape hatch was
    used, as the number of arguments might not be knowable statically. -/
  argumentTypes? : Option (List Expr)
  /- Hmm, what if the operation is variadic?
  Say, we have some `add w n` instruction, where `n` is the number of arguments,
  then the signature would be akin to `List.replicate m (Ty.iX w)`.

  The point of this meta signature is that we can use information about the signature
  in `def_semantics` to influence the expected type on the RHS to not mention any
  `HVector` shenanigans.

  Note, however, that such a signature is inexpressible with `def_signature` to begin with...
  This is a potential, yet wildly unsatisying answer: maybe we just don't support
  variadics in the pretty answer. I'd rather not admit defeat, though!

  The answer is relatively elegant: we introduce a `${...}` escape hatch, where
  the term inside is expected to be of type `List MyDialectTy`.
  Then, in the semantics we know when we can be cute, and when we have to
  fallback to hvectors (namely, we fallback when the escape hatch was used to
  define the signature).

  This escape hatch is reflected in this structure via the `argumentTypes?` field,
  as per the doc-string: when the escape hatch is used, we set the field to `none`.
  Otherwise, we can elaborate each argument separately, and get a list of expressions.
  -/

  returnType : Expr

/- A meta function signature stores:
* A list of (meta) region signatures,
* A list of argument types, and
* A single return type

Where each "type" is a Lean expression of type `d.Ty`,
for some fixed `d : Dialect`.
-/
structure MetaSignature extends MetaRegionSignature where
  regions : List MetaRegionSignature

/-
TODO: Store the signature declared in `def_signature` somewhere, so that we can
query it in `def_semantics`.

We have the `MetaSignature` struct above; it should be relatively straightforward
to reflect a signature in the syntax we've defined for `def_signature`'s rhs'es
into such a `MetaSignature`, keeping in mind that we simply give up when encountering
the `${...}` variadic escape hatch.

The challenge lies in the lhs'es -- the patterns: when elaborating a specific
match arm of `def_signature` how do we find the corresponding signature?
* In the case that the Op type is just a simple enumeration and the patterns are
  ground terms, this should be easy.
  We could store something like a HashMap from names to meta signature, where
  we use the `Op` constructor name as key.
* If the Op type additionally carries information such as bitwidths, which don't
  alter the shape of the signature but might affect the specific types, we already
  get a bit more challenging: this width would be expressed as a variable
  (is it free or bound? I'm not actually sure).
  To make proper sense of the signature, we'd have to make sure we bind that
  variable appropriately in `def_semantics`.
* Supposing we have multiple match arms for one operations, things get even more
  challenging, as the hashmap would now have multiple entries for a single operation.

I can see two solutions:
a) We hypothesize that dialects will often not have that many different operations,
  so we could store all patterns in an ordered list, and when querying semantics
  we simply try to unify against each pattern, in order, until we've found a match.
  **Counterpoint:** this performs unifications quadratic in the number of ops,
  and dialects like RISC-V/LLVM do have a decent number of operations already,
  so this seems suboptimal.
b) We mandate that patterns in `def_signature` and `def_semantics` use the same
  head symbol up-to-reducability. That is, if we define some aliases for `Op`,
  and those aliasses are *not* marked reducable, then it would not be allowed to
  use the aliased form in `def_signature` and the non-aliased form in
  `def_semantics`. We keep a hashmap from Op names to lists of patterns, and
  perform unifications in order untill we find the right variant.
  This is still quadratic, but now in the number of variants for a specific Op,
  which almost surely will remain a low number, and is thus fine.
  **Counterpoint:** currently, we use aliasses in `MetaLLVM`/`LLVM`, to avoid
    having to redefine the entire `MOp` type, but also somewhat hide the meta
    definitions in the concrete LLVM dialect. I believe we've defined the
    signature for `MetaLLVM`, which then is able to be re-used as-is for `LLVM`.
    In this scenario, we'd like to define semantics using the nice ops, but we
    also would not want to make the aliasses reducible.

Although neither option is without fault, I like option (b) better:
it might invite some unnecessary code duplication, but it is unlikely to become
the source of scalability problems, and it seems relatively explainable (
with good error messages indicating the rules/expectations).


On second thought: we might want to just fully reduce the patterns, and chuck
everything in a discrimination tree. Lhs's are expected to be very simple, so
fully reducing them should not really be a concern. The reason we want this is
found in the LLVM dialect once again: when defining signatures, it's nice to just
group, e.g., all binary ops in one, letting us define the signatures fairly
succintly as follows:
```lean
def_signature for MetaLLVM φ where
  | .select w               => (.bitvec 1, .bitvec w, .bitvec w) → .bitvec w
  | .binary w _             => (.bitvec w, .bitvec w) → .bitvec w
  | .icmp _ w               => (.bitvec w, .bitvec w) → .bitvec 1
  | .trunc w w' _
  | .zext w w' _
  | .sext w w'              => (.bitvec w) → .bitvec w'
  -- Fallback for unary ops that are *not* trunc/zext/sext
  | .unary w _              => (.bitvec w) → .bitvec w
  | .const w _              => () → .bitvec w
```

However, when defining the semantics we obviously want to do so using the specific
binary ops, like `.add w` or `.sub w`. Requiring those to be marked reducible
would not be great.

-/



end Elab

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

/-! ## `def_signature` Elaboration  -/
namespace Elab
open LeanMLIR.Parser
open Lean.Parser.Term (matchAltExpr)
open Lean.Elab.Term (MatchAltView)
open Lean.Elab.Command (CommandElabM elabCommand)

/--

Based on Lean.Elab.Term.MatchAltView, but adapted for our purposes
-/
structure MatchAltView (rhsKind : SyntaxNodeKinds) where
  ref : Syntax
  patterns : Array Term
  rhs : TSyntax rhsKind

/-
TODO: automatically open the `Ty` namespace when elaborating the signature.
This requires us to figure out what namespace this is, by:
* Fetching the constant info corresponding to the Dialect,
* Looking up the definition of the `Ty` field
* Checking that `Ty` is the application of a constant, and finally
* Bringing the namespace of that constant into scope
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

variable {m} [Monad m] [MonadRef m] [MonadQuotation m] in
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
def throwUnexpectedSyntax (stx : Syntax) : CommandElabM α :=
  throwErrorAt stx "Unexpected syntax: {stx}\nThis is an internal bug"

-- /-- Transforms an mlir function signature to a Lean function.

-- For example, `(int, nat) -> int` becomes `⟦int⟧ → ⟦int⟧ → ⟦nat⟧`. -/
-- def functionSignatureToTermFunction : TSyntax ``function → CommandElabM Term
--   | `(function| ($args,*) → $outTy:term) => do
--     let outTy ← `(⟦$outTy⟧)
--     args.getElems.foldlM (init := outTy) fun ty acc =>
--       `(⟦$ty⟧ → $acc)
--   | ref => throwUnexpectedSyntax ref

partial def transformSignature (ref : TSyntax ``LeanMLIR.Parser.signature) : CommandElabM Term :=
  withRef ref <| match ref with
  | `(signature| { $regions,* } → $fn:function ) => do
      -- TODO: figure out how to get the regions in here
      let regions ← regions.getElems.mapM fun fn => withRef fn do
        let `(plainFunction| $args → $outTy) := fn
          | throwUnexpectedSyntax fn
        let args ← parseArgs args
        `(⟨$args, $outTy⟩)
      parseFunction regions fn
  | `(signature| $fn:function) => parseFunction #[] fn
  | ref => throwUnexpectedSyntax ref
  where
    parseArgs : TSyntax ``argumentList → CommandElabM Term
      | ref@`(argumentList| ($args,*))  => withRef ref <| `([$args,*])
      | `(argumentList| ${ $argsList }) => pure argsList
      | stx => throwUnexpectedSyntax stx
    parseFunction (regions : Array Term) : TSyntax ``LeanMLIR.Parser.function → CommandElabM Term
      | `(function| $args -[$eff]-> $outTy) => do
        let args ← parseArgs args
        `(_root_.Signature.mkEffectful ($args) [$regions,*] ($outTy) ($eff))
      | `(function| $args → $outTy) => do
        let args ← parseArgs args
        `(_root_.Signature.mkEffectful ($args) [$regions,*] ($outTy) (_root_.EffectKind.pure))
      | ref => throwUnexpectedSyntax ref

elab "def_signature" " for " dialect:term (" where ")? alts:matchAltsSig : command =>
  let msg := (return m!"{exceptEmoji ·} Defining operation signature for {dialect} dialect")
  withTraceNode `LeanMLIR.Elab msg (collapsed := false) <| do
    let alts := getMatchAlts alts
    let alts ← alts.filterMapM fun view => do
      trace[LeanMLIR.Elab] "Parsing match alternative with\n\
        \tpatterns: {view.patterns}\n\
        \tsignature: {view.rhs}"
      return some {view with
        rhs := ←transformSignature view.rhs
      }
    let matchAlts ← Elab.mkMatchAltsExpr alts
    elabCommand <|← `(command|
      instance : DialectSignature $dialect where
        signature := fun op => match op with $matchAlts:matchAlts
    )
    return ()

/-! ## `def_semantics`-/
open Parser (matchAltsExpr)
open Meta Elab.Command Elab.Term
open Qq

#check TyDenote
#check Dialect.Ty
#check Syntax
#check SourceInfo.fromRef
#check Syntax.setInfo

elab "def_semantics" " for " dialect:term (" where ")? alts:matchAltsExpr : command => do
  let dialectExpr ← withRef dialect <| runTermElabM <| fun _ => do
    let dialectExpr : Q(Dialect) ← elabTermEnsuringType dialect q(Dialect)
    let _ ← synthInstance q(TyDenote (Dialect.Ty $dialectExpr))
    return dialectExpr

  elabCommand <|← `(command|
    instance : DialectDenote $dialect where
      signature := fun op => match op with $alts:matchAlts
  )

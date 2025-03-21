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

/-- A structured representation of the Syntax describing a list of arguments -/
inductive ArgListView
  /-- A single term, expected to be of type `List _`,
      to describe all arguments at once -/
  | antiquot (term : Term)
  /-- A list of terms, where each term describes a single argument type -/
  | list (ref : Syntax) (args : Array Term)

/-- A structured representation of the Syntax describing the signature of a region -/
structure RegionSignatureView where
  ref : Syntax
  argumentTypes : ArgListView
  returnType : Term

/-- A structured representation of the Syntax describing the signature of an operation -/
structure SignatureView extends RegionSignatureView where
  regions : Array RegionSignatureView
  effectKind : Term

/-- A meta region signature stores a list of expressions describing the argument
types and an expression describing the return type.

All expressions are expected to be of type `d.Ty` for some fixed `d : Dialect`.
-/
structure MetaRegionSignature where
  /-- `argumentTypes?` gives a list of expressions, where each describes the
    type of one argument. This field is `none` if the `${...}` escape hatch was
    used, as the number of arguments might not be knowable statically. -/
  argumentTypes? : Option (Array Expr)
  returnType : Expr
  deriving BEq

/-!
NOTE: we'll use the `argumentTypes?` field in `def_semantics` to determine if
we expect a prettified `fun (x y : BitVec _) => _` type function, or a raw
`HVector` function. Namely, we can do the former if `argumentTypes?` is known,
and revert to the latter if not.
-/

/- A meta function signature stores:
* A list of (meta) region signatures,
* A list of argument types, and
* A single return type

Where each "type" is a Lean expression of type `d.Ty`,
for some fixed `d : Dialect`.
-/
structure MetaSignature extends MetaRegionSignature where
  regions : Array MetaRegionSignature
  /-- `priority` records the position of the match alternative that corresponds
  to this signature definition, where `0` indicates the first (and thus highest-
  priority) match alternative. -/
  priority : Nat
  deriving BEq

def MetaRegionSignature.ofView (Ty : Expr) (view : RegionSignatureView) :
    TermElabM MetaRegionSignature := withRef view.ref do
  let argumentTypes? ← match view.argumentTypes with
    | .antiquot _ => pure none
    | .list ref argumentTypes => withRef ref <| do
        let exprs ← argumentTypes.mapM (elabTermEnsuringType · Ty)
        pure <| some exprs
  let returnType ← elabTermEnsuringType view.returnType Ty
  return { argumentTypes?, returnType }

/-- Elaborate a `MatchAltView` into a `MetaSignature`, given a Lean expression
`Ty : Type` that describes the type universe of the expected dialect. -/
def MetaSignature.ofView (Ty : Expr) (view : SignatureView) (priority : Nat) :
    TermElabM MetaSignature := withRef view.ref do
  let base ← MetaRegionSignature.ofView Ty view.toRegionSignatureView
  return { base with
    regions  := ←view.regions.mapM (MetaRegionSignature.ofView Ty)
    priority := priority
  }

structure MetaSignatureTree.Key where
  /-- Construct a `Key` from a **fully-reduced(!)** expression.

  Prefer `Key.ofExpr`, which will perform the necessary reduction.
  -/
  mk :: toExpr : Expr

/-- A `MetaSignatureTree` stores the signatures of all operations in a specific
dialect. -/
/-
Discrtrees are hard, so let's just start with the naive array-based solution.
TODO: check whether the quadratic complexity is problematic, and move to
      `DiscrTree` if it is.
-/
structure MetaSignatureTree where
  /-- A collection of signatures, ascendingly ordered by their priority. -/
  signatures : Array (MetaSignatureTree.Key × MetaSignature)
  /-- The threshold priority: if a new element has a priority strictly less
    than `maxPriority`, the array will have to be sorted after insertion.
    This is equal to the maximum priority of any signature contained in
    the array, or `0` if the array is empty. -/
  maxPriority : Nat

namespace MetaSignatureTree

def empty : MetaSignatureTree where
  signatures := .empty
  maxPriority := 0

def Key.ofExpr (op : Expr) : MetaM Key :=
  -- TODO: fully reduce op
  return ⟨op⟩

def insert (self : MetaSignatureTree) (key : Key) (signature : MetaSignature) :
    MetaSignatureTree :=
  let signatures := self.signatures.push (key, signature)
  if signature.priority ≥ self.maxPriority then
    { self with signatures, maxPriority := signature.priority }
  else
    let signatures :=
      signatures.insertionSort (lt := fun x y => x.2.priority < y.2.priority)
    { self with signatures }

def getMatch (self : MetaSignatureTree) (op : Expr) :
    MetaM MetaSignature := do
  let key ← Key.ofExpr op
  let hits := self.signatures
  for hit in hits do
    if ←isDefEq key.toExpr hit.1.toExpr then
      return hit.2
  /- TODO: come up with a better error, that indicates why no signature might have been found.
    In particular, we should explicate that we did find the `def_signature` info, but failed to
    unify the current op with any of the LHSs of the signatures.
  -/
  throwError "No signature found for {op}."


end MetaSignatureTree

/-!
### Dialect identifiers
We need some way to find the `MetaSignature` information in `def_semantics`.
We can store this information an EnvironmentExtension, but we'd do so in some kind
of map from, say, `Name` to `MetaSignature`, which begs the question: what name
do we use there?

We could assume that dialects are always applications of a fixed constant, and
use the name of that constant. This yields consistent results, but then means
that if we define the signature of operations in a meta dialect (e.g., `MetaLLVM`)
this signature would not be found for the concrete dialect `LLVM` even if normal
typeclass resolution would find the instance.

We can also be a bit more cute, and use the name of the `DialectSignature` *instance*
as the identifier. This way, we can be sure that the meta info is in sync with
the instance that got synthesized!
-/

initialize signatureExt : EnvExtension (NameMap MetaSignatureTree) ←
  registerEnvExtension
    (mkInitial := return .empty)
    (asyncMode := .mainOnly)  -- TODO: for now we've picked the default,
                              -- but we should re-evaluate what asyncMode is appropriate here

private def throwExpectedInstToBeApp (instType inst : Expr) : MetaM α := do
  throwError "Synthesized the following instance of {instType}:\n\
        \t{inst}\n\
        This was expected to be an application of a constant."

/--
Register the signatures for a given dialect in the `signatureExt`
environment extension.

NOTE: this assumes that an instance of `DialectSignature $dialect` has just been
defined using these signatures.
-/
def registerDialectMetaSignatures (dialect : Expr) (signatures : MetaSignatureTree) :
    MetaM Unit := do
  let dialect : Q(Dialect) := dialect
  let instType := q(DialectSignature $dialect)
  let inst ← synthInstance instType
  let .const instName _ := inst.getAppFn
    | throwExpectedInstToBeApp instType inst
  setEnv <| signatureExt.modifyState (← getEnv) fun map =>
    map.insert instName signatures

/--
Get the signatures for a given dialect from the `signatureExt`
environment extension, or throw an error if no signatures could be found.
-/
def getDialectMetaSignatures (dialect : Expr) : MetaM MetaSignatureTree := do
  let dialect : Q(Dialect) := dialect
  let instType := q($dialect)
  let inst ← synthInstance instType
  let .const instName _ := Expr.bvar 0
    | throwExpectedInstToBeApp instType inst
  let state := signatureExt.findStateAsync (← getEnv) instName
  let some sig := state.find? instName
    | throwError "Synthesized the following instance of {instType}:\n\
        \t{inst}\n\
        However, the corresponding signature information was not found.\
        Was this instance defined using `def_signature`, in this file?\n\
        \n\
        Manually defined instances, or instances defined in other files are not \
        supported!"
  return sig



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

/-! ## `def_signature` Elaboration  -/

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

def ArgListView.parse : TSyntax ``argumentList → m ArgListView
  | ref@`(argumentList| ($args,*))  => return .list ref args
  | `(argumentList| ${$argList})    => return .antiquot argList
  | stx => throwUnexpectedSyntax stx

def ArgListView.toTerm : ArgListView → m Term
  | .list ref args  => withRef ref <| `([$args,*])
  | .antiquot t     => return t

-- /-- Transforms an mlir function signature to a Lean function.

-- For example, `(int, nat) -> int` becomes `⟦int⟧ → ⟦int⟧ → ⟦nat⟧`. -/
-- def functionSignatureToTermFunction : TSyntax ``function → CommandElabM Term
--   | `(function| ($args,*) → $outTy:term) => do
--     let outTy ← `(⟦$outTy⟧)
--     args.getElems.foldlM (init := outTy) fun ty acc =>
--       `(⟦$ty⟧ → $acc)
--   | ref => throwUnexpectedSyntax ref

def parseSignature (ref : TSyntax ``LeanMLIR.Parser.signature) :
    m SignatureView :=
  withRef ref <| match ref with
  | `(signature| { $regions,* } → $fn:function ) => do
      let regions ← regions.getElems.mapM fun fn => withRef fn do
        let `(plainFunction| $args → $outTy) := fn
          | throwUnexpectedSyntax fn
        return {
          ref := fn
          argumentTypes := ← ArgListView.parse args
          returnType := outTy
        }
        -- `(⟨$args, $outTy⟩)
      parseFunction regions fn
  | `(signature| $fn:function) => parseFunction #[] fn
  | ref => throwUnexpectedSyntax ref
  where
    parseFunction (regions : Array RegionSignatureView)
        (ref : TSyntax ``LeanMLIR.Parser.function) :
        m SignatureView := withRef ref <| do
      let view : SignatureView := {
        ref, regions,
        returnType    := ⟨.missing⟩
        argumentTypes := .list .missing #[]
        effectKind    := ⟨.missing⟩
      }
      match ref with
      | `(function| $argumentTypes -[$effectKind]-> $returnType) => do
          let argumentTypes ← ArgListView.parse argumentTypes
          return { view with
            argumentTypes, returnType, effectKind
          }
          -- `(_root_.Signature.mkEffectful $args [$regions,*] ($outTy) ($eff))
      | `(function| $argumentTypes → $returnType) => do
          let argumentTypes ← ArgListView.parse argumentTypes
          return { view with
            argumentTypes, returnType,
            effectKind := ←`(_root_.EffectKind.pure),
          }
      | _ => throwUnexpectedSyntax ref

def SignatureView.toTerm (view : SignatureView) : m Term := do
  let regions ← view.regions.mapM fun view => withRef view.ref <| do
      `(⟨$(← view.argumentTypes.toTerm), $view.returnType⟩)
  let argumentTypes ← view.argumentTypes.toTerm
  `(_root_.Signature.mkEffectful
      $argumentTypes
      [$regions,*]
      $view.returnType
      $view.effectKind)

-- TODO: should this be upstreamed at some point?
def _root_.Array.foldMapIdxM {m} [Monad m]
    (f : Nat → σ → α → m (β × σ)) (init : σ) (as : Array α) : m (Array β × σ) :=
  StateT.run (s := init) <| as.mapIdxM fun n a s => f n s a

open MetaSignatureTree (Key) in
elab "def_signature" " for " dialect:term (" where ")? alts:matchAltsSig : command =>
  let msg := (return m!"{exceptEmoji ·} Defining operation signature for {dialect} dialect")
  withTraceNode `LeanMLIR.Elab msg (collapsed := false) <| do
    let alts := getMatchAlts alts
    let (alts, (sigTree : MetaSignatureTree)) ← runTermElabM <| fun _ => do
      let dialectExpr : Q(Dialect) ← elabTermEnsuringType dialect q(Dialect)
      let Op := q(Dialect.Op $dialectExpr)
      let Ty := q(Dialect.Ty $dialectExpr)
      alts.foldMapIdxM (init := .empty) fun priority state view => do
        trace[LeanMLIR.Elab] m!"Parsing match alternative with\n\
          \tpatterns: {(view.patterns : Array _)}\n\
          \tsignature: {view.rhs}"
        -- HACK: The `(_ : Array _)` type ascription above is load-bearing.
        --       Without it, we get a type mismatch error.

        let key : Key ← do
          let op : Term := view.patterns[0]!
          let op : Expr ← elabTermEnsuringType op Op
          Key.ofExpr op
        let sigView ← parseSignature view.rhs
        let signature ← MetaSignature.ofView Ty sigView priority
        return ({view with
                  rhs := ← sigView.toTerm
                },
                state.insert key signature)

    -- Define instance
    let matchAlts ← Elab.mkMatchAltsExpr alts
    elabCommand <|← `(command|
      instance : DialectSignature $dialect where
        signature := fun op => match op with $matchAlts:matchAlts
    )
    -- Save signature
    runTermElabM <| fun  _ => do
      let dialectExpr ← elabTermEnsuringType dialect q(Dialect)
      registerDialectMetaSignatures dialectExpr sigTree
    return ()

/-! ## `def_semantics`-/
open Parser (matchAltsExpr)
open Qq


elab "def_semantics" " for " dialect:term (" where ")? alts:matchAltsExpr : command => do
  let dialectExpr ← withRef dialect <| runTermElabM <| fun _ => do
    let dialectExpr : Q(Dialect) ← elabTermEnsuringType dialect q(Dialect)
    let _ ← synthInstance q(TyDenote (Dialect.Ty $dialectExpr))
    return dialectExpr

  elabCommand <|← `(command|
    instance : DialectDenote $dialect where
      signature := fun op => match op with $alts:matchAlts
  )

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
def MetaSignature.ofView (Ty : Expr) (view : SignatureView) :
    TermElabM MetaSignature := withRef view.ref do
  let base ← MetaRegionSignature.ofView Ty view.toRegionSignatureView
  return { base with
    regions  := ←view.regions.mapM (MetaRegionSignature.ofView Ty)
  }

/-!
## `def_signature` Elaboration
-/

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

def elabDefSignatureFor (dialect : Term) (alts : TSyntax ``matchAltsSig) : CommandElabM Unit := do
  let msg := (return m!"{exceptEmoji ·} Defining operation signature for {dialect} dialect")
  withTraceNode `LeanMLIR.Elab msg (collapsed := false) <| do
    let alts := getMatchAlts alts
    let alts ← do
      alts.mapM fun view => do
        trace[LeanMLIR.Elab] m!"Parsing match alternative with\n\
          \tpatterns: {(view.patterns : Array _)}\n\
          \tsignature: {view.rhs}"
        -- HACK: The `(_ : Array _)` type ascription above is load-bearing.
        --       Without it, we get a type mismatch error.

        let sigView ← parseSignature view.rhs
        return {view with
                  rhs := ← sigView.toTerm
                }

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

structure MetaSignatureInfo where
  numRegions : Nat
  numArguments : Option Nat
  cleanExpectedType : Term

structure MetaSignatures where
  map : Array (TermElabM Expr × MetaSignatureInfo)

instance : ToMessageData MetaSignatureInfo where
  toMessageData sig :=
    m!"\{ numRegions := {sig.numRegions},\n  \
         numArguments := {sig.numArguments},\n  \
         cleanExpectedType := {sig.cleanExpectedType}}"

def MetaSignature.fromInstance (dialect : Expr) : TermElabM MetaSignatures := do
  let dialect : Q(Dialect) := dialect
  let instType := q(DialectSignature $dialect)
  let origInst ← synthInstance instType
  trace[LeanMLIR.Elab] "Found instance: {origInst}"
  let inst ← whnf origInst -- ensure we get the definition
  let ⟨instMVars, _, inst⟩ ← lambdaMetaTelescope inst -- ignore any lambdas
  let_expr DialectSignature.mk _d sig := inst
    | throwError m!"\
        Synthesised the following instance of {instType}:\n
        \t{origInst}\n
        Expected the definition to be an application of \
        {Expr.const ``DialectSignature.mk []},found:\n\
        \t{inst}"
  /-
  TODO: think about the corner case with a single trivial match arm:
  ```
  def_signature for MyCoolDialect where
    | _ => () -> .int
  ```

  In this case, the elaborator notices that no match is necessary, hence the
  following code will not work.
  -/

  let ⟨_, _, sig⟩ ← lambdaMetaTelescope sig -- ignore any lambdas

  -- TODO: We ought to check here that `sig` is actually a `match _ with ...`
  --       expression, and throw an error if not.

  /- `match foo with ...` gets elaborated into an application of a
      `$ident.match_$n` function: the following gets us that function. -/
  let matchFun := sig.getAppFn
  /- If the instance definition has variables, those get added to the match
      definition as well. The following normalizes this, so that the type of
      `matchFun` should be akin to:
      ```
        (motive : $Op → Type) → (op : $Op) → ...
      ``` -/
  let instArgs := origInst.getAppArgs ++ instMVars
  let matchFun := mkAppN matchFun instArgs
  let matchType ← inferType matchFun
  trace[LeanMLIR.Elab] "Match function: {matchFun}"
  forallTelescope matchType fun matchArgs _resultType => do
    let matchArgs := matchArgs.drop 2 -- ignore `motive` and `op`
    trace[LeanMLIR.Elab] "Match arguments:\n{matchArgs}"
    let map ← matchArgs.mapM fun matchArg => do
      let ty ← inferType matchArg
      let pattern := do
        let ⟨_, _, ty⟩ ← forallMetaTelescope ty
        let (.app _motive ty) := ty
          | throwError "Expected an application of a motive, found:\n\t{ty}"
        pure ty
      let signature ← `(term| _root_.Nat)
      return (pattern, {
        numRegions := 0
        numArguments := some 0
        cleanExpectedType := signature
      })
    return ⟨map⟩

def MetaSignatures.find (self : MetaSignatures) (op : Expr) : TermElabM (Option MetaSignatureInfo) := do
  let op ← instantiateMVars op
  let msg := (pure m!"{exceptEmoji ·} Searching signature for {op}")
  withTraceNode `LeanMLIR.Elab msg <| do
    if op.isMVar then
      return none

    for entry in self.map do
      let pattern ← entry.1
      if ←isDefEq pattern op then
        trace[LeanMLIR.Elab] "Found signature for {op}:\n\t{entry.2}"
        return entry.2

    logWarning "No signature found for operation {op}"
    return none

def MetaSignatures.findStx (self : MetaSignatures) (Op : Expr) (opPattern : Term) :
    TermElabM (Option MetaSignatureInfo) :=
  let msg := (pure m!"{exceptEmoji ·} Searching signature for {opPattern} (syntax)")
  withTraceNode `LeanMLIR.Elab msg <| do
    let patternVars ← getPatternVars opPattern
    let patternVars := getPatternVarNames patternVars
    trace[LeanMLIR.Elab] "pattern variables: {patternVars}"
    let patternVars := patternVars.map fun name =>
      (name, fun _ => (mkFreshExprMVar none : TermElabM _))
    withLocalDeclsD patternVars <| fun _ => do
      let expr ← elabTerm opPattern Op
      self.find expr

elab "def_semantics" " for " dialect:term (" where ")? alts:matchAltsExpr : command => do
  let alts ← runTermElabM <| fun _ => do
    let dialectExpr : Q(Dialect) ← elabTermEnsuringType dialect q(Dialect)

    -- Get signature info
    let sigMap ← withRef dialect <|
      MetaSignature.fromInstance dialectExpr
    let findSig := sigMap.findStx q(Dialect.Op $dialectExpr)

    -- Add function type annotations
    let matchAlts := getMatchAltsExpr alts
    let matchAlts ← matchAlts.mapM fun altView => withRef altView.ref <| do
      let pattern := altView.patterns[0]!
      match ← findSig pattern with
      | none     => return altView
      | some sig => do return { altView with
          rhs := ←`( ($altView.rhs : $sig.cleanExpectedType) )
        }
    -- Re-assemble match alternatives
    Elab.mkMatchAltsExpr matchAlts

  elabCommand <|← `(command| -- Declare instance
    instance : DialectDenote $dialect where
      denote := fun op => match op with $alts:matchAlts
  )

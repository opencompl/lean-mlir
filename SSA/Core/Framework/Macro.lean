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
## `def_denote`
-/
open Parser (matchAltsExpr)
open Qq

/-- `MetaList` represents an expression of type `List α` -/
inductive MetaArgList
  /-- A statically known argument list, represented as an array of expressions,
    where each `elements[i]` is of type `Dialect.Ty $d`, for some (fixed)
    dialect `d`
  -/
  | static (Ty toType : Expr) (elements : Array Expr)
  /-- A dynamic argument list is simply a single expression of type `Type _`,
      usually this expression is an application of `HVector`. -/
  | dynamic (name : Name) (expr : Expr)

/-- Construct a `MetaArgList` from an expression of type `HVector f as`.

NOTE: the `MetaArgList` effectively represents the list `as`. -/
def MetaArgList.ofExpr (arg : Expr) : MetaM MetaArgList := do
  let e ← inferType arg
  let_expr HVector α f as := e
    | throwError "Expected HVector, found: {e}"
  match ← listExprToArray as with
  | some as => do
      -- let as ← as.mapM (whnf <| mkApp f ·)
      return .static α f as
  | none =>
    let name ← match arg.fvarId? with
      | some id => id.getUserName
      | none    => pure .anonymous
    return .dynamic name e

/--
Given some expression `body` of type `Type _`, return the type expression
  `$f $as[0] → … → $f $as[n] → $body`
if the list of argument types is statically known, or simply
  `HVector $f $as → $body`
if not
-/
def MetaArgList.foldForallType (body : Expr) : MetaArgList → MetaM Expr
  | .dynamic name e => return Expr.forallE name e body .default
  | .static _ f as =>
    as.foldrM (init := body) fun a type => do
      let binderType ← whnf (.app f a)
      return Expr.forallE .anonymous binderType type .default

-- /-- Return the application of `HVector` represented by this argument list. -/
-- def toHVectorExpr : MetaArgList → Expr
--   | .static es    =>
--   | .dynamic _ e  => e

/--
Given an expression `fn` of the curried type returned by `args.foldForallType body`,
and an expression of uncurried type `HVector $f $as` (for the `f` and `as` this
`MetaArgList` was constructed with), return an expression of type `$body`.
-/
def MetaArgList.applyCurried (fn vec : Expr) : MetaArgList → MetaM Expr
  | dynamic ..      => return mkApp fn vec
  | static _α _f as => do
      let n : Nat := as.size
      let mut fn := fn
      for (i : Nat) in [0:n] do
        let inBoundsProof ← mkDecideProof q($i < $n)
        let idxExpr := mkApp3 (.const ``Fin.mk []) (toExpr n) (toExpr i) inBoundsProof
        let arg ← mkAppM ``HVector.get #[vec, idxExpr]
        -- let arg ← curryHVecFun arg args[i]
        fn := mkApp fn arg
      return fn

/--
`hvectorFun(...)` is an implementation detail of `def_denote`.

`hvectorFun($fn)` assumes the `expectedType` is something like:
```
  HVector ?f ?as → HVector ?g ?bs → ?β
```

This is transformed into an idiomatic, curried, function type--assuming that
`as` and `bs` reduce to a simple sequence of `List` constructors.
```
  f as[0] → f as[1] → … → f as[n] → g bs[0] → … → g bs[m] → β
```
Finally, an expression of the originally expected type is construed by applying
the elaborated the function to appropriate elements of the vectors arguments,
extracted via `HVector.get`.

If either `as` or `bs` does not reduce, the corresponding `HVector` argument
is left as-is in the new expected type.
-/
local elab "hvectorFun(" fn:term ")" : term <= expectedType => do
  let origLCtx ← getLCtx
  let origLocalInst ← getLocalInstances
  forallTelescope expectedType fun args returnType => do
    for arg in args do
      if returnType.containsFVar arg.fvarId! then
        throwError "Return type {returnType} depends on argument {arg}.\n\
          Only non-dependent arrow are supported."

    let argTypes ← args.mapM (MetaArgList.ofExpr ·)
    let returnType ← whnf returnType
    let altExpectedType ← argTypes.foldrM (·.foldForallType ·) returnType

    let fn ← withLCtx origLCtx origLocalInst <| do
      elabTermEnsuringType fn altExpectedType
    let fn ← (args.zip argTypes).foldlM (init := fn) fun fn (vecArg, args) => do
      args.applyCurried fn vecArg

    let fn ← mkLambdaFVars args fn
    synthesizeSyntheticMVarsUsingDefault
    runPendingTacticsAt fn
    let fn ← instantiateMVars fn
    trace[LeanMLIR.Elab] m!"desugared: {fn}"
    return fn

/--
`def_denote for $FooDialect` enables the definition of an instance for
`DialectDenote $FooDialect` via idiomatic curried functions, instead of the
internal encoding with `HVector` arguments.

NOTE: this is only possible for operations where the number of arguments in the
signature can be statically determined. For operations where we cannot (such as
variadic operations), the expected type falls back to the internal `HVector`
encoding.
-/
elab "def_denote" " for " dialect:term (" where ")? alts:matchAltsExpr : command => do
  let matchAlts := getMatchAltsExpr alts
  let matchAlts ← matchAlts.mapM fun altView => withRef altView.rhs <| do
    return { altView with
      rhs := ←`(hvectorFun($altView.rhs))
    }
  -- Re-assemble match alternatives
  let matchAlts ← Elab.mkMatchAltsExpr matchAlts

  elabCommand <|← `(instance : DialectDenote $dialect where
      denote := fun op => match op with $matchAlts:matchAlts
  )

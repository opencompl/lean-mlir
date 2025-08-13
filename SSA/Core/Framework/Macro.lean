/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Framework.Trace
import SSA.Core.Tactic.SimpSet

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
  leading_parser "$" >> checkNoWsBefore >> "{" >> termParser >> "}"
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
## Common Elaboration Utilities
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

/--
Given `e` a Lean expression of type `List α`, return an array of
expressions `es : Array Expr` where `es[i]` is the `i`th element of `e`.

Returns `none` if `e` does not reduce to a `Ctxt.ofList` applied to a sequence
of `List` constructors. -/
def ctxtExprToArray (e : Expr) : MetaM (Option <| Array Expr) := do
  let_expr Ctxt.ofList _ Γ := ← whnf e
    | return none
  listExprToArray Γ

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
        let args ← parseRegionArgumentList args
        `(⟨$args, $outTy⟩)
      parseFunction regions fn
  | `(signature| $fn:function) => parseFunction #[] fn
  | ref => throwUnexpectedSyntax ref
  where
    parseRegionArgumentList : TSyntax ``argumentList → m Term
      | `(argumentList| ${$args})  => pure args
      | `(argumentList| ($args,*)) => `(⟨[$args,*]⟩)
      | ref => throwUnexpectedSyntax ref
    parseArgumentList : TSyntax ``argumentList → m Term
      | `(argumentList| ${$args})  => pure args
      | `(argumentList| ($args,*)) => `([$args,*])
      | ref => throwUnexpectedSyntax ref
    mkReturnType (ret : Term) : m Term := do
      -- TODO: for now we assume there is just a single return type
      `([$ret])

    mkSignature (argumentTypes : TSyntax ``argumentList) (regions : Array Term)
        (returnType : Term) (effectKind : Term) :
        m Term := do
      let argumentTypes ← parseArgumentList argumentTypes
      let returnType ← mkReturnType returnType
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

mutual

/-- `CurriedArrow` represents a function *type*.
It is constructed from an uncurried type, such as
```
  HVector TyDenote.toType [.int, .int] → (Ctxt.Valuation [.int] → ⟦.int⟧) → ⟦.int⟧
```
And, assuming the denotation of `int` is an `Int`, represents the
curried function type:
```
  Int → Int → (Int → Int) → Int
```

Meanwhile storing enough information to reconstruct a term of the original
uncurried type from a term of the constructed curried type.
-/
structure CurriedArrow where
  (args : Array CurriedArgs)
  (returnType : Expr)
  deriving Inhabited

/-- `CurriedArgs` represents a single *uncurried* argument in a `CurriedArrow`.
In particular, it generally represents an `HVector` or `Ctxt.Valuation`, but may
in general represent any type expression.

Note that in the process of currying, the single uncurried argument is generally
transformed into multiple curried arguments.
-/
inductive CurriedArgs
  /--
  A vector with statically known element types, where each `elements[i]` is an
  expression of type `α : Type`, and `f : α → Type`.
  Each `args[i]` represents the type `toType elements[i]`.

  NOTE: We don't support universe polymorphism despite the fact that `HVector`
        *is* polymorphic.
  -/
  | vector (name : Name) (α f : Expr) (elements : Array Expr) (args : Array CurriedArrow)
  /--
  A valuation for a statically known context, where each `Γ[i]` is an expression
  of type `Ty`, and `instTyDenote` is an expression of type `TyDenote $Ty`.
  Each `args[i]` represents the type `⟦Γ[i]⟧`.
  -/
  | valuation (name : Name) (Ty instTyDenote : Expr) (Γ : Array Expr) (args : Array CurriedArrow)
  /--
  Some expression of type `Type`.
  -/
  | other (name : Name) (expr : Expr)

end

mutual

/-- Parse an expression of type `Type` into a `CurriedArrow` -/
partial def CurriedArrow.ofExpr (e : Expr) (argsArray : Array CurriedArgs := #[]) :
    MetaM CurriedArrow := do
  let e ← whnf e
  if let .forallE _x binderType body .default := e then
    -- NOTE: we currently don't track binderInfo, so we explicitly match only
    --       on arguments with default binderInfo!
    let args ← CurriedArgs.ofTypeExpr binderType
    CurriedArrow.ofExpr body (argsArray.push args)
  else
    let mut args := argsArray
    let mut returnType := e
    for _ in [0:args.size] do
      if let some (.other x binderType) := args.back? then
        args := args.pop
        returnType := Expr.forallE x binderType returnType .default
      else
        break
    return {
      args := argsArray
      returnType := e
    }

/-- Construct a `CurriedArgs` from a type expression such as `HVector ?f ?as`
or `Ctxt.Valuation ?Γ`.
-/
partial def CurriedArgs.ofTypeExpr (argTy : Expr) (argName : Option Name := none) :
    MetaM CurriedArgs := do
  let name ← argName.getDM <| mkFreshBinderName
  trace[LeanMLIR.Elab] "Analyzing: {argTy}"
  -- TODO: add better tracing, that explains when an argument type is left uncurried
  match_expr argTy with
  | HVector α f as =>
      match ← listExprToArray as with
      | some as => do
          let args ← as.mapM (CurriedArrow.ofExpr <| .app f ·)
          return .vector name α f as args
      | none => return .other name argTy
  | Ctxt.Valuation Ty inst Γ =>
      match ← ctxtExprToArray Γ with
      | some Γ =>
          let toType := mkApp2 (.const ``TyDenote.toType []) Ty inst
          let args ← Γ.mapM (CurriedArrow.ofExpr <| .app toType ·)
          return .valuation name Ty inst Γ args
      | none => return .other name argTy
  | _ => return .other name argTy

end

def CurriedArgs.ofArgExpr (arg : Expr) : MetaM CurriedArgs := do
  let argTy ← inferType arg
  let name ← arg.fvarId?.mapM (·.getUserName)
  ofTypeExpr argTy name

mutual

partial def CurriedArrow.toExpr : CurriedArrow → Expr
  | ⟨args, returnType⟩ => args.foldr (·.foldForallType ·) returnType

/--
Given some expression `body` of type `Type _`, return the curried type expression
  `$args[0] → … → $args[n] → $body`
if the list of argument types is statically known, or the uncurried type
  `$args → $body`
if not
-/
partial def CurriedArgs.foldForallType (body : Expr) : CurriedArgs → Expr
  | .other name e => Expr.forallE name e body .default
  | .valuation name _Ty _inst _Γ args
  | .vector name _ _f _as args =>
      args.foldr (init := body) fun binderType type =>
        Expr.forallE name binderType.toExpr type .default

end

def _root_.List.mkOfElems (u : Level) (α : Expr) (elems : Array Expr) : Expr :=
  elems.foldr (init := mkApp (.const ``List.nil [u]) α) <|
    mkApp3 (.const ``List.cons [u]) α

/-- Return an array of expression, each being a single *curried* argument type. -/
def CurriedArgs.toCurriedExprs : CurriedArgs → Array Expr
  | .other _ e => #[e]
  | .valuation _ _ _ _ args
  | .vector _ _ _ _ args => args.map (·.toExpr)

/-- Return the *uncurried* argument type expression. -/
def CurriedArgs.toUncurriedExpr : CurriedArgs → Expr
  | .other _ e              => e
  | .vector _ α f as _ =>
      let as := List.mkOfElems 0 α as
      mkApp3 (.const ``HVector [0, 0]) α f as
  | .valuation _ Ty inst Γ _  =>
      let Γ := List.mkOfElems 0 Ty Γ
      mkApp3 (.const ``Ctxt.Valuation []) Ty inst Γ

def CurriedArgs.name : CurriedArgs → Name
  | .other name _ | .vector name .. | .valuation name .. => name

mutual

/--
Given an expression `fn` of the uncurried type used represented by `arrow`,
return an expression of the curried type returned by `arrow.toExpr`.
-/
partial def CurriedArrow.curry (fn : Expr) (arrow : CurriedArrow) : MetaM Expr :=
  withTraceNode `LeanMLIR.Elab (fun _ => pure m!"currying `{fn}`") <|
    go fn arrow.args.toSubarray
where
  go (fn : Expr) (args : Subarray CurriedArgs) : MetaM Expr := do
    let some (arg, args) := args.popHead?
      | return fn
    let decls ← arg.toCurriedExprs.mapM fun argTy => do
      return (← mkFreshUserName arg.name, argTy)
    withLocalDeclsDND decls <| fun fvars => do
      let fn := mkApp fn (← arg.mkVector fvars)
      let fn ← go fn args
      let fn ← mkLambdaFVars fvars fn
      trace[LeanMLIR.Elab] "curried to: `{fn}`"
      return fn

/--
Given an expression `fn` of the curried type returned by `arrow.toExpr`,
return an expression of the original uncurried type.
-/
partial def CurriedArrow.uncurry (fn : Expr) (arrow : CurriedArrow) : MetaM Expr :=
  withTraceNode `LeanMLIR.Elab (fun _ => pure m!"uncurrying `{fn}`") <| do
    let args := arrow.args
    let decls ← args.mapM fun arg => do
      return (← mkFreshUserName arg.name, arg.toUncurriedExpr)
    withLocalDeclsDND decls <| fun fvars => do
      let fn ← (args.zip fvars).foldlM (init := fn) fun fn (arg, x) => do
        return mkAppN fn (← arg.getElems x)
      let fn ← mkLambdaFVars fvars fn
      trace[LeanMLIR.Elab] "uncurried to: `{fn}`"
      return fn

/--
Given an expression `vec` of the uncurried type `args` was constructed from,
return an array of expressions, where each expression is a single element of the
vector/valuation.
-/
partial def CurriedArgs.getElems (vec : Expr) : CurriedArgs → MetaM (Array Expr)
  | .other ..      => return #[vec]
  | .valuation _ (Ty : Q(Type)) _ Γ arrows => do
      let Γe : Q(Ctxt $Ty) := List.mkOfElems 0 Ty Γ
      (Γ.zip arrows).mapIdxM fun i (t, arr) => do
        let var := Ctxt.mkVar Ty Γe t (toExpr i)
        let arg := mkApp2 vec t var
        arr.curry arg
  | .vector _ α f as arrows => do
      let asE := List.mkOfElems 0 α as
      let n : Nat := arrows.size
      arrows.mapIdxM fun (i : Nat) arr => do
        let inBoundsProof ← mkDecideProof q($i < $n)
        let idxExpr := mkApp3 (.const ``Fin.mk []) (toExpr n) (toExpr i) inBoundsProof
        let arg := mkApp5 (.const ``HVector.get [0, 0]) α f asE vec idxExpr
        arr.curry arg

/--
Given an array of curried function arguments, construct an expression of the
uncurried vector/valuation type represented by `args`
-/
partial def CurriedArgs.mkVector (elems : Array Expr) : CurriedArgs → MetaM Expr
  | .other ..      =>
      if h : elems.size = 1 then
        return elems[0]
      else
        throwError "Expected exactly 1 element, found:\n{elems}"
  | .valuation _ (Ty : Q(Type)) inst Γ arrows => do
      let elems ← (arrows.zip elems).mapM fun (arr, elem) => arr.uncurry elem
      let toType := mkApp2 (.const ``TyDenote.toType []) Ty inst
      let vec ← HVector.mkOfElems 0 0 Ty toType (Γ.zip elems)
      return mkAppN (.const ``Ctxt.Valuation.ofHVector [])
        #[Ty, inst, (List.mkOfElems 0 Ty Γ), vec]
  | .vector _ α f as arrows => do
      let elems ← (arrows.zip elems).mapM fun (arr, elem) => arr.uncurry elem
      HVector.mkOfElems 0 0 α f (as.zip elems)

end

/--
`hvectorFun($fn)` is an implementation detail of `def_denote`.

Assuming the expected type is an uncurried function type, we use `CurriedFun`
machinery to transform this into a *curried* function type, elaborate the term
`fn` as a curried function, and finally transform the elaborated expression
into a term of the original, uncurried type.

See `CurriedFun` for details.
-/
local elab "hvectorFun(" fn:term ")" : term <= expectedType => do
  trace[LeanMLIR.Elab] "Original expected type:\n{expectedType}"

  let arrow ← CurriedArrow.ofExpr expectedType
  if arrow.returnType.hasLooseBVars then
    throwError "Expected a non-dependent type, found:\n\t{expectedType}"

  let fn ← elabTermEnsuringType fn arrow.toExpr
  let fn ← arrow.uncurry fn
  trace[LeanMLIR.Elab] m!"desugared: {fn}"
  Meta.check fn -- TODO: remove this once finished debugging
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

  elabCommand <|← `(
    @[simp_denote]
    instance : DialectDenote $dialect where
      denote := fun op => match op with $matchAlts:matchAlts
  )

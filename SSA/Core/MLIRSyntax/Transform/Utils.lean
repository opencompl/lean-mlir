import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.Transform

/-!
This file defines a set of helper functions on `AST` objects that
are usefull to implementors of `Transform` typeclasses
-/

namespace MLIR.AST

namespace Op
variable {φ} (op : Op φ)
variable {d : Dialect} [DialectSignature d] [DecidableEq d.Ty] [TransformTy d φ] [ToString d.Ty]

/-! ## Attributes-/

/--
`op.getAttr attr` returns the value of an attribute, if present,
or throw an error otherwise. -/
def getAttr (attr : String) : Except TransformError (AttrValue φ) := do
  let some val := op.getAttr? attr
    | .error <| .generic s!"Missing attribute `{attr}`"
  return val

/--
`op.hasAttr attr` returns whether the given attribute is present.
-/
def hasAttr (attr : String) : Bool :=
  (op.getAttr? attr).isSome

/--
`op.getBoolAttr attr` returns the value of a Boolean attribute.

Throws an error if the attribute is not present, or if the value of the attribute
has the wrong type.
-/
def getBoolAttr (attr : String) : Except TransformError Bool := do
  let .bool b ← op.getAttr attr
    | .error <| .generic s!"Expected attribute `{attr}` to be of type Bool, but found:\n\
        \t{attr}"
  return b

/--
`op.getIntAttr attr` returns the value of an integer attribute.

Throws an error if the attribute is not present, or if the value of the attribute
has the wrong type.
-/
def getIntAttr (attr : String) : Except TransformError (Int × MLIRType φ) := do
  let .int val ty ← op.getAttr attr
    | .error <| .generic s!"Expected attribute `{attr}` to be of type Int, but found:\n\
        \t{attr}"
  return (val, ty)

/-! ## Arguments -/

/--
`ParsedArgs Γ` wraps a list of variables in context `Γ`.
-/
structure ParsedArgs (Γ : Ctxt d.Ty) (n? : Option Nat := none) where
  toList : List (Σ t, Γ.Var t)
  length_eq : match n? with
    | some n => toList.length = n
    | none => True

def ParsedArgs.ofList {Γ : Ctxt d.Ty} : List (Σ t, Γ.Var t) → ParsedArgs Γ :=
  (⟨·, by constructor⟩)

/--
Translates the arguments of `op` into intrinsically well-typed variables in the
given context `Γ`.

See also `TypedSSAVal.mkVal`, which does the parsing.
-/
def parseArgs (Γ : Ctxt d.Ty) : ReaderM d (ParsedArgs Γ) :=
  ParsedArgs.ofList <$> op.args.mapM (TypedSSAVal.mkVal Γ)

namespace ParsedArgs
variable {Γ : Ctxt d.Ty} {n?} (args : ParsedArgs Γ n?)

/-- Returns the list of types of each argument. -/
def types : List d.Ty := args.toList.map Sigma.fst

/-- Return the collection of argument variables as an HVector. -/
def toHVector : HVector Γ.Var args.types :=
  go args.toList where
    go {α} {f : α → Type} : (as : List (Σ a, f a)) → HVector f (as.map Sigma.fst)
    | [] => .nil
    | ⟨_, x⟩::xs => .cons x (go xs)

/--
`parsedArgs.withSignature sig` returns an HVector of variables with the given
signature, assuming that:
* their are exactly as many arguments as the signature calls for, and
* each argument is of the respective type in the signature.

Throws an error if either of these assumptions is broken.
-/
def withSignature (sig : List d.Ty) : Except TransformError (HVector Γ.Var sig) := do
  if h : args.types = sig then
    return h ▸ args.toHVector
  else
    throw <| .generic "Argument types don't match expected signature. Expected:\n\
        \t{sig}\nfound:\n\t{args.types}"
    -- TODO: we could figure out why exactly these aren't equal and throw a more
    --       informative error

/-! ### Arity -/

/-- Throw an error if there are not exactly `n` arguments -/
def assumeArity (n : Nat) : Except TransformError (ParsedArgs Γ n) :=
  if h : n? = some n then
    return h ▸ args
  else if h : args.toList.length = n then
    return ⟨args.toList, h⟩
  else
    throw <| .generic s!"Expected exactly {n} argument(s), but found {args.toList.length}"

def withArity : Σ n, ParsedArgs Γ (some n) :=
  ⟨args.toList.length, ⟨args.toList, rfl⟩⟩

-- After checking the arity, we can access elements with static bounds checks
instance (n : Nat) : GetElem (ParsedArgs Γ (some n)) Nat (Σ t, Γ.Var t) (fun _ i => i < n) where
  getElem args i h := args.toList.get ⟨i, by simpa [args.length_eq]⟩

-- We can always forget the arity, if needed
instance (n : Nat) : CoeHead (ParsedArgs Γ (some n)) (ParsedArgs Γ) where
  coe args := .ofList args.toList

end ParsedArgs

/-! ## Expression Construction -/

/--
`op.mkExprOf parsedOp` constructs an `Expr` of the given parsed
operation and arguments.

Throws an error if the types of the arguments don't correspond to the signature
of the operation.

**Panics** if the given operation expects regions arguments!
-/
def mkExprOf (Γ : Ctxt d.Ty) (parsedOp : d.Op)
    (args? : Option (ParsedArgs Γ) := none):
    ReaderM d (Σ eff returnTy, Expr d Γ eff returnTy) := do
  let args ← args?.getDM (op.parseArgs Γ)
  let signature := DialectSignature.signature parsedOp
  let argsVec := args.toHVector
  let eff := signature.effectKind
  let returnTy := signature.outTy

  -- TODO: parse regions
  if h_noRegions : ¬signature.regSig.isEmpty then
    panic! s!"mkExprOf shouldn't be called with an operation that expects regions!"
  else
    return ⟨eff, returnTy, ⟨
      parsedOp,
      rfl,
      EffectKind.le_refl _,
      ← args.withSignature _,
      have : DialectSignature.regSig parsedOp = [] := by simpa using h_noRegions
      this ▸ .nil
    ⟩⟩

end Op

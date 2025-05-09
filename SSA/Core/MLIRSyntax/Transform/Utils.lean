import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.Transform

/-!
This file defines a set of helper functions on `AST` objects that
are usefull to implementors of `Transform` typeclasses
-/

namespace MLIR.AST

namespace Op
variable {φ} (op : Op φ)
variable {d : Dialect} [DialectSignature d] [DecidableEq d.Ty] [TransformTy d φ]

/-! ## Attributes-/

/--
`op.getAttr attr` returns the value of an attribute, if present,
or throw an error otherwise. -/
def getAttr (attr : String) : Except (TransformError Ty) (AttrValue φ) := do
  let some val := op.getAttr? attr
    | .error <| .generic s!"Missing attribute `{attr}`"
  return val

/--
`op.getBoolAttr attr` returns the value of a Boolean attribute.

Throws an error if the attribute is not present, or if the value of the attribute
has the wrong type.
-/
def getBoolAttr (attr : String) : Except (TransformError Ty) Bool := do
  let .bool b ← op.getAttr attr
    | .error <| .generic s!"Expected attribute `{attr}` to be of type Bool, but found:\n\
        \t{attr}"
  return b

/--
`op.getIntAttr attr` returns the value of an integer attribute.

Throws an error if the attribute is not present, or if the value of the attribute
has the wrong type.
-/
def getIntAttr (attr : String) : Except (TransformError Ty) (Int × MLIRType φ) := do
  let .int val ty ← op.getAttr attr
    | .error <| .generic s!"Expected attribute `{attr}` to be of type Int, but found:\n\
        \t{attr}"
  return (val, ty)

/-! ## Arguments -/

structure ParsedArgs (Γ : Ctxt d.Ty) where
  ofList :: toList : List (Σ t, Γ.Var t)

/--
Translates the arguments of `op` into intrinsically well-typed variables in the
given context `Γ`.

See also `TypedSSAVal.mkVal`, which does the parsing.
-/
def parseArgs (Γ : Ctxt d.Ty) : ReaderM d (ParsedArgs Γ) :=
  ParsedArgs.ofList <$> op.args.mapM (TypedSSAVal.mkVal Γ)

namespace ParsedArgs
variable {Γ : Ctxt d.Ty} (args : ParsedArgs Γ)

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
* each argument if of the respective type in the signature.

Throws an error if either of these assumptions is broken.
-/
def withSignature (sig : List d.Ty) : Except (TransformError d.Ty) (HVector Γ.Var sig) := do
  if h : args.types = sig then
    return h ▸ args.toHVector
  else
    throw <| .generic "Argument types don't match expected signature. Expected:\n\
        \t{sig}\nfound:\n\t{args.types}"
    -- TODO: we could figure out why exactly these aren't equal and throw a more
    --       informative error

end ParsedArgs

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

/-!
## Where should `mkExprOf` live?

At first, I defined `mkExprOf` in the `ParsedArgs` namespace, and made it
take a `ParsedArgs` argument.The idea behind this is that we sometimes need to parse
the argument type annotations to construct the concrete parsed operation
(e.g., in the LLVM dialect we do this because an `Op` carries the width of the
vectors it operates on). By taking in a `ParsedArgs` in `mkExprOf`, we then avoid
having the re-parse these arguments, which would be wasteful.
However, we've this loses any information about regions! Taking those in separately
would be quite annoying for the vast majority of operations that don't need to
parse their regions. `op.parseArgs.mkExprOf _ _` is acceptable, but
`op.parseArgs.mkExprOf (op.parseRegions)` is way too boilerplate-y.

Thus, instead I've moved to `Op.mkExprOf` which takes an `Op` argument, and an
*optional* `ParsedArgs` argument. This generalizes nicely to being able to parse
regions later. Plus it has the benefit of making the simple case (`Op` not depending
on the type annotations) simpler (`op.mkExprOf Γ (...)`) and the complex case not
that much worse `op.mkExprOf (args? := args) _ (...)`. Furthermore, we might even
have operations that want to inspect their region types (e.g., `SCF.if`), in which
case this generalizes nicely to a second optional `regions?` argument.
-/


end Op

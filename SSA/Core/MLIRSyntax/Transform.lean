/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- should replace with Lean import once Pure is upstream
import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.Transform.NameMapping
import SSA.Core.MLIRSyntax.Transform.TransformError
import SSA.Core.Framework
import SSA.Core.ErasedContext

/-!
# `Transform*` typeclasses
This file defines `TransformTy`, `TransformExpr`, and `TransformReturn` typeclasses,
which dictate how generic MLIR syntax (as defined in `MLIRSyntax.AST`) can be transformed into
an instance of `Com` or `Expr` for a specific dialect.
-/

universe u

namespace MLIR.AST

open Ctxt

instance {d : Dialect} [DialectSignature d] {t : d.Ty} {Γ : Ctxt d.Ty} {Γ' : DerivedCtxt Γ} : Coe (Expr d Γ t) (Expr d Γ'.ctxt t) where
  coe e := e.changeVars Γ'.diff.toHom


section Monads

/-!
  Even though we technically only need to know the `Ty` type,
  our typeclass hierarchy is fully based on `Op`.
  It is thus more convenient to incorporate `Op` in these types, so that there will be no ambiguity
  errors.
-/

abbrev ExceptM  (d : Dialect) := Except (TransformError d.Ty)
abbrev BuilderM (d : Dialect) := StateT NameMapping (ExceptM d)
abbrev ReaderM  (d : Dialect) := ReaderT NameMapping (ExceptM d)

instance {d : Dialect} : MonadLift (ReaderM d) (BuilderM d) where
  monadLift x := do (ReaderT.run x (←get) : ExceptM ..)

instance {d : Dialect} : MonadLift (ExceptM d) (ReaderM d) where
  monadLift x := do return ←x

def BuilderM.runWithEmptyMapping (k : BuilderM d α) : ExceptM d α :=
  Prod.fst <$> StateT.run k []

end Monads

/-!
  These typeclasses provide a natural flow to how users should implement `TransformDialect`.
  - First declare how to transform types with `TransformTy`.
  - Second, using `TransformTy`, declare how to transform expressions with `TransformExpr`.
  - Third, using both type and expression conversion, declare how to transform returns with `TransformReturn`.
  - These three automatically give an instance of `TransformDialect`.
-/
class TransformTy (d : Dialect) (φ : outParam Nat) [DialectSignature d]  where
  mkTy   : MLIRType φ → ExceptM d d.Ty

class TransformExpr (d : Dialect) (φ : outParam Nat) [DialectSignature d] [TransformTy d φ]  where
  mkExpr   : (Γ : List d.Ty) → (opStx : AST.Op φ) → ReaderM d (Σ ty, Expr d Γ ty)

class TransformReturn (d : Dialect) (φ : outParam Nat) [DialectSignature d] [TransformTy d φ] where
  mkReturn : (Γ : List d.Ty) → (opStx : AST.Op φ) → ReaderM d (Σ ty, Com d Γ ty)

/- instance of the transform dialect, plus data needed about `Op` and `Ty`. -/
variable {d φ} [DialectSignature d] [DecidableEq d.Ty] [DecidableEq d.Op]

/--
  Add a new variable to the context, and record it's (absolute) index in the name mapping

  Throws an error if the variable name already exists in the mapping, essentially disallowing
  shadowing
-/
def addValToMapping (Γ : Ctxt d.Ty) (name : String) (ty : d.Ty) :
    BuilderM d (Σ (Γ' : DerivedCtxt Γ), Ctxt.Var Γ'.ctxt ty) := do
  let some nm := (←get).add name
    | throw <| .nameAlreadyDeclared name
  set nm
  return ⟨DerivedCtxt.ofCtxt Γ |>.snoc ty, Ctxt.Var.last ..⟩

/--
  Look up a name from the name mapping, and return the corresponding variable in the given context.

  Throws an error if the name is not present in the mapping (this indicates the name may be free),
  or if the type of the variable in the context is different from `expectedType`
-/
def getValFromCtxt (Γ : Ctxt d.Ty) (name : String) (expectedType : d.Ty) :
    ReaderM d (Ctxt.Var Γ expectedType) := do
  let index := (←read).lookup name
  let some index := index | throw <| .undeclaredName name
  let n := Γ.length
  if h : index >= n then
    /-  This should not happen, it indicates the passed context `Γ` is out of sync with the
        namemapping stored in the monad -/
    throw <| .indexOutOfBounds name index n
  else
    let t := List.get Γ ⟨index, Nat.lt_of_not_le h⟩
    if h : t = expectedType then
      return ⟨index, by simp[←h]; rw [←List.get?_eq_get]⟩
    else
      throw <| .typeError expectedType t

def BuilderM.isOk {α : Type} (x : BuilderM d α) : Bool :=
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def BuilderM.isErr {α : Type} (x : BuilderM d α) : Bool :=
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def TypedSSAVal.mkTy [TransformTy d φ] : TypedSSAVal φ → ExceptM d d.Ty
  | (.SSAVal _, ty) => TransformTy.mkTy ty

/-- Translate a `TypedSSAVal` (a name with an expected type), to a variable in the context.
    This expects the name to have already been declared before -/
def TypedSSAVal.mkVal [instTransformTy : TransformTy d φ] (Γ : Ctxt d.Ty) : TypedSSAVal φ →
    ReaderM d (Σ (ty : d.Ty), Ctxt.Var Γ ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← instTransformTy.mkTy tyStx
    let var ← getValFromCtxt Γ valStx ty
    return ⟨ty, var⟩

/-- A variant of `TypedSSAVal.mkVal` that takes the function `mkTy` as an argument
    instead of using the typeclass `TransformDialect`.
    This is useful when trying to implement an instance of `TransformDialect` itself,
    to cut infinite regress. -/
def TypedSSAVal.mkVal' [instTransformTy : TransformTy d φ] (Γ : Ctxt d.Ty) : TypedSSAVal φ →
    ReaderM d (Σ (ty : d.Ty), Ctxt.Var Γ ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← instTransformTy.mkTy tyStx
    let var ← getValFromCtxt Γ valStx ty
    return ⟨ty, var⟩

/-- Declare a new variable,
    by adding the passed name to the name mapping stored in the monad state -/
def TypedSSAVal.newVal [instTransformTy : TransformTy d φ] (Γ : Ctxt d.Ty) : TypedSSAVal φ →
    BuilderM d (Σ (Γ' : DerivedCtxt Γ) (ty : d.Ty), Ctxt.Var Γ'.ctxt ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← instTransformTy.mkTy tyStx
    let ⟨Γ, var⟩ ← addValToMapping Γ valStx ty
    return ⟨Γ, ty, var⟩

/-- Given a list of `TypedSSAVal`s, treat each as a binder and declare a new variable with the
    given name and type -/
private def declareBindings [TransformTy d φ] (Γ : Ctxt d.Ty) (vals : List (TypedSSAVal φ)) :
    BuilderM d (DerivedCtxt Γ) := do
  vals.foldlM (fun Γ' ssaVal => do
    let ⟨Γ'', _⟩ ← TypedSSAVal.newVal Γ'.ctxt ssaVal
    return Γ''
  ) (.ofCtxt Γ)

private def mkComHelper
  [TransformTy d φ] [instTransformExpr : TransformExpr d φ] [instTransformReturn : TransformReturn d φ]
  (Γ : Ctxt d.Ty) :
    List (MLIR.AST.Op φ) → BuilderM d (Σ (ty : _), Com d Γ ty)
  | [retStx] => do
      instTransformReturn.mkReturn Γ retStx
  | lete::rest => do
    let ⟨ty₁, expr⟩ ← (instTransformExpr.mkExpr Γ lete)
    if h : lete.res.length != 1 then
      throw <| .generic s!"Each let-binding must have exactly one name on the left-hand side. Operations with multiple, or no, results are not yet supported.\n\tExpected a list of length one, found `{repr lete}`"
    else
      let _ ← addValToMapping Γ (lete.res[0]'(by simp_all) |>.fst |> SSAValToString) ty₁
      let ⟨ty₂, body⟩ ← mkComHelper (ty₁::Γ) rest
      return ⟨ty₂, Com.lete expr body⟩
  | [] => throw <| .generic "Ill-formed (empty) block"

def mkCom [TransformTy d φ] [TransformExpr d φ] [TransformReturn d φ]
  (reg : MLIR.AST.Region φ) : ExceptM d  (Σ (Γ : Ctxt d.Ty) (ty : d.Ty), Com d Γ ty) :=
  match reg.ops with
  | [] => throw <| .generic "Ill-formed region (empty)"
  | coms => BuilderM.runWithEmptyMapping <| do
    let Γ ← declareBindings ∅ reg.args
    let com ← mkComHelper Γ coms
    return ⟨Γ, com⟩

end MLIR.AST

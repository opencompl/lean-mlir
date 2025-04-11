/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Projects.SLLVM.Dialect.Basic

namespace StructuredLLVM
open MLIR.AST

#check MLIRType

instance : TransformTy SLLVM 0 where
  mkTy := fun
    | .int .Signless (.concrete w) => return .bitvec w
    | .undefined "ptr" => return .ptr
    | _ => throw .unsupportedType

instance : TransformExpr SLLVM 0 where
  mkExpr Γ op := do
    let args ← op.args.mapM (TypedSSAVal.mkVal Γ)
    match op.name with
    | "add" =>
        let [⟨.bitvec w₁, x₁⟩, ⟨.bitvec w₂, x₂⟩] := args
          | throw <| .generic ""
        if h : w₁ = w₂ then
          return ⟨_, _, ⟨
            .bv_add w₁,
            rfl,
            EffectKind.le_refl _,
            x₁ ::ₕ (h ▸ x₂ ::ₕ .nil),
            .nil⟩⟩
        else
          throw <| .widthError (φ:=0) w₁ w₂
    | _ => throw <| .unsupportedOp op.name

instance : TransformReturn SLLVM 0 where
  mkReturn Γ op := do
    let some v := op.args[0]?
      | throw <| .generic "No return value supplied"
    let ⟨ty, v⟩ ← TypedSSAVal.mkVal Γ v
    return ⟨.pure, ty, Com.ret v⟩

deriving instance Lean.ToExpr for SLLVM.PreTy
deriving instance Lean.ToExpr for SLLVM.PreOp

open Lean (Expr)

instance : DialectToExpr SLLVM where
  toExprM :=
    have : SLLVM.m = Id := rfl
    Expr.const ``Id []
  toExprDialect := Expr.const ``SLLVM []

elab "[sllvm|" reg:mlir_region "]" : term => do
  SSA.elabIntoCom' reg SLLVM

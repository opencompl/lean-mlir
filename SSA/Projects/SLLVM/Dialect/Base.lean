/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Framework.Macro

import SSA.Projects.InstCombine.Base
import SSA.Projects.SLLVM.Dialect.Semantics

namespace LeanMLIR
open InstCombine (LLVM)

/-!
## SLLVM Dialect
SLLVM stands for "Structured LLVM"; eventually this dialect will become a
formalization of the `ptr + arith + scf` MLIR dialects.
This IR is conceptually similar to LLVM IR, except it uses only *structured*
control flow, hence the name.

Note that in the formalization, we assume a 64-bit architecture!
Nothing in the formalization itself should depend on the exact pointer-width,
but this assumption does affect which optimizations are admitted.

For now, though, this dialect just models only arithmetic, just like our
existing LLVM dialect, *but* it refines the semantics to include a proper model
of (side-effecting) UB.
-/

/-! ### Dialect definition -/

def SLLVM : Dialect where
  Op := LLVM.Op
  Ty := LLVM.Ty
  m := EffectM

namespace SLLVM

instance : DecidableEq SLLVM.Op := by unfold SLLVM; infer_instance
instance : DecidableEq SLLVM.Ty := by unfold SLLVM; infer_instance
instance : ToString SLLVM.Op    := by unfold SLLVM; infer_instance
instance : ToString SLLVM.Ty    := by unfold SLLVM; infer_instance
instance : Repr SLLVM.Op        := by unfold SLLVM; infer_instance
instance : Repr SLLVM.Ty        := by unfold SLLVM; infer_instance
instance : Lean.ToExpr SLLVM.Op := by unfold SLLVM; infer_instance
instance : Lean.ToExpr SLLVM.Ty := by unfold SLLVM; infer_instance

instance : TyDenote SLLVM.Ty    := by unfold SLLVM; infer_instance
instance : Monad SLLVM.m        := by unfold SLLVM; infer_instance
instance : LawfulMonad SLLVM.m  := by unfold SLLVM; infer_instance

open Qq in instance : DialectToExpr SLLVM where
  toExprDialect := q(SLLVM)
  toExprM := q(Id.{0})

@[match_pattern]
abbrev Ty.bitvec : Nat → SLLVM.Ty :=
  InstCombine.LLVM.Ty.bitvec

@[simp_denote] theorem toType_bitvec : TyDenote.toType (Ty.bitvec w) = LLVM.IntW w := rfl

@[simp, simp_denote]
theorem m_eq : SLLVM.m α = EffectM α := by rfl

end SLLVM

/-! ### Signature -/

open InstCombine.LLVM.Op in
/-- The signature of each operation is the same as in LLVM. -/
instance : DialectSignature SLLVM where
  signature op :=
    { DialectSignature.signature (d := LLVM) op with
        effectKind := match op with
          | udiv .. | sdiv .. | urem .. | srem .. => .impure
          | _ => .pure
    }

open InstCombine.LLVM.Op in
instance : DialectDenote SLLVM where
  denote
  | udiv _ flag => fun ([x, y]ₕ) _ => ([·]ₕ) <$> LeanMLIR.SLLVM.udiv x y flag
  | sdiv _ flag => fun ([x, y]ₕ) _ => ([·]ₕ) <$> LeanMLIR.SLLVM.sdiv x y flag
  | urem _      => fun ([x, y]ₕ) _ => ([·]ₕ) <$> LeanMLIR.SLLVM.urem x y
  | srem _      => fun ([x, y]ₕ) _ => ([·]ₕ) <$> LeanMLIR.SLLVM.srem x y
  | op => fun args .nil =>
    EffectKind.liftEffect (EffectKind.pure_le _) <|
      DialectDenote.denote (d := LLVM) op args .nil
  -- ^^ For all other ops, just refer to the pure LLVM semantics

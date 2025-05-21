/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Framework.Macro

import SSA.Projects.InstCombine.Base
import SSA.Projects.SLLVM.Dialect.UB
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

def SLLVM : Dialect where
  Op := LLVM.Op
  Ty := LLVM.Ty
  m := UBOr

open InstCombine.LLVM.Op in
/-- The signature of each operation is the same as in LLVM. -/
instance : DialectSignature SLLVM where
  signature op :=
    { DialectSignature.signature (d := LLVM) op with
        effectKind := match op with
          | udiv .. | sdiv .. => .impure
          | _ => .pure
    }

instance : TyDenote SLLVM.Ty := inferInstanceAs (TyDenote LLVM.Ty)
instance : Monad (SLLVM.m) := inferInstanceAs (Monad PoisonOr)

open InstCombine.LLVM.Op in
instance : DialectDenote SLLVM where
  denote
  | udiv _ flag => fun (x ::ₕ (y ::ₕ .nil)) _ => LeanMLIR.SLLVM.udiv x y flag
  | sdiv _ flag => fun (x ::ₕ (y ::ₕ .nil)) _ => LeanMLIR.SLLVM.udiv x y flag
  | op => fun args .nil =>
    EffectKind.liftEffect (EffectKind.pure_le _) <|
      DialectDenote.denote (d := LLVM) op args .nil
  -- ^^ For all other ops, just refer to the pure LLVM semantics

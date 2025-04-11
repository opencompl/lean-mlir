/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean
import SSA.Core.Framework
import SSA.Core.Framework.Macro

/-! # SLLVM Dialect
We formalize an IR consisting of `arith + ptr + scf` MLIR dialects.
This IR is conceptually similar to LLVM IR, except it uses only *structured*
control flow, hence we'll call this IR Structured LLVM.

Note that in the formalization, we assume a 64-bit architecture!
Nothing in the formalization itself should depend on the exact pointer-width,
but this assumption does affect which optimizations are admitted.

-/
namespace StructuredLLVM

namespace SLLVM

/-! ## Basic Syntax -/

section Pre
variable (Width : Type)

inductive PreTy
  | bitvec (w : Width)
  | ptr
  | unit
  deriving DecidableEq, BEq, Repr

inductive PreOp
  | bv_add (w : Width)    -- Add two signless integers
  | ptr_add               -- Add a signless integer to a pointer
  | load (ty : PreTy Width)
  | store (ty : PreTy Width)
  deriving DecidableEq, BEq, Repr

end Pre

end SLLVM

/-! ## Meta Dialect -/

def NatOrFVar := Nat ⊕ Lean.FVarId

abbrev MetaSLLVM : Dialect where
  Op := SLLVM.PreOp NatOrFVar
  Ty := SLLVM.PreTy NatOrFVar

instance : BEq NatOrFVar := inferInstanceAs <| BEq (_ ⊕ _)
-- instance : BEq MetaSLLVM.Ty := inferInstanceAs <| BEq (SLLVM.PreTy _)
-- instance : BEq MetaSLLVM.Op := inferInstanceAs <| BEq (SLLVM.PreOp _)

deriving instance DecidableEq for Lean.FVarId
instance : DecidableEq NatOrFVar := inferInstanceAs <| DecidableEq (_ ⊕ _)
-- instance : DecidableEq MetaSLLVM.Ty := inferInstanceAs <| DecidableEq (SLLVM.PreTy _)
-- instance : DecidableEq MetaSLLVM.Op := inferInstanceAs <| DecidableEq (SLLVM.PreOp _)

instance : OfNat NatOrFVar n := ⟨.inl n⟩
instance : Repr NatOrFVar := inferInstanceAs <| Repr (_ ⊕ _)
-- instance : Repr MetaSLLVM.Op := inferInstanceAs <| Repr (SLLVM.PreOp _)
-- instance : Repr MetaSLLVM.Ty := inferInstanceAs <| Repr (SLLVM.PreTy _)

/-! ## Effects Monad -/

abbrev SLLVMMonad :=
  Id -- TODO: effect monad
  -- StateM SLLVM.State

abbrev SLLVM : Dialect where
  Op := SLLVM.PreOp Nat
  Ty := SLLVM.PreTy Nat
  m := SLLVMMonad

section Signature

def_signature for MetaSLLVM
  | .bv_add w => (.bitvec w, .bitvec w) → .bitvec w
  | .ptr_add  => (.ptr, .bitvec 64) -> .ptr
  | .load t   => (.ptr) -[.impure]-> t
  | .store t  => (.ptr, t) -[.impure]-> .unit

def_signature for SLLVM
  | .bv_add w => (.bitvec w, .bitvec w) → .bitvec w
  | .ptr_add  => (.ptr, .bitvec 64) -> .ptr
  | .load t   => (.ptr) -[.impure]-> t
  | .store t  => (.ptr, t) -[.impure]-> .unit

end Signature

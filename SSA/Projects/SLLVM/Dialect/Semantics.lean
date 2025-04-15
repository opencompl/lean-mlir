/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Macro
import SSA.Projects.SLLVM.Dialect.Basic
import SSA.Projects.InstCombine.LLVM.Semantics

/-! ## SLLVM Operation Semantics -/

namespace StructuredLLVM

instance : TyDenote (Dialect.Ty SLLVM) where
  toType := fun
    | .bitvec w => LLVM.IntW w
    | .ptr => BitVec 64 --TODO: make this a proper pointer type
    | .unit => Unit

instance (ty : SLLVM.Ty) : Inhabited ⟦ty⟧ where
  default := match ty with
    | .bitvec w => some 0#w
    | .ptr => 0#64
    | .unit => ()

def_denote for SLLVM
  | .bv_add _ => fun x y => LLVM.add x y
  -- TODO: implement actual semantics
  | .ptr_add  => fun p _ => p
  | .load ty  => fun _ => (default : ⟦ty⟧)
  | .store _  => fun _ _ => ()

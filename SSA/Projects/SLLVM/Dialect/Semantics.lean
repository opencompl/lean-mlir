/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.SLLVM.Dialect.Basic
import SSA.Projects.InstCombine.LLVM.Semantics

/-! ## SLLVM Operation Semantics -/

namespace StructuredLLVM

instance : TyDenote (Dialect.Ty SLLVM) where
  toType := fun
    | .bitvec w => LLVM.IntW w
    | .ptr => BitVec 64 --TODO: make this a proper pointer type
    | .unit => Unit

def_semantics for SLLVM

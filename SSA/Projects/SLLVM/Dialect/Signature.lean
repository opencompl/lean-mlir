/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.SLLVM.Dialect.Basic

/-! ## SLLVM Operation Signatures -/

namespace SideEffects

instance : DialectSignature SLLVM where
  signature := fun
    | .bv_add w => {
        sig := [.bitvec w, .bitvec w]
        outTy := .bitvec w
        regSig := []
      }
    | .ptr_add => {
        sig := [.ptr, .bitvec 64]
        outTy := .ptr
        regSig := []
      }
    | .load ty => {
        sig := [.ptr]
        outTy := ty
        regSig := []
      }
    | .store ty => {
        sig := [.ptr, ty]
        outTy := .unit
        regSig := []
      }

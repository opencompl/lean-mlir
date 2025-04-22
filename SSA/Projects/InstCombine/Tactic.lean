/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.LLVM.Refinement
import SSA.Projects.InstCombine.ForStd
import SSA.Core.ErasedContext
import SSA.Core.Tactic

open MLIR AST

attribute [simp_denote]
  InstCombine.Op.denote
  HVector.getN HVector.get HVector.cons_get_zero
  beq_self_eq_true Option.isSome_some
  -- Fold integers into their canonical form.
  Nat.cast_ofNat Nat.cast_one Int.reduceNegSucc Int.reduceNeg

@[deprecated "use `simp_peephole` instead" (since := "2025-05-16")]
macro "simp_alive_ssa" : tactic => `(tactic| simp_peephole)

@[deprecated "use `simp_peephole` instead" (since := "2025-05-16")]
macro "simp_alive_peephole" : tactic => `(tactic| simp_peephole)

/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForLean
import Lean


namespace AlivePaperExamples
open BitVec

-- Example proof of shift + mul, this is one of the hardest alive examples.
-- (alive_simplifyMulDivRem290)
theorem shift_mul:
    [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %c1 = llvm.mlir.constant(1)
    %poty = llvm.shl %c1, %Y
    %r = llvm.mul %poty, %X
    llvm.return %r
  }] ⊑  [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %r = llvm.shl %X, %Y
    llvm.return %r
  }] := by
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  intros A B
  rcases A with rfl | A  <;>
  rcases B with rfl | B  <;> (try (simp only [Bool.false_eq_true, shiftLeft_eq', false_and, ↓reduceIte, ushiftRight_eq', natCast_eq_ofNat,
  ge_iff_le, EffectKind.return_impure_toMonad_eq, Option.pure_def, truncate_eq_setWidth, ofNat_eq_ofNat, toNat_ofNat,
  mul_eq, Option.bind_eq_bind, Option.some_bind, Option.none_bind, Option.bind_none, Refinement.refl]; done)) ;
  by_cases h : (BitVec.ofNat w w) ≤ B <;>
    simp only [Bool.false_eq_true, shiftLeft_eq', false_and, ↓reduceIte, ushiftRight_eq',
      natCast_eq_ofNat, ge_iff_le, EffectKind.return_impure_toMonad_eq, Option.pure_def,
      truncate_eq_setWidth, ofNat_eq_ofNat, toNat_ofNat, mul_eq, Option.bind_eq_bind,
      Option.some_bind, Refinement.refl, h]
  simp
  simp

/--
info: 'AlivePaperExamples.shift_mul' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms shift_mul

-- Example proof of xor + sub, this is automatically closed by automation.
theorem xor_sub :
    [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %v1 = llvm.sub %X, %X
    %r = llvm.xor %v1, %Y
    llvm.return %r
  }] ⊑  [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    llvm.return %Y
  }] := by
    simp_alive_peephole
    alive_auto

/-- info: 'AlivePaperExamples.xor_sub' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms xor_sub

theorem bitvec_AddSub_1309 :
  [llvm (w)| {
    ^bb0(%X : _, %Y : _):
      %v1 = llvm.and %X, %Y
      %v2 = llvm.or %X, %Y
      %v3 = llvm.add %v1, %v2
      llvm.return %v3
  }] ⊑ [llvm (w)| {
    ^bb0(%X : _, %Y : _):
      %v3 = llvm.add %X, %Y
      llvm.return %v3
  }] := by
    simp_alive_peephole
    simp_alive_undef
    simp_alive_case_bash
    simp

/--
info: 'AlivePaperExamples.bitvec_AddSub_1309' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms bitvec_AddSub_1309

end AlivePaperExamples

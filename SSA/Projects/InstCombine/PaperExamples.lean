/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import Init.Data.BitVec.Bitblast
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Folds
import Lean


namespace AlivePaperExamples
open BitVec

-- Example proof of shift + mul, this is one of the hardest alive examples.
-- (alive_simplifyMulDivRem290)
theorem shift_mul:
    [llvm (w)| {
  ^bb0(%X : _, %Y : _):
    %c1 = llvm.mlir.constant 1
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
  rcases A with rfl | A  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  rcases B with rfl | B  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
  by_cases h : w ≤ BitVec.toNat B <;> simp [h]
  apply BitVec.eq_of_toNat_eq
  simp [bv_toNat]
  ring_nf

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

/-- Example with nontrivial mixture of arithmetic and bitwise ops. -/
theorem BitVec_AddSub_1309_stmt {A B : BitVec w} : (B &&& A) + (B ||| A) = B + A := by
  rw [add_eq_adc, add_eq_adc, adc_spec B A]
  unfold adc
  rw [iunfoldr_replace (fun i => carry i B A false)]
  · simp [carry]; omega
  · intro i
    simp only [adcb, getLsb_and, getLsb_or, ofBool_false, ofNat_eq_ofNat, zeroExtend_zero,
      BitVec.add_zero, Prod.mk.injEq]
    constructor
    · rw [carry_succ]
      cases A.getLsb i
      <;> cases B.getLsb i
      <;> cases carry i B A false
      <;> rfl

    · rw [getLsb_add (by omega)]
      cases A.getLsb i
      <;> cases B.getLsb i
      <;> cases carry i B A false
      <;> rfl

open BitVec in
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
    simp_alive_ops
    intros A B
    rcases A with rfl | A  <;> (try (simp [Option.bind, Bind.bind]; done)) <;>
    rcases B with rfl | B  <;> (try (simp [Option.bind, Bind.bind]; done))
    simp [BitVec_AddSub_1309_stmt]

/--
info: 'AlivePaperExamples.bitvec_AddSub_1309' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms bitvec_AddSub_1309

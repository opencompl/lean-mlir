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

theorem iunfoldr_getLsb' {f : Fin w → α → α × Bool} (state : Nat → α)
    (ind : ∀(i : Fin w), (f i (state i.val)).fst = state (i.val+1)) :
  (∀ i : Fin w, getLsb (iunfoldr f (state 0)).snd i.val = (f i (state i.val)).snd)
  ∧ (iunfoldr f (state 0)).fst = state w := by
  unfold iunfoldr
  simp
  apply Fin.hIterate_elim
        (fun j (p : α × BitVec j) => (hj : j ≤ w) →
         (∀ i : Fin j,  getLsb p.snd i.val = (f ⟨i.val, Nat.lt_of_lt_of_le i.isLt hj⟩ (state i.val)).snd)
          ∧ p.fst = state j)
  case hj => simp
  case init =>
    intro
    apply And.intro
    · intro i
      have := Fin.size_pos i
      contradiction
    · rfl
  case step =>
    intro j ⟨s, v⟩ ih hj
    apply And.intro
    case left =>
      intro i
      simp only [getLsb_cons]
      have hj2 : j.val ≤ w := by simp
      cases (Nat.lt_or_eq_of_le (Nat.lt_succ.mp i.isLt)) with
      | inl h3 => simp [if_neg, (Nat.ne_of_lt h3)]
                  exact (ih hj2).1 ⟨i.val, h3⟩
      | inr h3 => simp [h3, if_pos]
                  cases (Nat.eq_zero_or_pos j.val) with
                  | inl hj3 => congr
                               rw [← (ih hj2).2]
                  | inr hj3 => congr
                               exact (ih hj2).2
    case right =>
      simp
      have hj2 : j.val ≤ w := by simp
      rw [← ind j, ← (ih hj2).2]


theorem iunfoldr_getLsb {f : Fin w → α → α × Bool} (state : Nat → α) (i : Fin w)
    (ind : ∀(i : Fin w), (f i (state i.val)).fst = state (i.val+1)) :
  getLsb (iunfoldr f (state 0)).snd i.val = (f i (state i.val)).snd := by
  exact (iunfoldr_getLsb' state ind).1 i

-- /--
-- Correctness theorem for `iunfoldr`.
-- -/
-- theorem iunfoldr_replace
--     {f : Fin w → α → α × Bool} (state : Nat → α) (value : BitVec w) (a : α)
--     (init : state 0 = a)
--     (step : ∀(i : Fin w), f i (state i.val) = (state (i.val+1), value.getLsb i.val)) :
--     iunfoldr f a = (state w, value) := by
--   simp [iunfoldr.eq_test state value a init step]

-- theorem iunfoldr_replace_snd
--   {f : Fin w → α → α × Bool} (state : Nat → α) (value : BitVec w) (a : α)
--     (init : state 0 = a)
--     (step : ∀(i : Fin w), f i (state i.val) = (state (i.val+1), value.getLsb i.val)) :
--     (iunfoldr f a).snd = value := by
--   simp [iunfoldr.eq_test state value a init step]



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
    simp
    /- proof starts here. -/
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

/--
info: 'AlivePaperExamples.bitvec_AddSub_1309' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms bitvec_AddSub_1309

/-
Reduction from multi-width to single-width problems.
-/

import Std.Tactic.BVDecide


def BitVec.ofNatUnary (w : Nat) (val : Nat) : BitVec w :=
  ((1#w) <<< val) - 1

@[simp]
theorem getLsbD_ofNatUnary {w : Nat} (n : Nat) :
    (BitVec.ofNatUnary w n).getLsbD i = decide (i < w) && decide (i < n) := by
  simp [BitVec.ofNatUnary]
  sorry

@[simp]
theorem getElem_ofNatUnary {w : Nat} (n : Nat) (i : Nat) (hi : i < w) :
    (BitVec.ofNatUnary w n)[i] = decide (i < n)  := by
  simp [BitVec.ofNatUnary]
  sorry

@[simp]
theorem and_ofNatUnary_eq_setWidth_setWidth {w mask : Nat} (x : BitVec w):
    x &&& (BitVec.ofNatUnary w mask) = (x.setWidth mask).setWidth w := by
  ext i 
  simp 
  grind

@[simp]
theorem ofNatUnary_and_eq_setWidth_setWidth {w mask : Nat} (x : BitVec w):
    (BitVec.ofNatUnary w mask) &&& x = (x.setWidth mask).setWidth w := by
  ext i 
  simp 
  grind

/-- If I mask 'a : BitVec n', I get 'b', encoded via the usual encoding  -/
class TermTrans (win : Nat) (wout : Nat) (xin : BitVec win) where
  xout : BitVec wout
  legal : wout ≤ win → (xout) = xin.setWidth _ := by grind

instance termTransOfNat : TermTrans win wout (BitVec.ofNat win n) where
  xout := (BitVec.ofNat win n).setWidth wout
  legal := by
      intros hwout
      ext i 
      simp

instance termTransAdd 
      [ha : TermTrans win wout in1]
      [hb : TermTrans win wout in2] : 
      TermTrans win wout (in1 + in2) where
  xout := (ha.xout + hb.xout) &&& (BitVec.ofNatUnary wout win)
  legal := by
      intros hwout
      have h1 := ha.legal
      have h2 := hb.legal
      rw [h1 (by grind), h2 (by grind)]
      rw [BitVec.setWidth_add]
      simp [hwout] at h1 h2 ⊢
      grind

class PredicateTrans (α : Prop) where
   outType : Prop
   legal : outType → α

@[simp]
instance PredEq
    [t1 : TermTrans win wout in1]
    [t2 : TermTrans win wout in2] :
  PredicateTrans (in1 = in2) where
    outType := t1.xout = t2.xout
    legal := by
      have ht1 := t1.legal
      have ht2 := t2.legal
      rw [ht1]
      rw [ht2]
      sorry

@[simp]
theorem PredicateTrans.outType_eq {P : Prop} {n : Nat} {f1 f2 : Fin (2^n)} {b1 b2 : BitVec n}
    [t1 : TermTrans n f1 b1]
    [t2 : TermTrans n f2 b2] :
    (PredEq (t1 := t1) (t2 := t2) |>.outType : Prop) = (b1 = b2) := rfl


-- @[simp]
-- instance PredForall {P : ∀ {n : Nat}, Fin (2 ^ n) → Prop}
--    [hp : ∀ {n : Nat}, (f1 : Fin (2 ^ n)) → PredicateTrans (P f1)] :
--    PredicateTrans (∀ (f1 : Fin (2 ^ n)), P f1) where
--   outType := ∀ (bv : BitVec n), (hp bv.toFin).outType
--   legal := by
--     intros f f1
--     apply hp f1 |>.legal
--     specialize f (BitVec.ofFin f1)
--     simp at f
--     apply f

@[simp]
instance PredForall2 {n : Nat} {P : Fin (2 ^ n) → Prop}
   [hp : (f1 : Fin (2 ^ n)) → PredicateTrans (P f1)] :
   PredicateTrans (∀ (f1 : Fin (2 ^ n)), P f1) where
  outType := ∀ (bv : BitVec n), (hp bv.toFin).outType
  legal := by
    intros f f1
    apply hp f1 |>.legal
    specialize f (BitVec.ofFin f1)
    simp at f
    apply f


theorem provePredicateByDecide
    {P : Prop} [t : PredicateTrans P] (h : t.outType) : P := by
  have ht := t.legal
  apply ht
  exact h

set_option trace.Meta.synthInstance true in
theorem bar : (10 : Fin (2^8)) + 0 = 0 + (9 : Fin (2^8)) := by
   apply provePredicateByDecide
   simp
   sorry

theorem baz : (a : Fin (2^8)) + (b : Fin (2 ^ 8)) = (b : Fin (2^8)) + (a : Fin (2^8)) := by
   revert a b
   apply provePredicateByDecide
   simp
   bv_decide

/-- info: 'baz' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms baz



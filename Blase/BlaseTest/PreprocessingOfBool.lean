import Blase
open BitVec
set_option warn.sorry false

notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x
notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y

notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x
notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)

open Lean Meta Elab Tactic


-- | TODO: go into every 'ofBool', and call 'generalize' on the argument.
/--
warning: abstracted boolean: ⏎
  → 'x_2✝ <ₛ x_3✝'
---
error: MAYCEX: Found possible counter-example at iteration 1 for predicate '(x_2✝ <ₛ x_3✝) = true ∨
  ofBool (x_2✝ <ₛ x_3✝) ≠ b_ofBool✝¹ ∨
    ofBool (x_2✝ <ₛ x_3✝) ≠ b_ofBool✝ ∨ (signExtend w✝ b_ofBool✝ &&& x_1✝) + (signExtend w✝ b_ofBool✝ &&& x✝) = 0#w✝'
-/
#guard_msgs in theorem and_sext_multiuse_thm.extracted_1._2 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_2 <ₛ x_3) = 1#1 →
    (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x_1) + (signExtend 32 (ofBool (x_2 <ₛ x_3)) &&& x) = 0#32 := by
      intros
      generalize_all_bitvec_ofbool
      bv_generalize;
      intros
      bv_multi_width


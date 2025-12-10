-- {"fileBasename":"g2004h11h27hSetCCForCastLargerAndConstant_proof_different_size_sext_sext_sle_thm_extracted_1__1.lean","smtlib":"(pvar 0)","isPotentiallyGeneralizable":true,"isSolvedByUs":false}

/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
import Blase
open BitVec

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

theorem different_size_sext_sext_sle_thm.extracted_1._1 : ∀ (x : BitVec 4) (x_1 : BitVec 7),
  ofBool (signExtend 25 x_1 ≤ₛ signExtend 25 x) = ofBool (x_1 ≤ₛ signExtend 7 x) := by
  bv_multi_width +verbose?

sorry


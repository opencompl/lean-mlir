
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
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

theorem test_shl_nuw_nsw__nsw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x ||| BitVec.ofInt 32 (-83886080) == BitVec.ofInt 32 (-83886079)) = 1#1 →
    ¬(True ∧ ((x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32).sshiftRight' 2#32 ≠ x ||| BitVec.ofInt 32 (-83886080) ∨
          True ∧ (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 >>> 2#32 ≠ x ||| BitVec.ofInt 32 (-83886080) ∨
            2#32 ≥ ↑32) →
      (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 * (x ||| BitVec.ofInt 32 (-83886080)) *
          (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 =
        0#32 :=
sorry
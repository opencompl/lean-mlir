
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

theorem multiuse2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ ((x &&& 96#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 96#32 ∨
        True ∧ (x &&& 96#32) <<< 8#32 >>> 8#32 ≠ x &&& 96#32 ∨
          8#32 ≥ ↑32 ∨
            True ∧ ((x &&& 6#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 6#32 ∨
              True ∧ (x &&& 6#32) <<< 8#32 >>> 8#32 ≠ x &&& 6#32 ∨
                8#32 ≥ ↑32 ∨
                  True ∧ ((x &&& 24#32) <<< 8#32).sshiftRight' 8#32 ≠ x &&& 24#32 ∨
                    True ∧ (x &&& 24#32) <<< 8#32 >>> 8#32 ≠ x &&& 24#32 ∨
                      8#32 ≥ ↑32 ∨
                        True ∧ ((x &&& 6#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 6#32 ∨
                          True ∧ (x &&& 6#32) <<< 1#32 >>> 1#32 ≠ x &&& 6#32 ∨
                            1#32 ≥ ↑32 ∨
                              True ∧ ((x &&& 96#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 96#32 ∨
                                True ∧ (x &&& 96#32) <<< 1#32 >>> 1#32 ≠ x &&& 96#32 ∨
                                  1#32 ≥ ↑32 ∨
                                    True ∧ ((x &&& 24#32) <<< 1#32).sshiftRight' 1#32 ≠ x &&& 24#32 ∨
                                      True ∧ (x &&& 24#32) <<< 1#32 >>> 1#32 ≠ x &&& 24#32 ∨ 1#32 ≥ ↑32) →
    8#32 ≥ ↑32 ∨
        1#32 ≥ ↑32 ∨
          1#32 ≥ ↑32 ∨
            1#32 ≥ ↑32 ∨
              True ∧ (x <<< 1#32 &&& 192#32 &&& (x <<< 1#32 &&& 48#32) != 0) = true ∨
                True ∧ (x <<< 1#32 &&& 12#32 &&& (x <<< 1#32 &&& 192#32 ||| x <<< 1#32 &&& 48#32) != 0) = true ∨
                  True ∧
                    (x <<< 8#32 &&& 32256#32 &&&
                          (x <<< 1#32 &&& 12#32 ||| (x <<< 1#32 &&& 192#32 ||| x <<< 1#32 &&& 48#32)) !=
                        0) =
                      true →
      False :=
sorry
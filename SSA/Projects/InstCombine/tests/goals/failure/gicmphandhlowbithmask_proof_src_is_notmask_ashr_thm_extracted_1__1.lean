
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem src_is_notmask_ashr_thm.extracted_1._1 : ∀ (x : BitVec 16) (x_1 : BitVec 8) (x_2 : BitVec 16),
  ¬(x_1 ≥ ↑8 ∨ x ≥ ↑16) →
    ofBool
        (x_2 ^^^ 123#16 ==
          (x_2 ^^^ 123#16) &&& ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ^^^ -1#16)) =
      ofBool ((signExtend 16 (BitVec.ofInt 8 (-32) <<< x_1)).sshiftRight' x ≤ᵤ x_2 ^^^ BitVec.ofInt 16 (-124)) :=
sorry
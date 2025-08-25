
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_mask_ashr28_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32) →
    ¬28#32 ≥ ↑32 → (x.sshiftRight' 28#32 &&& 8#32) + x.sshiftRight' 28#32 = x >>> 28#32 &&& 7#32 :=
sorry
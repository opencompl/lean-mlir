/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- goals/success/gsubhofhnegatible_proof_t7_thm_extracted_1__2.lean
-/
import Blase
open BitVec

theorem t7_thm.extracted_1._2 :
    ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8), x_1 = 1#1 → x_2 - 0#8 = 0#8 + x_2 := by
  intros;
  bv_multi_width


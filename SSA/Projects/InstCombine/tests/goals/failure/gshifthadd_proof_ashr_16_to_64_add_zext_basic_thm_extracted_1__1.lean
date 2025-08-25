
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_16_to_64_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#64 ≥ ↑64 →
    (zeroExtend 64 x_1 + zeroExtend 64 x).sshiftRight' 16#64 = zeroExtend 64 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
sorry
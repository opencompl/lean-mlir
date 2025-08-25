
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_32_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬32#64 ≥ ↑64 →
    (zeroExtend 64 x_1 + zeroExtend 64 x).sshiftRight' 32#64 = zeroExtend 64 (ofBool (x_1 ^^^ -1#32 <ᵤ x)) :=
sorry
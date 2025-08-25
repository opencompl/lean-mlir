
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_ashr_exact__exact_is_unsafe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483585) == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-2147483585)) >>> 2#32 <<< 2#32 ≠ x_1 &&& BitVec.ofInt 32 (-2147483585) ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483585)).sshiftRight' 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        False :=
sorry
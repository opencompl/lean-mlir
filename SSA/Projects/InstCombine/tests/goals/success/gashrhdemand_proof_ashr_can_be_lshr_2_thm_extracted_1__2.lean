
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_can_be_lshr_2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(34#64 ≥ ↑64 ∨
        True ∧
            (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 >>> 32#64 <<< 32#64 ≠
              (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 ∨
          32#64 ≥ ↑64 ∨
            True ∧
              signExtend 64 (truncate 32 (((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64)) ≠
                ((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64) →
    ¬2#32 ≥ ↑32 →
      truncate 32 (((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64) =
        x <<< 2#32 ||| BitVec.ofInt 32 (-67108864) :=
sorry
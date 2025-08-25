
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem trunc_ashr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬8#36 ≥ ↑36 →
    ¬8#32 ≥ ↑32 →
      truncate 32 ((zeroExtend 36 x ||| BitVec.ofInt 36 (-2147483648)).sshiftRight' 8#36) =
        x >>> 8#32 ||| BitVec.ofInt 32 (-8388608) :=
sorry
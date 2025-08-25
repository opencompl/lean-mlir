
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_signbit_select_ashr_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 1),
  x_1 = 1#1 →
    ¬8#32 ≥ ↑32 → (x &&& BitVec.ofInt 32 (-65536)).sshiftRight' 8#32 = x.sshiftRight' 8#32 &&& BitVec.ofInt 32 (-256) :=
sorry
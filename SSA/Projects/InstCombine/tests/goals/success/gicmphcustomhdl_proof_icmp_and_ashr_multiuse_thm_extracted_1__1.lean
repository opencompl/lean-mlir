
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_and_ashr_multiuse_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(4#32 ≥ ↑32 ∨ 4#32 ≥ ↑32) →
    ofBool (x.sshiftRight' 4#32 &&& 15#32 != 14#32) &&& ofBool (x.sshiftRight' 4#32 &&& 31#32 != 27#32) =
      ofBool (x &&& 240#32 != 224#32) &&& ofBool (x &&& 496#32 != 432#32) :=
sorry
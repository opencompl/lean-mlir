
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphshrhlthgt_proof
theorem lshrugt_01_00_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 0) ⊑ icmp IntPred.ugt e (const? 4 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_01_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPred.ugt e (const? 4 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_02_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPred.ugt e (const? 4 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_03_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_04_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 4) ⊑ icmp IntPred.ugt e (const? 4 (-7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_05_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 5) ⊑ icmp IntPred.ugt e (const? 4 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_06_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 6) ⊑ icmp IntPred.ugt e (const? 4 (-3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_07_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_08_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_09_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_10_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_11_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_12_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_13_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_14_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_15_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 1)) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_00_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 0) ⊑ icmp IntPred.ugt e (const? 4 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_01_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 1) ⊑ icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_02_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 2) ⊑ icmp IntPred.ugt e (const? 4 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_03_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_04_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_05_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_06_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_07_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_08_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_09_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_10_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_11_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_12_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_13_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_14_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_15_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 2)) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_00_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 0) ⊑ icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_01_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_02_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_03_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_04_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_05_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_06_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_07_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_08_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_09_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_10_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_11_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_12_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_13_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_14_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_15_thm (e : IntW 4) : icmp IntPred.ugt (lshr e (const? 4 3)) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_00_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_01_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPred.ult e (const? 4 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_02_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPred.ult e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_03_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPred.ult e (const? 4 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_04_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 4) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_05_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 5) ⊑ icmp IntPred.ult e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_06_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 6) ⊑ icmp IntPred.ult e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_07_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 7) ⊑ icmp IntPred.ult e (const? 4 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_08_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_09_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_10_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_11_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_12_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_13_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_14_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_15_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 1)) (const? 4 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_00_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_01_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 1) ⊑ icmp IntPred.ult e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_02_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 2) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_03_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 3) ⊑ icmp IntPred.ult e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_04_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_05_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_06_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_07_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_08_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_09_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_10_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_11_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_12_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_13_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_14_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_15_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 2)) (const? 4 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_00_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_01_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 1) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_02_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_03_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 3) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_04_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_05_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_06_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_07_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_08_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_09_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_10_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_11_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_12_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_13_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_14_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_15_thm (e : IntW 4) : icmp IntPred.ult (lshr e (const? 4 3)) (const? 4 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_00_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 0) ⊑ icmp IntPred.sgt e (const? 4 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_01_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPred.sgt e (const? 4 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_02_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPred.sgt e (const? 4 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_03_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_04_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_05_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_06_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_07_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_08_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_09_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_10_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_11_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_12_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-4)) ⊑ icmp IntPred.sgt e (const? 4 (-7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_13_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-3)) ⊑ icmp IntPred.sgt e (const? 4 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_14_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-2)) ⊑ icmp IntPred.sgt e (const? 4 (-3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_15_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1)) (const? 4 (-1)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_00_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 0) ⊑ icmp IntPred.sgt e (const? 4 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_01_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_02_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_03_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_04_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_05_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_06_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_07_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_08_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_09_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_10_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_11_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_12_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_13_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_14_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-2)) ⊑ icmp IntPred.sgt e (const? 4 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_15_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2)) (const? 4 (-1)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_00_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_01_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_02_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_03_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_04_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_05_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_06_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_07_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_08_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_09_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_10_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_11_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_12_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_13_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_14_thm (e : IntW 4) : icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_15_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3)) (const? 4 (-1)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_00_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 0) ⊑ icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_01_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPred.slt e (const? 4 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_02_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPred.slt e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_03_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPred.slt e (const? 4 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_04_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_05_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_06_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_07_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_08_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_09_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_10_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_11_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_12_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_13_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-3)) ⊑ icmp IntPred.slt e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_14_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-2)) ⊑ icmp IntPred.slt e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_15_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1)) (const? 4 (-1)) ⊑ icmp IntPred.slt e (const? 4 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_00_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 0) ⊑ icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_01_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 1) ⊑ icmp IntPred.slt e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_02_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_03_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 3) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_04_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_05_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_06_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_07_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_08_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_09_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_10_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_11_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_12_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_13_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_14_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_15_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2)) (const? 4 (-1)) ⊑ icmp IntPred.slt e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_00_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 0) ⊑ icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_01_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_02_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_03_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 3) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_04_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_05_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_06_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_07_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_08_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_09_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_10_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_11_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_12_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_13_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_14_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_15_thm (e : IntW 4) : icmp IntPred.slt (ashr e (const? 4 3)) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_00_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.ne e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_01_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.ugt e (const? 4 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_02_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 2) ⊑
    icmp IntPred.ugt e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_03_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 3) ⊑
    icmp IntPred.ugt e (const? 4 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_04_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 4) ⊑
    icmp IntPred.ugt e (const? 4 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_05_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 5) ⊑
    icmp IntPred.ugt e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_06_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 6) ⊑
    icmp IntPred.eq e (const? 4 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_07_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_08_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_09_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_10_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_11_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_12_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_13_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_14_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_01_15_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_00_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.ne e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_01_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.ugt e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_02_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 2) ⊑
    icmp IntPred.eq e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_03_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_04_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_05_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_06_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_07_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_08_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_09_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_10_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_11_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_12_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_13_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_14_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_02_15_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_00_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.ne e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_01_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_02_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_03_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_04_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_05_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_06_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_07_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_08_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_09_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_10_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_11_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_12_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_13_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_14_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrugt_03_15_exact_thm (e : IntW 4) :
  icmp IntPred.ugt (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_eq_exact_thm (e : IntW 8) :
  icmp IntPred.eq (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.eq e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ne_exact_thm (e : IntW 8) :
  icmp IntPred.ne (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.ne e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_exact_thm (e : IntW 8) :
  icmp IntPred.ugt (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.ugt e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_uge_exact_thm (e : IntW 8) :
  icmp IntPred.uge (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.ugt e (const? 8 72) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_exact_thm (e : IntW 8) :
  icmp IntPred.ult (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.ult e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ule_exact_thm (e : IntW 8) :
  icmp IntPred.ule (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.ult e (const? 8 88) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sgt_exact_thm (e : IntW 8) :
  icmp IntPred.sgt (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.sgt e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sge_exact_thm (e : IntW 8) :
  icmp IntPred.sge (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.sgt e (const? 8 72) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_slt_exact_thm (e : IntW 8) :
  icmp IntPred.slt (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.slt e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sle_exact_thm (e : IntW 8) :
  icmp IntPred.sle (ashr e (const? 8 3) { «exact» := true }) (const? 8 10) ⊑
    icmp IntPred.slt e (const? 8 88) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_eq_noexact_thm (e : IntW 8) :
  icmp IntPred.eq (ashr e (const? 8 3)) (const? 8 10) ⊑
    icmp IntPred.eq (LLVM.and e (const? 8 (-8))) (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ne_noexact_thm (e : IntW 8) :
  icmp IntPred.ne (ashr e (const? 8 3)) (const? 8 10) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 (-8))) (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_noexact_thm (e : IntW 8) :
  icmp IntPred.ugt (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.ugt e (const? 8 87) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_uge_noexact_thm (e : IntW 8) :
  icmp IntPred.uge (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.ugt e (const? 8 79) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_noexact_thm (e : IntW 8) :
  icmp IntPred.ult (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.ult e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ule_noexact_thm (e : IntW 8) :
  icmp IntPred.ule (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.ult e (const? 8 88) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sgt_noexact_thm (e : IntW 8) :
  icmp IntPred.sgt (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.sgt e (const? 8 87) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sge_noexact_thm (e : IntW 8) :
  icmp IntPred.sge (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.sgt e (const? 8 79) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_slt_noexact_thm (e : IntW 8) :
  icmp IntPred.slt (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.slt e (const? 8 80) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sle_noexact_thm (e : IntW 8) :
  icmp IntPred.sle (ashr e (const? 8 3)) (const? 8 10) ⊑ icmp IntPred.slt e (const? 8 88) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_sgt_overflow_thm (e : IntW 8) : icmp IntPred.sgt (ashr e (const? 8 1)) (const? 8 63) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_00_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_01_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.eq e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_02_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 2) ⊑
    icmp IntPred.ult e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_03_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 3) ⊑
    icmp IntPred.ult e (const? 4 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_04_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 4) ⊑
    icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_05_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 5) ⊑
    icmp IntPred.ult e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_06_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 6) ⊑
    icmp IntPred.ult e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_07_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 7) ⊑
    icmp IntPred.ne e (const? 4 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_08_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_09_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_10_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_11_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_12_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_13_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_14_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_01_15_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 1) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_00_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_01_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.eq e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_02_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 2) ⊑
    icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_03_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 3) ⊑
    icmp IntPred.ne e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_04_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_05_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_06_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_07_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_08_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_09_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_10_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_11_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_12_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_13_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_14_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_02_15_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 2) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_00_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_01_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.eq e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_02_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_03_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 3) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_04_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_05_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_06_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_07_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_08_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_09_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_10_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_11_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_12_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_13_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_14_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshrult_03_15_exact_thm (e : IntW 4) :
  icmp IntPred.ult (lshr e (const? 4 3) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_00_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.sgt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_01_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.sgt e (const? 4 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_02_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 2) ⊑
    icmp IntPred.sgt e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_03_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_04_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_05_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_06_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_07_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_08_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_09_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_10_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_11_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_12_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-4)) ⊑
    icmp IntPred.ne e (const? 4 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_13_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-3)) ⊑
    icmp IntPred.sgt e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_14_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-2)) ⊑
    icmp IntPred.sgt e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_01_15_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-1)) ⊑
    icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_00_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.sgt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_01_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_02_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_03_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_04_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_05_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_06_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_07_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_08_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_09_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_10_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_11_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_12_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_13_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_14_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-2)) ⊑
    icmp IntPred.ne e (const? 4 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_02_15_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-1)) ⊑
    icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_00_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_01_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_02_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_03_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 3) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_04_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 4) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_05_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 5) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_06_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 6) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_07_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 7) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_08_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_09_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_10_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_11_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_12_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_13_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_14_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrsgt_03_15_exact_thm (e : IntW 4) :
  icmp IntPred.sgt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-1)) ⊑
    icmp IntPred.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_00_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_01_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.slt e (const? 4 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_02_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 2) ⊑
    icmp IntPred.slt e (const? 4 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_03_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 3) ⊑
    icmp IntPred.slt e (const? 4 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_04_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_05_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_06_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_07_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_08_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_09_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_10_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_11_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_12_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_13_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-3)) ⊑
    icmp IntPred.slt e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_14_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-2)) ⊑
    icmp IntPred.slt e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_01_15_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 1) { «exact» := true }) (const? 4 (-1)) ⊑
    icmp IntPred.slt e (const? 4 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_00_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_01_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 1) ⊑
    icmp IntPred.slt e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_02_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_03_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 3) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_04_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_05_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_06_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_07_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_08_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_09_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_10_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_11_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_12_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_13_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_14_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_02_15_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 2) { «exact» := true }) (const? 4 (-1)) ⊑
    icmp IntPred.slt e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_00_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 0) ⊑
    icmp IntPred.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_01_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_02_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_03_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 3) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_04_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 4) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_05_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 5) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_06_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 6) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_07_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 7) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_08_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-8)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_09_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-7)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_10_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-6)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_11_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-5)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_12_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-4)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_13_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-3)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_14_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-2)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashrslt_03_15_exact_thm (e : IntW 4) :
  icmp IntPred.slt (ashr e (const? 4 3) { «exact» := true }) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_slt_exact_near_pow2_cmpval_thm (e : IntW 8) :
  icmp IntPred.slt (ashr e (const? 8 1) { «exact» := true }) (const? 8 5) ⊑
    icmp IntPred.slt e (const? 8 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_exact_near_pow2_cmpval_thm (e : IntW 8) :
  icmp IntPred.ult (ashr e (const? 8 1) { «exact» := true }) (const? 8 5) ⊑
    icmp IntPred.ult e (const? 8 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negtest_near_pow2_cmpval_ashr_slt_noexact_thm (e : IntW 8) :
  icmp IntPred.slt (ashr e (const? 8 1)) (const? 8 5) ⊑ icmp IntPred.slt e (const? 8 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_thm (e : IntW 8) :
  icmp IntPred.eq (ashr e (const? 8 1) { «exact» := true }) (const? 8 5) ⊑
    icmp IntPred.eq e (const? 8 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negtest_near_pow2_cmpval_isnt_close_to_pow2_thm (e : IntW 8) :
  icmp IntPred.slt (ashr e (const? 8 1) { «exact» := true }) (const? 8 6) ⊑
    icmp IntPred.slt e (const? 8 12) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negtest_near_pow2_cmpval_would_overflow_into_signbit_thm (e : IntW 8) :
  icmp IntPred.ult (ashr e (const? 8 2) { «exact» := true }) (const? 8 33) ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry

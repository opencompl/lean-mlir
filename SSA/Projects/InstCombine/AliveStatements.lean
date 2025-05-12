/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

set_option linter.style.nameCheck false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false

theorem bv_AddSub_1043 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.add (LLVM.add (LLVM.xor (LLVM.and e_1 e) e) (LLVM.const? w 1)) e_2 ⊑ LLVM.sub e_2 (LLVM.or e_1 (LLVM.not e)) := by
  simp_llvm
  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1152 :
    ∀ (e e_1 : LLVM.IntW 1), LLVM.add e_1 e ⊑ LLVM.xor e_1 e := by
  simp_llvm
  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1156 :
    ∀ (e : LLVM.IntW w), LLVM.add e e ⊑ LLVM.shl e (LLVM.const? w 1) := by
  simp_llvm
  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1164 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.sub (LLVM.const? w 0) e) e_1 ⊑ LLVM.sub e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1165 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.add (LLVM.sub (LLVM.const? w 0) e) (LLVM.sub (LLVM.const? w 0) e_1) ⊑ LLVM.sub (LLVM.const? w 0) (LLVM.add e e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1176 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add e (LLVM.sub (LLVM.const? w 0) e_1) ⊑ LLVM.sub e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1202 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.xor e (LLVM.const? w (-1))) e_1 ⊑ LLVM.sub (LLVM.sub e_1 (LLVM.const? w 1)) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1295 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.and e e_1) (LLVM.xor e e_1) ⊑ LLVM.or e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1309 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.and e e_1) (LLVM.or e e_1) ⊑ LLVM.add e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1539 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 (LLVM.sub (LLVM.const? w 0) e) ⊑ LLVM.add e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1539_2 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e e_1 ⊑ LLVM.add e (LLVM.neg e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1556 :
    ∀ (e e_1 : LLVM.IntW 1), LLVM.sub e_1 e ⊑ LLVM.xor e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1560 :
    ∀ (e : LLVM.IntW w), LLVM.sub (LLVM.const? w (-1)) e ⊑ LLVM.xor e (LLVM.const? w (-1)) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1564 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 (LLVM.xor e (LLVM.const? w (-1))) ⊑ LLVM.add e (LLVM.add e_1 (LLVM.const? w 1)) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1574 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.sub e_1 (LLVM.add e e_2) ⊑ LLVM.sub (LLVM.sub e_1 e_2) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1614 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 (LLVM.add e_1 e) ⊑ LLVM.sub (LLVM.const? w 0) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1619 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub (LLVM.sub e_1 e) e_1 ⊑ LLVM.sub (LLVM.const? w 0) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1624 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub (LLVM.or e e_1) (LLVM.xor e e_1) ⊑ LLVM.and e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_135 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.and (LLVM.xor e e_1) e_2 ⊑ LLVM.xor (LLVM.and e e_2) (LLVM.and e_1 e_2) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_144 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.and (LLVM.or e e_1) e_2 ⊑ LLVM.and (LLVM.or e (LLVM.and e_1 e_2)) e_2 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_698 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPred.eq (LLVM.and e e_1) (LLVM.const? w 0))
          (LLVM.icmp LLVM.IntPred.eq (LLVM.and e e_2) (LLVM.const? w 0)) ⊑
        LLVM.icmp LLVM.IntPred.eq (LLVM.and e (LLVM.or e_1 e_2)) (LLVM.const? w 0) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_709 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPred.eq (LLVM.and e e_1) e_1) (LLVM.icmp LLVM.IntPred.eq (LLVM.and e e_2) e_2) ⊑
        LLVM.icmp LLVM.IntPred.eq (LLVM.and e (LLVM.or e_1 e_2)) (LLVM.or e_1 e_2) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_716 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPred.eq (LLVM.and e e_1) e) (LLVM.icmp LLVM.IntPred.eq (LLVM.and e e_2) e) ⊑
        LLVM.icmp LLVM.IntPred.eq (LLVM.and e (LLVM.and e_1 e_2)) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_794 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPred.sgt e e_1) (LLVM.icmp LLVM.IntPred.ne e e_1) ⊑ LLVM.icmp LLVM.IntPred.sgt e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_827 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPred.eq e (LLVM.const? w 0)) (LLVM.icmp LLVM.IntPred.eq e_1 (LLVM.const? w 0)) ⊑
        LLVM.icmp LLVM.IntPred.eq (LLVM.or e e_1) (LLVM.const? w 0) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_887_2 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.icmp LLVM.IntPred.eq e e_1) (LLVM.icmp LLVM.IntPred.ne e e_1) ⊑ LLVM.const? 1 0 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1230__A__B___A__B :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.xor e (LLVM.const? w (-1))) (LLVM.xor e_1 (LLVM.const? w (-1))) ⊑
        LLVM.xor (LLVM.or e e_1) (LLVM.const? w (-1)) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1241_AB__AB__AB :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.or e e_1) (LLVM.xor (LLVM.and e e_1) (LLVM.const? w (-1))) ⊑ LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1247_AB__AB__AB :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.xor (LLVM.and e e_1) (LLVM.const? w (-1))) (LLVM.or e e_1) ⊑ LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1253_A__AB___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.xor e e_1) e ⊑ LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1280_ABA___AB :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.or (LLVM.xor e (LLVM.const? w (-1))) e_1) e ⊑ LLVM.and e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1288_A__B__B__C__A___A__B__C :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.xor e e_2) (LLVM.xor (LLVM.xor e_2 e_1) e) ⊑
        LLVM.and (LLVM.xor e e_2) (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1294_A__B__A__B___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.or e e_1) (LLVM.xor (LLVM.xor e (LLVM.const? w (-1))) e_1) ⊑ LLVM.and e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1683_1 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPred.ugt e e_1) (LLVM.icmp LLVM.IntPred.eq e e_1) ⊑ LLVM.icmp LLVM.IntPred.uge e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1683_2 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.icmp LLVM.IntPred.uge e e_1) (LLVM.icmp LLVM.IntPred.ne e e_1) ⊑ LLVM.const? 1 1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1704 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPred.eq e_1 (LLVM.const? w 0)) (LLVM.icmp LLVM.IntPred.ult e e_1) ⊑
        LLVM.icmp LLVM.IntPred.uge (LLVM.add e_1 (LLVM.const? w (-1))) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1705 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPred.eq e_1 (LLVM.const? w 0)) (LLVM.icmp LLVM.IntPred.ugt e_1 e) ⊑
        LLVM.icmp LLVM.IntPred.uge (LLVM.add e_1 (LLVM.const? w (-1))) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1733 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPred.ne e (LLVM.const? w 0)) (LLVM.icmp LLVM.IntPred.ne e_1 (LLVM.const? w 0)) ⊑
        LLVM.icmp LLVM.IntPred.ne (LLVM.or e e_1) (LLVM.const? w 0) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2063__X__C1__C2____X__C2__C1__C2 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.xor e e_1) e_2 ⊑ LLVM.xor (LLVM.or e e_2) (LLVM.and e_1 (LLVM.not e_2)) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2113___A__B__A___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.and (LLVM.xor e (LLVM.const? w (-1))) e_1) e ⊑ LLVM.or e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2118___A__B__A___A__B :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.and e e_1) (LLVM.xor e (LLVM.const? w (-1))) ⊑ LLVM.or (LLVM.xor e (LLVM.const? w (-1))) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2123___A__B__A__B___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1)))) (LLVM.xor e e_1) ⊑ LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2188 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1)))) (LLVM.and (LLVM.xor e (LLVM.const? w (-1))) e_1) ⊑
        LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2231__A__B__B__C__A___A__B__C :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.xor e e_2) (LLVM.xor (LLVM.xor e_2 e_1) e) ⊑ LLVM.or (LLVM.xor e e_2) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2243__B__C__A__B___B__A__C :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.and (LLVM.or e_2 e_1) e) e_2 ⊑ LLVM.or e_2 (LLVM.and e e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2247__A__B__A__B :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.xor e (LLVM.const? w (-1))) (LLVM.xor e_1 (LLVM.const? w (-1))) ⊑
        LLVM.xor (LLVM.and e e_1) (LLVM.const? w (-1)) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2263 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or e_1 (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2264 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or e (LLVM.xor (LLVM.xor e (LLVM.const? w (-1))) e_1) ⊑ LLVM.or e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2265 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.and e e_1) (LLVM.xor e e_1) ⊑ LLVM.or e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2284 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or e (LLVM.xor (LLVM.or e e_1) (LLVM.const? w (-1))) ⊑ LLVM.or e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2285 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or e (LLVM.xor (LLVM.xor e e_1) (LLVM.const? w (-1))) ⊑ LLVM.or e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2297 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.and e e_1) (LLVM.xor (LLVM.xor e (LLVM.const? w (-1))) e_1) ⊑
        LLVM.xor (LLVM.xor e (LLVM.const? w (-1))) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2367 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.or e e_1) e_2 ⊑ LLVM.or (LLVM.or e e_2) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2416 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and (LLVM.xor e (LLVM.const? w (-1))) e_1) (LLVM.const? w (-1)) ⊑
        LLVM.or e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2417 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.or (LLVM.xor e (LLVM.const? w (-1))) e_1) (LLVM.const? w (-1)) ⊑
        LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2429 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and e_1 e) (LLVM.const? w (-1)) ⊑
        LLVM.or (LLVM.xor e_1 (LLVM.const? w (-1))) (LLVM.xor e (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2430 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.or e_1 e) (LLVM.const? w (-1)) ⊑
        LLVM.and (LLVM.xor e_1 (LLVM.const? w (-1))) (LLVM.xor e (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2443 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.ashr (LLVM.xor e_1 (LLVM.const? w (-1))) e) (LLVM.const? w (-1)) ⊑ LLVM.ashr e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2453 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.icmp LLVM.IntPred.slt e_1 e) (LLVM.const? 1 (-1)) ⊑ LLVM.icmp LLVM.IntPred.sge e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2475 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.sub e_1 e) (LLVM.const? w (-1)) ⊑ LLVM.add e (LLVM.sub (LLVM.const? w (-1)) e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2486 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.add e e_1) (LLVM.const? w (-1)) ⊑ LLVM.sub (LLVM.sub (LLVM.const? w (-1)) e_1) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2581__BAB___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.or e e_1) e_1 ⊑ LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1))) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2587__BAA___B__A :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.and e e_1) e_1 ⊑ LLVM.and (LLVM.xor e (LLVM.const? w (-1))) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2595 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.and e e_1) (LLVM.or e e_1) ⊑ LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2607 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.or e (LLVM.xor e_1 (LLVM.const? w (-1)))) (LLVM.or (LLVM.xor e (LLVM.const? w (-1))) e_1) ⊑
        LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2617 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1)))) (LLVM.and (LLVM.xor e (LLVM.const? w (-1))) e_1) ⊑
        LLVM.xor e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2627 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.xor (LLVM.xor e e_1) (LLVM.or e e_2) ⊑ LLVM.xor (LLVM.and (LLVM.xor e (LLVM.const? w (-1))) e_2) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2647 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.and e e_1) (LLVM.xor e e_1) ⊑ LLVM.or e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2658 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and e (LLVM.xor e_1 (LLVM.const? w (-1)))) (LLVM.xor e (LLVM.const? w (-1))) ⊑
        LLVM.xor (LLVM.and e e_1) (LLVM.const? w (-1)) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2663 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.icmp LLVM.IntPred.ule e e_1) (LLVM.icmp LLVM.IntPred.ne e e_1) ⊑ LLVM.icmp LLVM.IntPred.uge e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_152 :
    ∀ (e : LLVM.IntW w), LLVM.mul e (LLVM.const? w (-1)) ⊑ LLVM.sub (LLVM.const? w 0) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_229 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.mul (LLVM.add e e_1) e_2 ⊑ LLVM.add (LLVM.mul e e_2) (LLVM.mul e_1 e_2) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_239 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.mul (LLVM.sub (LLVM.const? w 0) e_1) (LLVM.sub (LLVM.const? w 0) e) ⊑ LLVM.mul e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_275 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.udiv e_1 e) e ⊑ LLVM.sub e_1 (LLVM.urem e_1 e) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_275_2 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.sdiv e_1 e) e ⊑ LLVM.sub e_1 (LLVM.srem e_1 e) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_276 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.sdiv e_1 e) (LLVM.sub (LLVM.const? 5 0) e) ⊑ LLVM.sub (LLVM.srem e_1 e) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_276_2 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.udiv e_1 e) (LLVM.sub (LLVM.const? 5 0) e) ⊑ LLVM.sub (LLVM.urem e_1 e) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_283 :
    ∀ (e e_1 : LLVM.IntW 1), LLVM.mul e_1 e ⊑ LLVM.and e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_290__292 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.mul (LLVM.shl (LLVM.const? w 1) e) e_1 ⊑ LLVM.shl e_1 e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_820 :
    ∀ (e e_1 : LLVM.IntW 9), LLVM.sdiv (LLVM.sub e (LLVM.srem e e_1)) e_1 ⊑ LLVM.sdiv e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_820' :
    ∀ (e e_1 : LLVM.IntW 9), LLVM.udiv (LLVM.sub e (LLVM.urem e e_1)) e_1 ⊑ LLVM.udiv e e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_1030 :
    ∀ (e : LLVM.IntW w), LLVM.sdiv e (LLVM.const? w (-1)) ⊑ LLVM.sub (LLVM.const? w 0) e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_Select_858 :
    ∀ (e e_1 : LLVM.IntW 1),
      LLVM.select e (LLVM.xor e (LLVM.const? 1 (-1))) e_1 ⊑ LLVM.and (LLVM.xor e (LLVM.const? 1 (-1))) e_1 := by
  simp_llvm
  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_Select_859' :
    ∀ (e e_1 : LLVM.IntW 1),
      LLVM.select e e_1 (LLVM.xor e (LLVM.const? 1 (-1))) ⊑ LLVM.or (LLVM.xor e (LLVM.const? 1 (-1))) e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_select_1100 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.select (LLVM.const? 1 1) e_1 e ⊑ e_1 := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_Select_1105 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.select (LLVM.const? 1 0) e_1 e ⊑ e := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__239 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.lshr (LLVM.shl e e_1) e_1 ⊑ LLVM.and e (LLVM.lshr (LLVM.const? w (-1)) e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__279 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.shl (LLVM.lshr e e_1) e_1 ⊑ LLVM.and e (LLVM.shl (LLVM.const? w (-1)) e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__440 :
    ∀ (e e_1 e_2 e_3 : LLVM.IntW w),
      LLVM.shl (LLVM.xor e (LLVM.and (LLVM.lshr e_1 e_2) e_3)) e_2 ⊑
        LLVM.xor (LLVM.and e_1 (LLVM.shl e_3 e_2)) (LLVM.shl e e_2) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__476 :
    ∀ (e e_1 e_2 e_3 : LLVM.IntW w),
      LLVM.shl (LLVM.or (LLVM.and (LLVM.lshr e_1 e_2) e_3) e) e_2 ⊑
        LLVM.or (LLVM.and e_1 (LLVM.shl e_3 e_2)) (LLVM.shl e e_2) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__497 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.lshr (LLVM.xor e e_2) e_1 ⊑ LLVM.xor (LLVM.lshr e e_1) (LLVM.lshr e_2 e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__497''' :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.shl (LLVM.add e e_2) e_1 ⊑ LLVM.add (LLVM.shl e e_1) (LLVM.shl e_2 e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__582 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.lshr (LLVM.shl e e_1) e_1 ⊑ LLVM.and e (LLVM.lshr (LLVM.const? w (-1)) e_1) := by
  simp_llvm

  simp_alive_case_bash
  simp_alive_split
  try alive_auto
  all_goals sorry

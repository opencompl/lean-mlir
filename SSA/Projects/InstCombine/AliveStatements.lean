/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

set_option linter.unreachableTactic false
set_option linter.unusedTactic false

theorem bv_AddSub_1043 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.add (LLVM.add (LLVM.xor (LLVM.and e_2 e_1) e_1) (LLVM.const? 1)) e ⊑ LLVM.sub e (LLVM.or e_2 (LLVM.not e_1)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1152 :
    ∀ (e e_1 : LLVM.IntW 1), LLVM.add e_1 e ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1156 :
    ∀ (e : LLVM.IntW w), LLVM.add e e ⊑ LLVM.shl e (LLVM.const? 1) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1164 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.sub (LLVM.const? 0) e_1) e ⊑ LLVM.sub e e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1165 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.add (LLVM.sub (LLVM.const? 0) e_1) (LLVM.sub (LLVM.const? 0) e) ⊑ LLVM.sub (LLVM.const? 0) (LLVM.add e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1176 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add e_1 (LLVM.sub (LLVM.const? 0) e) ⊑ LLVM.sub e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1202 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.xor e_1 (LLVM.const? (-1))) e ⊑ LLVM.sub (LLVM.sub e (LLVM.const? 1)) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1295 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.and e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1309 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ LLVM.add e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1539 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 (LLVM.sub (LLVM.const? 0) e) ⊑ LLVM.add e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1539_2 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 e ⊑ LLVM.add e_1 (LLVM.neg e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1556 :
    ∀ (e e_1 : LLVM.IntW 1), LLVM.sub e_1 e ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1560 :
    ∀ (e : LLVM.IntW w), LLVM.sub (LLVM.const? (-1)) e ⊑ LLVM.xor e (LLVM.const? (-1)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1564 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 (LLVM.xor e (LLVM.const? (-1))) ⊑ LLVM.add e (LLVM.add e_1 (LLVM.const? 1)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1574 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.sub e_2 (LLVM.add e_1 e) ⊑ LLVM.sub (LLVM.sub e_2 e) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1614 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub e_1 (LLVM.add e_1 e) ⊑ LLVM.sub (LLVM.const? 0) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1619 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub (LLVM.sub e_1 e) e_1 ⊑ LLVM.sub (LLVM.const? 0) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AddSub_1624 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.sub (LLVM.or e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.and e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_135 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.and (LLVM.xor e_2 e_1) e ⊑ LLVM.xor (LLVM.and e_2 e) (LLVM.and e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_144 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.and (LLVM.or e_2 e_1) e ⊑ LLVM.and (LLVM.or e_2 (LLVM.and e_1 e)) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_698 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 e_1) (LLVM.const? 0))
          (LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 e) (LLVM.const? 0)) ⊑
        LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 (LLVM.or e_1 e)) (LLVM.const? 0) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_709 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 e_1) e_1) (LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 e) e) ⊑
        LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 (LLVM.or e_1 e)) (LLVM.or e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_716 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 e_1) e_2)
          (LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 e) e_2) ⊑
        LLVM.icmp LLVM.IntPredicate.eq (LLVM.and e_2 (LLVM.and e_1 e)) e_2 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_794 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPredicate.sgt e_1 e) (LLVM.icmp LLVM.IntPredicate.ne e_1 e) ⊑
        LLVM.icmp LLVM.IntPredicate.sgt e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_827 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPredicate.eq e_1 (LLVM.const? 0)) (LLVM.icmp LLVM.IntPredicate.eq e (LLVM.const? 0)) ⊑
        LLVM.icmp LLVM.IntPredicate.eq (LLVM.or e_1 e) (LLVM.const? 0) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_887_2 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.icmp LLVM.IntPredicate.eq e_1 e) (LLVM.icmp LLVM.IntPredicate.ne e_1 e) ⊑ LLVM.const? 0 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1230__A__B___A__B :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) (LLVM.xor e (LLVM.const? (-1))) ⊑
        LLVM.xor (LLVM.or e_1 e) (LLVM.const? (-1)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1241_AB__AB__AB :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.or e_1 e) (LLVM.xor (LLVM.and e_1 e) (LLVM.const? (-1))) ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1247_AB__AB__AB :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.xor (LLVM.and e_1 e) (LLVM.const? (-1))) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1253_A__AB___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.xor e_1 e) e_1 ⊑ LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1280_ABA___AB :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) e) e_1 ⊑ LLVM.and e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1288_A__B__B__C__A___A__B__C :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.and (LLVM.xor e_2 e_1) (LLVM.xor (LLVM.xor e_1 e) e_2) ⊑
        LLVM.and (LLVM.xor e_2 e_1) (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1294_A__B__A__B___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.and (LLVM.or e_1 e) (LLVM.xor (LLVM.xor e_1 (LLVM.const? (-1))) e) ⊑ LLVM.and e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1683_1 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPredicate.ugt e_1 e) (LLVM.icmp LLVM.IntPredicate.eq e_1 e) ⊑
        LLVM.icmp LLVM.IntPredicate.uge e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1683_2 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPredicate.uge e_1 e) (LLVM.icmp LLVM.IntPredicate.ne e_1 e) ⊑ LLVM.const? 1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1704 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPredicate.eq e_1 (LLVM.const? 0)) (LLVM.icmp LLVM.IntPredicate.ult e e_1) ⊑
        LLVM.icmp LLVM.IntPredicate.uge (LLVM.add e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1705 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPredicate.eq e_1 (LLVM.const? 0)) (LLVM.icmp LLVM.IntPredicate.ugt e_1 e) ⊑
        LLVM.icmp LLVM.IntPredicate.uge (LLVM.add e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_1733 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.icmp LLVM.IntPredicate.ne e_1 (LLVM.const? 0)) (LLVM.icmp LLVM.IntPredicate.ne e (LLVM.const? 0)) ⊑
        LLVM.icmp LLVM.IntPredicate.ne (LLVM.or e_1 e) (LLVM.const? 0) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2063__X__C1__C2____X__C2__C1__C2 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.xor e_2 e_1) e ⊑ LLVM.xor (LLVM.or e_2 e) (LLVM.and e_1 (LLVM.not e)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2113___A__B__A___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e) e_1 ⊑ LLVM.or e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2118___A__B__A___A__B :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.and e_1 e) (LLVM.xor e_1 (LLVM.const? (-1))) ⊑ LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2123___A__B__A__B___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1)))) (LLVM.xor e_1 e) ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2188 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1)))) (LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e) ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2231__A__B__B__C__A___A__B__C :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.xor e_2 e_1) (LLVM.xor (LLVM.xor e_1 e) e_2) ⊑ LLVM.or (LLVM.xor e_2 e_1) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2243__B__C__A__B___B__A__C :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.and (LLVM.or e_2 e_1) e) e_2 ⊑ LLVM.or e_2 (LLVM.and e e_1) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2247__A__B__A__B :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) (LLVM.xor e (LLVM.const? (-1))) ⊑
        LLVM.xor (LLVM.and e_1 e) (LLVM.const? (-1)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2263 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or e_1 (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2264 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or e_1 (LLVM.xor (LLVM.xor e_1 (LLVM.const? (-1))) e) ⊑ LLVM.or e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2265 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.or (LLVM.and e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2284 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or e_1 (LLVM.xor (LLVM.or e_1 e) (LLVM.const? (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2285 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or e_1 (LLVM.xor (LLVM.xor e_1 e) (LLVM.const? (-1))) ⊑ LLVM.or e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2297 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.or (LLVM.and e_1 e) (LLVM.xor (LLVM.xor e_1 (LLVM.const? (-1))) e) ⊑ LLVM.xor (LLVM.xor e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2367 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.or (LLVM.or e_2 e_1) e ⊑ LLVM.or (LLVM.or e_2 e) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2416 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e) (LLVM.const? (-1)) ⊑
        LLVM.or e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2417 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) e) (LLVM.const? (-1)) ⊑
        LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2429 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and e_1 e) (LLVM.const? (-1)) ⊑
        LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2430 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.or e_1 e) (LLVM.const? (-1)) ⊑
        LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2443 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.ashr (LLVM.xor e_1 (LLVM.const? (-1))) e) (LLVM.const? (-1)) ⊑ LLVM.ashr e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2453 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.icmp LLVM.IntPredicate.slt e_1 e) (LLVM.const? (-1)) ⊑ LLVM.icmp LLVM.IntPredicate.sge e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2475 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.sub e_1 e) (LLVM.const? (-1)) ⊑ LLVM.add e (LLVM.sub (LLVM.const? (-1)) e_1) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2486 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.add e_1 e) (LLVM.const? (-1)) ⊑ LLVM.sub (LLVM.sub (LLVM.const? (-1)) e) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2581__BAB___A__B :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.or e_1 e) e ⊑ LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1))) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2587__BAA___B__A :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.and e_1 e) e ⊑ LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2595 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2607 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.or e_1 (LLVM.xor e (LLVM.const? (-1)))) (LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) e) ⊑ LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2617 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1)))) (LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e) ⊑
        LLVM.xor e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2627 :
    ∀ (e e_1 e_2 : LLVM.IntW w),
      LLVM.xor (LLVM.xor e_2 e_1) (LLVM.or e_2 e) ⊑ LLVM.xor (LLVM.and (LLVM.xor e_2 (LLVM.const? (-1))) e) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2647 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.xor (LLVM.and e_1 e) (LLVM.xor e_1 e) ⊑ LLVM.or e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2658 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.and e_1 (LLVM.xor e (LLVM.const? (-1)))) (LLVM.xor e_1 (LLVM.const? (-1))) ⊑
        LLVM.xor (LLVM.and e_1 e) (LLVM.const? (-1)) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_AndOrXor_2663 :
    ∀ (e e_1 : LLVM.IntW w),
      LLVM.xor (LLVM.icmp LLVM.IntPredicate.ule e_1 e) (LLVM.icmp LLVM.IntPredicate.ne e_1 e) ⊑
        LLVM.icmp LLVM.IntPredicate.uge e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_152 :
    ∀ (e : LLVM.IntW w), LLVM.mul e (LLVM.const? (-1)) ⊑ LLVM.sub (LLVM.const? 0) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_229 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.mul (LLVM.add e_2 e_1) e ⊑ LLVM.add (LLVM.mul e_2 e) (LLVM.mul e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_239 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.mul (LLVM.sub (LLVM.const? 0) e_1) (LLVM.sub (LLVM.const? 0) e) ⊑ LLVM.mul e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_275 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.udiv e_1 e) e ⊑ LLVM.sub e_1 (LLVM.urem e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_275_2 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.sdiv e_1 e) e ⊑ LLVM.sub e_1 (LLVM.srem e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_276 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.sdiv e_1 e) (LLVM.sub (LLVM.const? 0) e) ⊑ LLVM.sub (LLVM.srem e_1 e) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_276_2 :
    ∀ (e e_1 : LLVM.IntW 5), LLVM.mul (LLVM.udiv e_1 e) (LLVM.sub (LLVM.const? 0) e) ⊑ LLVM.sub (LLVM.urem e_1 e) e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_283 :
    ∀ (e e_1 : LLVM.IntW 1), LLVM.mul e_1 e ⊑ LLVM.and e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_290__292 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.mul (LLVM.shl (LLVM.const? 1) e_1) e ⊑ LLVM.shl e e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_820 :
    ∀ (e e_1 : LLVM.IntW 9), LLVM.sdiv (LLVM.sub e_1 (LLVM.srem e_1 e)) e ⊑ LLVM.sdiv e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_820' :
    ∀ (e e_1 : LLVM.IntW 9), LLVM.udiv (LLVM.sub e_1 (LLVM.urem e_1 e)) e ⊑ LLVM.udiv e_1 e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_1030 :
    ∀ (e : LLVM.IntW w), LLVM.sdiv e (LLVM.const? (-1)) ⊑ LLVM.sub (LLVM.const? 0) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_Select_858 :
    ∀ (e e_1 : LLVM.IntW 1),
      LLVM.select e_1 (LLVM.xor e_1 (LLVM.const? (-1))) e ⊑ LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_Select_859' :
    ∀ (e e_1 : LLVM.IntW 1),
      LLVM.select e_1 e (LLVM.xor e_1 (LLVM.const? (-1))) ⊑ LLVM.or (LLVM.xor e_1 (LLVM.const? (-1))) e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_select_1100 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.select (LLVM.const? 1) e_1 e ⊑ e_1 := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_Select_1105 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.select (LLVM.const? 0) e_1 e ⊑ e := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__239 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.lshr (LLVM.shl e_1 e) e ⊑ LLVM.and e_1 (LLVM.lshr (LLVM.const? (-1)) e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__279 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.shl (LLVM.lshr e_1 e) e ⊑ LLVM.and e_1 (LLVM.shl (LLVM.const? (-1)) e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__440 :
    ∀ (e e_1 e_2 e_3 : LLVM.IntW w),
      LLVM.shl (LLVM.xor e_3 (LLVM.and (LLVM.lshr e_2 e_1) e)) e_1 ⊑
        LLVM.xor (LLVM.and e_2 (LLVM.shl e e_1)) (LLVM.shl e_3 e_1) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__476 :
    ∀ (e e_1 e_2 e_3 : LLVM.IntW w),
      LLVM.shl (LLVM.or (LLVM.and (LLVM.lshr e_3 e_2) e_1) e) e_2 ⊑
        LLVM.or (LLVM.and e_3 (LLVM.shl e_1 e_2)) (LLVM.shl e e_2) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

theorem bv_InstCombineShift__497 :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.lshr (LLVM.xor e_2 e_1) e ⊑ LLVM.xor (LLVM.lshr e_2 e) (LLVM.lshr e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

@[simp]
theorem shiftLeft_one_getLsbD_add (x y: BitVec w) :
  (x <<< (↑1 : Nat) + y <<< (↑1 : Nat)).getLsbD 0 = false := by
  induction w
  case zero =>
    bv_decide
  case succ =>
    rw [BitVec.getLsbD_add]
    simp [bv_toNat]
    omega

@[simp]
theorem potato (n : Nat) (h : w > 0)  (h' : m > 0):
  ((1 + n) % 2 ^ w) <<< m % 2 ^ w = (n % 2 ^ w) <<< m % 2 ^ w := by
  sorry

@[simp]
theorem zero_shiftLeft (m : Nat) :
  0 <<< m = 0 := by
  simp

@[simp]
theorem shiftLeft_distr_add (x y : BitVec w) (m : Nat) (h : m < w):
  (x + y) <<< m = x <<< m + y <<< m := by

  rw [BitVec.toNat_eq]
  simp
  induction x.toNat generalizing y
  case zero =>
    simp only [zero_add, BitVec.toNat_mod_cancel, Nat.zero_shiftLeft]
  case succ n ih =>
    rw [Nat.add_assoc]
    rw [Nat.add_comm]
    rw [Nat.add_assoc]
    rw [← Nat.mod_add_mod]
    simp [h]
    by_cases h' : m = 0
    · subst h'
      simp only [Nat.shiftLeft_zero, dvd_refl, Nat.mod_mod_of_dvd]
      rw [← Nat.add_assoc, Nat.add_comm, ← Nat.add_assoc]
    · have : m > 0 := by omega
      by_cases h'' : w = 0
      · omega
      · have : 0 < w := by omega
        rw [potato]
        · rw [Nat.add_comm, ih]
          rw [Nat.add_mod (a := (n + 1) <<< m) (b := y.toNat <<< m)]

          rw [Nat.shiftLeft_eq]
          rw [Nat.shiftLeft_eq]
          rw [Nat.shiftLeft_eq]
          rw [Nat.mul_comm (n := (n + 1))]
          rw [Nat.mul_add]
          sorry
        · omega
        · omega

@[simp]
theorem pumpkin' (x y : BitVec w) (h : i > 0) (h1 : w > 0):
  BitVec.carry (i - 1) x y false = BitVec.carry (i) (x <<< 1) (y <<< 1) false := by
  induction i
  case zero =>
    simp
  case succ n ih =>
    rw [add_tsub_cancel_right]
    rw [BitVec.carry_succ]
    simp [← ih]
    rw [Nat.one_mod_two_pow]
    · sorry
    · sorry

theorem pumpkin (x y : BitVec w) (h : i > 0) (h' : w > 0):
  BitVec.carry (i - (1 : Nat)) x y false = BitVec.carry (i) (x <<< (1 : Nat)) (y <<< (1 : Nat)) false := by
  induction i
  case zero =>
    simp
  case succ n ih =>
    simp only [add_tsub_cancel_right]
    rw [BitVec.carry_succ, ← ih]
    rw [BitVec.getLsbD_shiftLeft]
    rw [BitVec.getLsbD_shiftLeft]
    bv_auto
    by_cases h'' : n < w
    · simp [h'', *]
      sorry
    · sorry
    · sorry


@[simp]
theorem shiftLeft_distrib_add_one (x y : BitVec w) (h : w > 1) :
  (x + y) <<< (1 : Nat) = x <<< (1 : Nat) + y <<< (1 : Nat):= by
  ext i
  by_cases h' : i.val = 0
  · simp only [h', BitVec.getLsbD_shiftLeft, zero_lt_one, decide_True, Bool.not_true,
    Bool.and_false, zero_le, tsub_eq_zero_of_le, Bool.false_and, shiftLeft_one_getLsbD_add]
  · have : i.val > 0 := by omega
    simp only [BitVec.getLsbD_shiftLeft, Fin.is_lt, decide_True, Nat.lt_one_iff, Bool.true_and, *]
    simp
    rw [BitVec.getLsbD_add]
    rw [BitVec.getLsbD_add]
    simp [*]
    · by_cases h'' : i.val = w
      · omega
      · have : i.val < w := by omega
        rw [pumpkin]
        · omega
        · omega
    · omega
    · omega


@[simp]
theorem shiftLeft_distr_add' (x y : BitVec w) (m : Nat) (h : m < w):
  (x + y) <<< m = x <<< m + y <<< m := by
  induction m generalizing x y
  case zero =>
    bv_auto
  case succ n ih =>
    by_cases h' : w = 0
    · subst h'
      bv_decide
    · rw [BitVec.shiftLeft_add, ih]
      by_cases h'' : n = 0
      · rw [h'']
        simp only [BitVec.shiftLeft_zero_eq, zero_add]
        rw [shiftLeft_distrib_add_one]
        bv_omega
      · have : 0 < n := by omega
        rw [shiftLeft_distrib_add_one]
        · rw [BitVec.shiftLeft_add, BitVec.shiftLeft_add]
        · omega
      · omega

theorem bv_InstCombineShift__497''' :
    ∀ (e e_1 e_2 : LLVM.IntW w), LLVM.shl (LLVM.add e_2 e_1) e ⊑ LLVM.add (LLVM.shl e_2 e) (LLVM.shl e_1 e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  bv_auto
  rw [shiftLeft_distr_add]
  omega


theorem bv_InstCombineShift__582 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.lshr (LLVM.shl e_1 e) e ⊑ LLVM.and e_1 (LLVM.lshr (LLVM.const? (-1)) e) := by
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  all_goals sorry

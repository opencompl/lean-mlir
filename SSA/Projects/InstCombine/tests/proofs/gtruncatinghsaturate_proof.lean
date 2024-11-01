
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gtruncatinghsaturate_proof
theorem testtrunclowhigh_thm (e e_1 : IntW 16) (e_2 : IntW 32) :
  select (icmp IntPredicate.ult (add e_2 (const? 128)) (const? 256)) (trunc 16 e_2)
      (select (icmp IntPredicate.sgt e_2 (const? (-1))) e_1 e) ⊑
    select (icmp IntPredicate.ult (add e_2 (const? 128)) (const? 256)) (trunc 16 e_2)
      (select (icmp IntPredicate.slt e_2 (const? 0)) e e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi32i8_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 15))) (const? 127)) ⊑
    select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (lshr e (const? 15))) (const? 127)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem differentconsts_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 16)) (const? 144)) (trunc 16 e)
      (select (icmp IntPredicate.slt e (const? 128)) (const? 256) (const? (-1))) ⊑
    select (icmp IntPredicate.sgt e (const? 127)) (const? (-1))
      (select (icmp IntPredicate.slt e (const? (-16))) (const? 256) (trunc 16 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem badimm1_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 9)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 15))) (const? 127)) ⊑
    select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 9)))) (trunc 8 e)
      (select (icmp IntPredicate.sgt e (const? (-1))) (const? 127) (const? (-128))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem badimm2_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 6)) (trunc 8 (lshr e (const? 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 15))) (const? 127)) ⊑
    select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 6)) (trunc 8 (lshr e (const? 8)))) (trunc 8 e)
      (select (icmp IntPredicate.sgt e (const? (-1))) (const? 127) (const? (-128))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem badimm3_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 14))) (const? 127)) ⊑
    select (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 14))) (const? 127)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem badimm4_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 15))) (const? 126)) ⊑
    select (icmp IntPredicate.sgt e (const? 127)) (const? 126)
      (select (icmp IntPredicate.slt e (const? (-128))) (const? (-127)) (trunc 8 e)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem C0zero_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ult (add e_2 (const? 10)) (const? 0)) e_2
      (select (icmp IntPredicate.slt e_2 (const? (-10))) e_1 e) ⊑
    select (icmp IntPredicate.slt e_2 (const? (-10))) e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry



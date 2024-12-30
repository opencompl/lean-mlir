
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gtruncatinghsaturate_proof
theorem testtrunclowhigh_thm (e e_1 : IntW 16) (e_2 : IntW 32) :
  select (icmp IntPredicate.ult (add e_2 (const? 32 128)) (const? 32 256)) (trunc 16 e_2)
      (select (icmp IntPredicate.sgt e_2 (const? 32 (-1))) e_1 e) ⊑
    select (icmp IntPredicate.ult (add e_2 (const? 32 128)) (const? 32 256)) (trunc 16 e_2)
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi32i8_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 32 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 32 15))) (const? 8 127)) ⊑
    select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 32 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (lshr e (const? 32 15))) (const? 8 127)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem differentconsts_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 16)) (const? 32 144)) (trunc 16 e)
      (select (icmp IntPredicate.slt e (const? 32 128)) (const? 16 256) (const? 16 (-1))) ⊑
    select (icmp IntPredicate.sgt e (const? 32 127)) (const? 16 (-1))
      (select (icmp IntPredicate.slt e (const? 32 (-16))) (const? 16 256) (trunc 16 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem badimm1_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 9)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 127)) ⊑
    select
      (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7))
        (trunc 8 (lshr e (const? 16 9)) { «nsw» := true, «nuw» := true }))
      (trunc 8 e) (select (icmp IntPredicate.sgt e (const? 16 (-1))) (const? 8 127) (const? 8 (-128))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem badimm2_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 6)) (trunc 8 (lshr e (const? 16 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 127)) ⊑
    select
      (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 6))
        (trunc 8 (lshr e (const? 16 8)) { «nsw» := false, «nuw» := true }))
      (trunc 8 e) (select (icmp IntPredicate.sgt e (const? 16 (-1))) (const? 8 127) (const? 8 (-128))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem badimm3_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 14))) (const? 8 127)) ⊑
    select (icmp IntPredicate.ult (add e (const? 16 128)) (const? 16 256)) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 14)) { «nsw» := true, «nuw» := false }) (const? 8 127)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem badimm4_thm (e : IntW 16) :
  select (icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 126)) ⊑
    select (icmp IntPredicate.sgt e (const? 16 127)) (const? 8 126)
      (select (icmp IntPredicate.slt e (const? 16 (-128))) (const? 8 (-127)) (trunc 8 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem C0zero_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.ult (add e_2 (const? 8 10)) (const? 8 0)) e_2
      (select (icmp IntPredicate.slt e_2 (const? 8 (-10))) e_1 e) ⊑
    select (icmp IntPredicate.slt e_2 (const? 8 (-10))) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry



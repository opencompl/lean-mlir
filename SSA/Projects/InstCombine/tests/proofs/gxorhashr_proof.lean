
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gxorhashr_proof
theorem testi8i8_thm (e : IntW 8) :
  LLVM.xor (ashr e (const? 8 7)) (const? 8 127) ⊑
    select (icmp IntPred.sgt e (const? 8 (-1))) (const? 8 127) (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi16i8_thm (e : IntW 16) :
  LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 27) ⊑
    select (icmp IntPred.sgt e (const? 16 (-1))) (const? 8 27) (const? 8 (-28)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi64i32_thm (e : IntW 64) :
  LLVM.xor (trunc 32 (ashr e (const? 64 63))) (const? 32 127) ⊑
    select (icmp IntPred.sgt e (const? 64 (-1))) (const? 32 127) (const? 32 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi128i128_thm (e : IntW 128) :
  LLVM.xor (ashr e (const? 128 127)) (const? 128 27) ⊑
    select (icmp IntPred.sgt e (const? 128 (-1))) (const? 128 27) (const? 128 (-28)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem wrongimm_thm (e : IntW 16) :
  LLVM.xor (trunc 8 (ashr e (const? 16 14))) (const? 8 27) ⊑
    LLVM.xor (trunc 8 (ashr e (const? 16 14)) { «nsw» := true, «nuw» := false }) (const? 8 27) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry

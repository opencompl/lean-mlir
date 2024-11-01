
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gxorhashr_proof
theorem testi8i8_thm (e : IntW 8) :
  LLVM.xor (ashr e (const? 7)) (const? 127) ⊑
    select (icmp IntPredicate.sgt e (const? (-1))) (const? 127) (const? (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi16i8_thm (e : IntW 16) :
  LLVM.xor (trunc 8 (ashr e (const? 15))) (const? 27) ⊑
    select (icmp IntPredicate.sgt e (const? (-1))) (const? 27) (const? (-28)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi64i32_thm (e : IntW 64) :
  LLVM.xor (trunc 32 (ashr e (const? 63))) (const? 127) ⊑
    select (icmp IntPredicate.sgt e (const? (-1))) (const? 127) (const? (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi128i128_thm (e : IntW 128) :
  LLVM.xor (ashr e (const? 127)) (const? 27) ⊑
    select (icmp IntPredicate.sgt e (const? (-1))) (const? 27) (const? (-28)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry




import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphtopbitssame_proof
theorem testi16i8_thm (e : IntW 16) :
  icmp IntPredicate.eq (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 8))) ⊑
    icmp IntPredicate.ult (add e (const? 128)) (const? 256) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi16i8_com_thm (e : IntW 16) :
  icmp IntPredicate.eq (trunc 8 (lshr e (const? 8))) (ashr (trunc 8 e) (const? 7)) ⊑
    icmp IntPredicate.ult (add e (const? 128)) (const? 256) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi16i8_ne_thm (e : IntW 16) :
  icmp IntPredicate.ne (ashr (trunc 8 e) (const? 7)) (trunc 8 (lshr e (const? 8))) ⊑
    icmp IntPredicate.ult (add e (const? (-128))) (const? (-256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi16i8_ne_com_thm (e : IntW 16) :
  icmp IntPredicate.ne (trunc 8 (lshr e (const? 8))) (ashr (trunc 8 e) (const? 7)) ⊑
    icmp IntPredicate.ult (add e (const? (-128))) (const? (-256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi64i32_thm (e : IntW 64) :
  icmp IntPredicate.eq (ashr (trunc 32 e) (const? 31)) (trunc 32 (lshr e (const? 32))) ⊑
    icmp IntPredicate.ult (add e (const? 2147483648)) (const? 4294967296) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem testi64i32_ne_thm (e : IntW 64) :
  icmp IntPredicate.ne (ashr (trunc 32 e) (const? 31)) (trunc 32 (lshr e (const? 32))) ⊑
    icmp IntPredicate.ult (add e (const? (-2147483648))) (const? (-4294967296)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry




import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthrem2_proof
theorem test1_thm (x : BitVec 333) :
  (if 70368744177664 % 2 ^ 333 = 0 then none else some (BitVec.ofNat 333 (x.toNat % (70368744177664 % 2 ^ 333)))) ⊑
    some (x &&& 70368744177663#333) := sorry

theorem test2_thm (x : BitVec 499) :
  (Option.bind (if 499 ≤ 111 % 2 ^ 499 then none else some (4096#499 <<< (111 % 2 ^ 499))) fun a =>
      if a.toNat = 0 then none else some (BitVec.ofNat 499 (x.toNat % a.toNat))) ⊑
    some (x &&& 10633823966279326983230456482242756607#499) := sorry


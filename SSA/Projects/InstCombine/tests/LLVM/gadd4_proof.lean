
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gadd4_proof
theorem match_andAsRem_lshrAsDiv_shlAsMul_thm (x : BitVec 64) :
  (x &&& 63#64) + BitVec.ofNat 64 (x.toNat >>> 6 % 9) <<< 6 = BitVec.ofNat 64 (x.toNat % 576) := sorry

theorem match_signed_thm (x : BitVec 64) :
  x - x.sdiv 299#64 * 299#64 + (x.sdiv 299#64 - (x.sdiv 299#64).sdiv 64#64 * 64#64) * 299#64 +
      (x.sdiv 19136#64 - (x.sdiv 19136#64).sdiv 9#64 * 9#64) * 19136#64 =
    x - x.sdiv 172224#64 * 172224#64 := sorry

theorem not_match_inconsistent_signs_thm (x : BitVec 64) :
  BitVec.ofNat 64 ((x.sdiv 299#64).toNat % 64) * 299#64 = (x.sdiv 299#64 &&& 63#64) * 299#64 := sorry

theorem fold_add_sdiv_srem_thm (x : BitVec 32) : x.sdiv 10#32 <<< 4 + (x - x.sdiv 10#32 * 10#32) = x.sdiv 10#32 * 6#32 + x := sorry


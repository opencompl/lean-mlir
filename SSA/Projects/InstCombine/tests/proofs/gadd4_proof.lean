
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gadd4_proof
theorem match_unsigned_thm (x : BitVec 64) : x % 299#64 + x / 299#64 % 64#64 * 299#64 = x % 19136#64 := sorry

theorem match_andAsRem_lshrAsDiv_shlAsMul_thm (x : BitVec 64) : (x &&& 63#64) + (x >>> 6 % 9#64) <<< 6 = x % 576#64 := sorry

theorem match_signed_thm (x : BitVec 64) :
  x - x.sdiv 299#64 * 299#64 + (x.sdiv 299#64 - (x.sdiv 299#64).sdiv 64#64 * 64#64) * 299#64 +
      (x.sdiv 19136#64 - (x.sdiv 19136#64).sdiv 9#64 * 9#64) * 19136#64 =
    x - x.sdiv 172224#64 * 172224#64 := sorry

theorem not_match_inconsistent_signs_thm (x : BitVec 64) :
  some (x % 299#64 + x.sdiv 299#64 % 64#64 * 299#64) ⊑
    (if
            signExtend 128 (x.sdiv 299#64 &&& 63#64) * 299#128 < signExtend 128 (twoPow 64 63) ∨
              twoPow 128 63 ≤ signExtend 128 (x.sdiv 299#64 &&& 63#64) * 299#128 then
          none
        else
          if twoPow 128 63 <<< 1 ≤ (setWidth 128 (x.sdiv 299#64) &&& 63#128) * 299#128 then none
          else some ((x.sdiv 299#64 &&& 63#64) * 299#64)).bind
      fun y' =>
      if (x % 299#64).msb = y'.msb ∧ ¬(x % 299#64 + y').msb = (x % 299#64).msb then none
      else if x % 299#64 + y' < x % 299#64 ∨ x % 299#64 + y' < y' then none else some (x % 299#64 + y') := sorry

theorem not_match_inconsistent_values_thm (x : BitVec 64) :
  some (x % 299#64 + x / 29#64 % 64#64 * 299#64) ⊑
    (if
            signExtend 128 (x / 29#64 &&& 63#64) * 299#128 < signExtend 128 (twoPow 64 63) ∨
              twoPow 128 63 ≤ signExtend 128 (x / 29#64 &&& 63#64) * 299#128 then
          none
        else
          if twoPow 128 63 <<< 1 ≤ (setWidth 128 (x / 29#64) &&& 63#128) * 299#128 then none
          else some ((x / 29#64 &&& 63#64) * 299#64)).bind
      fun y' =>
      if (x % 299#64).msb = y'.msb ∧ ¬(x % 299#64 + y').msb = (x % 299#64).msb then none
      else if x % 299#64 + y' < x % 299#64 ∨ x % 299#64 + y' < y' then none else some (x % 299#64 + y') := sorry

theorem fold_add_udiv_urem_thm (x : BitVec 32) :
  some ((x / 10#32) <<< 4 + x % 10#32) ⊑
    (if twoPow 64 31 <<< 1 ≤ setWidth 64 (x / 10#32) * 6#64 then none else some (x / 10#32 * 6#32)).bind fun a =>
      some (a + x) := sorry

theorem fold_add_sdiv_srem_thm (x : BitVec 32) :
  some (x.sdiv 10#32 <<< 4 + (x - x.sdiv 10#32 * 10#32)) ⊑
    (if
            signExtend 64 (x.sdiv 10#32) * 6#64 < signExtend 64 (twoPow 32 31) ∨
              twoPow 64 31 ≤ signExtend 64 (x.sdiv 10#32) * 6#64 then
          none
        else some (x.sdiv 10#32 * 6#32)).bind
      fun a => some (a + x) := sorry

theorem fold_add_udiv_urem_to_mul_thm (x : BitVec 32) : x / 7#32 * 21#32 + x % 7#32 * 3#32 = x * 3#32 := sorry

theorem fold_add_udiv_urem_commuted_thm (x : BitVec 32) :
  some (x % 10#32 + (x / 10#32) <<< 4) ⊑
    (if twoPow 64 31 <<< 1 ≤ setWidth 64 (x / 10#32) * 6#64 then none else some (x / 10#32 * 6#32)).bind fun a =>
      some (a + x) := sorry

theorem fold_add_udiv_urem_or_disjoint_thm (x : BitVec 32) :
  some ((x / 10#32) <<< 4 ||| x % 10#32) ⊑
    (if twoPow 64 31 <<< 1 ≤ setWidth 64 (x / 10#32) * 6#64 then none else some (x / 10#32 * 6#32)).bind fun a =>
      some (a + x) := sorry

theorem fold_add_udiv_urem_without_noundef_thm (x : BitVec 32) : (x / 10#32) <<< 4 + x % 10#32 = (x / 10#32) <<< 4 ||| x % 10#32 := sorry


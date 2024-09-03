
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshlhdemand_proof
theorem src_srem_shl_demand_max_signbit_thm (x : BitVec 32) :
  (x - x.sdiv 2#32 * 2#32) <<< 30 &&& 2147483648#32 = x - x.sdiv 2#32 * 2#32 &&& 2147483648#32 := sorry

theorem src_srem_shl_demand_min_signbit_thm (x : BitVec 32) :
  (x - x.sdiv 1073741823#32 * 1073741823#32) <<< 1 &&& 2147483648#32 =
    x - x.sdiv 1073741823#32 * 1073741823#32 &&& 2147483648#32 := sorry

theorem src_srem_shl_demand_max_mask_thm (x : BitVec 32) :
  (x - x.sdiv 2#32 * 2#32) <<< 1 &&& 4294967292#32 = x - x.sdiv 2#32 * 2#32 &&& 4294967292#32 := sorry

theorem set_shl_mask_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some ((x_1 ||| 196609#32) <<< x.toNat)) fun a => some (a &&& 65536#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some ((x_1 ||| 65537#32) <<< x.toNat)) fun a =>
      some (a &&& 65536#32) := sorry



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

theorem src_srem_shl_demand_max_signbit_mask_hit_first_demand_thm (x : BitVec 32) :
  some ((x - x.sdiv 4#32 * 4#32) <<< 29 &&& 3221225472#32) ⊑
    (if ((x - x.sdiv 4#32 * 4#32) <<< 29).sshiftRight 29 = x - x.sdiv 4#32 * 4#32 then none
        else some ((x - x.sdiv 4#32 * 4#32) <<< 29)).bind
<<<<<<< HEAD
      fun x' => some (x' &&& 3221225472#32) := sorry
=======
      fun a => some (a &&& 3221225472#32) := sorry
>>>>>>> 43a49182 (re-ran scripts)

theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_thm (x : BitVec 32) :
  some ((x - x.sdiv 536870912#32 * 536870912#32) <<< 1 &&& 3221225474#32) ⊑
    (if ((x - x.sdiv 536870912#32 * 536870912#32) <<< 1).sshiftRight 1 = x - x.sdiv 536870912#32 * 536870912#32 then
          none
        else some ((x - x.sdiv 536870912#32 * 536870912#32) <<< 1)).bind
<<<<<<< HEAD
      fun x' => some (x' &&& 3221225474#32) := sorry
=======
      fun a => some (a &&& 3221225474#32) := sorry
>>>>>>> 43a49182 (re-ran scripts)

theorem src_srem_shl_demand_eliminate_signbit_thm (x : BitVec 32) :
  some ((x - x.sdiv 1073741824#32 * 1073741824#32) <<< 1 &&& 2#32) ⊑
    (if ((x - x.sdiv 1073741824#32 * 1073741824#32) <<< 1).sshiftRight 1 = x - x.sdiv 1073741824#32 * 1073741824#32 then
          none
        else some ((x - x.sdiv 1073741824#32 * 1073741824#32) <<< 1)).bind
<<<<<<< HEAD
      fun x' => some (x' &&& 2#32) := sorry
=======
      fun a => some (a &&& 2#32) := sorry
>>>>>>> 43a49182 (re-ran scripts)

theorem src_srem_shl_demand_max_mask_hit_demand_thm (x : BitVec 32) :
  some ((x - x.sdiv 4#32 * 4#32) <<< 1 &&& 4294967292#32) ⊑
    (if ((x - x.sdiv 4#32 * 4#32) <<< 1).sshiftRight 1 = x - x.sdiv 4#32 * 4#32 then none
        else some ((x - x.sdiv 4#32 * 4#32) <<< 1)).bind
<<<<<<< HEAD
      fun x' => some (x' &&& 4294967292#32) := sorry

theorem set_shl_mask_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((x_1 ||| 196609#32) <<< x.toNat)) fun x' => some (x' &&& 65536#32)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((x_1 ||| 65537#32) <<< x.toNat)) fun x' =>
      some (x' &&& 65536#32) := sorry
=======
      fun a => some (a &&& 4294967292#32) := sorry

theorem set_shl_mask_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((x_1 ||| 196609#32) <<< x.toNat)) fun a => some (a &&& 65536#32)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((x_1 ||| 65537#32) <<< x.toNat)) fun a =>
      some (a &&& 65536#32) := sorry
>>>>>>> 43a49182 (re-ran scripts)


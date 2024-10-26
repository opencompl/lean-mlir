
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
      fun x' => some (x' &&& 3221225472#32) := sorry

theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_thm (x : BitVec 32) :
  some ((x - x.sdiv 536870912#32 * 536870912#32) <<< 1 &&& 3221225474#32) ⊑
    (if ((x - x.sdiv 536870912#32 * 536870912#32) <<< 1).sshiftRight 1 = x - x.sdiv 536870912#32 * 536870912#32 then
          none
        else some ((x - x.sdiv 536870912#32 * 536870912#32) <<< 1)).bind
      fun x' => some (x' &&& 3221225474#32) := sorry

theorem src_srem_shl_demand_eliminate_signbit_thm (x : BitVec 32) :
  some ((x - x.sdiv 1073741824#32 * 1073741824#32) <<< 1 &&& 2#32) ⊑
    (if ((x - x.sdiv 1073741824#32 * 1073741824#32) <<< 1).sshiftRight 1 = x - x.sdiv 1073741824#32 * 1073741824#32 then
          none
        else some ((x - x.sdiv 1073741824#32 * 1073741824#32) <<< 1)).bind
      fun x' => some (x' &&& 2#32) := sorry

theorem src_srem_shl_demand_max_mask_hit_demand_thm (x : BitVec 32) :
  some ((x - x.sdiv 4#32 * 4#32) <<< 1 &&& 4294967292#32) ⊑
    (if ((x - x.sdiv 4#32 * 4#32) <<< 1).sshiftRight 1 = x - x.sdiv 4#32 * 4#32 then none
        else some ((x - x.sdiv 4#32 * 4#32) <<< 1)).bind
      fun x' => some (x' &&& 4294967292#32) := sorry

theorem sext_shl_trunc_same_size_thm (x : BitVec 32) (x_1 : BitVec 16) :
  (Option.bind (if 32#32 ≤ x then none else some (signExtend 32 x_1 <<< x.toNat)) fun x' => some (setWidth 16 x')) ⊑
    Option.bind (if 32#32 ≤ x then none else some (setWidth 32 x_1 <<< x.toNat)) fun x' =>
      some (setWidth 16 x') := sorry

theorem sext_shl_trunc_smaller_thm (x : BitVec 32) (x_1 : BitVec 16) :
  (Option.bind (if 32#32 ≤ x then none else some (signExtend 32 x_1 <<< x.toNat)) fun x' => some (setWidth 5 x')) ⊑
    Option.bind (if 32#32 ≤ x then none else some (setWidth 32 x_1 <<< x.toNat)) fun x' => some (setWidth 5 x') := sorry

theorem sext_shl_mask_thm (x : BitVec 32) (x_1 : BitVec 16) :
  (Option.bind (if 32#32 ≤ x then none else some (signExtend 32 x_1 <<< x.toNat)) fun x' => some (x' &&& 65535#32)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (setWidth 32 x_1 <<< x.toNat)) fun x' =>
      some (x' &&& 65535#32) := sorry

theorem set_shl_mask_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((x_1 ||| 196609#32) <<< x.toNat)) fun x' => some (x' &&& 65536#32)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((x_1 ||| 65537#32) <<< x.toNat)) fun x' =>
      some (x' &&& 65536#32) := sorry

theorem must_drop_poison_thm (x x_1 : BitVec 32) :
  ((if ((x_1 &&& 255#32) <<< x.toNat).sshiftRight x.toNat = x_1 &&& 255#32 then none
        else
          if (x_1 &&& 255#32) <<< x.toNat >>> x.toNat = x_1 &&& 255#32 then none
          else if 32#32 ≤ x then none else some ((x_1 &&& 255#32) <<< x.toNat)).bind
      fun x' => some (setWidth 8 x')) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_1 <<< x.toNat)) fun x' => some (setWidth 8 x') := sorry

theorem f_t15_t01_t09_thm (x : BitVec 40) :
  setWidth 32 (x.sshiftRight 31) <<< 16 = setWidth 32 (x.sshiftRight 15) &&& 4294901760#32 := sorry


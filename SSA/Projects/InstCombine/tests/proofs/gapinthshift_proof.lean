
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthshift_proof
theorem test6_thm (x : BitVec 55) : x <<< 1 * 3#55 = x * 6#55 := sorry

theorem test6a_thm (x : BitVec 55) : (x * 3#55) <<< 1 = x * 6#55 := sorry

theorem test7_thm (x : BitVec 8) :
  (if 29#29 ≤ setWidth 29 x then none else some ((536870911#29).sshiftRight (x.toNat % 536870912))) ⊑
    some 536870911#29 := sorry

theorem test8_thm (x : BitVec 7) : x <<< 7 = 0#7 := by bv_compare'

theorem test9_thm (x : BitVec 17) : x <<< 16 >>> 16 = x &&& 1#17 := by bv_compare'

theorem test11_thm (x : BitVec 23) : (x * 3#23) >>> 11 <<< 12 = x * 6#23 &&& 8384512#23 := by bv_compare'

theorem test12_thm (x : BitVec 47) : x.sshiftRight 8 <<< 8 = x &&& 140737488355072#47 := by bv_compare'

theorem test13_thm (x : BitVec 18) : (x * 3#18).sshiftRight 8 <<< 9 = x * 6#18 &&& 261632#18 := by bv_compare'

theorem test14_thm (x : BitVec 35) : (x >>> 4 ||| 1234#35) <<< 4 = x &&& 34359718608#35 ||| 19744#35 := by bv_compare'

theorem test14a_thm (x : BitVec 79) : (x <<< 4 &&& 1234#79) >>> 4 = x &&& 77#79 := by bv_compare'

theorem test15_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#45
      | some { toFin := ⟨0, ⋯⟩ } => some 1#45)
      fun x' => some (x' <<< 2)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 12#45
    | some { toFin := ⟨0, ⋯⟩ } => some 4#45 := sorry

theorem test15a_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#8
      | some { toFin := ⟨0, ⋯⟩ } => some 1#8)
      fun x => if 53#53 ≤ setWidth 53 x then none else some (64#53 <<< (x.toNat % 9007199254740992))) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 512#53
    | some { toFin := ⟨0, ⋯⟩ } => some 128#53 := sorry

theorem test23_thm (x : BitVec 44) : setWidth 11 ((x <<< 33).sshiftRight 33) = setWidth 11 x := sorry

theorem shl_lshr_eq_amt_multi_use_thm (x : BitVec 44) : x <<< 33 + x <<< 33 >>> 33 = x <<< 33 ||| x &&& 2047#44 := by bv_compare'

theorem test25_thm (x x_1 : BitVec 37) :
  (x_1 &&& 137438822400#37) + (x &&& 137438822400#37) = x + (x_1 &&& 137438822400#37) &&& 137438822400#37 := by bv_compare'

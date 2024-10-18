
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthshift_proof
theorem test6_thm (x : BitVec 55) : x <<< 1 * 3#55 = x * 6#55 := sorry

theorem test6a_thm (x : BitVec 55) : (x * 3#55) <<< 1 = x * 6#55 := sorry

theorem test8_thm (x : BitVec 7) : x <<< 7 = 0#7 := sorry

theorem test9_thm (x : BitVec 17) : x <<< 16 >>> 16 = x &&& 1#17 := sorry

theorem test11_thm (x : BitVec 23) : (x * 3#23) >>> 11 <<< 12 = x * 6#23 &&& 8384512#23 := sorry

theorem test12_thm (x : BitVec 47) : x.sshiftRight 8 <<< 8 = x &&& 140737488355072#47 := sorry

theorem test13_thm (x : BitVec 18) : (x * 3#18).sshiftRight 8 <<< 9 = x * 6#18 &&& 261632#18 := sorry

theorem test14_thm (x : BitVec 35) : (x >>> 4 ||| 1234#35) <<< 4 = x &&& 34359718608#35 ||| 19744#35 := sorry

theorem test14a_thm (x : BitVec 79) : (x <<< 4 &&& 1234#79) >>> 4 = x &&& 77#79 := sorry

<<<<<<< HEAD
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

=======
>>>>>>> 4bf2f937 (Re-ran the sccripts)
theorem shl_lshr_eq_amt_multi_use_thm (x : BitVec 44) : x <<< 33 + x <<< 33 >>> 33 = x <<< 33 ||| x &&& 2047#44 := sorry

theorem test25_thm (x x_1 : BitVec 37) :
  (x_1 &&& 137438822400#37) + (x &&& 137438822400#37) = x + (x_1 &&& 137438822400#37) &&& 137438822400#37 := sorry



import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section grem_proof
theorem test3_thm (x : BitVec 32) : x % 8#32 = x &&& 7#32 := by bv_compare'

theorem test4_thm (x : BitVec 1) (x_1 : BitVec 32) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 1#32
      | some { toFin := ⟨0, ⋯⟩ } => some 8#32)
      fun y' => if y' = 0#32 then none else some (x_1 % y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#32
      | some { toFin := ⟨0, ⋯⟩ } => some 7#32)
      fun y' => some (x_1 &&& y') := sorry

theorem test5_thm (x : BitVec 8) (x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ setWidth 32 x then none else some (32#32 <<< (x.toNat % 4294967296))) fun y' =>
      if y' = 0#32 then none else some (x_1 % y')) ⊑
    (if 32#32 <<< (x.toNat % 4294967296) >>> (x.toNat % 4294967296) = 32#32 then none
        else if 32#32 ≤ setWidth 32 x then none else some (32#32 <<< (x.toNat % 4294967296))).bind
      fun x => some (x_1 &&& x + 4294967295#32) := sorry

theorem test7_thm (x : BitVec 32) : x * 8#32 - (x * 8#32).sdiv 4#32 * 4#32 = 0#32 := by bv_compare'

theorem test8_thm (x : BitVec 32) : x <<< 4 - (x <<< 4).sdiv 8#32 * 8#32 = 0#32 := sorry

theorem test9_thm (x : BitVec 32) : x * 64#32 % 32#32 = 0#32 := sorry

theorem test11_thm (x : BitVec 32) : (x &&& 4294967294#32) * 2#32 % 4#32 = 0#32 := sorry

theorem test12_thm (x : BitVec 32) : (x &&& 4294967292#32) - (x &&& 4294967292#32).sdiv 2#32 * 2#32 = 0#32 := by bv_compare'

theorem test13_thm (x : BitVec 32) :
  Option.map (fun div => x - div * x)
      (if x = 0#32 ∨ x = intMin 32 ∧ x = 4294967295#32 then none else some (if x = 0#32 then 0#32 else 1#32)) ⊑
    some 0#32 := sorry

theorem test16_thm (x x_1 : BitVec 32) :
  (if (x >>> 11 &&& 4#32) + 4#32 = 0#32 then none else some (x_1 % ((x >>> 11 &&& 4#32) + 4#32))) ⊑
    some (x_1 &&& (x >>> 11 &&& 4#32 ||| 3#32)) := by bv_compare'

theorem test19_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun a =>
      Option.bind (if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)) fun a_1 =>
        Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x =>
          if (a &&& a_1) + x = 0#32 then none else some (x_1 % ((a &&& a_1) + x))) ⊑
    (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun a =>
      (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
        fun a_1 =>
        (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
          fun x => some (x_1 &&& (a &&& a_1) + x + 4294967295#32) := by bv_compare'

theorem test19_commutative0_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)) fun a =>
      Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun a_1 =>
        Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x =>
          if (a &&& a_1) + x = 0#32 then none else some (x_1 % ((a &&& a_1) + x))) ⊑
    (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
        else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a =>
      (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
        fun a_1 =>
        (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
          fun x => some (x_1 &&& (a &&& a_1) + x + 4294967295#32) := by bv_compare'

theorem test19_commutative1_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun a =>
      Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun a_1 =>
        Option.bind (if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)) fun x =>
          if a + (a_1 &&& x) = 0#32 then none else some (x_1 % (a + (a_1 &&& x)))) ⊑
    (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun a =>
      (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
        fun a_1 =>
        (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
            else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
          fun x => some (x_1 &&& a + (a_1 &&& x) + 4294967295#32) := by bv_compare'

theorem test19_commutative2_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun a =>
      Option.bind (if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)) fun a_1 =>
        Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x =>
          if a + (a_1 &&& x) = 0#32 then none else some (x_1 % (a + (a_1 &&& x)))) ⊑
    (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun a =>
      (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
        fun a_1 =>
        (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
          fun x => some (x_1 &&& a + (a_1 &&& x) + 4294967295#32) := by bv_compare'

theorem test22_thm (x : BitVec 32) :
  (x &&& 2147483647#32) - (x &&& 2147483647#32).sdiv 2147483647#32 * 2147483647#32 =
    (x &&& 2147483647#32) % 2147483647#32 := by bv_compare'

theorem srem_constant_dividend_select_of_constants_divisor_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 12#32
      | some { toFin := ⟨0, ⋯⟩ } => some 4294967293#32)
      fun y' =>
      Option.map (fun div => 42#32 - div * y')
        (if y' = 0#32 ∨ 42#32 = intMin 32 ∧ y' = 4294967295#32 then none else some ((42#32).sdiv y'))) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 6#32
    | some { toFin := ⟨0, ⋯⟩ } => some 0#32 := by bv_compare'

theorem srem_constant_dividend_select_of_constants_divisor_0_arm_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 12#32
      | some { toFin := ⟨0, ⋯⟩ } => some 0#32)
      fun y' =>
      Option.map (fun div => 42#32 - div * y')
        (if y' = 0#32 ∨ 42#32 = intMin 32 ∧ y' = 4294967295#32 then none else some ((42#32).sdiv y'))) ⊑
    some 6#32 := by bv_compare'

theorem urem_constant_dividend_select_of_constants_divisor_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 12#32
      | some { toFin := ⟨0, ⋯⟩ } => some 4294967293#32)
      fun y' => if y' = 0#32 then none else some (42#32 % y')) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 6#32
    | some { toFin := ⟨0, ⋯⟩ } => some 42#32 := by bv_compare'

theorem urem_constant_dividend_select_of_constants_divisor_0_arm_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 12#32
      | some { toFin := ⟨0, ⋯⟩ } => some 0#32)
      fun y' => if y' = 0#32 then none else some (42#32 % y')) ⊑
    some 6#32 := by bv_compare'

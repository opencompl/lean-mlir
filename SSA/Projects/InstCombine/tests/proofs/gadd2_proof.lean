
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gadd2_proof
theorem test2_thm (x : BitVec 32) : (x &&& 7#32) + (x &&& 32#32) = x &&& 39#32 := sorry

theorem test3_thm (x : BitVec 32) : (x &&& 128#32) + x >>> 30 = x &&& 128#32 ||| x >>> 30 := sorry

theorem test4_thm (x : BitVec 32) :
  (if x + x < x then none else some (x + x)) ⊑ if x <<< 1 >>> 1 = x then none else some (x <<< 1) := sorry

theorem test9_thm (x : BitVec 16) : x * 2#16 + x * 32767#16 = x * 32769#16 := sorry

theorem test10_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x.sshiftRight 3 ||| 2863311530#32) ^^^ 1431655765#32) =
    x_1 - (x.sshiftRight 3 &&& 1431655765#32) := sorry

theorem test11_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x ||| 2863311530#32) ^^^ 1431655765#32) = x_1 - (x &&& 1431655765#32) := sorry

theorem test12_thm (x x_1 : BitVec 32) :
  ((if x_1.msb = false ∧ ¬(x_1 + 1#32).msb = x_1.msb then none else some (x_1 + 1#32)).bind fun a =>
      if
          a.msb = ((x.msb || (2863311530#32).msb) ^^ (1431655765#32).msb) ∧
            ¬(a + ((x ||| 2863311530#32) ^^^ 1431655765#32)).msb = a.msb then
        none
      else some (a + ((x ||| 2863311530#32) ^^^ 1431655765#32))) ⊑
    some (x_1 - (x &&& 1431655765#32)) := sorry

theorem test13_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x ||| 2863311529#32) ^^^ 1431655766#32) = x_1 - (x &&& 1431655766#32) := sorry

theorem test14_thm (x x_1 : BitVec 32) :
  ((if x_1.msb = false ∧ ¬(x_1 + 1#32).msb = x_1.msb then none else some (x_1 + 1#32)).bind fun a =>
      if
          a.msb = ((x.msb || (2863311529#32).msb) ^^ (1431655766#32).msb) ∧
            ¬(a + ((x ||| 2863311529#32) ^^^ 1431655766#32)).msb = a.msb then
        none
      else some (a + ((x ||| 2863311529#32) ^^^ 1431655766#32))) ⊑
    some (x_1 - (x &&& 1431655766#32)) := sorry

theorem test15_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + (x &&& 2863311529#32 ^^^ 2863311529#32) = x_1 - (x ||| 1431655766#32) := sorry

theorem test16_thm (x x_1 : BitVec 32) :
  ((if x_1.msb = false ∧ ¬(x_1 + 1#32).msb = x_1.msb then none else some (x_1 + 1#32)).bind fun a =>
      if
          a.msb = (x.msb && (2863311529#32).msb ^^ (2863311529#32).msb) ∧
            ¬(a + (x &&& 2863311529#32 ^^^ 2863311529#32)).msb = a.msb then
        none
      else some (a + (x &&& 2863311529#32 ^^^ 2863311529#32))) ⊑
    some (x_1 - (x ||| 1431655766#32)) := sorry

theorem test17_thm (x x_1 : BitVec 32) :
  (if
        (x_1.msb && (2863311530#32).msb ^^ (2863311531#32).msb) = x.msb ∧
          ¬((x_1 &&& 2863311530#32 ^^^ 2863311531#32) + x).msb =
              (x_1.msb && (2863311530#32).msb ^^ (2863311531#32).msb) then
      none
    else some ((x_1 &&& 2863311530#32 ^^^ 2863311531#32) + x)) ⊑
    some (x - (x_1 ||| 1431655765#32)) := sorry

theorem test18_thm (x x_1 : BitVec 32) :
  ((if x_1.msb = false ∧ ¬(x_1 + 1#32).msb = x_1.msb then none else some (x_1 + 1#32)).bind fun a =>
      if
          a.msb = (x.msb && (2863311530#32).msb ^^ (2863311530#32).msb) ∧
            ¬(a + (x &&& 2863311530#32 ^^^ 2863311530#32)).msb = a.msb then
        none
      else some (a + (x &&& 2863311530#32 ^^^ 2863311530#32))) ⊑
    some (x_1 - (x ||| 1431655765#32)) := sorry

theorem add_nsw_mul_nsw_thm (x : BitVec 16) :
  ((if (x + x).msb = x.msb then some (x + x) else none).bind fun a =>
      if a.msb = x.msb ∧ ¬(a + x).msb = a.msb then none else some (a + x)) ⊑
    if signExtend 32 x * 3#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 3#32 then none
    else some (x * 3#16) := sorry

theorem mul_add_to_mul_1_thm (x : BitVec 16) :
  ((if signExtend 32 x * 8#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 8#32 then none
        else some (x * 8#16)).bind
      fun y' => if x.msb = y'.msb ∧ ¬(x + y').msb = x.msb then none else some (x + y')) ⊑
    if signExtend 32 x * 9#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 9#32 then none
    else some (x * 9#16) := sorry

theorem mul_add_to_mul_2_thm (x : BitVec 16) :
  ((if signExtend 32 x * 8#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 8#32 then none
        else some (x * 8#16)).bind
      fun a => if a.msb = x.msb ∧ ¬(a + x).msb = a.msb then none else some (a + x)) ⊑
    if signExtend 32 x * 9#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 9#32 then none
    else some (x * 9#16) := sorry

theorem mul_add_to_mul_3_thm (x : BitVec 16) :
  (if (x * 2#16).msb = (x * 3#16).msb ∧ ¬(x * 2#16 + x * 3#16).msb = (x * 2#16).msb then none
    else some (x * 2#16 + x * 3#16)) ⊑
    some (x * 5#16) := sorry

theorem mul_add_to_mul_4_thm (x : BitVec 16) :
  ((if signExtend 32 x * 2#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 2#32 then none
        else some (x * 2#16)).bind
      fun a =>
      (if signExtend 32 x * 7#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 7#32 then none
          else some (x * 7#16)).bind
        fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    if signExtend 32 x * 9#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 9#32 then none
    else some (x * 9#16) := sorry

theorem mul_add_to_mul_5_thm (x : BitVec 16) :
  ((if signExtend 32 x * 3#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 3#32 then none
        else some (x * 3#16)).bind
      fun a =>
      (if signExtend 32 x * 7#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 7#32 then none
          else some (x * 7#16)).bind
        fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    if signExtend 32 x * 10#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 10#32 then none
    else some (x * 10#16) := sorry

theorem mul_add_to_mul_6_thm (x x_1 : BitVec 32) :
  ((if
            signExtend 64 x_1 * signExtend 64 x < signExtend 64 (twoPow 32 31) ∨
              twoPow 64 31 ≤ signExtend 64 x_1 * signExtend 64 x then
          none
        else some (x_1 * x)).bind
      fun a =>
      (if
              signExtend 64 x_1 * signExtend 64 x < signExtend 64 (twoPow 32 31) ∨
                twoPow 64 31 ≤ signExtend 64 x_1 * signExtend 64 x then
            none
          else some (x_1 * x)).bind
        fun x =>
        (if signExtend 64 x * 5#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 5#64 then none
            else some (x * 5#32)).bind
          fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    (if
            signExtend 64 x_1 * signExtend 64 x < signExtend 64 (twoPow 32 31) ∨
              twoPow 64 31 ≤ signExtend 64 x_1 * signExtend 64 x then
          none
        else some (x_1 * x)).bind
      fun x' =>
      if signExtend 64 x' * 6#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x' * 6#64 then none
      else some (x' * 6#32) := sorry

theorem mul_add_to_mul_7_thm (x : BitVec 16) :
  ((if signExtend 32 x * 32767#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 32767#32 then none
        else some (x * 32767#16)).bind
      fun y' => if x.msb = y'.msb ∧ ¬(x + y').msb = x.msb then none else some (x + y')) ⊑
    some (x <<< 15) := sorry

theorem mul_add_to_mul_8_thm (x : BitVec 16) :
  ((if signExtend 32 x * 16383#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 16383#32 then none
        else some (x * 16383#16)).bind
      fun a =>
      (if signExtend 32 x * 16384#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 16384#32 then
            none
          else some (x * 16384#16)).bind
        fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    if signExtend 32 x * 32767#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 32767#32 then none
    else some (x * 32767#16) := sorry

theorem mul_add_to_mul_9_thm (x : BitVec 16) :
  ((if signExtend 32 x * 16384#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 16384#32 then none
        else some (x * 16384#16)).bind
      fun a =>
      (if signExtend 32 x * 16384#32 < signExtend 32 (twoPow 16 15) ∨ twoPow 32 15 ≤ signExtend 32 x * 16384#32 then
            none
          else some (x * 16384#16)).bind
        fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    some (x <<< 15) := sorry

theorem add_or_and_thm (x x_1 : BitVec 32) : (x_1 ||| x) + (x_1 &&& x) = x_1 + x := sorry

theorem add_or_and_commutative_thm (x x_1 : BitVec 32) : (x_1 ||| x) + (x &&& x_1) = x_1 + x := sorry

theorem add_and_or_commutative_thm (x x_1 : BitVec 32) : (x_1 &&& x) + (x ||| x_1) = x + x_1 := sorry

theorem add_nsw_or_and_thm (x x_1 : BitVec 32) :
  (if (x_1.msb || x.msb) = (x_1.msb && x.msb) ∧ ¬((x_1 ||| x) + (x_1 &&& x)).msb = (x_1.msb || x.msb) then none
    else some ((x_1 ||| x) + (x_1 &&& x))) ⊑
    if x_1.msb = x.msb ∧ ¬(x_1 + x).msb = x_1.msb then none else some (x_1 + x) := sorry

theorem add_nuw_or_and_thm (x x_1 : BitVec 32) :
  (if (x_1 ||| x) + (x_1 &&& x) < x_1 ||| x ∨ (x_1 ||| x) + (x_1 &&& x) < x_1 &&& x then none
    else some ((x_1 ||| x) + (x_1 &&& x))) ⊑
    if x_1 + x < x_1 ∨ x_1 + x < x then none else some (x_1 + x) := sorry

theorem add_nuw_nsw_or_and_thm (x x_1 : BitVec 32) :
  (if (x_1.msb || x.msb) = (x_1.msb && x.msb) ∧ ¬((x_1 ||| x) + (x_1 &&& x)).msb = (x_1.msb || x.msb) then none
    else
      if (x_1 ||| x) + (x_1 &&& x) < x_1 ||| x ∨ (x_1 ||| x) + (x_1 &&& x) < x_1 &&& x then none
      else some ((x_1 ||| x) + (x_1 &&& x))) ⊑
    if x_1.msb = x.msb ∧ ¬(x_1 + x).msb = x_1.msb then none
    else if x_1 + x < x_1 ∨ x_1 + x < x then none else some (x_1 + x) := sorry

theorem add_of_mul_thm (x x_1 x_2 : BitVec 8) :
  ((if
            signExtend 16 x_2 * signExtend 16 x_1 < signExtend 16 (twoPow 8 7) ∨
              twoPow 16 7 ≤ signExtend 16 x_2 * signExtend 16 x_1 then
          none
        else some (x_2 * x_1)).bind
      fun a =>
      (if
              signExtend 16 x_2 * signExtend 16 x < signExtend 16 (twoPow 8 7) ∨
                twoPow 16 7 ≤ signExtend 16 x_2 * signExtend 16 x then
            none
          else some (x_2 * x)).bind
        fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    some (x_2 * (x_1 + x)) := sorry

<<<<<<< HEAD
theorem add_of_selects_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#32
      | some { toFin := ⟨0, ⋯⟩ } => some 4294967294#32)
      fun x' =>
      Option.bind
        (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some 2#32)
        fun y' => some (x' + y')) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 0#32 := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gadd2.lean:1092:17: theorem add_of_selects_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 0#32
        | some { toFin := ⟨0, ⋯⟩ } => some 4294967294#32)
        fun x' =>
        Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some x
          | some { toFin := ⟨0, ⋯⟩ } => some 2#32)
          fun y' => some (x' + y')) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some 0#32 := sorry

=======
>>>>>>> 1011dc2e (re-ran the tests)
theorem add_undemanded_low_bits_thm (x : BitVec 32) : ((x ||| 15#32) + 1616#32) >>> 4 = (x + 1616#32) >>> 4 := sorry

theorem sub_undemanded_low_bits_thm (x : BitVec 32) : ((x ||| 15#32) - 1616#32) >>> 4 = (x + 4294965680#32) >>> 4 := sorry


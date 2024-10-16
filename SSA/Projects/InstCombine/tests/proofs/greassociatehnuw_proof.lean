
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section greassociatehnuw_proof
theorem reassoc_add_nuw_thm (x : BitVec 32) :
<<<<<<< HEAD
  ((if x + 4#32 < x ∨ x + 4#32 < 4#32 then none else some (x + 4#32)).bind fun x' =>
      if x' + 64#32 < x' ∨ x' + 64#32 < 64#32 then none else some (x' + 64#32)) ⊑
    if x + 68#32 < x ∨ x + 68#32 < 68#32 then none else some (x + 68#32) := sorry

theorem reassoc_sub_nuw_thm (x : BitVec 32) :
  ((if x < 4#32 then none else some (x - 4#32)).bind fun x' => if x' < 64#32 then none else some (x' - 64#32)) ⊑
    some (x + 4294967228#32) := sorry

theorem reassoc_mul_nuw_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 4#64 then none else some (x * 4#32)).bind fun x' =>
      if twoPow 64 31 <<< 1 ≤ setWidth 64 x' * 65#64 then none else some (x' * 65#32)) ⊑
=======
  ((if x + 4#32 < x ∨ x + 4#32 < 4#32 then none else some (x + 4#32)).bind fun a =>
      if a + 64#32 < a ∨ a + 64#32 < 64#32 then none else some (a + 64#32)) ⊑
    if x + 68#32 < x ∨ x + 68#32 < 68#32 then none else some (x + 68#32) := sorry

theorem reassoc_sub_nuw_thm (x : BitVec 32) :
  ((if x < 4#32 then none else some (x - 4#32)).bind fun a => if a < 64#32 then none else some (a - 64#32)) ⊑
    some (x + 4294967228#32) := sorry

theorem reassoc_mul_nuw_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 4#64 then none else some (x * 4#32)).bind fun a =>
      if twoPow 64 31 <<< 1 ≤ setWidth 64 a * 65#64 then none else some (a * 65#32)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 260#64 then none else some (x * 260#32) := sorry

theorem no_reassoc_add_nuw_none_thm (x : BitVec 32) :
  (if x + 4#32 + 64#32 < x + 4#32 ∨ x + 4#32 + 64#32 < 64#32 then none else some (x + 4#32 + 64#32)) ⊑
    some (x + 68#32) := sorry

theorem no_reassoc_add_none_nuw_thm (x : BitVec 32) :
<<<<<<< HEAD
  ((if x + 4#32 < x ∨ x + 4#32 < 4#32 then none else some (x + 4#32)).bind fun x' => some (x' + 64#32)) ⊑
=======
  ((if x + 4#32 < x ∨ x + 4#32 < 4#32 then none else some (x + 4#32)).bind fun a => some (a + 64#32)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    some (x + 68#32) := sorry

theorem reassoc_x2_add_nuw_thm (x x_1 : BitVec 32) :
  ((if x_1 + 4#32 < x_1 ∨ x_1 + 4#32 < 4#32 then none else some (x_1 + 4#32)).bind fun a =>
<<<<<<< HEAD
      (if x + 8#32 < x ∨ x + 8#32 < 8#32 then none else some (x + 8#32)).bind fun y' =>
        if a + y' < a ∨ a + y' < y' then none else some (a + y')) ⊑
    (if x_1 + x < x_1 ∨ x_1 + x < x then none else some (x_1 + x)).bind fun x' =>
      if x' + 12#32 < x' ∨ x' + 12#32 < 12#32 then none else some (x' + 12#32) := sorry

theorem reassoc_x2_mul_nuw_thm (x x_1 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_1 * 5#64 then none else some (x_1 * 5#32)).bind fun a =>
      (if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 9#64 then none else some (x * 9#32)).bind fun y' =>
        if twoPow 64 31 <<< 1 ≤ setWidth 64 a * setWidth 64 y' then none else some (a * y')) ⊑
=======
      (if x + 8#32 < x ∨ x + 8#32 < 8#32 then none else some (x + 8#32)).bind fun a_1 =>
        if a + a_1 < a ∨ a + a_1 < a_1 then none else some (a + a_1)) ⊑
    (if x_1 + x < x_1 ∨ x_1 + x < x then none else some (x_1 + x)).bind fun a =>
      if a + 12#32 < a ∨ a + 12#32 < 12#32 then none else some (a + 12#32) := sorry

theorem reassoc_x2_mul_nuw_thm (x x_1 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_1 * 5#64 then none else some (x_1 * 5#32)).bind fun a =>
      (if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 9#64 then none else some (x * 9#32)).bind fun a_1 =>
        if twoPow 64 31 <<< 1 ≤ setWidth 64 a * setWidth 64 a_1 then none else some (a * a_1)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    if twoPow 64 31 <<< 1 ≤ setWidth 64 (x_1 * x) * 45#64 then none else some (x_1 * x * 45#32) := sorry

theorem reassoc_x2_sub_nuw_thm (x x_1 : BitVec 32) :
  ((if x_1 < 4#32 then none else some (x_1 - 4#32)).bind fun a =>
<<<<<<< HEAD
      (if x < 8#32 then none else some (x - 8#32)).bind fun y' => if a < y' then none else some (a - y')) ⊑
=======
      (if x < 8#32 then none else some (x - 8#32)).bind fun a_1 => if a < a_1 then none else some (a - a_1)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    some (x_1 - x + 4#32) := sorry

theorem tryFactorization_add_nuw_mul_nuw_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 3#64 then none else some (x * 3#32)).bind fun a =>
      if a + x < a ∨ a + x < x then none else some (a + x)) ⊑
    if x <<< 2 >>> 2 = x then none else some (x <<< 2) := sorry

theorem tryFactorization_add_nuw_mul_nuw_int_max_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 2147483647#64 then none else some (x * 2147483647#32)).bind fun a =>
      if a + x < a ∨ a + x < x then none else some (a + x)) ⊑
    if x <<< 31 >>> 31 = x then none else some (x <<< 31) := sorry

theorem tryFactorization_add_mul_nuw_thm (x : BitVec 32) :
  (if x * 3#32 + x < x * 3#32 ∨ x * 3#32 + x < x then none else some (x * 3#32 + x)) ⊑ some (x <<< 2) := sorry

theorem tryFactorization_add_nuw_mul_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 3#64 then none else some (x * 3#32)).bind fun a => some (a + x)) ⊑
    some (x <<< 2) := sorry

theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_thm (x x_1 x_2 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x_1 then none else some (x_2 * x_1)).bind fun a =>
<<<<<<< HEAD
      (if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x then none else some (x_2 * x)).bind fun y' =>
        if a + y' < a ∨ a + y' < y' then none else some (a + y')) ⊑
    if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 (x_1 + x) then none else some (x_2 * (x_1 + x)) := sorry

theorem tryFactorization_add_nuw_mul_mul_nuw_var_thm (x x_1 x_2 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x then none else some (x_2 * x)).bind fun y' =>
      if x_2 * x_1 + y' < x_2 * x_1 ∨ x_2 * x_1 + y' < y' then none else some (x_2 * x_1 + y')) ⊑
=======
      (if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x then none else some (x_2 * x)).bind fun a_1 =>
        if a + a_1 < a ∨ a + a_1 < a_1 then none else some (a + a_1)) ⊑
    if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 (x_1 + x) then none else some (x_2 * (x_1 + x)) := sorry

theorem tryFactorization_add_nuw_mul_mul_nuw_var_thm (x x_1 x_2 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x then none else some (x_2 * x)).bind fun a =>
      if x_2 * x_1 + a < x_2 * x_1 ∨ x_2 * x_1 + a < a then none else some (x_2 * x_1 + a)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    some (x_2 * (x_1 + x)) := sorry

theorem tryFactorization_add_nuw_mul_nuw_mul_var_thm (x x_1 x_2 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x_1 then none else some (x_2 * x_1)).bind fun a =>
      if a + x_2 * x < a ∨ a + x_2 * x < x_2 * x then none else some (a + x_2 * x)) ⊑
    some (x_2 * (x_1 + x)) := sorry

theorem tryFactorization_add_mul_nuw_mul_var_thm (x x_1 x_2 : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x_1 then none else some (x_2 * x_1)).bind fun a =>
<<<<<<< HEAD
      (if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x then none else some (x_2 * x)).bind fun y' =>
        some (a + y')) ⊑
=======
      (if twoPow 64 31 <<< 1 ≤ setWidth 64 x_2 * setWidth 64 x then none else some (x_2 * x)).bind fun a_1 =>
        some (a + a_1)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    some (x_2 * (x_1 + x)) := sorry


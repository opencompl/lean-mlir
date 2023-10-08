import SSA.Projects.FullyHomomorphicEncryption.Basic
import Std.Data.List.Lemmas
import Mathlib.Data.List.Basic

variable {q t : Nat} [ hqgt1 : Fact (q > 1)] {n : Nat}
variable (a b : R q n)

theorem poly_mul_comm : a * b = b * a := by
  ring

theorem poly_add_comm : a + b = b + a := by
  ring

theorem poly_f_eq_zero : (f q n) = (0 : R q n) := by
  apply Ideal.Quotient.eq_zero_iff_mem.2
  rw [Ideal.mem_span_singleton]

theorem poly_mul_f_eq_zero : a * (f q n) = 0 := by
  rw [poly_f_eq_zero]; ring

theorem poly_mul_one_eq : 1 * a = a := by
  ring

theorem poly_add_f_eq : a + (f q n) = a := by
  rw [← poly_mul_one_eq (q := q) (n := n) (f q n), poly_mul_f_eq_zero 1]; ring

theorem poly_add_zero_eq : a + 0 = a := by
  ring

theorem eq_from_rep_eq :a.representative = b.representative → a = b := by 
  intros hRep
  have hFromPolyRep : R.fromPoly (q := q) (n := n) a.representative = R.fromPoly (q := q) (n := n) b.representative := by
    rw [hRep]
  rw [R.fromPoly_representative _ _ _ , R.fromPoly_representative _ _ _ ] at hFromPolyRep
  assumption

open Polynomial in
theorem from_poly_zero : R.fromPoly (0 : (ZMod q)[X]) (n := n) = (0 : R q n) := by
  have hzero : f q n * 0 = 0 := by simp
  rw [← hzero]
  apply R.from_poly_kernel_eq_zero

theorem rep_zero : R.representative q n 0 = 0 := by
  rw [← from_poly_zero, R.representative_fromPoly]; simp


open Polynomial in
theorem monomial_mul_mul (x y : Nat) : (R.monomial 1 y) * (R.monomial 1 x) = R.monomial 1 (x + y) (q := q) (n := n) := by
  unfold R.monomial
  rw [← map_mul, monomial_mul_monomial, Nat.add_comm]
  simp

theorem R.toTensor_length : a.toTensor.length = a.rep_length := by
  unfold toTensor
  unfold rep_length
  cases Polynomial.degree a.representative <;> simp

theorem R.toTensor_getD (i : Nat) : a.toTensor.getD i 0 = (a.coeff i).toInt := by 
  simp [R.toTensor, R.coeff]
  have hLength : (List.map (fun i => ZMod.toInt q (Polynomial.coeff (representative q n a) i)) (List.range (rep_length a))).length = rep_length a := by
    simp 
  by_cases (i < rep_length a) 
  · rw [← hLength] at h; rw [List.getD_eq_get _ _ h, List.get_map, List.get_range]
  · rw [Nat.not_lt] at h
    rw [List.getD_eq_default _, Polynomial.coeff_eq_zero_of_degree_lt]
    simp [ZMod.toInt]; rw [ZMod.toInt_zero (q := q)]
    unfold rep_length at h 
    cases hDeg : Polynomial.degree (representative q n a) 
    · apply WithBot.bot_lt_coe 
    · simp [hDeg] at h
      apply WithBot.some_lt_some.2
      apply h
    · rw [← hLength] at h
      apply h

theorem R.monomial_zero_c_eq_zero : R.monomial (q := q) (n := n) 0 c = 0 := by
  unfold monomial
  rw [Polynomial.monomial_zero_right]
  simp 

theorem R.fromTensor_eq_concat_zero (tensor : List Int) : R.fromTensor (q := q) (n := n) tensor = R.fromTensor (q := q) (n := n) (tensor ++ [0]) := by
  unfold fromTensor
  simp
  rw [List.enum_append, List.enumFrom_singleton, List.foldl_concat]
  simp [R.monomial_zero_c_eq_zero]

@[simp]
theorem R.trimTensor_append_zero_eq (tensor : List Int) :  trimTensor (tensor ++ [0]) = trimTensor tensor := by
  simp [trimTensor]
  rw [List.dropWhile]
  simp

theorem R.trimTensor_eq_append_zeros (tensor : List Int) : ∃ (n : Nat), 
tensor = trimTensor tensor ++ List.replicate n 0 := by
induction tensor using List.reverseRecOn with
   | H0 => exists 0 
   | H1 xs x ih =>
     have ⟨n,hxs⟩ := ih 
     by_cases (x = 0)
     · exists (n + 1)
       rw [h]
       simp
       rw [← List.replicate_succ, List.replicate_succ', ← List.append_assoc, ← hxs]
     · exists 0
       simp [trimTensor]
       rw [List.dropWhile]
       simp [h]

theorem poly_toTensorFromTensor (tensor : List Int) {l : Nat}: 
  Polynomial.degree a.representative = .some l → tensor.length < l → 
  (R.fromTensor tensor (q:=q) (n :=n)).toTensor = trimTensor tensor := by
  intros hDeg hLen
  simp [R.fromTensor, R.toTensor]
  sorry
 
theorem poly_fromTensortoTensor : R.fromTensor a.toTensor = a := by
  simp [R.fromTensor, R.toTensor, Id.run]
  cases h : Polynomial.degree (R.representative q n a) with
    | none => simp
              have h' :=  Polynomial.degree_eq_bot.1 h
              rw [← rep_zero] at h'
              have h'':= eq_from_rep_eq _ _ <| h'
              apply eq_from_rep_eq
              symm
              exact h'
    | some deg => simp; sorry


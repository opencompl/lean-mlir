import SSA.Projects.FullyHomomorphicEncryption.Basic

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
 
theorem poly_toTensorFromTensor (tensor : List Int) {l : Nat} {q n : Nat} [Fact (q > 1)]: 
  Polynomial.degree a.representative = .some l → tensor.length < l → 
  (R.fromTensor tensor (q:=q) (n :=n)).toTensor = tensor := by
  intros hDeg hLen
  simp [R.fromTensor, R.toTensor, Id.run]
  sorry

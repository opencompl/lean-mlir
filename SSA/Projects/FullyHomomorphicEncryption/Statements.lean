import SSA.Projects.FullyHomomorphicEncryption.Basic

variable (q t : Nat) [ hqgt1 : Fact (q > 1)] (n : Nat)
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
  rw [← poly_mul_one_eq q n (f q n), poly_mul_f_eq_zero _ _ 1]; ring

theorem poly_add_zero_eq : a + 0 = a := by
  ring




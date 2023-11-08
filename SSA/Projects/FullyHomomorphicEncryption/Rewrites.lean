import SSA.Projects.FullyHomomorphicEncryption.Basic
import SSA.Projects.FullyHomomorphicEncryption.Statements
import SSA.Projects.MLIRSyntax.EDSL

theorem dialect_mul_comm :
[mlir_icom| {
^bb0(%A : P, %B : P):
  %v1 = "poly.mul" (%A,%B) : (P, P) -> (P)
  "poly.return" (%v1) : (P) -> ()
}] = 
[mlir_icom| {
^bb0(%A : P, %B : P):
  %v1 = "poly.mul" (%A,%B) : (P, P) -> (P)
  "poly.return" (%v1) : (P) -> ()
}]=  := by
  simp_mlir
  apply poly_mul_comm

theorem dialect_add_comm : a + b = b + a := by
  ring

theorem dialect_f_eq_zero : (f q n) = (0 : R q n) := by
  apply Ideal.Quotient.eq_zero_iff_mem.2
  rw [Ideal.mem_span_singleton]

theorem dialect_mul_f_eq_zero : a * (f q n) = 0 := by
  rw [dialect_f_eq_zero]; ring

theorem dialect_mul_one_eq : 1 * a = a := by
  ring

theorem dialect_add_f_eq : a + (f q n) = a := by
  rw [← dialect_mul_one_eq q n (f q n), dialect_mul_f_eq_zero _ _ 1]; ring

theorem dialect_add_zero_eq : a + 0 = a := by
  ring








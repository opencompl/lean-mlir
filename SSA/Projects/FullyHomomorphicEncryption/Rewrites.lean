/-
End-to-end showcase of the framework for verifying rewrites about FHE semantics.

Authors: Andrés Goens<andres@goens.org>
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.Tactic
import SSA.Projects.FullyHomomorphicEncryption.Basic
import SSA.Projects.FullyHomomorphicEncryption.Statements
import SSA.Projects.FullyHomomorphicEncryption.Syntax

open Ctxt (Var Valuation DerivedCtxt)

open MLIR AST -- need this to support the unhygenic macros in the EDSL

/- Lemmas about the elements of the quotient ring. -/
namespace RingLemmas

/-- In the quotient ring, (f q n) = 0. -/
theorem dialect_f_eq_zero : (f q n) = (0 : R q n) := by
  apply Ideal.Quotient.eq_zero_iff_mem.2
  rw [Ideal.mem_span_singleton]

/-- Since (f q n) = 0, anything multiplied by it is also zero. -/
theorem dialect_mul_f_eq_zero (a : R q n) : a * (f q n) = 0 := by
  rw [dialect_f_eq_zero]; ring

/-- Since (f q n) = 0, adding it to any element gives the element itself. -/
theorem dialect_add_f_eq (a : R q n) : a + (f q n) = a := by
  rw [← one_mul a, dialect_f_eq_zero]; ring

end RingLemmas


namespace ExampleComm

variable {q : Nat} {n : Nat} [hq : Fact (q > 1)]

def lhs :=
[fhe_com q, n, hq| {
^bb0(%A : ! R, %B : ! R):
  %v1 = "poly.add" (%A,%B) : (! R, ! R) -> (! R)
  "return" (%v1) : (! R) -> ()
}]

def rhs :=
[fhe_com q, n, hq| {
^bb0(%A : ! R, %B : ! R):
  %v1 = "poly.add" (%B,%A) : (! R, ! R) -> (! R)
  "return" (%v1) : (! R) -> ()
}]

open MLIR AST in
noncomputable def p1 : PeepholeRewrite (Op q n) [.polynomialLike, .polynomialLike] .polynomialLike :=
  { lhs := lhs, rhs := rhs, correct :=
    by
      rw [lhs, rhs]
      /-:
      Com.denote
        (Com.lete (cst 0)
        (Com.lete (add { val := 1, property := _ } { val := 0, property := _ })
        (Com.ret { val := 0, property := ex1.proof_3 }))) =
      Com.denote (Com.ret { val := 0, property := _ })
      -/
      funext Γv
      simp_peephole [] at Γv
      /- ⊢ ∀ (a b : R 2 3), b + a = a + b -/
      intros a b
      rw [add_comm]
      /- No goals-/
      done
    }

end ExampleComm

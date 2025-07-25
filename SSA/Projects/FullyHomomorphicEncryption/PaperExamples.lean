/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
/-
End-to-end showcase of the framework for verifying rewrites about FHE semantics.

Authors: Andrés Goens<andres@goens.org>
-/
import SSA.Core
import SSA.Projects.FullyHomomorphicEncryption.Basic
import SSA.Projects.FullyHomomorphicEncryption.Statements
import SSA.Projects.FullyHomomorphicEncryption.Syntax
import SSA.Projects.FullyHomomorphicEncryption.PrettySyntax

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
[poly q, n, hq| {
^bb0(%A : ! R, %B : ! R):
  %v1 = "poly.add" (%A,%B) : (! R, ! R) -> (! R)
  "return" (%v1) : (! R) -> ()
}]

def rhs :=
[poly q, n, hq| {
^bb0(%A : ! R, %B : ! R):
  %v1 = "poly.add" (%B,%A) : (! R, ! R) -> (! R)
  "return" (%v1) : (! R) -> ()
}]

open MLIR AST in
noncomputable def p1 : PeepholeRewrite (FHE q n) [.polynomialLike, .polynomialLike]
    .polynomialLike :=
  { lhs := lhs, rhs := rhs, correct :=
    by
      rw [lhs, rhs]
      /-:
      Com.denote
        (Com.var (cst 0)
        (Com.var (add { val := 1, property := _ } { val := 0, property := _ })
        (Com.ret { val := 0, property := ex1.proof_3 }))) =
      Com.denote (Com.ret { val := 0, property := _ })
      -/
      simp_peephole
      /- ⊢ ∀ (a b : R 2 3), b + a = a + b -/
      intros a b
      rw [add_comm]
      /- No goals-/
    }

end ExampleComm

section ExampleModulo

@[irreducible]
def irreduciblePow (q n : Nat) : Nat := q^n
infixl:50 "**" => irreduciblePow


variable {q : Nat} {n : Nat} [hq : Fact (q > 1)]

-- We mark this as noncomputable due to the presence of poly.const, which
-- creates a value of type R.  This operation is noncomputable, as we use `coe`
-- from `Int` to `R`, which is a noncomputable instance.
noncomputable def a_plus_generator_eq_a := [poly q, n, hq| {
^bb0(%a : !R):
  %one_int = arith.const 1 : i16
  %two_to_the_n = arith.const ${2**n} : index
  %x2n = poly.monomial %one_int, %two_to_the_n : (i16, index) -> !R
  %oner = poly.const 1 : !R
  %p = poly.add %x2n, %oner : !R
  %v1 = poly.add %a, %p : !R
  return %v1 : !R
}]

def rhs := [poly q, n, hq | {
^bb0(%a : !R):
  return %a : !R

}]

/-- info: 'a_plus_generator_eq_a' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms a_plus_generator_eq_a

/-  `x^(2^n) + a = a`, since we quotient the polynomial ring with x^(2^n) -/
open MLIR AST in
noncomputable def p1 : PeepholeRewrite (FHE q n) [.polynomialLike] .polynomialLike :=
  { lhs := a_plus_generator_eq_a,
     rhs := rhs
  , correct :=
    by
      unfold a_plus_generator_eq_a rhs
       /-
      Com.denote
          (Com.var (Expr.mk (Op.const_int (Int.ofNat 1)) lhs.proof_2 HVector.nil HVector.nil)
            (Com.var (Expr.mk (Op.const_idx 1) lhs.proof_3 HVector.nil HVector.nil)
              (Com.var
                (Expr.mk Op.monomial lhs.proof_4
                  ({ val := 1, property := lhs.proof_5 }::ₕ({ val := 0, property
                  := lhs.proof_6 }::ₕHVector.nil)) HVector.nil)
                (Com.var
                  (Expr.mk (Op.const (ROfZComputable_stuck_term 2 3 (Int.ofNat
                  1))) lhs.proof_7 HVector.nil HVector.nil)
                  (Com.var
                    (Expr.mk Op.add lhs.proof_8
                      ({ val := 1, property := lhs.proof_9 }::ₕ({ val := 0,
                      property := lhs.proof_10 }::ₕHVector.nil)) HVector.nil)
                    (Com.var
                      (Expr.mk Op.add lhs.proof_8
                        ({ val := 5, property := lhs.proof_11 }::ₕ({ val := 0,
                        property := lhs.proof_12 }::ₕHVector.nil))
                        HVector.nil)
                      (Com.ret { val := 0, property := lhs.proof_13 })))))))
          Γv =
        Com.denote (Com.ret { val := 0, property := rhs.proof_2 }) Γv
       -/
      simp_peephole
      /- ⊢ ∀ (a : ⟦Ty.polynomialLike⟧), a + (R.monomial q n 1 (2**n) + 1) = a -/
      simp only [R.monomial, R.fromPoly, Int.toNat_natCast, Int.cast_one, ROfZComputable_def]
      /- ⊢ a + ((Ideal.Quotient.mk (Ideal.span {f q n})) ((Polynomial.monomial
      (2**n)) 1) + 1) = a -/
      intros a
      unfold irreduciblePow
      have hgenerator :
        f q n - (1 : Polynomial (ZMod q)) =
          (Polynomial.monomial (R := ZMod q) (2^n : Nat) 1)  := by
            simp [f, Polynomial.X_pow_eq_monomial]
      rw [← hgenerator]
      have add_congr_quotient :
          ((Ideal.Quotient.mk (Ideal.span {f q n})) (f q n - 1) + 1)  =
            ((Ideal.Quotient.mk (Ideal.span {f q n})) (f q n )) := by
        simp
      rw [add_congr_quotient]
      apply Poly.add_f_eq
    }
/--info: 'p1' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms p1
end ExampleModulo

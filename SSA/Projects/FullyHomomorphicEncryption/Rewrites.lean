import SSA.Projects.MLIRSyntax.EDSL
import SSA.Core.Tactic
import SSA.Projects.FullyHomomorphicEncryption.Basic
import SSA.Projects.FullyHomomorphicEncryption.Statements
import SSA.Projects.FullyHomomorphicEncryption.Syntax

open MLIR AST -- need this to support the unhygenic macros in the EDSL

variable {q : Nat} {n : Nat} [Fact (q > 1)]

section ExampleComm

def lhs :=
[fhe_com| {
^bb0(%A : ! R, %B : ! R):
  %v1 = "poly.add" (%A,%B) : (! R, ! R) -> (! R)
  "return" (%v1) : (! R) -> ()
}]

def rhs :=
[fhe_com| {
^bb0(%A : ! R, %B : ! R):
  %v1 = "poly.add" (%B,%A) : (! R, ! R) -> (! R)
  "return" (%v1) : (! R) -> ()
}]

open MLIR AST in
noncomputable def p1 : PeepholeRewrite (Op 2 3) [.polynomialLike, .polynomialLike] .polynomialLike :=
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
      simp_peephole [add, cst] at Γv
      /- ⊢ ∀ (a b : R 2 3), b + a = a + b -/
      intros a b
      rw [add_comm]
      /- No goals-/
      done
    }

end ExampleComm

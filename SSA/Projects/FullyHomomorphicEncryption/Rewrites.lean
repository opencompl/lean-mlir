import SSA.Projects.MLIRSyntax.EDSL
import SSA.Core.Tactic
import SSA.Projects.FullyHomomorphicEncryption.Basic
import SSA.Projects.FullyHomomorphicEncryption.Statements
import SSA.Projects.FullyHomomorphicEncryption.Syntax

open Ctxt (Var Valuation DerivedCtxt)

open MLIR AST -- need this to support the unhygenic macros in the EDSL


namespace ExampleComm

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

#check Lean.Meta.Simp.Config
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
      simp_peephole [add] at Γv
      /- ⊢ ∀ (a b : R 2 3), b + a = a + b -/
      intros a b
      rw [add_comm]
      /- No goals-/
      done
    }

end ExampleComm


section ExampleModulo
-- 2^n

-- code generator does not support recursor 'Decidable.rec' yet, consider using 'match ... with' and/or structural recursion
noncomputable def lhs := -- We can't have symbolic constants in the EDSL, so we use a concrete value here
[fhe_com| {
^bb0(%A : ! R):
  -- %oneint = "arith.const" () {value = 1}: () -> (i16)
  -- %oneidx = "arith.const" () {value = 1}: () -> (index)
  -- %x2n = "poly.monomial" (%oneint,%oneidx) : (i16, index) -> (! R)
  %oner = "poly.const" () {value = 1}: () -> (! R)
  -- %p = "poly.add" (%x2n, %oner) : (! R, ! R) -> (! R)
  -- %v1 = "poly.add" (%A, %p) : (! R, ! R) -> (! R)
  -- "return" (%v1) : (! R) -> ()
  "return" (%oner) : (! R) -> ()
}]

def rhs :=
[fhe_com| {
^bb0(%A : ! R):
  "return" (%A) : (! R) -> ()
}]

open MLIR AST in
noncomputable def p1 : PeepholeRewrite (Op 2 3) [.polynomialLike] .polynomialLike :=
  { lhs := lhs,
    -- Inlining rhs because of some `rw` bug. Maybe it's https://github.com/leanprover/lean4/commit/504b6dc93f46785ccddb8c5ff4a8df5be513d887
     rhs := rhs
  , correct :=
    by
      /-:
      Com.denote
        (Com.lete (cst 0)
        (Com.lete (add { val := 1, property := _ } { val := 0, property := _ })
        (Com.ret { val := 0, property := ex1.proof_3 }))) =
      Com.denote (Com.ret { val := 0, property := _ })
      -/
      funext Γv
      rw [lhs]
      change_mlir_context Γv
      simp_peephole [] at Γv
      intros a
      simp
      try rw [Poly.add_f_eq]
      sorry
    }

end ExampleModulo

import LeanMLIR

/-!
# ElimValuation simproc

The following is an MWE extracted from `circomvent` (our LLZK experiments repo),
where the `SSA.elimValuation` simproc triggered a `(kernel) application type mismatch`
error.
-/

namespace MWE
open Ctxt (Valuation)

inductive Ty
  | felt

def BabyBear := 2^31 - 2^27 + 1

instance : TyDenote Ty where toType
  | .felt => Fin BabyBear

set_option warn.sorry false in
example (i : Fin BabyBear) :
    ∀ (os : Valuation ⟨[Ty.felt]⟩), ∃ (es' : Valuation ⟨[Ty.felt]⟩),
      (Valuation.cons i <| .cons i <| .nil) = (os ++ es') := by
  -- simp only [SSA.elimValuation]
  -- ^^ uncomment the above to trigger a `(kernel) application type mismatch` error
  stop
  guard_target = ∀ (e : ⟦Ty.felt⟧), ∃ (es' : Valuation ⟨[Ty.felt]⟩),
    (Valuation.cons i <| .cons i .nil) = (Valuation.cons e .nil ++ es')
  sorry

end MWE

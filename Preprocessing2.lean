/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-- goals/success/gsubhofhnegatible_proof_t7_thm_extracted_1__2.lean
-/
import Blase
open BitVec

#eval (((MultiWidth.Term.Ctx.empty 2).cons (MultiWidth.WidthExpr.var ⟨0, by omega⟩)).cons (MultiWidth.WidthExpr.var ⟨1, by omega⟩)
      ⟨0, by omega⟩)

-- set_option pp.explicit true in
/-- Bug due to reflection of multiple widths. -/
theorem minimized :
    ∀ (v w : Nat) (x_1 : BitVec v) (x_2 : BitVec w), x_1 = 42#v ∨ x_2 = 43#w := by
  intros;
  bv_multi_width +verbose?

theorem t7_thm.extracted_1._2 :
    ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8), x_1 = 1#1 → x_2 - 0#8 = 0#8 + x_2 := by
  intros;
  bv_multi_width


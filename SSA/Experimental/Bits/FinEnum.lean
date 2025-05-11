/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.FinEnum
import Mathlib.Tactic.FinCases

instance: FinEnum (BitVec w) where
  card := 2^w
  equiv := {
    toFun := fun x => x.toFin
    invFun := fun x => BitVec.ofFin x
    left_inv := by intros bv; simp
    right_inv := by intros n; simp
  }

instance : FinEnum Bool where
  card := 2
  equiv := {
    toFun := fun x => if x then 1 else 0,
    invFun := fun (x : Fin 2 ) => if x == 0 then false else true,
    left_inv := by intros _; simp,
    right_inv := by intros x; fin_cases x <;> simp
  }

instance finEnumUnit : FinEnum Unit where
  card := 1
  equiv := {
    toFun := fun _ => 0,
    invFun := fun (_ : Fin 1) => (),
    left_inv := by intros _; simp,
    right_inv := by intros x; fin_cases x; simp
  }

instance finEnumEmpty : FinEnum Empty where
  card := 0
  equiv := {
    toFun := fun x => Empty.elim x
    invFun := fun (x : Fin 0) => Fin.elim0 x
    left_inv := by intros x; cases x
    right_inv := by intros x; fin_cases x
  }

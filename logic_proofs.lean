

theorem test (p q : Prop) (hp : p) (hq : q) : p ∧ q ∧ p :=
  by exact and.intro hp (and.intro hq hp)

/-
  goal is to prove that:
  p : Prop , q : Prop , hp : p, hq : q (proof of these props)
   |- p ∧ q ∧ p



-/

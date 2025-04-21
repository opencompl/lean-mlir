/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Refinement

/-!
# Poison Semantics
This file defines a generic `PoisonOr α` type, which dialects can use to
implement (LLVM) poison semantics.
-/

/--
Elements of type `PoisonOr α` are either `poison`, or values of type `α`.

`PoisonOr α` is simply a wrapper around `Option α`, but we generally prefer `PoisonOr`
when specifying poison semantics in dialects, as it's more self-documenting.
-/
structure PoisonOr (α : Type) where
  ofOption :: toOption : Option α

namespace PoisonOr

/-! ### Constructors-/
@[match_pattern] def poison : PoisonOr α := ⟨none⟩
@[match_pattern] def value : α → PoisonOr α := (⟨some ·⟩)

/--
`casesOn'` is a custom eliminator. By tagging it with `cases_eliminator`, we can
write `cases a?` in tactic mode and have it do a case-analysis in terms of the
`poison` or `value` constructors defined above rather than breaking the value
down into the underlying option.
-/
@[elab_as_elim, cases_eliminator]
def casesOn'.{u} {α : Type} {motive : PoisonOr α → Sort u}
    (a? : PoisonOr α)
    (poison : motive poison)
    (value : (a : α) → motive (value a))
    : motive a? :=
  match a? with
  | .poison => poison
  | .value a => value a

/-! ### Formatting & Priting instances -/
instance [ToString α] : ToString (PoisonOr α) where
  toString
  | .poison  => "poison"
  | .value a => "(value " ++ addParenHeuristic (toString a) ++ ")"

/-! ### Monad instance and lemmas -/
instance : Monad PoisonOr where
  pure := value
  bind := fun a f => match a with
    | poison  => poison
    | value a => f a

def bind₂ (a : PoisonOr α) (b : PoisonOr β) (f : α → β → PoisonOr γ) : PoisonOr γ :=
  (a >>= fun x => b >>= f x)

section Lemmas
--TODO: these lemmas should all be tagged `simp_denote` once that simpset is merged to main
@[simp] theorem bind_poison : poison >>= f = poison := rfl
@[simp] theorem bind_value : value a >>= f = f a := rfl

@[simp] theorem bind₂_poison_left : bind₂ poison b? f = poison := rfl
@[simp] theorem bind₂_poison_right : bind₂ a? poison f = poison := by
  cases a? <;> simp [bind₂]
@[simp] theorem bind₂_value : bind₂ (value a) (value b) f = f a b := rfl
end Lemmas


/-! ### Refinement -/
inductive IsRefinedBy [HRefinement α β] : PoisonOr α → PoisonOr β → Prop
  /-- `poison` is refined by anything -/
  | poisonLeft : IsRefinedBy poison b?
  /-- `value a` is only refined by a `value b` s.t. `a ⊑ b` -/
  | bothValues : a ⊑ b → IsRefinedBy (value a) (value b)

section Refinement
variable {a b} [HRefinement α β] (a? : PoisonOr α) (b? : PoisonOr β)

instance : HRefinement (PoisonOr α) (PoisonOr β) where
  IsRefinedBy := IsRefinedBy

@[simp] theorem poison_isRefinedBy : (@poison α) ⊑ b? :=
  IsRefinedBy.poisonLeft

@[simp] theorem value_isRefinedBy_value (a : α) (b : β) :
    value a ⊑ value b ↔ a ⊑ b := by
  constructor
  · rintro ⟨⟩; assumption
  · exact IsRefinedBy.bothValues

@[simp] theorem not_value_isRefinedBy_poison (a : α) : ¬value a ⊑ (@poison β) := by
  rintro ⟨⟩

--TODO: this was not tagged `@[simp]` originally, but it seems like it'd make a good simp-lemma
theorem isRefinedBy_poison : a? ⊑ (@poison β) ↔ a? = poison := by
  cases a?
  · simp
  · simp only [not_value_isRefinedBy_poison, false_iff]; rintro ⟨⟩

section PreOrder
variable {α : Type} [HRefinement α α]

/--
Refinement on poison values is reflexive if refinement of the underlying values is reflexive.
-/
theorem isRefinedBy_refl (h : ∀ (a : α), a ⊑ a) :
    ∀ (a? : PoisonOr α), a? ⊑ a? := by
  intro a; cases a <;> simp [h]

/--
Refinement on poison values is transitive if refinement of the underlying values is transitive.
-/
theorem isRefinedBy_trans (h : ∀ (a b c : α), a ⊑ b → b ⊑ c → a ⊑ c) :
    ∀ (a? b? c? : PoisonOr α), a? ⊑ b? → b? ⊑ c? → a? ⊑ c? := by
  intro a? b? c?
  cases a? <;> cases b? <;> cases c? <;> simp
  apply h

end PreOrder

/--
Refinement on poison values is decidable if refinement of the underlying values is decidable.
-/
instance {α β : Type} [HRefinement α β] [DecidableRel (· ⊑ · : α → β → _)] :
    DecidableRel (· ⊑ · : PoisonOr α → PoisonOr β → _)
  | .poison, _ => .isTrue <| by simp
  | .value _, .poison => .isFalse <| by simp
  | .value a, .value b => decidable_of_decidable_of_iff (p := a ⊑ b) <| by simp

end Refinement

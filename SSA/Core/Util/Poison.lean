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
  deriving DecidableEq

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

@[simp] theorem value_inj {a b : α} :
    @Eq (no_index _) (value a) (value b) ↔ a = b := by
    -- ^^ `value a = value b ↔ _`
  constructor
  · rintro ⟨⟩; rfl
  · exact fun h => h ▸ rfl

theorem poison_ne_value (a : α) :
    @Ne (no_index _) poison (value a) := by -- `poison ≠ value a`
  rintro ⟨⟩
theorem value_ne_poison (a : α) :
    @Ne (no_index _) (value a) poison := by -- `value a ≠ poison`
  rintro ⟨⟩

@[simp]
theorem ite_value_value {c : Prop} [Decidable c] {a b : α} :
    (if c then value a else value b : no_index _) = value (if c then a else b) := by
  split <;> rfl

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
@[simp] theorem pure_def : pure = @value α := rfl

@[simp] theorem poison_bind : poison >>= f = poison := rfl
@[simp] theorem value_bind : value a >>= f = f a := rfl
@[simp] theorem bind_poison : a? >>= (fun _ => @poison β) = poison := by
  cases a? <;> rfl

@[simp]
theorem bind_if_then_poison_eq_ite_bind (p : Prop) [Decidable p] (x : PoisonOr α) :
    (if p then poison else x : no_index _) >>= f = if p then poison else x >>= f := by
-- /---------------------------^^^^^^^^^^
-- NOTE: the if-then-else has an implicit type argument, which will be `PoisonOr α`,
-- that is normally indexed in the discr_tree. Since we want this rewrite to apply
-- when this type is, say, LLVM.IntW, we ensure it is not indexed, using `no_index`
  split <;> simp

@[simp]
theorem bind_if_else_poison_eq_ite_bind (p : Prop) [Decidable p] (x : PoisonOr α) :
    (if p then x else poison : no_index _) >>= f = if p then x >>= f else poison := by
  split <;> simp

@[simp] theorem bind₂_poison_left : bind₂ poison b? f = poison := rfl
@[simp] theorem bind₂_poison_right : bind₂ a? poison f = poison := by
  cases a? <;> simp [bind₂]
@[simp] theorem bind₂_value : bind₂ (value a) (value b) f = f a b := rfl
end Lemmas

instance : LawfulMonad PoisonOr where
  map_const := by intros; rfl
  id_map := by rintro _ (_|_) <;> rfl
  seqLeft_eq := by rintro _ _ (_|_) _ <;> rfl
  seqRight_eq := by rintro _ _ (_|_) (_|_) <;> rfl
  pure_seq := by intros; rfl
  bind_pure_comp := by intros; rfl
  bind_map := by intros; rfl
  pure_bind _ _ := value_bind
  bind_assoc := by rintro _ _ _ (_|_) _ _ <;> rfl

/-! ## isPoison & getValue-/

/-- Returns whether the element is poison. -/
def isPoison : PoisonOr α → Bool
  | poison => true
  | value _ => false

/-- Returns the value of the element, or a default value if it is poison. -/
def getValue [Inhabited α] : PoisonOr α → α
  | poison => default
  | value a => a

section Lemmas
variable {a : α}

@[simp] theorem isPoison_poison : isPoison (@poison α) = true := rfl
@[simp] theorem isPoison_value : isPoison (value a) = false := rfl

@[simp] theorem getValue_value [Inhabited α] : (value a).getValue = a := rfl
@[simp] theorem getValue_poison [Inhabited α] : (@poison α).getValue = default := rfl

@[simp] theorem mk_some (x : α) : { toOption := some x } = PoisonOr.value x := rfl
@[simp] theorem mk_none : { toOption := none (α := α) } = PoisonOr.poison := rfl

@[simp_denote, simp]
theorem toOption_getSome : (PoisonOr.value x).toOption.getD y = x := by rfl
@[simp_denote, simp]
theorem toOption_getNone : (PoisonOr.poison).toOption.getD y = y := by rfl

end Lemmas

/-! ### Refinement -/
inductive IsRefinedBy [HRefinement α α] : PoisonOr α → PoisonOr α → Prop
  /-- `poison` is refined by anything -/
  | poisonLeft : IsRefinedBy poison b?
  /-- `value a` is only refined by a `value b` s.t. `a ⊑ b` -/
  | bothValues : a ⊑ b → IsRefinedBy (value a) (value b)

section Refinement
variable [HRefinement α α] (a? b? : PoisonOr α)

instance : Refinement (PoisonOr α) where
  IsRefinedBy := IsRefinedBy

@[simp] theorem poison_isRefinedBy : (@poison α) ⊑ b? :=
  IsRefinedBy.poisonLeft

@[simp] theorem value_isRefinedBy_value (a b : α) :
    value a ⊑ value b ↔ a ⊑ b := by
  constructor
  · rintro ⟨⟩; assumption
  · exact IsRefinedBy.bothValues

@[simp] theorem not_value_isRefinedBy_poison (a : α) : ¬value a ⊑ (@poison α) := by
  rintro ⟨⟩

theorem isRefinedBy_poison_iff : a? ⊑ (@poison α) ↔ a? = poison := by
  cases a?
  · simp
  · simp only [not_value_isRefinedBy_poison, false_iff]; rintro ⟨⟩

theorem isRefinedBy_iff [Inhabited α] [Inhabited β] :
    a? ⊑ b?
    ↔ (b?.isPoison → a?.isPoison)
      ∧ (a?.isPoison = false → a?.getValue ⊑ b?.getValue) := by
  cases a? <;> cases b? <;> simp

@[simp, simp_denote]
theorem eq_squb (a b : PoisonOr α) : PoisonOr.IsRefinedBy a b ↔ a ⊑ b := by rfl

section PreOrder

/--
Refinement on poison values is reflexive, when the underlying refinement is reflexive
-/
instance [Std.Refl (· ⊑ · : α → α → _)] : Std.Refl (· ⊑ · : PoisonOr α → PoisonOr α → _) where
  refl a? := by cases a? <;> simp [Std.Refl.refl]

@[simp] theorem isRefinedBy_self [Std.Refl (· ⊑ · : α → α → _)] : a? ⊑ a? := Std.Refl.refl _

/--
Refinement on poison values is transitive, when the underlying refinement is transitive
-/
instance [IsTrans α (· ⊑ ·)] : IsTrans (PoisonOr α) (· ⊑ ·) where
  trans a? b? c? := by
    cases a?; simp
    cases b?; simp
    cases c?; simp
    simpa using IsTrans.trans _ _ _

/--
Refinement on poison values is transitive
-/
theorem isRefinedBy_trans [IsTrans α (· ⊑ ·)] (a? b? c? : PoisonOr α) :
    a? ⊑ b? → b? ⊑ c? → a? ⊑ c? := IsTrans.trans _ _ _

end PreOrder

/--
Refinement on poison values is decidable if equality of the underlying values is decidable.
-/
instance [DecidableRel (· ⊑ · : α → α → _)] :
    DecidableRel (· ⊑ · : PoisonOr α → PoisonOr α → _)
  | .poison, _ => .isTrue <| by simp
  | .value _, .poison => .isFalse <| by simp
  | .value a, .value b => decidable_of_decidable_of_iff (p := a ⊑ b) <| by simp


/-! ### if-then-else -/
section Ite
variable {c : Prop} [Decidable c] (a? b? : PoisonOr α) (a : α)

@[simp]
theorem if_then_poison_isRefinedBy_iff  :
    (if c then poison else a? : no_index _) ⊑ b? ↔ ¬c → a? ⊑ b? := by
  split <;> simp [*]

@[simp]
theorem value_isRefinedBy_if_then_poison_iff :
    value a ⊑ (if c then poison else b? : no_index _) ↔ ¬c ∧ (value a ⊑ b?) := by
  split <;> simp [*]


/-!
Fallback theorems for generic if-then-else; other theorems should be preferred
as they give simpler rhs's for their specialized situations.
-/
theorem ite_isRefinedBy_iff {x? y? z? : PoisonOr α} :
    ite c x? y? ⊑ z?
    ↔ let c := c
      (c → x? ⊑ z?) ∧ (¬c → y? ⊑ z?) := by
  split <;> simp [*]

theorem isRefinedBy_ite_iff {x? y? z? : PoisonOr α} :
    x? ⊑ ite c y? z?
    ↔ let c := c
      (c → x? ⊑ y?) ∧ (¬c → x? ⊑ z?) := by
  split <;> simp [*]

end Ite

end Refinement


end PoisonOr

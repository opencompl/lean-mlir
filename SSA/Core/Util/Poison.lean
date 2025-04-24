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

@[simp] theorem value_inj {a b : α} : value a = value b ↔ a = b := by
  constructor
  · rintro ⟨⟩; rfl
  · exact fun h => h ▸ rfl

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
Refinement on poison values is reflexive iff refinement of the underlying values is reflexive.
-/
theorem isRefinedBy_refl (h : ∀ (a : α), a ⊑ a) :
    ∀ (a? : PoisonOr α), a? ⊑ a? := by
  intro a; cases a <;> simp [h]

/--
Refinement on poison values is transitive iff refinement of the underlying values is transitive.
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

variable {i : HRefinement α β} (a : PoisonOr α) (b : PoisonOr β) in
theorem isRefinedBy_iff {i : Inhabited α} {i :Inhabited β} :
    a ⊑ b
    ↔ (b.isPoison → a.isPoison)
      ∧ (a.isPoison = false → a.getValue ⊑ b.getValue) := by
  cases a <;> cases b <;> simp

end Lemmas


/-! ## OfParts -/

/--
`poisonIf isPoison elseValue` returns `poison` if `isPoison` is `true`,
and `elseValue` otherwise.
-/
def poisonIf (isPoison : Bool) (elseValue : PoisonOr α) : PoisonOr α :=
  if isPoison then poison else elseValue

/--
Construct an element of `PoisonOr α`, given a Boolean `isPoison` which indicates
whether it's poison, and a value `val` for if it's not poison.

That is, returns `poison` if `isPoison` is `true`, and `value val` otherwise.

See also [`poisonIf`].
-/
def ofParts (isPoison : Bool) (val : α) : PoisonOr α :=
  poisonIf isPoison <| value val

section OfPartsLemmas

@[simp] theorem poisonIf_true : poisonIf true x = poison := rfl
@[simp] theorem poisonIf_false : poisonIf false x = x := rfl
@[simp] theorem ofParts_true : ofParts true val = poison := rfl
@[simp] theorem ofParts_false : ofParts false val = value val := rfl

@[simp] theorem isPoison_ofParts_bind :
    (ofParts xPoison x >>= f).isPoison =
      (xPoison || (f x).isPoison) := by
  cases xPoison <;> simp

theorem isPoison_ite [Decidable c] :
    (isPoison (if c then x else y))
    = ((decide c && x.isPoison) || (!decide c && y.isPoison)) := by
  by_cases hc : c <;> simp [hc]

@[simp] theorem isPoison_ite_poison [Decidable c] :
    isPoison (if c then poison else x)
    = ((decide c) || x.isPoison) := by
  simp only [isPoison_ite, isPoison_poison, Bool.and_true]
  cases decide c <;> rfl

theorem ofParts_isPoison_getValue {i : Inhabited α} (x : PoisonOr α) :
    ofParts (x.isPoison) (x.getValue) = x := by
  cases x <;> rfl

theorem isRefinedBy_iff_ofParts_isRefinedBy_ofParts
    {i : HRefinement α β} [Inhabited α] [Inhabited β]
    {x : PoisonOr α} {y : PoisonOr β} :
    x ⊑ y ↔ ofParts (x.isPoison) (x.getValue) ⊑ ofParts (y.isPoison) (y.getValue) := by
  simp [ofParts_isPoison_getValue]

theorem ofParts_isRefinedBy_ofParts_iff [HRefinement α β]
    (isPoison : Bool) (val : α) (isPoison' : Bool) (val' : β) :
    ofParts isPoison val ⊑ ofParts isPoison' val' ↔
      (isPoison' = true → isPoison = true)
      ∧ (isPoison = false → val ⊑ val') := by
  cases isPoison <;> cases isPoison' <;> simp

@[simp]
theorem ofParts_eq_iff {isPoison isPoison' : Bool} {val val' : α} :
  ofParts isPoison val = ofParts isPoison' val' ↔
    (isPoison = isPoison') ∧ (isPoison = false → val = val') := by
  cases isPoison <;> cases isPoison' <;> simp [poison, value]

theorem ofParts_getValue_bind_eq {isPoison xPoison : Bool} {x : α} {f : α → PoisonOr β}
    [Inhabited α] [Inhabited β]
    (h : xPoison = true → isPoison = true) :
    ofParts isPoison (ofParts xPoison x >>= f).getValue = ofParts isPoison (f x).getValue := by
  simp only [ofParts_eq_iff, true_and]
  rintro rfl
  obtain rfl : xPoison = false := by simpa using h
  simp

end OfPartsLemmas

end PoisonOr

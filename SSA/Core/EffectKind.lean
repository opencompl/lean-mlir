import SSA.Core.Tactic.SimpSet
import Lean
import Mathlib.Order.Lattice

/- Kinds of effects, either pure or impure -/
inductive EffectKind
| pure -- pure effects.
| impure -- impure, lives in IO.
deriving Repr, DecidableEq, Lean.ToExpr

namespace EffectKind

def toMonad (e : EffectKind) (m : Type → Type) : Type → Type :=
  match e with
  | pure => Id
  | impure => m

section Lemmas

@[simp_denote] theorem toMonad_pure   : pure.toMonad m = Id := rfl
@[simp_denote] theorem toMonad_impure : impure.toMonad m = m := rfl

end Lemmas

section Instances
variable {e : EffectKind} {m : Type → Type}

/-!
NOTE: The `Monad` instance below also implies `Functor`, `Applicative`, etc.
If `m` is a `Functor`, but not a full `Monad`, then `e.toMonad m` should still be a functor too.
However, actually having these instances causes diamond problems with the aforementioned instances
implied by `Monad`. Thus, we generally assume `m` is a monad, and add a low priority
instance for `Pure`.

Similarly, there is some overlap between the instance that says `pure.toMonad m` is a
(lawful) monad, irrespective of whether `m` is a monad or not, and the broader instances
for `e.toMonad m`. For some reason, the latter were not being picked up [1], so we add
lower priority to the `pure.toMonad m` instances, too.

[1]: reported at https://github.com/leanprover/lean4/issues/7984#issuecomment-2847319540
-/

/-!
Firstly, we show that `pure.toMonad m` is a (lawful) monad, irrespective of
whether `m` is.
-/
instance (priority := low) : Monad (pure.toMonad m) := by unfold toMonad; infer_instance
instance (priority := low) : LawfulMonad (pure.toMonad m) := by unfold toMonad; infer_instance

/-!
Then, we show that `eff.toMonad m` is a (lawful) monad, for arbitrary effect `eff`,
assuming that `m` is a (lawful) monad.
-/
instance (priority := low) [Pure m] : Pure (e.toMonad m) := by
  unfold toMonad; cases e <;> infer_instance

instance [Monad m] : Monad (e.toMonad m) := by
  unfold toMonad; cases e <;> infer_instance

instance [Monad m] [LawfulMonad m] : LawfulMonad (e.toMonad m) := by
  unfold toMonad; cases e <;> infer_instance

end Instances

section Lemmas
variable [Monad m]

@[simp] lemma pure_pure (eff : EffectKind) (x : α) :
    (Pure.pure (Pure.pure x : pure.toMonad m (no_index α)) : eff.toMonad m α) = Pure.pure x :=
  rfl

variable [LawfulMonad m] in
theorem pure_map (f : α → β) (x : pure.toMonad m α) (eff : EffectKind) :
    (Pure.pure (f <$> x : pure.toMonad m _) : eff.toMonad m _) = f <$> (Pure.pure x) := by
  simp; rfl

end Lemmas

/-!
## `PartialOrder`
Establish a partial order on `EffectKind`
-/
section PartialOrder

inductive le : EffectKind → EffectKind → Prop
  | pure_le (e) : le .pure e
  | le_impure (e) : le e .impure

@[simp]
def decLe (e e' : EffectKind) : Decidable (le e e') :=
  match e with
  | .pure => match e' with
    | .pure => isTrue (by constructor)
    | .impure => isTrue (by constructor)
  | .impure => match e' with
    | .pure => isFalse (by intro; contradiction)
    | .impure => isTrue (by constructor)


instance : LE EffectKind where le := le
instance : DecidableRel (LE.le (α := EffectKind)) := decLe

@[simp]
theorem eq_of_le_pure {e : EffectKind}
    (he : e ≤ pure) : e = pure := by
  cases he; rfl

@[simp] theorem not_impure_le_pure : ¬(impure ≤ pure) := by
  intro; contradiction

@[simp] theorem pure_le (e : EffectKind) : pure ≤ e := le.pure_le e
@[simp] theorem le_impure (e : EffectKind) : e ≤ impure := le.le_impure e

@[simp] theorem le_refl (e : EffectKind) : e ≤ e := by cases e <;> constructor

@[simp]
theorem le_trans {e1 e2 e3 : EffectKind} (h12: e1 ≤ e2) (h23: e2 ≤ e3) : e1 ≤ e3 := by
  cases e1 <;> cases e2 <;> cases e3 <;> simp_all

@[simp]
theorem le_antisymm {e1 e2 : EffectKind} (h12: e1 ≤ e2) (h21: e2 ≤ e1) : e1 = e2 := by
  cases e1 <;> cases e2 <;> simp_all

theorem le_of_eq {e1 e2 : EffectKind} (h : e1 = e2) : e1 ≤ e2 := by
  subst h
  cases e1 <;> simp

instance : PartialOrder EffectKind where
  le_refl := le_refl
  le_trans := @le_trans
  le_antisymm := @le_antisymm

end PartialOrder

/-!
### `Lattice`
`EffectKind` forms a lattice -/
section Lattice

def sup : EffectKind → EffectKind → EffectKind
  | .pure, .pure => .pure
  | _, _ => .impure

instance : Max EffectKind where
  max := sup

def inf : EffectKind → EffectKind → EffectKind
  | .impure, .impure => .impure
  | _, _ => .pure

instance : Min EffectKind where
  min := inf

@[simp] theorem pure_sup_pure_eq  : max pure pure = pure    := rfl
@[simp] theorem pure_sup_pure_eq' : max pure pure = pure    := rfl

@[simp] theorem impure_sup_eq : max impure e  = impure  := rfl
@[simp] theorem sup_impure_eq : max e impure  = impure  := by cases e <;> rfl

@[simp] theorem impure_inf_impure_eq : min impure impure = impure  := rfl
@[simp] theorem pure_inf_eq      : min pure e = pure           := rfl
@[simp] theorem inf_pure_eq      : min e pure = pure           := by cases e <;> rfl

-- TODO: these proofs are currently quite slow, they could probablye be sped up quite a bit
instance : Lattice EffectKind where
  sup           := max
  inf           := min
  le_sup_left   := by rintro (_|_) (_|_) <;> constructor
  le_sup_right  := by rintro (_|_) (_|_) <;> constructor
  sup_le        := by rintro (_|_) (_|_) (_|_) <;> simp
  inf_le_left   := by rintro (_|_) (_|_) <;> constructor
  inf_le_right  := by rintro (_|_) (_|_) <;> constructor
  le_inf        := by rintro (_|_) (_|_) (_|_) <;> simp

end Lattice

/-!
## `liftEffect`
-/

/-- Lift a value wrapped in effect `e1` into effect `e2`, given that `e1 ≤ e2`.

Said differently, this is a functor from the category of EffectKind (with `e1 ≤ e2` as its arrows)
to Lean (with `e1.toMonad x → e2.toMonad x` as its arrows). -/
def liftEffect [Pure m] {e1 e2 : EffectKind} {α : Type}
    (hle : e1 ≤ e2) (v1 : e1.toMonad m α) : e2.toMonad m α :=
  match e1, e2, hle with
    | .pure, .pure, _ | .impure, .impure, _ => v1
    | .pure, .impure, _ => Pure.pure v1

section MonadLift
variable {m} [Monad m]

/-!
NOTE: Normally one ought to implement `MonadLift n _`, rather than `MonadLiftT`.
However, the former declares `n` to be a semiOutParam, meaning the type of each
instance must have `n` fully concrete. In the following instances, we have
meta-variables in the type of `n`, so we have to implement `MonadLiftT` instead.
-/

instance instMonadLiftOfLe {e1 e2 : EffectKind} (h : e1 ≤ e2) :
    MonadLiftT (e1.toMonad m) (e2.toMonad m) where
  monadLift := liftEffect h

variable (eff : EffectKind)
instance : MonadLiftT (eff.toMonad m) m                  := instMonadLiftOfLe (le_impure eff)
instance : MonadLiftT (eff.toMonad m) (impure.toMonad m) := instMonadLiftOfLe (le_impure eff)
instance : MonadLiftT (pure.toMonad m) (eff.toMonad m)   := instMonadLiftOfLe (pure_le eff)

end MonadLift

@[simp, simp_denote]
theorem liftEffect_rfl [Pure m] (hle : eff ≤ eff) :
    liftEffect hle (α := α) (m := m) = id := by cases eff <;> rfl

@[simp, simp_denote]
theorem liftEffect_pure_impure [Pure m] (hle : pure ≤ impure) :
    liftEffect hle (α := α) (m := m) = Pure.pure :=
  rfl

/-- Forded version of `liftEffect_pure_impure` -/
theorem liftEffect_eq_pure_cast {m : Type → Type} [Pure m]
    {eff : EffectKind} (eff_eq : eff = .pure) (eff_le : eff ≤ .impure) :
    liftEffect eff_le = fun (x : eff.toMonad m α) =>
      Pure.pure (cast (by rw [eff_eq]; rfl) x) := by
  subst eff_eq; rfl


@[simp] theorem liftEffect_impure [Pure m] {e} (hle : e ≤ impure) :
    liftEffect hle (α := α) (m := m) = match e with
      | .pure => fun v => Pure.pure v
      | .impure => id := by
  cases e <;> rfl

theorem liftEffect_eq_pure_cast_of [Pure m] {e₁ e₂} (heq : e₁ = .pure) (hle : e₁ ≤ e₂) :
    liftEffect hle (α := α) (m := m) = fun x => Pure.pure (cast (by subst heq; rfl) x) := by
  subst heq; cases e₂ <;> rfl

/-- toMonad is functorial: it preserves identity. -/
@[simp]
theorem liftEffect_eq_id (hle : eff ≤ eff) [Pure m] :
    liftEffect hle (α := α) (m := m) = id := by
  cases eff <;> rfl

/-- toMonad is functorial: it preserves composition. -/
def liftEffect_compose {e1 e2 e3 : EffectKind} {α : Type} [Pure m]
    (h12 : e1 ≤ e2)
    (h23 : e2 ≤ e3)
    (h13 : e1 ≤ e3 := le_trans h12 h23) :
    ((liftEffect (α := α) h23) ∘ (liftEffect h12)) = liftEffect (m := m) h13 := by
  cases e1 <;> cases e2 <;> cases e3 <;> (solve | rfl | contradiction)

@[simp]
theorem pure_liftEffect {eff₁ eff₂ : EffectKind}
    (hle : eff₁ ≤ .pure) [Monad m] (x : eff₁.toMonad m α) :
    (Pure.pure (liftEffect hle x) : eff₂.toMonad m α)
    = liftEffect (by cases hle; constructor) x := by
  obtain rfl : eff₁ = .pure := eq_of_le_pure hle
  cases eff₂ <;> rfl

/-!
## `toMonad` coercion
-/

/--
Coerce a value of type `eff.toMonad m α` into a monadic value `m α`, by applying
either `pure` or the identity, depending on the effect `eff`.

NOTE: This is simply `liftEffect` with the second effect fixed to be impure.
-/
@[simp, simp_denote]
def coe_toMonad [Pure m] {eff : EffectKind} : eff.toMonad m α → m α :=
  liftEffect (le_impure eff)

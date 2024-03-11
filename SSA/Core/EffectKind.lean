/- Kinds of effects, either pure or impure -/
inductive EffectKind
| pure -- pure effects.
| impure -- impure, lives in IO.
deriving Repr, DecidableEq

@[reducible]
def EffectKind.toType2 (e : EffectKind) (m : Type → Type) : Type → Type :=
  match e with
  | pure => Id
  | impure => m

section EffectKind
variable {e : EffectKind} {m : Type → Type}

instance [Functor m] : Functor (e.toType2 m) := by cases e <;> infer_instance
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (e.toType2 m) := by
  cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (EffectKind.toType2 .impure m) := inferInstance
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (EffectKind.toType2 .pure m) := inferInstance

instance [SeqLeft m]  : SeqLeft (e.toType2 m)  := by cases e <;> infer_instance
instance [SeqRight m] : SeqRight (e.toType2 m) := by cases e <;> infer_instance
instance [Seq m]      : Seq (e.toType2 m)      := by cases e <;> infer_instance

instance [Applicative m] : Applicative (e.toType2 m) := by cases e <;> infer_instance
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (e.toType2 m) := by
  cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (EffectKind.toType2 .impure m) := inferInstance
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (EffectKind.toType2 .pure m) := inferInstance

instance [Bind m] : Bind (e.toType2 m)   := by cases e <;> infer_instance
instance [Monad m] : Monad (e.toType2 m) := by cases e <;> infer_instance
instance [Monad m] [LawfulMonad m] : LawfulMonad (e.toType2 m) := by cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Monad m] : Monad (EffectKind.toType2 .pure m)   := inferInstance
instance [Monad m] : Monad (EffectKind.toType2 .impure m) := inferInstance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Monad m] [LawfulMonad m] : LawfulMonad (EffectKind.toType2 .impure m) := inferInstance
instance [Monad m] [LawfulMonad m] : LawfulMonad (EffectKind.toType2 .pure m) := inferInstance

end EffectKind

def EffectKind.return [Monad m] (e : EffectKind) (a : α) : e.toType2 m α := return a

@[simp] -- return is normal form.
def EffectKind.return_eq [Monad m] (e : EffectKind) (a : α) : e.return a = (return a : e.toType2 m α) := by rfl

@[simp]
def EffectKind.return_pure_toType2_eq (a : α) : (return a : EffectKind.pure.toType2 m α) = a := rfl

@[simp]
def EffectKind.return_impure_toType2_eq [Monad m] (a : α) : (return a : EffectKind.impure.toType2 m α) = (return a : m α) := rfl

inductive EffectKind.le : EffectKind → EffectKind → Prop
  | pure_le (e) : le .pure e
  | le_impure (e) : le e .impure

@[simp]
def EffectKind.decLe (e e' : EffectKind) : Decidable (EffectKind.le e e') :=
  match e with
  | .pure => match e' with
    | .pure => isTrue (by constructor)
    | .impure => isTrue (by constructor)
  | .impure => match e' with
    | .pure => isFalse (by intro; contradiction)
    | .impure => isTrue (by constructor)


instance : LE EffectKind where le := EffectKind.le
instance : DecidableRel (LE.le (α := EffectKind)) := EffectKind.decLe

@[simp]
theorem EffectKind.eq_of_le_pure {e : EffectKind}
    (he : e ≤ EffectKind.pure) : e = EffectKind.pure := by
  cases he; rfl


@[simp] theorem EffectKind.not_impure_le_pure : ¬(EffectKind.impure ≤ EffectKind.pure) := by
  intro; contradiction

@[simp] theorem EffectKind.pure_le (e : EffectKind) : EffectKind.pure ≤ e := le.pure_le e
@[simp] theorem EffectKind.le_impure (e : EffectKind) : e ≤ EffectKind.impure := le.le_impure e

@[simp] theorem EffectKind.le_refl (e : EffectKind) : e ≤ e := by cases e <;> constructor

@[simp]
theorem EffectKind.le_trans {e1 e2 e3 : EffectKind} (h12: e1 ≤ e2) (h23: e2 ≤ e3) : e1 ≤ e3 := by
  cases e1 <;> cases e2 <;> cases e3 <;> simp_all

@[simp]
theorem EffectKind.le_antisym {e1 e2 : EffectKind} (h12: e1 ≤ e2) (h21: e2 ≤ e1) : e1 ≤ e2 := by
  cases e1 <;> cases e2 <;> simp_all

theorem EffectKind.le_of_eq {e1 e2 : EffectKind} (h : e1 = e2) : e1 ≤ e2 := by
  subst h
  cases e1 <;> simp

def EffectKind.union : EffectKind → EffectKind → EffectKind
| .pure, .pure => .pure
| _, _ => .impure

@[simp] def EffectKind.pure_union_pure_eq : EffectKind.union .pure .pure = .pure := rfl
@[simp] def EffectKind.impure_union_eq : EffectKind.union .impure e = .impure := rfl
@[simp] def EffectKind.union_impure_eq : EffectKind.union e .impure = .impure := by cases e <;> rfl


/-- Given (e1 ≤ e2), we can get a morphism from e1.toType2 x → e2.toType2 x.
Said differently, this is a functor from the skeletal category of EffectKind to Lean. -/
def EffectKind.toType2_hom [Monad m] {e1 e2 : EffectKind} {α : Type}
    (hle : e1 ≤ e2) (v1 : e1.toType2 m α) : e2.toType2 m α :=
  match e1, e2, hle with
    | .pure, .pure, _ | .impure, .impure, _ => v1
    | .pure, .impure, _ => return v1

-- /-- Any value `v : e.toType2 ..` with effect `e` can be transformed to have the `impure` effect -/
-- def EffectKind.promoteToImpure [Monad m] {α : Type} :
--     (e : EffectKind) → e.toType2 m α → EffectKind.impure.toType2 m α
--   | .pure, v => return v
--   | .impure, v => v

@[simp] theorem EffectKind.toType2_hom_pure_pure [Monad m] (hle : pure ≤ pure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = id :=
  rfl

@[simp] theorem EffectKind.toType2_hom_pure_impure [Monad m] (hle : pure ≤ impure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = Pure.pure :=
  rfl

/-- Forded version of `toType2_hom_pure_impure` -/
theorem EffectKind.toType2_hom_eq_pure_cast {m : Type → Type} [Monad m]
    {eff : EffectKind} (eff_eq : eff = .pure) (eff_le : eff ≤ .impure) :
    EffectKind.toType2_hom eff_le = fun (x : eff.toType2 m α) =>
      Pure.pure (cast (by rw [eff_eq]; rfl) x) := by
  subst eff_eq; rfl

@[simp] theorem EffectKind.toType2_hom_impure_impure [Monad m] (hle : impure ≤ impure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = id :=
  rfl

@[simp] theorem EffectKind.toType2_hom_pure [Monad m] {e} (hle : e ≤ EffectKind.pure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = cast (by rw [eq_of_le_pure hle]) := by
  cases hle; rfl

@[simp] theorem Effectkind.toType2_hom_impure [Monad m] {e} (hle : e ≤ EffectKind.impure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = match e with
      | .pure => fun v => return v
      | .impure => id := by
  cases e <;> rfl

/-- toType2 is functorial: it preserves identity. -/
@[simp]
theorem EffectKind.toType2_hom_eq_id (hle : eff ≤ eff) [Monad m] :
    EffectKind.toType2_hom hle (α := α) (m := m) = id  := by
  cases eff <;> rfl

/-- toType2 is functorial: it preserves composition. -/
def EffectKind.toType2_hom_compose {e1 e2 e3 : EffectKind} {α : Type} [Monad m]
    (h12 : e1 ≤ e2)
    (h23: e2 ≤ e3)
    (h13: e1 ≤ e3 := EffectKind.le_trans h12 h23) :
    ((EffectKind.toType2_hom (α := α) h23) ∘ (EffectKind.toType2_hom h12)) = EffectKind.toType2_hom (m := m) h13 := by
  cases e1 <;> cases e2 <;> cases e3 <;> (solve | rfl | contradiction)

instance (eff : EffectKind) {m} [Monad m] : MonadLiftT (eff.toType2 m) m where
  monadLift x := match eff with
    | .pure   => return x
    | .impure => x

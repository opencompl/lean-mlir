import Std.Data.Option.Lemmas
import Std.Data.Array.Lemmas
import Std.Data.Array.Init.Lemmas
import Mathlib.Data.List.Indexes
import Mathlib.Data.Fin.Basic

/-!

## Context & Variables

Defines the `Ty`, `Ctxt` and `Ctxt.Var` types
-/

/-- A very simple type universe. -/
inductive Ty
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
def Ty.toType
  | nat => Nat
  | bool => Bool


noncomputable section

/-- A context is basicallty a list of `Ty`, but we make it a constant here to be
implemented later -/
axiom Ctxt : Type

/-- The empty context -/
axiom Ctxt.empty : Ctxt

instance : EmptyCollection Ctxt := ⟨Ctxt.empty⟩

/-- Add a `Ty` to a context -/
axiom Ctxt.snoc : Ctxt → Ty → Ctxt

/-- A `Γ.Var t` is a variable of Type `t` in a context `Γ`   -/
axiom Ctxt.Var (Γ : Ctxt) (t : Ty) : Type

@[instance]
axiom Ctxt.Var.decidableEq {Γ : Ctxt} {t : Ty} : DecidableEq (Ctxt.Var Γ t)

/-- The last variable in a context, i.e. the most recently added. -/
axiom Ctxt.Var.last (Γ : Ctxt) (t : Ty) : Ctxt.Var (Ctxt.snoc Γ t) t

/-- The empty Context has no variables, so we can add this eliminator. -/
axiom Ctxt.Var.emptyElim {α : Sort _} {t : Ty} : Ctxt.Var ∅ t → α  

/-- Take a variable in a context `Γ` and get the corresponding variable
in context `Γ.snoc t`. This is marked as a coercion. -/
@[coe]
axiom Ctxt.Var.toSnoc {Γ : Ctxt} {t t' : Ty} : 
    Ctxt.Var Γ t → Ctxt.Var (Ctxt.snoc Γ t') t 

-- axiom Ctxt.append : Ctxt → Ctxt → Ctxt

-- axiom Ctxt.append_empty (Γ : Ctxt) : Ctxt.append Γ ∅ = Γ

-- axiom Ctxt.append_snoc (Γ Γ' : Ctxt) (t : Ty) : 
--   Ctxt.append Γ (Ctxt.snoc Γ' t) = (Γ.append Γ').snoc t

-- axiom Ctxt.Var.inl {Γ Γ' : Ctxt} {t : Ty} (v : Var Γ t) : 
--   Var (Ctxt.append Γ Γ') t

-- axiom Ctxt.Var.inr {Γ Γ' : Ctxt} {t : Ty} (v : Var Γ' t) :
--   Var (Ctxt.append Γ Γ') t

/-- This is an induction principle that case splits on whether or not a variable 
is the last variable in a context. -/
@[elab_as_elim]
axiom Ctxt.Var.casesOn 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : (Γ.snoc t').Var t)
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      motive Γ t t' v

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to the last variable -/
@[simp]
axiom Ctxt.Var.casesOn_last
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t : Ty}
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
    Ctxt.Var.casesOn (motive := motive)
        (Ctxt.Var.last Γ t) toSnoc last = last

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to a previous variable,
that is not the last one. -/
@[simp]
axiom Ctxt.Var.casesOn_toSnoc 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : Γ.Var t)
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      Ctxt.Var.casesOn (motive := motive) (Ctxt.Var.toSnoc (t' := t') v) toSnoc last = toSnoc v

theorem toSnoc_injective {Γ : Ctxt} {t t' : Ty} : 
    Function.Injective (@Ctxt.Var.toSnoc Γ t t') := by
  let ofSnoc : (Γ.snoc t').Var t → Option (Γ.Var t) :=
    fun v => Ctxt.Var.casesOn v some none
  intro x y h
  simpa using congr_arg ofSnoc h
  

-- axiom Ctxt.Var.appendCasesOn 
--     {motive : (Γ Γ' : Ctxt) → (t : Ty) → (Γ.append Γ').Var t → Sort _}
--     {Γ Γ' : Ctxt} {t : Ty} (v : (Γ.append Γ').Var t)
--     (inl : {Γ Γ' : Ctxt} → (v : Γ.Var t) → motive Γ Γ' t v.inl)
--     (inr : {Γ Γ' : Ctxt} → (v : Γ'.Var t) → motive Γ Γ' t v.inr) :
--       motive Γ Γ' t v

-- @[simp]
-- axiom Ctxt.Var.appendCasesOn_inl
--     {motive : (Γ Γ' : Ctxt) → (t : Ty) → (Γ.append Γ').Var t → Sort _}
--     {Γ Γ' : Ctxt} {t : Ty} (v : Γ.Var t)
--     (inl : {Γ Γ' : Ctxt} → (v : Γ.Var t) → motive Γ Γ' t v.inl)
--     (inr : {Γ Γ' : Ctxt} → (v : Γ'.Var t) → motive Γ Γ' t v.inr) :
--     Ctxt.Var.appendCasesOn (motive := motive)
--        (v.inl : (Γ.append Γ').Var t) inl inr = inl v

-- @[simp]
-- axiom Ctxt.Var.appendCasesOn_inr
--     {motive : (Γ Γ' : Ctxt) → (t : Ty) → (Γ.append Γ').Var t → Sort _}
--     {Γ Γ' : Ctxt} {t : Ty} (v : Γ'.Var t)
--     (inl : {Γ Γ' : Ctxt} → (v : Γ.Var t) → motive Γ Γ' t v.inl)
--     (inr : {Γ Γ' : Ctxt} → (v : Γ'.Var t) → motive Γ Γ' t v.inr) :
--     Ctxt.Var.appendCasesOn (motive := motive)
--        (v.inr : (Γ.append Γ').Var t) inl inr = inr v

instance {Γ : Ctxt} : Coe (Γ.Var t) ((Γ.snoc t').Var t) := ⟨Ctxt.Var.toSnoc⟩

/-- Given a change of variables map from `Γ` to `Γ'`, extend it to 
a map `Γ.snoc t` to `Γ'.snoc t` -/
@[simp] 
def Ctxt.Var.snocMap {Γ Γ' : Ctxt} {t : Ty}
    (f : (t : Ty) → Γ.Var t → Γ'.Var t) :
    (t' : Ty) → (Γ.snoc t).Var t' → (Γ'.snoc t).Var t' :=
  fun _ v => Ctxt.Var.casesOn v (fun v f => (f _ v).toSnoc) 
    (fun _ => Ctxt.Var.last _ _) f

end
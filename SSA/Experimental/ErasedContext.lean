import Mathlib.Data.Erased
import Mathlib.Data.Finset.Basic

/-- A very simple type universe. -/
inductive Ty
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
def Ty.toType
  | nat => Nat
  | bool => Bool

def Ctxt : Type :=
  -- Erased <| List Ty
  List Ty

namespace Ctxt

-- def empty : Ctxt := Erased.mk []
def empty : Ctxt := []

instance : EmptyCollection Ctxt := ⟨Ctxt.empty⟩

@[match_pattern]
def snoc : Ctxt → Ty → Ctxt :=
  -- fun tl hd => do return hd :: (← tl)
  fun tl hd => hd :: tl

/-- Turn a list of types into a context -/
@[coe, simp]
def ofList : List Ty → Ctxt :=
  -- Erased.mk
  fun Γ => Γ 
  

def Var (Γ : Ctxt) (t : Ty) : Type :=
  -- { i : Nat // Γ.out.get? i = some t }
  { i : Nat // Γ.get? i = some t }

namespace Var

instance : DecidableEq (Var Γ t) := by
  delta Var
  infer_instance

@[match_pattern]
def last (Γ : Ctxt) (t : Ty) : Ctxt.Var (Ctxt.snoc Γ t) t :=
  ⟨0, by simp [snoc, List.get?]⟩

def emptyElim {α : Sort _} {t : Ty} : Ctxt.Var ∅ t → α :=
  fun ⟨_, h⟩ => by 
    simp [EmptyCollection.emptyCollection, empty] at h


/-- Take a variable in a context `Γ` and get the corresponding variable
in context `Γ.snoc t`. This is marked as a coercion. -/
@[coe]
def toSnoc {Γ : Ctxt} {t t' : Ty} (var : Var Γ t) : Var (snoc Γ t') t  :=
  ⟨var.1+1, by cases var; simp_all [snoc]⟩

@[simp]
theorem zero_eq_last {Γ : Ctxt} {t : Ty} (h) :
    ⟨0, h⟩ = last Γ t :=
  rfl

@[simp]
theorem succ_eq_toSnoc {Γ : Ctxt} {t : Ty} {w} (h : (Γ.snoc t).get? (w+1) = some t') :
    ⟨w+1, h⟩ = toSnoc ⟨w, h⟩ :=
  rfl


  
/-- This is an induction principle that case splits on whether or not a variable 
is the last variable in a context. -/
@[elab_as_elim]
def casesOn 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : (Γ.snoc t').Var t)
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      motive Γ t t' v :=
  match v with
    | ⟨0, h⟩ => 
        cast (by 
          simp [snoc] at h
          subst h
          simp [Ctxt.Var.last]
          ) <| @last Γ t
    | ⟨i+1, h⟩ =>
        toSnoc ⟨i, by simpa [snoc] using h⟩

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to the last variable -/
@[simp]
def casesOn_last
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t : Ty}
    (base : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
    Ctxt.Var.casesOn (motive := motive)
        (Ctxt.Var.last Γ t) base last = last :=
  rfl

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to a previous variable,
that is not the last one. -/
@[simp]
def casesOn_toSnoc 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : Γ.Var t)
    (base : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      Ctxt.Var.casesOn (motive := motive) (Ctxt.Var.toSnoc (t' := t') v) base last = base v :=
  rfl

end Var
  
theorem toSnoc_injective {Γ : Ctxt} {t t' : Ty} : 
    Function.Injective (@Ctxt.Var.toSnoc Γ t t') := by
  let ofSnoc : (Γ.snoc t').Var t → Option (Γ.Var t) :=
    fun v => Ctxt.Var.casesOn v some none
  intro x y h
  simpa using congr_arg ofSnoc h

abbrev Hom (Γ Γ' : Ctxt) := ⦃t : Ty⦄ → Γ.Var t → Γ'.Var t

def Hom.snocMap {Γ Γ' : Ctxt} (f : Hom Γ Γ') {t : Ty} : 
    (Γ.snoc t).Hom (Γ'.snoc t) := by
  intro t' v
  cases v using Ctxt.Var.casesOn with
  | toSnoc v => exact Ctxt.Var.toSnoc (f v)
  | last => exact Ctxt.Var.last _ _

instance {Γ : Ctxt} : Coe (Γ.Var t) ((Γ.snoc t').Var t) := ⟨Ctxt.Var.toSnoc⟩

/-- A valuation for a context. Provide a way to evaluate every variable in a context. -/
def Valuation (Γ : Ctxt) : Type :=
  ⦃t : Ty⦄ → Γ.Var t → t.toType

instance : Inhabited (Ctxt.Valuation ∅) := ⟨fun _ v => v.emptyElim⟩ 

/-- Make a valuation for `Γ.snoc t` from a valuation for `Γ` and an element of `t.toType`. -/
def Valuation.snoc {Γ : Ctxt} {t : Ty} (s : Γ.Valuation) (x : t.toType) : 
    (Γ.snoc t).Valuation := by
  intro t' v
  revert s x
  refine Ctxt.Var.casesOn v ?_ ?_
  . intro _ _ _ v s _; exact s v
  . intro _ _ _ x; exact x

@[simp]
theorem Valuation.snoc_last {Γ : Ctxt} {t : Ty} (s : Γ.Valuation) (x : t.toType) : 
    (s.snoc x) (Ctxt.Var.last _ _) = x := by 
  simp [Ctxt.Valuation.snoc]

@[simp]
theorem Valuation.snoc_toSnoc {Γ : Ctxt} {t t' : Ty} (s : Γ.Valuation) (x : t.toType) 
    (v : Γ.Var t') : (s.snoc x) v.toSnoc = s v := by
  simp [Ctxt.Valuation.snoc]



/- ## VarSet -/

/-- A `Ty`-indexed family of sets of variables in context `Γ` -/
def VarSet (Γ : Ctxt) : Type := 
  (t' : Ty) → Finset (Γ.Var t')

namespace VarSet

/-- A `VarSet` with exactly one variable `v` -/
@[simp]
def ofVar {Γ : Ctxt} (v : Γ.Var t) : VarSet Γ :=
  fun t' => if ty_eq : t = t' then {ty_eq ▸ v} else {}

@[simp]
instance : EmptyCollection (VarSet Γ) := ⟨fun _ => ∅⟩

@[simp]
instance : Union (VarSet Γ) := ⟨fun S₁ S₂ t => S₁ t ∪ S₂ t⟩

end VarSet


end Ctxt

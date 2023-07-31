import Mathlib.Tactic
import Mathlib.Data.Erased
import Mathlib.Data.FinEnum

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
  Erased <| List Ty

namespace Ctxt

@[match_pattern]
def empty : Ctxt := Erased.mk []

instance : EmptyCollection Ctxt := ⟨Ctxt.empty⟩

@[match_pattern]
def snoc : Ctxt → Ty → Ctxt :=
  fun tl hd => do return hd :: (← tl)

@[simp]
theorem out_empty : Erased.out empty = [] := by 
  simp[empty]

@[simp]
theorem out_empty' : Erased.out (∅ : Ctxt) = [] := by 
  simp[EmptyCollection.emptyCollection]

@[simp]
theorem out_snoc : Erased.out (snoc Γ t) = t :: (Erased.out Γ) := by
  simp[snoc]


def Var (Γ : Ctxt) (t : Ty) : Type :=
  { i : Nat // Γ.out.get? i = some t }

namespace Var

instance : DecidableEq (Var Γ t) := 
  fun ⟨i, ih⟩ ⟨j, jh⟩ => match inferInstanceAs (Decidable (i = j)) with
    | .isTrue h => .isTrue <| by simp_all
    | .isFalse h => .isFalse <| by intro hc; apply h; apply Subtype.mk.inj hc

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

/-!
## Induction / Case-analysis
-/

@[elab_as_elim]
noncomputable def inductionOn {motive : Ctxt → Sort u}
    (Γ : Ctxt)
    (empty : motive .empty)
    (snoc : (Γ : Ctxt) → (t : Ty) → motive Γ → motive (snoc Γ t)) :
    motive Γ :=
  cast (by simp) <|
    List.recOn (motive := fun as => motive <| Erased.mk as)
      Γ.out empty (fun t Γ ih => cast (by simp[Ctxt.snoc]) <| snoc (Erased.mk Γ) t ih)

-- set_option pp.analyze true
-- set_option pp.proofs true
-- @[simp]
-- theorem inductionOn_empty {motive : Ctxt → Sort u} (empty : motive .empty) 
--     (snoc : (Γ : Ctxt) → (t : Ty) → motive Γ → motive (snoc Γ t)) : 
--     inductionOn Ctxt.empty empty snoc = empty := by
--   simp [inductionOn]
--   have m_eq : motive (Erased.mk []) = motive (Erased.mk (Erased.out Ctxt.empty)) := by simp
--   have : 
--       cast (by simp) (List.rec (motive := fun x => motive <| Erased.mk x)
--         empty (fun t Γ ih => cast (inductionOn.proof_2 t Γ) (snoc (Erased.mk Γ) t ih))
--         (Erased.out Ctxt.empty))
--       = (List.rec (motive := fun x => motive <| Erased.mk x)
--           empty
--           (fun t Γ ih => cast (inductionOn.proof_2 t Γ) (snoc (Erased.mk Γ) t ih))
--           []) := by
--     simp
--     rw[empty_out]; rfl
      
  
  
--   have :
--     (fun t Γ (h : Erased.out Ctxt.empty = t :: Γ) => 
--       cast (inductionOn.proof_1 Ctxt.empty t Γ h) (snoc (Erased.mk Γ) t))
--     = (fun _ _ _ => empty) := by 
--       funext _ _ h
--       simp[Ctxt.empty] at h
--   simp only [this, cast_eq]
--   simp only [Ctxt.empty]
--   rw [Erased.out_mk]



@[elab_as_elim, eliminator]
noncomputable def casesOn {motive : Ctxt → Sort u}
    (Γ : Ctxt)
    (empty : motive .empty)
    (snoc : (Γ : Ctxt) → (t : Ty) → motive (snoc Γ t)) :
    motive Γ :=
  match h : Γ.out with
    | [] => cast (by simp[Ctxt.empty, ←h]) empty
    | t::Γ => cast (by simp[Ctxt.snoc, ←h]) <| snoc (Erased.mk Γ) t

@[simp]
theorem casesOn_empty {motive : Ctxt → Sort u} (empty : motive .empty) 
    (snoc : (Γ : Ctxt) → (t : Ty) → motive (snoc Γ t)) : 
    casesOn Ctxt.empty empty snoc = empty := by
  simp only [casesOn]
  have :
    (fun t Γ (h : Erased.out Ctxt.empty = t :: Γ) => 
      cast (casesOn.proof_2 (motive := motive) Ctxt.empty t Γ h) (snoc (Erased.mk Γ) t))
    = (fun _ _ _ => empty) := by 
      funext _ _ h
      simp[Ctxt.empty] at h
  simp only [this, cast_eq]
  simp only [Ctxt.empty]
  rw [Erased.out_mk]

@[simp]
theorem casesOn_snoc {motive : Ctxt → Sort u} (empty : motive .empty) 
    (snoc : (Γ : Ctxt) → (t : Ty) → motive (snoc Γ t)) : 
    casesOn (Ctxt.snoc Γ t) empty snoc = (snoc Γ t) := by
  simp only [casesOn]
  have :  
      (fun (h : Erased.out (Ctxt.snoc Γ t) = []) => 
        cast (casesOn.proof_1 (Ctxt.snoc Γ t) h) empty)
      = (fun _ => snoc Γ t) := by 
    funext h
    simp[Ctxt.snoc] at h
  rw [this]
  have :
      (fun t' Γ' h =>
        cast (casesOn.proof_2 (motive := motive) (Ctxt.snoc Γ t) t' Γ' h) (snoc (Erased.mk Γ') t'))
      = (fun _ _ _ => snoc Γ t) := by
    funext t' Γ' h
    unfold casesOn.proof_2
    dsimp [Ctxt.snoc] at h
    simp at h
    rcases h with ⟨h₁, h₂⟩
    cases h₁
    have : Γ = Erased.mk Γ' := by rw[←h₂]; simp
    cases this
    simp
  rw [this]
  simp [Ctxt.snoc]
  rw [Erased.out_mk]
  
theorem toSnoc_injective {Γ : Ctxt} {t t' : Ty} : 
    Function.Injective (@Ctxt.Var.toSnoc Γ t t') := by
  let ofSnoc : (Γ.snoc t').Var t → Option (Γ.Var t) :=
    fun v => Ctxt.Var.casesOn v some none
  intro x y h
  simpa using congr_arg ofSnoc h


namespace Var

/-- Given a partial change of variables map from `Γ` to `Γ'`, extend it to 
a map `Γ.snoc t` to `Γ'.snoc t` -/
@[simp] 
def snocMap? {Γ Γ' : Ctxt} {t : Ty}
    (f : (t : Ty) → Γ.Var t → Option (Γ'.Var t)) :
    (t' : Ty) → (Γ.snoc t).Var t' → Option ((Γ'.snoc t).Var t') :=
  fun _ v => Ctxt.Var.casesOn v (fun v f => (f _ v).map Var.toSnoc) 
    (fun _ => some <| Ctxt.Var.last _ _) f

/-- Given a total change of variables map from `Γ` to `Γ'`, extend it to 
a map `Γ.snoc t` to `Γ'.snoc t` -/
@[simp] 
def snocMap {Γ Γ' : Ctxt} {t : Ty}
    (f : (t : Ty) → Γ.Var t → Γ'.Var t) :
    (t' : Ty) → (Γ.snoc t).Var t' → (Γ'.snoc t).Var t' :=
  fun _ v => Ctxt.Var.casesOn v (fun v f => (f _ v).toSnoc) 
    (fun _ => Ctxt.Var.last _ _) f

/-- If two variables have the same index, then their types are equal -/
theorem type_eq_of_index_eq {Γ : Ctxt} {v : Γ.Var t} {w : Γ.Var u} (h : v.1 = w.1) : t = u := by
  rcases v with ⟨v, h₁⟩
  rcases w with ⟨w, h₂⟩
  cases h
  apply Option.some_inj.mp
  rw[←h₁, ←h₂]

/-- If two variables have the same index, then they are (heterogenously) equal -/
theorem heq_of_index_eq {Γ : Ctxt} {v : Γ.Var t} {w : Γ.Var u} (h : v.1 = w.1) : HEq v w := by
  rcases v with ⟨v, h₁⟩
  rcases w with ⟨w, h₂⟩
  cases (type_eq_of_index_eq h)
  cases h
  rfl
  
  
  

end Var
  


  








namespace Var

protected def isHeq {Γ : Ctxt} (v₁ : Γ.Var t₁) (v₂ : Γ.Var t₂) : Bool :=
  if h : t₂ = t₁ then
    v₁ = cast (by congr) v₂
  else
    false

-- theorem isHeq_lawful : Var.isHeq v₁ v₂ ↔ HEq v₁ v₂ := by
--   simp[Var.isHeq]
--   split_ifs
--   next h =>
--     cases h
--     simp[cast_eq]
--     constructor
--     . exact of_decide_eq_true 
--     . exact decide_eq_true
--   . constructor
--     . apply False.elim
--     . intro h
--       have type_eq := type_eq_of_heq h
--       simp [Var] at type_eq
      

end Var


/-
## Sized context
We introduce the `SizedCtxt` type to allow some limited computation, by bundling an erased context
with a (non-erased) natural number storing the contexts length
-/

/-- A computable way to keep track of the size of an erased context -/
def Size (Γ : Ctxt) : Type := { n // Γ.out.length = n}


/-- An erased context, whose size is available for computation. -/
structure SizedCtxt where
  ctxt : Ctxt
  size' : ctxt.Size

namespace SizedCtxt

def size (Γ : SizedCtxt) : Nat :=
  Γ.size'.val

instance {Γ : Ctxt} : Nonempty Γ.Size := ⟨⟨Γ.out.length, rfl⟩⟩

instance : Coe SizedCtxt Ctxt := ⟨SizedCtxt.ctxt⟩

instance : CoeDep SizedCtxt Γ Γ.ctxt.Size := ⟨Γ.size'⟩

/-- The empty context, plus its size -/
def empty : SizedCtxt := 
  ⟨Ctxt.empty, 0, by simp⟩

/-- Add a `Ty` to a context, incrementing the tracked size -/
def snoc : SizedCtxt → Ty → SizedCtxt := 
  fun ⟨Γ, ⟨n, h⟩⟩ t => ⟨Ctxt.snoc Γ t, n+1, by simp[h]⟩

end SizedCtxt



section Append

def append : Ctxt → Ctxt → Ctxt :=
  fun xs ys => do return List.append (← ys) (← xs)

instance : Append Ctxt := ⟨append⟩

@[simp]
theorem append_empty (Γ : Ctxt) : Γ ++ ∅ = Γ := by
  simp only [(· ++ ·), Append.append]
  simp[append, EmptyCollection.emptyCollection, empty]
  
@[simp]
theorem append_snoc (Γ Γ' : Ctxt) (t : Ty) : 
    Γ ++ (snoc Γ' t) = snoc (Γ ++ Γ') t := by
  simp only [(· ++ ·), Append.append]
  simp[append, snoc]

@[simp]
theorem _root_.List.get?_append_add :
    List.get? (xs ++ ys) (i + xs.length) = List.get? ys i := by
  induction xs
  . rfl
  . simp_all


/--
  Embed a variable from context `Γ` into `Γ ++ Γ'`.
  This means adding the Size of `Γ'` to the variable index, but the context is erased, so the
  caller has to keep track of this Size
-/
def Var.inl {Γ Γ' : Ctxt} {t : Ty} {len : Γ'.Size} : Var Γ t → Var (Γ ++ Γ') t
  | ⟨v, h⟩ => ⟨v + len.1, by 
      rcases len with ⟨len, ⟨⟩⟩
      simp[←h, (· ++ ·), Append.append, append, List.get?_append_add]
    ⟩

def Var.inr {Γ Γ' : Ctxt} {t : Ty} : Var Γ' t → Var (Γ ++ Γ') t
  | ⟨v, h⟩ => ⟨v, by 
      simp[(· ++ ·), Append.append, append]
      induction Γ' using Ctxt.inductionOn generalizing v 
      next =>
        simp[empty] at h
      next cons ih =>
        cases v
        case zero =>
          rw[←h]; simp
        case succ v =>
          simp_all
    ⟩


theorem append_assoc (Γ₁ Γ₂ Γ₃ : Ctxt) : Γ₁ ++ Γ₂ ++ Γ₃ = Γ₁ ++ (Γ₂ ++ Γ₃) := by
  simp[HAppend.hAppend, Append.append, append]
  congr 1
  apply Eq.symm
  apply List.append_assoc
  

end Append

/-!
  ## VarSet
-/

-- TODO: is this erased at runtime? It probably should be!
/-- A set of variables of potentially different types -/
abbrev VarSet (Γ : Ctxt) : Type :=
  (t : Ty) → Set (Γ.Var t)

namespace VarSet
variable {Γ : Ctxt}

instance : Union Γ.VarSet where
  union V₁ V₂ := fun t => V₁ t ∪ V₂ t

instance : EmptyCollection Γ.VarSet where
  emptyCollection := fun _ => ∅

instance : Singleton (Σt, Γ.Var t) Γ.VarSet where
  singleton := fun v _ w => v.2.1 = w.1

instance : HasSubset (Γ.VarSet) where
  Subset V₁ V₂ := ∀ t, V₁ t ⊆ V₂ t

instance : CoeOut (Γ.Var t) (Σt, Γ.Var t) where
  coe v := ⟨t, v⟩

/-- A `VarSet` is complete if it contains all variables in the context -/
def IsComplete (V : Γ.VarSet) : Prop :=
  ∀ t v, v ∈ V t


theorem mem_of_subset_mem {v : Γ.Var t} {V V' : Γ.VarSet} :
    V ⊆ V' → v ∈ V t → v ∈ V' t := by
  exact fun s m => s t m

end VarSet




/-!
  ## Var Fintype
-/
namespace Var
variable {Γ : Ctxt}

noncomputable def varsEnum (Γ : Ctxt) (t : Ty) : List (Γ.Var t) :=
  List.range Γ.out.length 
    |>.filterMap fun i => 
      if h : Γ.out.get? i = some t then
        some ⟨i, h⟩
      else 
        none

theorem _root_.List.le_length_of_get?_isSome : (List.get? as x).isSome → x < as.length := by
  sorry
    
noncomputable instance finEnum {t} : FinEnum (Ctxt.Var Γ t) :=
  .ofList (varsEnum Γ t) <| by
    rintro ⟨x, h⟩
    simp [varsEnum]
    use x
    constructor
    . apply List.le_length_of_get?_isSome
      rw[h]
      rfl
    . split_ifs
      rfl
      

noncomputable def extractWitnessOfExists {Γ : Ctxt} {t : Ty} {p : Γ.Var t → Prop}
    [DecidablePred p] :
    (∃ v, p v) → {v // p v} :=
  fun h =>
    let enum : FinEnum {v // p v} := by infer_instance
    have : 0 < enum.card := by
      rcases enum with ⟨card, eqv, _⟩
      cases card
      case succ =>
        simp
      case zero =>
        rcases h with ⟨v, h⟩
        apply Fin.elim0
        apply eqv.toFun
        exact ⟨v, h⟩
    enum.Equiv.invFun ⟨0, this⟩
  


end Var


/-!
  ## Context Homomorphism
-/

/-- A homomorphism between contexts is a map between variables of these contexts -/
abbrev hom (Γ Γ' : Ctxt) := ⦃t : Ty⦄ → Γ.Var t → Γ'.Var t

end Ctxt

export Ctxt (SizedCtxt)
import SSA.Projects.LeanMlirCommon.UnTyped.Basic
import SSA.Projects.LeanMlirCommon.SimplyTyped.Context
import Batteries.Data.List
import Mathlib.Tactic.Use

/-!
## Simple Intrinsically WellTyped MLIR programs
This module sets up a simple typesystem for MLIR programs, where the only terminator is
"return a value".

In particular:
  * This means there is no unstructured control flow (no jumping between basic blocks)
  * The type system assumes all variable are defined prior to usage (i.e., no graph regions)
  * We don't model dominance, only "closed from above" regions
  * The type system is structural
  * We define a concrete type for the context

We use `VarName` as the type of terminators, so that each terminator gives us exactly the variable
we should return.
-/

namespace MLIR.SimplyTyped

/-- The type of a region specifies the number and types of arguments to its entry block and
the region return type -/
structure RegionType (Ty : Type) where
  arguments : List Ty
  returnType : Ty
-- TODO: include a bool `closedFromAbove` field, to control variable inheritance

/-- The signature of a specific operation specifies:
* The number and types of its arguments,
* The number and types of its regions, and
* The type of it's return value -/
structure Signature (Ty : Type) where
  arguments : List Ty
  regions : List (RegionType Ty)
  returnType : Ty

/-- To implement `OpSignature` for a type of `Op`erations, we specify the signature of each
operation `op : Op` -/
class OpSignature (Op : Type) (Ty : outParam Type) where
  signature : Op → Signature Ty
open OpSignature (signature)

variable {Op Ty} [OpSignature Op Ty]

/-- For each expression `e` in `lets`, add `e.varName, (signature e).returnType` to the context -/
def Lets.outContext (lets : UnTyped.Lets Op VarName) (Γ_in : Context Ty) : Context Ty :=
  lets.inner.foldl (fun Γ e => Γ.push e.varName (signature e.op).returnType) Γ_in

@[simp] theorem Lets.outContext_cons (lets : List (UnTyped.Expr Op VarName)) (Γ_in : Context Ty) :
    Lets.outContext ⟨e :: lets⟩ Γ_in
    = (Lets.outContext ⟨lets⟩ (Γ_in.push e.varName (signature e.op).returnType)) := by
  simp [outContext]


/-!
# WellTyped
We define what it means for an untyped program to be well-formed under a specific context
-/
mutual

variable {Op Ty : Type} [OpSignature Op Ty]

def Expr.WellTyped (Γ : Context Ty) : UnTyped.Expr Op VarName → Ty → Prop
  | ⟨_, op, args, regions⟩, ty =>
    let ⟨argTys, rgnTys, retTy⟩ := signature op
    args.length = argTys.length
      ∧ (∀ x ∈ args.zip argTys, Γ.hasType x.fst x.snd)
    ∧ RegionList.WellTyped regions rgnTys
    ∧ ty = retTy

/-- -/
def Lets.WellTyped (Γ_in : Context Ty) : UnTyped.Lets Op VarName → Context Ty → Prop
  | ⟨[]⟩, Γ_out       => Γ_out = Γ_in -- Γ_out.ExtEq Γ_in
  | ⟨e :: es⟩, Γ_out  =>
      let eTy := (signature e.op).returnType
      Expr.WellTyped Γ_in e eTy ∧ Lets.WellTyped (Γ_in.push e.varName eTy) ⟨es⟩ Γ_out

def Body.WellTyped (Γ : Context Ty) : UnTyped.Body Op VarName → Ty → Prop
  | ⟨lets, v⟩, ty =>
      let Γ_out := Lets.outContext lets Γ
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ see `Lets.WellTyped.exists_iff` for the justification
      --                                  behind choosing this particular context
      Lets.WellTyped Γ lets Γ_out ∧ Γ_out.hasType v ty

def BasicBlock.WellTyped : UnTyped.BasicBlock Op VarName → RegionType Ty → Prop
  | ⟨_, args, prog⟩, ⟨argTys, retTy⟩ =>
      args.length = argTys.length ∧ Body.WellTyped (args.zip argTys) prog retTy

/-- Note that because we don't have branches between basic block, only the entry block to a region
actually matters. Any other blocks, if specified, are unreachable and may be ignored.
Also, regions are closed from above, so the well-formedness of a region does not depend on the
context of the outer region -/
def Region.WellTyped : UnTyped.Region Op VarName → RegionType Ty → Prop
  | ⟨entry, _⟩ => BasicBlock.WellTyped entry

/-- `RegionList.WellTyped regions regionTypes` holds when `regions` and `regionTypes` are of the
same length, and each `region` in the first list is welltyped according to the corresponing type
of the second list.
Morally, this can be expressed as
`regions.length = rgnTys.length ∧ ∀ r ∈ regions.zip rgnTys, Region.WellTyped r.fst r.snd`
However, we inline the definition to make the termination checker happy -/
def RegionList.WellTyped : List (UnTyped.Region Op VarName) → List (RegionType Ty) → Prop
  | [], [] => True
  | r :: rgns, rTy :: rgnTys => Region.WellTyped r rTy ∧ RegionList.WellTyped rgns rgnTys
  | _, _ => False

end

/-!
## Theorems
-/

theorem Expr.WellTyped.exists_iff {e : UnTyped.Expr Op VarName} {Γ : Context Ty} :
    (∃ ty, Expr.WellTyped Γ e ty) ↔ Expr.WellTyped Γ e (signature e.op).returnType := by
  rcases e with ⟨⟩; simp [WellTyped]

/-- There exists an output context for which a `Lets` is well-typed iff it is well-typed for
`Lets.outContext lets _`. This justifies the choice of this particular context in `Body.WellTyped`
-/
theorem Lets.WellTyped.exists_iff {lets : UnTyped.Lets Op VarName} {Γ_in : Context Ty} :
    (∃ Γ_out, Lets.WellTyped Γ_in lets Γ_out)
    ↔ Lets.WellTyped Γ_in lets (Lets.outContext lets Γ_in) := by
  constructor
  case mpr => intro h; exact ⟨_, h⟩
  case mp =>
    intro ⟨Γ_out, h⟩
    rcases lets with ⟨lets⟩
    induction lets generalizing Γ_in
    case nil => simp [WellTyped, outContext]
    case cons e lets ih =>
      rcases e with ⟨v, op, args, regions⟩
      simp only [WellTyped, UnTyped.Expr.op_mk, UnTyped.Expr.varName_mk] at h
      simpa [WellTyped, h, outContext] using ih h.right

/-- Justify the `RegionList.WellTyped` definition -/
@[simp] theorem RegionList.WellTyped.iff
    (regions : List (UnTyped.Region Op VarName)) (regionTypes : List (RegionType Ty)) :
    RegionList.WellTyped regions regionTypes
    ↔ regions.length = regionTypes.length
      ∧ ∀ r ∈ regions.zip regionTypes, Region.WellTyped r.fst r.snd := by
  induction regions generalizing regionTypes
  case nil =>
    cases regionTypes <;> simp [RegionList.WellTyped]
  case cons r regions ih =>
    cases regionTypes
    case nil => simp [RegionList.WellTyped]
    case cons rTy regionTypes =>
      simp only [RegionList.WellTyped, ih, List.length_cons, Nat.succ.injEq, List.zip_cons_cons,
        List.mem_cons, forall_eq_or_imp]
      constructor <;> (intro ⟨h₁, h₂, h₃⟩; simpa [h₁, h₂] using h₃)

/-!
### Congr
Show that well-typedness is preserved by extensionally equivalent contexts
TODO: this is no longer true, now that we've switched `Lets.WellTyped` to use equality
-/

-- theorem Expr.WellTyped_of_extEq {Γ Δ : Context Ty} (e : UnTyped.Expr Op VarName)
--     (h_eq : Γ.ExtEq Δ) : Expr.WellTyped Γ e t → Expr.WellTyped Δ e t := by
--   intro h
--   rcases e
--   unfold WellTyped at h ⊢
--   simp at h ⊢
--   rcases h with ⟨h₁, h₂, h₃, rfl⟩
--   refine ⟨h₁, ?_, h₃, rfl⟩
--   intro ⟨v, ty⟩
--   sorry -- TODO: finish this proof

-- theorem Lets.WellTyped_of_extEq {Γ_in Γ_out Δ_in Δ_out : Context Ty} {lets : UnTyped.Lets Op _}
--     (h_eq_in : Γ_in.ExtEq Δ_in) (h_eq_out : Γ_out.ExtEq Δ_out) :
--     Lets.WellTyped Γ_in lets Γ_out → Lets.WellTyped Δ_in lets Δ_out := by
--   intro h
--   rcases lets with ⟨lets⟩
--   induction lets
--   case nil =>
--     exact Context.ExtEq.trans h_eq_out.symm (Context.ExtEq.trans h h_eq_in)
--   case cons e lets ih =>
--     simp [WellTyped] at h ⊢
--     sorry -- TODO: finish

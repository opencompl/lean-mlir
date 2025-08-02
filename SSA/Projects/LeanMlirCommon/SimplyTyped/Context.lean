import SSA.Projects.LeanMlirCommon.UnTyped.Basic
import Batteries.Data.List.Lemmas

namespace MLIR.SimplyTyped

def Context (Ty : Type) : Type :=
  List (VarName × Ty)

namespace Context

/-- `Γ.hasType v ty` holds if `Γ` maps variable `v` to type `ty` -/
def hasType (Γ : Context Ty) (v : VarName) (ty : Ty) : Prop :=
  Γ.lookup v = some ty

/-- `Γ.hasType v ty` is decidable when our type universe has decidable equality -/
instance {Γ : Context Ty} [DecidableEq Ty] {v ty} :
    Decidable (Γ.hasType v ty) := by
  unfold hasType; infer_instance

/-- `Γ.push v ty` returns a context which maps `v` to `ty`, and works like `Γ` on all other
variables -/
def push (Γ : Context Ty) (v : VarName) (ty : Ty) : Context Ty :=
  (v, ty) :: Γ

@[simp] theorem hasType_push {Γ : Context Ty} :
    (Γ.push v ty).hasType v ty := by
  simp [push, hasType]

@[simp] theorem hasType_push_of_neq {Γ : Context Ty} (h : w ≠ v) :
    (Γ.push v ty).hasType w ty' ↔ Γ.hasType w ty' := by
  simp [push, hasType, List.lookup, (beq_eq_false_iff_ne).mpr h]

/-! ## `ExtEq`-/

/-- Two contexts are extensionally equal if they map each variable to the same type -/
def ExtEq (Γ Δ : Context Ty) : Prop :=
  ∀ v, Γ.lookup v = Δ.lookup v

@[simp] theorem ExtEq.rfl {Γ : Context Ty} : Γ.ExtEq Γ := by
  intro; rfl

theorem ExtEq.trans {Γ Δ Ξ : Context Ty} : Γ.ExtEq Δ → Δ.ExtEq Ξ → Γ.ExtEq Ξ := by
  unfold ExtEq
  intro h₁ h₂ v
  rw [h₁ v, h₂ v]
instance : Trans (@ExtEq Op) ExtEq ExtEq := ⟨ExtEq.trans⟩

theorem ExtEq.symm {Γ Δ : Context Ty} : Γ.ExtEq Δ → Δ.ExtEq Γ := by
  unfold ExtEq
  intro h v
  rw [h v]

import SSA.Core.WellTypedFramework
import SSA.Core.Util
import Mathlib.Data.Holor

#check Holor

/- Holor is profunctorial, covariant in the first argument and contavariant in the second argument. -/

/-- Mapping is covariant in the index set -/
def Holor.map (f : α → β) (h : Holor α ds) : Holor β ds :=
  f ∘ h

theorem Holor.map_functorial (f : α → β) (g : β → γ) (h : Holor α ds) : Holor.map g (Holor.map f h) = Holor.map (g ∘ f) h :=
  rfl

/-- Reindexing is contravariant in the index set -/
def Holor.reindex (ix : HolorIndex ds₂ → HolorIndex ds₁) (h : Holor α ds₁) : Holor α ds₂ :=
  λ ix₂ => h (ix ix₂)

theorem Holor.reindex_functorial (ix : HolorIndex ds₂ → HolorIndex ds₁) (iy : HolorIndex ds₃ → HolorIndex ds₂) (h : Holor α ds₁) : Holor.reindex iy (Holor.reindex ix h) = Holor.reindex (ix ∘ iy) h :=
  rfl
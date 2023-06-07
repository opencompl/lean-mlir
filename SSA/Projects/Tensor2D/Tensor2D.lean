import SSA.Core.WellTypedFramework
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Nat.Basic
import SSA.Core.Util


/-- Tensor2d with existential dimension sizes. -/
structure Tensor2d' (α : Type) where 
  n₀ : ℕ
  n₁ : ℕ
  mat : Matrix (Fin n₀) (Fin n₁) α


def Tensor2d'.transpose (t : Tensor2d' α) : Tensor2d' α where 
  n₀ := t.n₁
  n₁ := t.n₀  
  mat := t.mat.transpose

theorem Tensor2d'.transpose_transpose (t : Tensor2d' α) : t.transpose.transpose = t := rfl

def Tensor2d'.map (f : α → β) (t : Tensor2d' α) : Tensor2d' β where 
  n₀ := t.n₀
  n₁ := t.n₁
  mat := t.mat.map f

theorem Tensor2d'.map_functorial (g : β → γ) (f : α → β) (t : Tensor2d' α) : t.map (g ∘ f) = (t.map f).map g := rfl


/-- K combinator / constant function. -/
def const (a : α) (_b : β) : α := a

def Tensor2d'.fill (v : β) (t : Tensor2d' α) : Tensor2d' β := t.map (const v)

/-- extract a submatrix of (sz₀ × sz₁) size at offset (δ₀, δ₁). Fails if this is out of bounds. -/
def Tensor2d'.extract (δ₀ δ₁ : ℕ) (sz₀ sz₁ : ℕ) (t : Tensor2d' α) : Option (Tensor2d' α) := 
  if SZ0 : δ₀ + sz₀ ≤ t.n₀ then 
    if SZ1 : δ₁ + sz₁ ≤ t.n₁ then 
      {
        n₀ := sz₀,
        n₁ := sz₁,
        mat := Matrix.of fun (ix₀ : Fin sz₀) (ix₁ : Fin sz₁) => 
          have INBOUNDS0 : δ₀ + ix₀ < t.n₀ := by linarith[ix₀.isLt] 
          have INBOUNDS1 : δ₁ + ix₁ < t.n₁ := by linarith[ix₁.isLt] 
          t.mat ⟨δ₀ + ix₀, INBOUNDS0⟩ ⟨δ₁ + ix₁, INBOUNDS1⟩   
        : Tensor2d' α
      }
    else none
  else none

/-- This implies fill_extract -/
theorem Tensor2d'.map_extract (δ₀ δ₁ sz₀ sz₁ : ℕ) (t : Tensor2d' α) (f : α → β) :
  (t.map f).extract δ₀ δ₁ sz₀ sz₁ = (t.extract δ₀ δ₁ sz₀ sz₁).map (Tensor2d'.map f) := by {
    simp only [extract];
    have MAP_n₀ : (map f t).n₀ = t.n₀ := rfl
    simp only [MAP_n₀]
    have MAP_n₁ : (map f t).n₁ = t.n₁ := rfl
    simp only [MAP_n₁]
    by_cases H₀ : δ₀ + sz₀ ≤ t.n₀ <;> simp[H₀];
    by_cases H₁ : δ₁ + sz₁ ≤ t.n₁ <;> simp[H₁];
    simp only [map, Matrix.map, Matrix.of_apply, Int.ofNat_add_ofNat, Eq.ndrec, Int.rawCast, Int.cast_id,
      Nat.rawCast, Nat.cast_id, Int.ofNat_eq_coe, eq_mp_eq_cast, id_eq]
}

theorem Tensor2d'.fill_extract (δ₀ δ₁ sz₀ sz₁ : ℕ) (t : Tensor2d' α) (v : β) :
  (t.fill v).extract δ₀ δ₁ sz₀ sz₁ = (t.extract δ₀ δ₁ sz₀ sz₁).map (Tensor2d'.fill v) := by {
    simp only[fill, Tensor2d'.map_extract]
}
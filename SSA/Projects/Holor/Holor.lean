/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import LeanMLIR.Framework
import LeanMLIR.Util
import Mathlib.Data.Holor
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.Algebra.Pi

/- Holor is profunctorial, covariant in the values and contavariant in the indexes. -/

/-- Mapping is covariant in the value -/
def Holor.map (f : α → β) (h : Holor α ds) : Holor β ds :=
  f ∘ h

theorem Holor.map_functorial (f : α → β) (g : β → γ) (h : Holor α ds) :
  Holor.map g (Holor.map f h) = Holor.map (g ∘ f) h :=
  rfl

/-- Reindexing is contravariant in the index -/
def Holor.reindex (ix : HolorIndex ds₂ → HolorIndex ds₁) (h : Holor α ds₁) : Holor α ds₂ :=
  λ ix₂ => h (ix ix₂)

theorem Holor.reindex_functorial
  (ix : HolorIndex ds₂ → HolorIndex ds₁) (iy : HolorIndex ds₃ → HolorIndex ds₂)
  (h : Holor α ds₁) : Holor.reindex iy (Holor.reindex ix h) = Holor.reindex (ix ∘ iy) h := rfl


/-- Pointiwse multiplication of holors. Lifts multiplicative structure into holor. -/
def Holor.pointwise_mul [Mul α] (h₁ h₂ : Holor α ds) : Holor α ds := fun ix => (h₁ ix) * (h₂ ix)

instance  [Mul α] : Mul (Holor α ds) where
  mul := Holor.pointwise_mul

theorem Holor.pointwise_mul_index [Mul α] (h₁ h₂ : Holor α ds) :
  (h₁ * h₂) i = h₁ i * h₂ i := rfl


/-- Holor inherits algebraic structures --/
instance [Semiring α] : Semiring (Holor α ds) :=
  by delta Holor; infer_instance

instance [CommSemiring α] : CommSemiring (Holor α ds) :=
  by delta Holor; infer_instance

instance [Ring α] : Ring (Holor α ds) :=
  by delta Holor; infer_instance

instance [CommRing α] : CommRing (Holor α ds) :=
  by delta Holor; infer_instance

instance [SMul M A] : SMul M (Holor A ds) := by
  delta Holor; infer_instance

/-- Fill a holor with a constant value 'a'. -/
def Holor.fill (a : α) : Holor α ds := fun _ => a

-- @chrishughes24:
-- given the map ralg : R -> Z(A),
-- I want to declare the map (r : R) -> (fill (ralg R) : Holor A ds).
-- This will be the map that turns (Holor A ds) into an R-algebra.
-- I'm not sure how to define this.
instance [CommSemiring R] [Semiring A] [Algebra R A] : Algebra R (Holor A ds) := Pi.algebra _ _

/-
inductive op
| none
| dup --Identity function : Tensor k → Tensor k
| add --Addition : Tensor k → Tensor k → Tensor k
| sub --Subtraction : Tensor k → Tensor k → Tensor k
| mul --Pointwise Multiplication : Tensor k → Tensor k → Tensor k
| div --Pointwise Division : Tensor k → Tensor k → Tensor k
| sqr --Pointwise Squaring : Tensor k → Tensor k
| sqrt --Pointwise Square Root : Tensor k → Tensor k
| sum -- Add 'em up : Tensor k → Tensor (identity of tensor product)
| mean -- Average 'em out : Tensor k → Tensor (identity of tensor product)
| repeat_ -- Complicated
| abs -- Pointwise
| sgn -- Pointwise
| neg -- Pointwise
| step -- Pointwise fun x => if x < 0 then 0 else 1
| relu -- Pointwise fun x => if x < 0 then 0 else x
| gelu -- Pointwise fun x => x * 0.5 * (1 + erf(x/sqrt(2)))
| silu -- Pointwise fun x => x * 1/ (1+exp(-x))
| norm -- not the sqrt of sum of squares
| rms_norm -- Don't know yet : Tensor k ->
  Tensor k rms(a) = sqrt(1/n * sum_i (a_i^2)), rms_norm i = a_i
| mul_mat -- Matrix multiplication, undefined on stuff that isn't a matrix
| scale -- Tensor 0 → Tensor k → Tensor k
| cpy -- identity function
| reshape -- Tensor → Shape → Tensor
  --Changes the data to fit new layout of same (linear algebra sense) dimension
| view1D -- Tensor → (Num_elements : ℕ) → (offset : ℕ) → Tensor
  --Output at i = input at i+offset output
| view2D -- Number of elements in 2 axes and offsets in 2 axes
| permute4D -- take a permutation of 4 numbers and Return a 4d tesnro with everything permuted
| transpose -- Matrix transpose
| get_rows -- (x : Matrix) (I : vector of Nats)  out(i,j) = x(I(i),j)
| diag_mask_inf -- Take a matrix and set upper triangle to -infinity
| soft_max -- Take a vector and exponentiate pointwise and normalize by L1-norm
| rope -- Screwed up rotatory positional embedding
| conv_1d_1s -- Polynomial multiplication of vectors
| conv_1d_2s -- Convolve 1d 2d
| flash_attn -- 3 input matrices Q K V, compute softmax (QKᵀ / sqrt(number of columns of q)) V
| flash_ff -- TODO
| count
-/

import SSA.Core.Framework
import SSA.Core.Util
-- import Mathlib.Data.Holor
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Algebra.BigOperators.Basic
import Mathlib.Algebra.Algebra.Pi
import Mathlib.Data.Matrix.Basic

abbrev DimSize := Additive ℕ
abbrev DimSize.ofNat (n : Nat) : DimSize := n

/-- Actually, I nee the ℕ to be ℕ*. -/
abbrev Shape := Finsupp ℕ (DimSize) -- finitely supported function with values in ℕ.

def HolorIndex (shape : Shape) : Type :=
  (dim : ℕ) → (Fin (shape dim))


/-- given a shape like [1xax1xb], a shift by `2` will make it [1x1x(1xax1xb)]. -/
noncomputable def Shape.shiftTowardsInfty (shape : Shape) (delta : ℕ) : Shape :=
  shape.comapDomain (fun i => i + delta) (by simp[Set.InjOn])

/-- given a shape like `[0xa]`, the rank is `2`. -/
def Shape.rank (shape : Shape) : ℕ := (Finset.max shape.support).unbot' 0

/-- contracting across indeces `ix1`, `ix2` makes both of the supports equal to 1. -/
noncomputable def Shape.append (s1 : Shape) (s2 : Shape) : Shape :=
  s1 + s2.shiftTowardsInfty s1.rank

def HolorIndex.drop (s1 s2 : Shape) (ix : HolorIndex (s1.append s2)) : HolorIndex s2 :=
  fun dim => sorry

def HolorIndex.take (s1 s2 : Shape) (ix : HolorIndex (s1.append s2)) : HolorIndex s1 :=
  fun dim => sorry

/-- contracting indeces ix1, ix2 erases both of the indices from the support. -/
noncomputable def Shape.contract (s : Shape) (ix1 ix2 : ℕ) :=
  (s.erase ix1).erase ix2

/-- insert `v` into the indeces `ix1, ix2`.. -/
noncomputable def Shape.expand (s : Shape) (ix1 ix2 : ℕ) (v : ℕ) :=
  (s.update ix1 v).update ix2 v

def HolorIndex.expand (h : HolorIndex (s.contract ix1 ix2)) (v : Fin (min (s ix1) (s ix2))) : HolorIndex s :=
  sorry
/-
  fun dim =>
    if dim₁ : dim = ix1
    then v
    else if dim₂ : dim = ix2
    then v
    else
      _
-/

/-
theorem Shape.append_apply_nat_plus (s1 s2 : Shape) (dim : ℕ) :
  (s1.append s2) dim = s2 (s1.rank + dim) := by
    simp[append, Finsupp.add_apply]
    simp[FunLike.coe]
-/

/-- Holor (indexed collections of tensor coefficients) -/
def Holor (α : Type) (shape : Shape) :=
  HolorIndex shape → α

/- create a 1D `Shape`-/
noncomputable def Shape.oned (n : DimSize) : Shape :=
  Finsupp.single 0 n

@[simp]
theorem Shape.oned_apply_zero (n : Nat) : (Shape.oned n) 0 = n := by
  simp[oned]

/- createa a 2D `Shape` -/
noncomputable def Shape.twod (n m : DimSize) : Shape :=
  let f₀ := (Finsupp.single 0 n)
  let f₁ := f₀.update 1 m
  f₁

@[simp]
theorem Shape.twod_apply_zero (m : Nat) {n : Nat}: (Shape.twod m n) 0 = m := by
  simp[twod]

@[simp]
theorem Shape.twod_apply_one {m : Nat} (n : Nat) : (Shape.twod m n) 1 = n := by
  simp[twod]

/-- create a 1D holor from a (Fin n → alpha). -/
def Holor.ofFn (f : Fin n → R) : Holor R (Shape.oned n) :=
  fun ixs =>
    let ix₀:= Shape.oned_apply_zero n ▸ ixs 0
    f (ix₀)

/-- create a 1D holor from a (Fin m → Fin n → alpha). -/
def Holor.ofMatrix (f : Fin m → Fin n → R) : Holor R (Shape.twod m n) :=
  fun ixs =>
    let ix₀:= Shape.twod_apply_zero m ▸ ixs 0
    let ix₁ := Shape.twod_apply_one n ▸ ixs 1
    f ix₀ ix₁

/-- Fill a holor with a constant value 'a'. -/
def Holor.fill (a : α) : Holor α ds := fun _ => a

/-- I'm sure this is right. -/
def Holor.tensorProduct {rank rank' : ℕ} (R : Type) [CommRing R]
  (h1 : Holor R s1) (h2 : Holor R s2) (f : R → R → R := Mul.mul):
  Holor R (s1.append s2) :=
    fun ix =>
      f (h1 ix.take) (h2 ix.drop)

-- A[i, j, k] : K x L x M
-- B[k] = A[i, i, k]
-- B[k] = ∑_i A[i, i, k]
-- I am confused?
#check Finset.range
def Holor.contract [CommRing R] (h : Holor R shape) (ix1 ix2 : ℕ) (f : R → R → R):
  Holor R (shape.contract ix1 ix2) :=
    let limit := min (shape ix1)  (shape ix2)
    fun ix => sorry

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

instance [CommSemiring R] [Semiring A] [Algebra R A] : Algebra R (Holor A ds) :=
  Pi.algebra _ _

/- A generalization of 'Linalg.generic'. -/
namespace genericBinop

open BigOperators

inductive LoopKind : (depth : ℕ) → (outRank : ℕ)  → Type
| parallel (loop : LoopKind d r) : LoopKind (.succ d) (.succ r)
| reduction (loop : LoopKind d r) : LoopKind (.succ d) r
| done : LoopKind 0 0

/-- data specifying a Linalg.Generic operation -/
structure LinalgGenericData (R : Type)
  (aRank : ℕ) (bRank : ℕ) (loopKind : LoopKind depth outRank) [CommRing R] where
  aindex : Fin aRank → Fin depth -- (m, n)
  bindex : Fin bRank → Fin depth  -- (n, k)
  outindex : Fin outRank → Fin depth -- (m, n) [can access 3 values]
  computation : R → R → R

#check Finsupp
-- def LinalgGenericData.aShape [CommRing R]
--   (loopKind : LoopKind d r)
--   (data : LinalgGenericData R aRank bRank loopKind)
--   (oshape : Shape r) : Shape aRank :=
--     fun adim => oshape <| data.aindex adim

-- full: (aspace ++ bspace)
-- [out] =
noncomputable def Holor.linalgGenericBinop [CommRing R]
  (loopKind : LoopKind depth outRank)
  (data : LinalgGenericData R aRank bRank loopKind)
  (ha : Holor R aspace) (hb : Holor R bspace) : Holor R ospace :=
  fun oix =>
    match loopKind with
    | .done => sorry
    | .parallel kind' => sorry
    | .reduction kind' => sorry


end genericBinop


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
| repeat_ --  icated
| abs -- Pointwise
| sgn -- Pointwise
| neg -- Pointwise
| step -- Pointwise fun x => if x < 0 then 0 else 1
| relu -- Pointwise fun x => if x < 0 then 0 else x
| gelu -- Pointwise fun x => x * 0.5 * (1 + erf(x/sqrt(2)))
| silu -- Pointwise fun x => x * 1/ (1+exp(-x))
| norm -- not the sqrt of sum of squares
| rms_norm -- Don't know yet : Tensor k -> Tensor k rms(a) = sqrt(1/n * sum_i (a_i^2)), rms_norm i = a_i
| mul_mat -- Matrix multiplication, undefined on stuff that isn't a matrix
| scale -- Tensor 0 → Tensor k → Tensor k
| cpy -- identity function
| reshape -- Tensor → Shape → Tensor --Changes the data to fit new layout of same (linear algebra sense) dimension
| view1D -- Tensor → (Num_elements : ℕ) → (offset : ℕ) → Tensor --Output at i = input at i+offset output
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

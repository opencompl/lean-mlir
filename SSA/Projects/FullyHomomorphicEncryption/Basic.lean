/-
This file contains the definition of the MLIR `Poly` dialect as implemented in HEIR, see:
https://github.com/google/heir/blob/a18d4e8ddc0031e2a0e6dd2dd0d7fe289b9d1651/include/Dialect/Poly/IR/PolyDialect.td
https://github.com/j2kun/heir/blob/5c5c0e2ff2ae37a7d1ec5791ec6c38046c4115c1/include/Dialect/Poly/IR/PolyOps.td
https://github.com/google/heir/blob/a18d4e8ddc0031e2a0e6dd2dd0d7fe289b9d1651/tests/poly/poly_ops.mlir

This dialect describes operations on equivalence classes of polynomials in ℤ/qℤ[X]/(X^(2^n) + 1).
For the rationale behind this, see:
 Junfeng Fan and Frederik Vercauteren, Somewhat Practical Fully Homomorphic Encryption
https://eprint.iacr.org/2012/144

-/
import Mathlib.RingTheory.Polynomial.Quotient
import Mathlib.RingTheory.Ideal.Quotient
import Mathlib.RingTheory.Ideal.QuotientOperations
import Mathlib.Data.ZMod.Defs
import SSA.Core.Framework

open Polynomial -- for R[X] notation

/-
We assume tat `q > 1` is a natural number (not necessarily a prime) and `n` is a natural number.
We will use these to build `ℤ/qℤ[X]/(X^(2^n) + 1)`
-/
variable (q t : Nat) [ hqgt1 : Fact (q > 1)] (n : Nat)

-- Can we make this computable?
-- see: https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Way.20to.20recover.20computability.3F/near/322382109
-- and :https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Groebner.20bases

-- Question: Can we make something like d := 2^n work as a macro?
--
theorem WithBot.npow_coe_eq_npow (n : Nat) (x : ℕ) : (WithBot.some x : WithBot ℕ) ^ n = WithBot.some (x ^ n) := by
  induction n with
    | zero => simp
    | succ n ih =>
        rw [pow_succ, ih, ← WithBot.coe_mul]
        rw [← WithBot.some_eq_coe, WithBot.some]
        apply Option.some_inj.2
        rw [Nat.pow_succ]
        ring
  done

noncomputable def f : (ZMod q)[X] := X^(2^n) + 1

theorem zmodq_eq_finq : ZMod q = Fin q := by
  have h : q > 1 := hqgt1.elim
  unfold ZMod
  cases q
  · exfalso
    apply Nat.not_lt_zero 1
    exact h
  · simp [Fin]
  done

def ZMod.toInt (x  : ZMod q) : Int :=
  let ⟨val,_⟩ : Fin q := zmodq_eq_finq q ▸ x
  val

theorem ZMod.toInt_coe_eq (x : ZMod q) : ↑(x.toInt) = x := by
  unfold toInt
  simp
  sorry

theorem ZMod.eq_from_toInt_eq (x y : ZMod q) : x.toInt = y.toInt → x = y := by
  intro h
  simp [toInt] at h
  sorry

def ZMod.toInt_zero : ↑(↑(zmodq_eq_finq q ▸ 0) : Fin q) = (0 : Int) := by
  sorry

def ZMod.toInt_zero_iff_zero (x : ZMod q) : x = 0 ↔ x.toInt = 0 := by
  constructor
  · intro h
    rw [h]
    simp [toInt]
    sorry
  · intro h
    simp [toInt] at h
    sorry

theorem nontrivial_finq : ∃ (x y : Fin q), x ≠ y  := by
  have h : q > 1 := hqgt1.elim
  exists ⟨0, Nat.lt_of_succ_lt h⟩, ⟨1, h⟩
  intro contra
  exact Nat.noConfusion (Fin.veq_of_eq contra)
  done

instance : Nontrivial (ZMod q) where
  exists_pair_ne := zmodq_eq_finq q ▸ nontrivial_finq q

/-- Charaterizing `f`: `f` has degree `2^n` -/
theorem f_deg_eq : (f q n).degree = 2^n := by
  simp [f]
  rw [Polynomial.degree_add_eq_left_of_degree_lt]
  <;> rw [Polynomial.degree_X_pow]
  simp
  simp [Polynomial.degree_one]
  have h : 0 < 2^n := by
    apply Nat.one_le_two_pow
  have h' := WithBot.coe_lt_coe.2 h
  simp [Preorder.toLT, WithBot.preorder]
  have h0 : @OfNat.ofNat (WithBot ℕ) 0 Zero.toOfNat0  = @WithBot.some ℕ 0 := by
    simp [OfNat.ofNat]
  have h2 : @OfNat.ofNat (WithBot ℕ) 2 instOfNat = @WithBot.some ℕ 2 := by
    simp [OfNat.ofNat]
  have h2n : @HPow.hPow (WithBot ℕ) ℕ (WithBot ℕ) instHPow 2 n = @WithBot.some ℕ (@HPow.hPow ℕ ℕ ℕ instHPow 2 n) := by
    rw [h2, WithBot.npow_coe_eq_npow]
  rw [h0, h2n]
  exact h'
  done

/-- Charaterizing `f`: `f` is monic -/
theorem f_monic : Monic (f q n) := by
  have hn : 2^n = (2^n - 1) + 1 := by rw [Nat.sub_add_cancel (Nat.one_le_two_pow n)]
  have hn_minus_1 : degree 1 ≤ ↑(2^n - 1) := by
    rw [Polynomial.degree_one (R := (ZMod q))]; simp
  rw [f, hn]
  apply Polynomial.monic_X_pow_add hn_minus_1
  done

/--
The basic ring of interest in this dialect is `R q n` which corresponds to
the ring `ℤ/qℤ[X]/(X^(2^n) + 1)`.
-/
abbrev R := (ZMod q)[X] ⧸ (Ideal.span {f q n})
-- Coefficients of `a : R' q n` are `a\_i : Zmod q`.
-- TODO: get this from mathlib

/-- Canonical epimorphism `ZMod q[X] ->*+ R q n` -/
abbrev R.fromPoly {q n : Nat} : (ZMod q)[X] →+* R q n := Ideal.Quotient.mk (Ideal.span {f q n})

private noncomputable def R.representative' : R q n → (ZMod q)[X] := Function.surjInv Ideal.Quotient.mk_surjective
/--
The representative of `a : R q n` is the (unique) polynomial `p : ZMod q[X]` of degree `< 2^n`
 such that `R.fromPoly p = a`.
-/
noncomputable def R.representative : R q n → (ZMod q)[X] := fun x => R.representative' q n x %ₘ (f q n)

@[simp]
theorem R.fromPoly_kernel_eq_zero (x : (ZMod q)[X]) : R.fromPoly (n := n) (f q n * x) = 0 := by
   unfold fromPoly
   apply Ideal.Quotient.eq_zero_iff_mem.2
   rw [Ideal.mem_span_singleton]
   simp [Dvd.dvd]
   use x

/--
`R.representative` is in fact a representative of the equivalence class.
-/
@[simp]
theorem R.fromPoly_representative : forall a : R q n, (R.fromPoly (n:=n) (R.representative q n a)) = a := by
 intro a
 simp [R.representative]
 rw [Polynomial.modByMonic_eq_sub_mul_div _ (f_monic q n)]
 rw [RingHom.map_sub (R.fromPoly (q := q) (n:=n)) _ _]
 rw [R.fromPoly_kernel_eq_zero]
 simp
 apply Function.surjInv_eq


@[simp]
theorem R.representative_fromPoly (x : (ZMod q)[X]) (DEGREE: x.degree < (f q n).degree) :
   R.representative q n (R.fromPoly (n:=n) x) = x := sorry

/--
Characterization theorem for any potential representative.
For an  `a : (ZMod q)[X]`, the representative of its equivalence class
is just `a + i` for some `i ∈ (Ideal.span {f q n})`.
-/
theorem R.fromPoly_rep'_eq : forall a : (ZMod q)[X], ∃ i ∈ Ideal.span {f q n}, (R.fromPoly (n:=n) a).representative' = a + i := by
  intro a
  exists (R.fromPoly (n:=n) a).representative' - a
  constructor
  · apply Ideal.Quotient.eq.1
    simp [R.representative', Function.surjInv_eq]
  · ring
  done

/--
Characterization theorem for the representative.
Taking the representative of the equivalence class of a polynomial  `a : (ZMod q)[X]` is
the same as taking the remainder of `a` modulo `f q n`.
-/
theorem R.representative_fromPoly : forall a : (ZMod q)[X], (R.fromPoly (n:=n) a).representative = a %ₘ (f q n) := by
  intro a
  simp [R.representative]
  have ⟨i,⟨hiI,hi_eq⟩⟩ := R.fromPoly_rep'_eq q n a
  rw [hi_eq]
  apply Polynomial.modByMonic_eq_of_dvd_sub (f_monic q n)
  ring_nf
  apply Ideal.mem_span_singleton.1 hiI
  done

/--
The representative of `a : R q n` is the (unique) reperesntative with degree `< 2^n`.
-/
theorem R.rep_degree_lt_n : forall a : R q n, (R.representative q n a).degree < 2^n := by
  intro a
  simp [R.representative]
  rw [← f_deg_eq q n]
  apply Polynomial.degree_modByMonic_lt
  exact f_monic q n

noncomputable def R.rep_length {q n} (a : R q n) : Nat := match
  Polynomial.degree a.representative with
    | none => 0
    | some d => d + 1

/--
This function gets the `i`th coefficient of the polynomial representative
(with degree `< 2^n`) of an element `a : R q n`. Note that this is not
invariant under the choice of representative.
-/
noncomputable def R.coeff {q n} (a : R q n) (i : Nat) : ZMod q :=
  Polynomial.coeff a.representative i

/--
`R.monomial i c` is the equivalence class of the monomial `c * X^i` in `R q n`.
-/
noncomputable def R.monomial {q n : Nat} (c : ZMod q) (i : Nat): R q n :=
  R.fromPoly (Polynomial.monomial i c)

/--
Given an equivalence class of polynomials `a : R q n` with representative
`p = p_0 + p_1 X + ... + p_{2^n - 1} X^{2^n - 1}`, `R.slice a startIdx endIdx` yields
the equivalence class of the polynomial
`p_{startIdx}*X^{startIdx} + p_{startIdx + 1} X^{startIdx + 1} + ... + p_{endIdx - 1} X^{endIdx - 1}`
 Note that this is not invariant under the choice of representative.
-/
noncomputable def R.slice {q n : Nat} (a : R q n) (startIdx endIdx : Nat) : R q n :=
  let coeffIdxs := List.range (endIdx - startIdx)
  let coeffs := coeffIdxs.map (fun i => a.coeff (startIdx + i))
  let accum : R q n → (ZMod q × Nat) → R q n :=
    fun poly (c,i) => poly + R.monomial (n:=n) c i
  coeffs.zip coeffIdxs |>.foldl accum (0 : R q n)

noncomputable def R.leadingTerm {q n} (a : R q n) : R q n :=
  let deg? := Polynomial.degree a.representative
  match deg? with
    | .none => 0
    | .some deg =>  R.monomial (a.coeff deg) deg

noncomputable def R.fromTensor {q n} (coeffs : List Int) : R q n :=
  coeffs.enum.foldl (init := 0) fun res (i,c) =>
    res + R.monomial ↑c i

/-- A definition of fromTensor that operates on Z/qZ[X], to provide a relationship between
    R and Z/qZ[X] as the polynomial in R is built.
-/
noncomputable def R.fromTensor' (coeffs : List Int) : (ZMod q)[X] :=
  coeffs.enum.foldl (init := 0) fun res (i,c) =>
    res + (Polynomial.monomial i ↑c)

theorem R.fromTensor_eq_fromTensor'_toPoly_aux (coeffs : List Int) (rp : R q n) (p : (ZMod q)[X])
  (H : R.fromPoly (q := q) (n := n) p = rp) :
  ((List.enumFrom k coeffs).foldl (init := rp) fun res (i,c) =>
    res + R.monomial ↑c i) =
  R.fromPoly (q := q) (n := n)
    ((List.enumFrom k coeffs).foldl (init := p) fun res (i,c) =>
      res + (Polynomial.monomial i ↑c)) := by
      induction coeffs generalizing p rp k
      case nil =>
        simp[List.enum, H]
      case cons head tail tail_ih =>
        simp[List.enum_cons]
        specialize tail_ih (k := k + 1) (rp := (rp + monomial (↑head) k)) (p := (p + ↑(Polynomial.monomial k ↑head)))
        apply tail_ih
        simp[monomial, H]

/-- fromTensor = R.fromPoly ∘ fromTensor'.
This permits reasoning about fromTensor directly on the polynomial ring.
-/
theorem R.fromTensor_eq_fromTensor'_toPoly {q n} : R.fromTensor (q := q) (n := n) coeffs =
  R.fromPoly (q := q) (n := n) (R.fromTensor' q coeffs) := by
    simp[fromTensor, fromTensor']
    induction coeffs
    . simp[List.enum]
    . simp[List.enum_cons]
      apply fromTensor_eq_fromTensor'_toPoly_aux
      simp[monomial]

theorem R.representative_fromTensor : R.representative q n (R.fromTensor tensor) = R.representative' q n (R.fromTensor' q tensor)  %ₘ (f q n) := by
  simp [R.representative]
  rw[fromTensor_eq_fromTensor'_toPoly];

noncomputable def R.toTensor {q n} [Fact (q > 1)] (a : R q n) : List Int :=
  List.range a.rep_length |>.map fun i =>
        a.coeff i |>.toInt

def trimTensor (tensor : List Int) : List Int
  := tensor.reverse.dropWhile (· = 0) |>.reverse

/--
We define the base type of the representation, which encodes both natural numbers
and elements in the ring `R q n` (which in FHE are sometimes called 'polynomials'
 in allusion to `R.representative`).

 In this context, `Tensor is a 1-D tensor, which we model here as a list of integers.
-/
inductive Ty (q : Nat) (n : Nat) [Fact (q > 1)]
  | index : Ty q n
  | integer : Ty q n
  | tensor : Ty q n
  | polynomialLike : Ty q n
  deriving DecidableEq

instance : Inhabited (Ty q n) := ⟨Ty.index⟩
instance : Goedel (Ty q n) where
toType := fun
  | .index => Nat
  | .integer => Int
  | .tensor => List Int
  | .polynomialLike => (R q n)


/--
The operation type of the `Poly` dialect. Operations are parametrized by the
two parameters `p` and `n` that characterize the ring `R q n`.
We parametrize the entire type by these since it makes no sense to mix operations in different rings.
-/
inductive Op (q : Nat) (n : Nat) [Fact (q > 1)]
  | add : Op q n-- Addition in `R q n`
  | sub : Op q n-- Substraction in `R q n`
  | mul : Op q n-- Multiplication in `R q n`
  | mul_constant : Op q n-- Multiplication by a constant of the base ring (we assume this to be a `.integer` and take its representative)
  | leading_term : Op q n-- Leading term of representative
  | monomial : Op q n-- create a monomial
  | monomial_mul : Op q n-- multiply by(monic) monomial
  | from_tensor : Op q n-- interpret values as coefficients of a representative
  | to_tensor : Op q n-- give back coefficients from `R.representative`
  | const (c : R q n) : Op q n

open Goedel (toType)


@[simp, reducible]
def Op.sig : Op  q n → List (Ty q n)
| Op.add => [Ty.polynomialLike, Ty.polynomialLike]
| Op.sub => [Ty.polynomialLike, Ty.polynomialLike]
| Op.mul => [Ty.polynomialLike, Ty.polynomialLike]
| Op.mul_constant => [Ty.polynomialLike, Ty.integer]
| Op.leading_term => [Ty.polynomialLike]
| Op.monomial => [Ty.integer, Ty.index]
| Op.monomial_mul => [Ty.polynomialLike, Ty.index]
| Op.from_tensor => [Ty.tensor]
| Op.to_tensor => [Ty.polynomialLike]
| Op.const _ => []

@[simp, reducible]
def Op.outTy : Op q n → Ty q n
| Op.add | Op.sub | Op.mul | Op.mul_constant | Op.leading_term | Op.monomial
| Op.monomial_mul | Op.from_tensor | Op.const _  => Ty.polynomialLike
| Op.to_tensor => Ty.tensor

@[simp, reducible]
def Op.signature : Op q n → Signature (Ty q n) :=
  fun o => {sig := Op.sig q n o, outTy := Op.outTy q n o, regSig := []}

instance : OpSignature (Op q n) (Ty q n) := ⟨Op.signature q n⟩

@[simp]
noncomputable def Op.denote (o : Op q n)
   (arg : HVector toType (OpSignature.sig o))
   : (toType <| OpSignature.outTy o) :=
    match o with
    | Op.add => (fun args : R q n × R q n => args.1 + args.2) arg.toPair
    | Op.sub => (fun args : R q n × R q n => args.1 - args.2) arg.toPair
    | Op.mul => (fun args : R q n × R q n => args.1 * args.2) arg.toPair
    | Op.mul_constant => (fun args : R q n × Int => args.1 * ↑(args.2)) arg.toPair
    | Op.leading_term => R.leadingTerm arg.toSingle
    | Op.monomial => (fun args => R.monomial ↑(args.1) args.2) arg.toPair
    | Op.monomial_mul => (fun args : R q n × Nat => args.1 * R.monomial 1 args.2) arg.toPair
    | Op.from_tensor => R.fromTensor arg.toSingle
    | Op.to_tensor => R.toTensor arg.toSingle
    | Op.const c => c
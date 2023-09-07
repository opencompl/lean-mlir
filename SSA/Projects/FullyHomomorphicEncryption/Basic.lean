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
import Mathlib.Data.Zmod.Basic
import SSA.Experimental.IntrinsicAsymptotics

open Polynomial -- for R[X] notation

/-
We assume tat `q > 1` is a natural number (not necessarily a prime) and `n` is a natural number.
We will use these to build `ℤ/qℤ[X]/(X^(2^n) + 1)`
-/
variable (q t : Nat) [Fact (q > 1)] (n : Nat)

-- Can we make this computable?
-- see: https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Way.20to.20recover.20computability.3F/near/322382109
-- and :https://leanprover.zulipchat.com/#narrow/stream/113488-general/topic/Groebner.20bases

-- Question: Can we make something like d := 2^n work as a macro?
--
theorem WithBot.npow_coe_eq_npow (n : Nat) (x : ℕ) : (WithBot.some x : WithBot ℕ) ^ n = WithBot.some (x ^ n) := by
  induction n with
    | zero => simp
    | succ n ih =>  
        rw [pow_succ'', ih, ← WithBot.coe_mul]
        rw [← WithBot.some_eq_coe, WithBot.some]
        apply Option.some_inj.2
        rw [Nat.pow_succ]
        ring
  done

noncomputable def f : (ZMod q)[X] := X^(2^n) + 1
/-! Charaterizing `f`: `f` is monic of degree `2^n` -/
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

theorem f_monic : Monic (f q n) := by 
  simp [Monic]; unfold leadingCoeff; unfold natDegree; rw [f_deg_eq]
  simp [coeff_add, f]
  have h2 : @OfNat.ofNat (WithBot ℕ) 2 instOfNat = @WithBot.some ℕ 2 := by
    simp [OfNat.ofNat]
  have h2n : @HPow.hPow (WithBot ℕ) ℕ (WithBot ℕ) instHPow 2 n = @WithBot.some ℕ (@HPow.hPow ℕ ℕ ℕ instHPow 2 n) := by
    simp [h2, WithBot.npow_coe_eq_npow]
  rw [h2n]
  rw [WithBot.unbot'_coe]
  simp
  have h2nne0 : 2^n ≠ 0 := by 
    apply Nat.pos_iff_ne_zero.1
    apply Nat.one_le_two_pow
  rw [← Polynomial.C_1, Polynomial.coeff_C]
  simp [h2nne0]

/--
The basic ring of interest in this dialect is `R q n` which corresponds to
the ring `ℤ/qℤ[X]/(X^(2^n) + 1)`.
-/
abbrev R := (ZMod q)[X] ⧸ (Ideal.span {f q n})
-- Coefficients of `a : R' q n` are `a\_i : Zmod q`.
-- TODO: get this from mathlib

/-- Canonical epimorphism `ZMod q[X] ->*+ R q n` -/
abbrev R.fromPoly {q n : Nat} : (ZMod q)[X] →+* R q n := Ideal.Quotient.mk (Ideal.span {f q n})

noncomputable abbrev R.zero {q n : Nat} : R q n := R.fromPoly 0
noncomputable abbrev R.one {q n : Nat} : R q n := R.fromPoly 1

noncomputable instance {q n : Nat} : Zero (R q n) := ⟨R.zero⟩
noncomputable instance {q n : Nat} : One (R q n) := ⟨R.one⟩

private noncomputable def R.representative' : R q n → (ZMod q)[X] := Function.surjInv Ideal.Quotient.mk_surjective
/--
The representative of `a : R q n` is the (unique) polynomial `p : ZMod q[X]` of degree `< 2^n`
 such that `R.fromPoly p = a`.
-/
noncomputable def R.representative : R q n → (ZMod q)[X] := fun x => R.representative' q n x %ₘ (f q n)

/--
`R.representative` is in fact a representative of the equivalence class.
-/
theorem R.rep_fromPoly_eq : forall a : R q n, (R.fromPoly (n:=n) (R.representative q n a)) = a := by
 intro a 
 simp [R.representative]
 rw [Polynomial.modByMonic_eq_sub_mul_div _ (f_monic q n)]
 rw [RingHom.map_sub (R.fromPoly (q := q) (n:=n)) _ _]
 have hker : forall x, fromPoly (f q n * x) = 0 := by
   intro x
   unfold fromPoly
   apply Ideal.Quotient.eq_zero_iff_mem.2
   rw [Ideal.mem_span_singleton]
   simp [Dvd.dvd]
   use x
 rw [hker _]
 simp
 apply Function.surjInv_eq


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
theorem R.fromPoly_rep_eq : forall a : (ZMod q)[X], (R.fromPoly (n:=n) a).representative = a %ₘ (f q n) := by
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

/--
This function gets the `i`th coefficient of the polynomial representative 
(with degree `< 2^n`) of an element `a : R q n`. Note that this is not 
invariant under the choice of representative.
-/
noncomputable def R.coeff (a : R q n) (i : Nat) : ZMod q := 
  Polynomial.coeff a.representative i 

/--
`R.monomial i c` is the equivalence class of the monomial `c * X^i` in `R q n`.
-/
noncomputable def R.monomial {q n : Nat} (i : Nat) (c : ZMod q) : R q n :=
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
    fun poly (c,i) => poly + R.monomial (n:=n) i c
  coeffs.zip coeffIdxs |>.foldl accum R.zero

/--
We define the base type of the representation, which encodes both natural numbers 
and elements in the ring `R q n` (which in FHE are sometimes called 'polynomials'
 in allusion to `R.representative`).
-/
inductive Ty
  | nat : Ty
  | poly (q : Nat) (n : Nat) : Ty
  deriving DecidableEq

instance : Inhabited Ty := ⟨Ty.nat⟩
instance : Goedel Ty where
toType := fun
  | .nat => Nat
  | .poly q n => (R q n)

/--
The operation type of the `Poly` dialect. Operations are parametrized by the 
two parameters `p` and `n` that characterize the ring `R q n`.
-/
inductive Op
| add (q : Nat) (n : Nat) : Op
| sub (q : Nat) (n : Nat) : Op
| mul (q : Nat) (n : Nat) : Op
| mul_constant (q : Nat) (n : Nat) (c : R q n) : Op
| get_coeff (q : Nat) (n : Nat) : Op
| extract_slice (q : Nat) (n : Nat) : Op
--deriving DecidableEq --, Repr

open Goedel (toType)


@[simp, reducible]
def Op.sig : Op  → List Ty
| Op.add q n => [Ty.poly q n, Ty.poly q n]
| Op.sub q n => [Ty.poly q n, Ty.poly q n]
| Op.mul q n => [Ty.poly q n, Ty.poly q n]
| Op.mul_constant q n _ => [Ty.poly q n]
| Op.get_coeff q n => [Ty.poly q n, Ty.nat]
| Op.extract_slice q n => [Ty.poly q n, Ty.nat, Ty.nat]

@[simp, reducible]
def Op.outTy : Op → Ty
| Op.add q n => Ty.poly q n
| Op.sub q n => Ty.poly q n
| Op.mul q n => Ty.poly q n
| Op.mul_constant q n _ => Ty.poly q n
| Op.get_coeff _ _ => Ty.nat
| Op.extract_slice q n => Ty.poly q n

instance : OpSignature Op Ty := ⟨Op.sig, Op.outTy⟩

variable (a b : R q n)
@[simp]
noncomputable def Op.denote (o : Op)
   (arg : HVector toType (OpSignature.sig o))
   : (toType <| OpSignature.outTy o) :=
    match o with
    | Op.add q n => (fun args : R q n × R q n => args.1 + args.2) arg.toPair
    | Op.sub q n => (fun args : R q n × R q n => args.1 - args.2) arg.toPair
    | Op.mul q n => (fun args : R q n × R q n => args.1 * args.2) arg.toPair
    | Op.mul_constant q n c => (fun arg : R q n => arg * c) arg.toSingle
    | Op.get_coeff q n => (fun args : R q n × Nat => args.1.coeff args.2 |>.val) arg.toPair
    | Op.extract_slice _ _ => (fun (a,i,c) => R.slice a i c) arg.toTriple
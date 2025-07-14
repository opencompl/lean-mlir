/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.FullyHomomorphicEncryption.Basic
import Batteries.Data.List.Lemmas
import Mathlib.Data.List.Basic

namespace Poly

theorem mul_comm (a b : R q n) : a * b = b * a := by
  ring

theorem add_comm (a b : R q n) : a + b = b + a := by
  ring

@[simp]
theorem f_eq_zero : (f q n) = (0 : R q n) := by
  apply Ideal.Quotient.eq_zero_iff_mem.2
  rw [Ideal.mem_span_singleton]

theorem mul_f_eq_zero (a : R q n): a * (f q n) = 0 := by
  rw [f_eq_zero]; ring

theorem mul_one_eq (a : R q n) : 1 * a = a := by
  ring

theorem add_f_eq (a : R q n) : a + (f q n) = a := by
  rw[f_eq_zero]
  ring

theorem add_zero_eq : a + 0 = a := by
  ring

theorem eq_iff_rep_eq [Fact (q > 1)] (a b : R q n) :
    a.representative = b.representative ↔ a = b := by
  constructor
  · intros hRep
    have hFromPolyRep :
        R.fromPoly (q := q) (n := n) a.representative =
          R.fromPoly (q := q) (n := n) b.representative := by
      rw [hRep]
    rw [R.fromPoly_representative, R.fromPoly_representative] at hFromPolyRep
    assumption
  · intro h; rw [h]

open Polynomial in
theorem from_poly_zero : R.fromPoly (0 : (ZMod q)[X]) (n := n) = (0 : R q n) := by
  have hzero : f q n * 0 = 0 := by simp
  rw [← hzero]
  apply R.fromPoly_kernel_eq_zero

theorem rep_zero [Fact (q > 1)]: R.representative q n 0 = 0 := by
  rw [← from_poly_zero, R.representative_fromPoly]; simp


open Polynomial in
theorem monomial_mul_mul (x y : Nat) :
    (R.monomial 1 y) * (R.monomial 1 x) = R.monomial 1 (x + y) (q := q) (n := n) := by
  unfold R.monomial
  rw [← map_mul, monomial_mul_monomial, Nat.add_comm]
  simp

end Poly

theorem R.toTensor_getD [Fact (q > 1)] (a : R q n) (i : Nat) :
    a.toTensor.getD i 0 = (a.coeff i).toInt := by
  simp only [toTensor, coeff]
  have hLength :
      (List.map (fun i => ZMod.toInt q (Polynomial.coeff (R.representative q n a) i))
        (List.range (R.repLength a))).length = repLength a := by
    simp
  by_cases (i < R.repLength a)
  case pos h =>
    rw [← hLength] at h
    rw [List.getD_eq_getElem _ _ h]
    simp
  case neg h =>
    rw [Nat.not_lt] at h
    rw [List.getD_eq_default _, Polynomial.coeff_eq_zero_of_degree_lt]
    simp only [ZMod.toInt, ZMod.cast_zero]
    unfold R.repLength at h
    cases hDeg : Polynomial.degree (R.representative q n a)
    · apply WithBot.bot_lt_coe
    · simp only [hDeg] at h
      apply WithBot.coe_lt_coe.2
      linarith
    · rw[← hLength] at h
      linarith

theorem R.toTensor_getD' [hqgt1 : Fact (q > 1)] (a : R q n) (i : Nat) :
    ↑(a.toTensor.getD i 0) = a.coeff i := by
  rw [R.toTensor_getD]
  simp [ZMod.toInt]

theorem R.monomial_zero_c_eq_zero : R.monomial (q := q) (n := n) 0 c = 0 := by
  unfold R.monomial
  rw [Polynomial.monomial_zero_right]
  simp

theorem R.fromTensor_eq_concat_zero (tensor : List Int) :
  R.fromTensor (q := q) (n := n) tensor = R.fromTensor (q := q) (n := n) (tensor ++ [0]) := by
  unfold R.fromTensor
  rw [List.zipIdx_append, List.zipIdx_singleton, List.foldl_concat]
  simp [R.monomial_zero_c_eq_zero]


theorem R.fromTensor_eq_concat_zeroes (tensor : List Int) (k : Nat) :
   R.fromTensor (q := q) (n := n) (tensor ++ List.replicate k 0) =
     R.fromTensor (q := q) (n := n) tensor := by
  induction k generalizing tensor with
   | zero => simp
   | succ k ih =>
       simp only [List.replicate]
       have H : tensor ++ (0 :: List.replicate k 0) = (tensor ++ [0]) ++ List.replicate k 0 :=
        List.append_cons ..
       rw [H]
       rw [ih (tensor ++ [0])]
       rw [← R.fromTensor_eq_concat_zero]

@[simp]
theorem R.trimTensor_append_zero_eq (tensor : List Int) :
    trimTensor (tensor ++ [0]) = trimTensor tensor := by
  simp only [trimTensor, List.reverse_append, List.reverse_cons, List.reverse_nil, List.nil_append,
    List.singleton_append, List.reverse_inj]
  rw [List.dropWhile]
  simp

@[simp]
theorem R.trimTensor_append_zeroes_eq (tensor : List Int) (n : Nat) :
    trimTensor (tensor ++ List.replicate n 0) = trimTensor tensor := by
  induction n with
  | zero => simp
  | succ n ih =>
     rw [List.replicate_succ', ← List.append_assoc, R.trimTensor_append_zero_eq,ih]

theorem R.trimTensor_append_not_zero (tensor : List Int) (x : Int) (hX : x ≠ 0) :
  trimTensor (tensor ++ [x]) = tensor ++ [x] := by
  simp only [trimTensor, List.reverse_append, List.reverse_cons, List.reverse_nil, List.nil_append,
    List.singleton_append]
  rw [List.dropWhile]
  simp [hX]

theorem R.trimTensor_eq_append_zeros (tensor : List Int) : ∃ (n : Nat),
tensor = trimTensor tensor ++ List.replicate n 0 := by
induction tensor using List.reverseRecOn with
   | nil => exists 0
   | append_singleton xs x ih =>
     have ⟨n,hxs⟩ := ih
     by_cases (x = 0)
     case pos h =>
       exists (n + 1)
       rw [h]
       simp only [trimTensor_append_zero_eq, List.replicate]
       rw [← List.replicate_succ, List.replicate_succ', ← List.append_assoc, ← hxs]
     case neg h =>
       exists 0
       rw [R.trimTensor_append_not_zero _ _ h] ; simp

theorem R.trimTensor_getD_0 (tensor: List Int) :
  tensor.getD i 0 = (trimTensor tensor).getD i 0 := by
  have ⟨n, H⟩ := trimTensor_eq_append_zeros tensor
  conv =>
    lhs
    rw[H]
  by_cases INBOUNDS:(i < List.length (trimTensor tensor))
  · rw[List.getD_append (h := INBOUNDS)]
  · have OUT_OF_BOUNDS : List.length (trimTensor tensor) ≤ i := by linarith
    rw[List.getD_eq_default (hn := OUT_OF_BOUNDS)]
    rw[List.getD_append_right (h := OUT_OF_BOUNDS)]
    simp

theorem R.trimTensor_trimTensor (tensor : List Int) :
  trimTensor (trimTensor tensor) = trimTensor tensor := by
  induction tensor using List.reverseRecOn with
    | nil => simp [trimTensor]
    | append_singleton xs x ih =>
       by_cases (x = 0)
       case pos h => rw [h, R.trimTensor_append_zero_eq,ih]
       case neg h => rw [trimTensor_append_not_zero _ _ h, trimTensor_append_not_zero _ _ h]

theorem R.fromTensor_eq_fromTensor_trimTensor (tensor : List Int) :
   R.fromTensor (q := q) (n := n) (trimTensor tensor) = R.fromTensor (q := q) (n := n) tensor := by
  have ⟨n,hn⟩ := R.trimTensor_eq_append_zeros tensor
  conv =>
    rhs
    rw [hn]
  simp [R.fromTensor_eq_concat_zeroes]

theorem R.trimTensor_toTensor'_eq_trimTensor_toTensor [Fact (q > 1)] (a : R q n) :
  trimTensor a.toTensor' = trimTensor a.toTensor := by
  apply R.trimTensor_append_zeroes_eq

namespace Poly

theorem eq_iff_coeff_eq [hqgt1 : Fact (q > 1)] (a b : R q n) :
    a = b ↔ Polynomial.coeff a.representative = Polynomial.coeff b.representative := by
  constructor
  ·  intro h; rw [h]
  ·  intro h
     apply (eq_iff_rep_eq _ _).1
     apply Polynomial.coeff_inj.1
     exact h

theorem toTensor_length_eq_rep_length [Fact (q > 1)] (a : R q n) :
  a.toTensor.length = a.repLength := by
  simp [R.repLength, R.toTensor]

-- Surely this doesn't need to be this annoying
theorem toTensor_length_eq_f_deg_plus_1 [Fact (q > 1)] (a : R q n) :
  a.toTensor'.length = 2^n + 1 := by
  rw [R.toTensor', List.length_append, toTensor_length_eq_rep_length, List.length_replicate]
  have h : R.repLength a ≤ 2^n  := Nat.le_of_lt_succ (R.repLength_lt_n_plus_1 a)
  calc
       R.repLength a + (2 ^ n - R.repLength a + 1)
     = R.repLength a + (Nat.succ (2 ^ n) - R.repLength a) := by rw
       [Nat.add_comm _ 1, ← Nat.add_sub_assoc h, Nat.add_comm 1 (2^n)]
   _ = 2^n + 1 := by rw [Nat.add_sub_cancel' (Nat.le_succ_of_le h)]


theorem toTensor_trimTensor_eq_toTensor [Fact (q > 1)] (a : R q n) :
  trimTensor a.toTensor = a.toTensor := by
  unfold R.toTensor
  cases h : Polynomial.degree a.representative with
  | bot => simp [trimTensor, h, R.repLength]
  | coe n  =>
    simp only [R.repLength, h]
    rw [List.range_succ, List.map_append]
    simp only [List.map_cons, List.map_nil]
    have hNe := Polynomial.coeff_ne_zero_of_eq_degree h
    simp only [R.coeff]
    have hNe': ZMod.toInt q (Polynomial.coeff (a.representative) n) ≠ 0 := by
      intro contra
      have contra' := (ZMod.toInt_zero_iff_zero _ _).2 contra
      contradiction
    apply R.trimTensor_append_not_zero  _ _ hNe'

theorem R.trim_toTensor'_eq_toTensor [hqgt1 : Fact (q > 1)] (a : R q n) :
  trimTensor a.toTensor' = a.toTensor := by
  rw [R.trimTensor_toTensor'_eq_trimTensor_toTensor, toTensor_trimTensor_eq_toTensor]


theorem toTensor_fromTensor [hqgt1 : Fact (q > 1)] (tensor : List Int) (i : Nat)
  (htensorlen : List.length tensor < 2 ^ n) :
  (R.fromTensor tensor (q:=q) (n :=n)).toTensor.getD i 0 = (tensor.getD i 0) % q := by
  simp only [R.toTensor_getD]
  simp only [ZMod.toInt]
  rw [R.coeff_fromTensor (htensorlen := htensorlen)]
  norm_cast
  simp only [Int.cast, ZMod.cast]
  cases q;
  case zero =>
    exfalso
    simp only [gt_iff_lt, not_lt_zero'] at hqgt1
    exact (Fact.elim hqgt1)
  case succ q' =>
    simp only
    norm_cast
    simp only [IntCast.intCast, Nat.succ_eq_add_one, ZMod.natCast_val, Nat.cast_add, Nat.cast_one]
    norm_cast
    ring_nf
    rw [ZMod.cast_eq_val]
    rw [ZMod.val_intCast]
    ring_nf

/- TODO: this should be a theorem that we prove, that the length of anything
that comes from `R.toTensor` will be < 2^n -/
theorem fromTensor_toTensor [hqgt1 : Fact (q > 1)] (a : R q n)
    (adeg : (R.representative q n a).natDegree + 1 < 2^n) :
  R.fromTensor a.toTensor = a := by
  cases h : Polynomial.degree (R.representative q n a) with
    | bot =>
        have h' :=  Polynomial.degree_eq_bot.1 h
        rw [← rep_zero] at h'
        have h'' := (eq_iff_rep_eq _ _).1 h'
        simp only [R.fromTensor, R.toTensor, R.repLength]
        rw [h, h'']
        simp
    | coe deg =>
        apply (eq_iff_coeff_eq _ _).2
        have hCoeff := R.toTensor_getD' (q := q) (n := n)
        unfold R.coeff at hCoeff
        apply funext
        intro i
        rw [← hCoeff, ← hCoeff]
        rw [toTensor_fromTensor]
        rw [← ZMod.coe_intCast]
        norm_cast
        · simp only [R.toTensor_length]
          have hdeg := R.repLength_leq_representative_degree_plus_1 a
          linarith

theorem fromTensor_toTensor' [hqgt1 : Fact (q > 1)] (a : R q n)
    (adeg : (R.representative q n a).natDegree + 1 < 2^n) : R.fromTensor a.toTensor' = a := by
  rw [← R.fromTensor_eq_fromTensor_trimTensor, R.trim_toTensor'_eq_toTensor]
  apply fromTensor_toTensor a adeg
end Poly

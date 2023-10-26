import SSA.Projects.FullyHomomorphicEncryption.Basic
import Std.Data.List.Lemmas
import Mathlib.Data.List.Basic

-- variable {q t : Nat} [ hqgt1 : Fact (q > 1)] {n : Nat}
-- variable (a b : R q n)

namespace Poly

theorem mul_comm (a b : R q n) : a * b = b * a := by
  ring

theorem add_comm (a b : R q n) : a + b = b + a := by
  ring

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

theorem eq_iff_rep_eq [Fact (q > 1)] (a b : R q n) : a.representative = b.representative ↔ a = b := by
  constructor
  · intros hRep
    have hFromPolyRep : R.fromPoly (q := q) (n := n) a.representative = R.fromPoly (q := q) (n := n) b.representative := by
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
theorem monomial_mul_mul (x y : Nat) : (R.monomial 1 y) * (R.monomial 1 x) = R.monomial 1 (x + y) (q := q) (n := n) := by
  unfold R.monomial
  rw [← map_mul, monomial_mul_monomial, Nat.add_comm]
  simp

end Poly

theorem R.toTensor_length [hqgt1 : Fact (q > 1)] (a : R q n) : a.toTensor.length = a.rep_length := by
  unfold R.toTensor
  unfold R.rep_length
  cases Polynomial.degree a.representative <;> simp


theorem R.toTensor_getD [hqgt1 : Fact (q > 1)] (a : R q n) (i : Nat) : a.toTensor.getD i 0 = (a.coeff i).toInt := by
  simp [R.toTensor, R.coeff]
  have hLength : (List.map (fun i => ZMod.toInt q (Polynomial.coeff (R.representative q n a) i)) (List.range (R.rep_length a))).length = rep_length a := by
    simp
  by_cases (i < R.rep_length a)
  case pos =>
    rw [← hLength] at h; rw [List.getD_eq_get _ _ h, List.get_map, List.get_range]
    done
  case neg =>
    rw [Nat.not_lt] at h
    rw [List.getD_eq_default _, Polynomial.coeff_eq_zero_of_degree_lt]
    simp[ZMod.toInt]
    unfold R.rep_length at h
    cases hDeg : Polynomial.degree (R.representative q n a)
    · apply WithBot.bot_lt_coe
    . simp[hDeg] at h
      apply WithBot.some_lt_some.2
      linarith
    . rw[← hLength] at h
      linarith

theorem R.toTensor_getD' [hqgt1 : Fact (q > 1)] (a : R q n) (i : Nat) : ↑(a.toTensor.getD i 0) = a.coeff i := by
  rw [R.toTensor_getD]
  simp [ZMod.toInt]

theorem R.monomial_zero_c_eq_zero : R.monomial (q := q) (n := n) 0 c = 0 := by
  unfold R.monomial
  rw [Polynomial.monomial_zero_right]
  simp

theorem R.fromTensor_eq_concat_zero (tensor : List Int) :
  R.fromTensor (q := q) (n := n) tensor = R.fromTensor (q := q) (n := n) (tensor ++ [0]) := by
  unfold R.fromTensor
  simp
  rw [List.enum_append, List.enumFrom_singleton, List.foldl_concat]
  simp [R.monomial_zero_c_eq_zero]


theorem R.fromTensor_eq_concat_zeroes (tensor : List Int) (k : Nat) :
   R.fromTensor (q := q) (n := n) (tensor ++ List.replicate k 0) = R.fromTensor (q := q) (n := n) tensor := by
  induction k generalizing tensor with
   | zero => simp
   | succ k ih =>
       simp [ih]
       have H : tensor ++ (0 :: List.replicate k 0) = (tensor ++ [0]) ++ List.replicate k 0 :=
        List.append_cons ..
       rw[H]
       rw [ih (tensor ++ [0])]
       rw[← R.fromTensor_eq_concat_zero]

@[simp]
theorem R.trimTensor_append_zero_eq (tensor : List Int) :  trimTensor (tensor ++ [0]) = trimTensor tensor := by
  simp [trimTensor]
  rw [List.dropWhile]
  simp

@[simp]
theorem R.trimTensor_append_zeroes_eq (tensor : List Int) (n : Nat) :  trimTensor (tensor ++ List.replicate n 0) = trimTensor tensor := by
  induction n with
  | zero => simp
  | succ n ih =>
     rw [List.replicate_succ', ← List.append_assoc, R.trimTensor_append_zero_eq,ih]

theorem R.trimTensor_append_not_zero (tensor : List Int) (x : Int) (hX : x ≠ 0) :
  trimTensor (tensor ++ [x]) = tensor ++ [x] := by
  simp [trimTensor]; rw [List.dropWhile]
  simp [hX]

theorem R.trimTensor_eq_append_zeros (tensor : List Int) : ∃ (n : Nat),
tensor = trimTensor tensor ++ List.replicate n 0 := by
induction tensor using List.reverseRecOn with
   | H0 => exists 0
   | H1 xs x ih =>
     have ⟨n,hxs⟩ := ih
     by_cases (x = 0)
     · exists (n + 1)
       rw [h]
       simp
       rw [← List.replicate_succ, List.replicate_succ', ← List.append_assoc, ← hxs]
     · exists 0
       rw [R.trimTensor_append_not_zero _ _ h] ; simp

theorem R.trimTensor_getD_0 (tensor: List Int) :
  tensor.getD i 0 = (trimTensor tensor).getD i 0 := by
  have ⟨n, H⟩ := trimTensor_eq_append_zeros tensor
  conv =>
    lhs
    rw[H]
  by_cases INBOUNDS:(i < List.length (trimTensor tensor))
  . rw[List.getD_append (h := INBOUNDS)]
  . have OUT_OF_BOUNDS : List.length (trimTensor tensor) ≤ i := by linarith
    rw[List.getD_eq_default (hn := OUT_OF_BOUNDS)]
    rw[List.getD_append_right (h := OUT_OF_BOUNDS)]
    rw[List.getD_replicate_default_eq]

theorem R.trimTensor_trimTensor (tensor : List Int) :
  trimTensor (trimTensor tensor) = trimTensor tensor := by
  induction tensor using List.reverseRecOn with
    | H0 => simp
    | H1 xs x ih =>
       by_cases (x = 0)
       · rw [h, R.trimTensor_append_zero_eq,ih]
       · rw [trimTensor_append_not_zero _ _ h, trimTensor_append_not_zero _ _ h]

theorem R.fromTensor_eq_fromTensor_trimTensor (tensor : List Int) :
   R.fromTensor (q := q) (n := n) (trimTensor tensor) = R.fromTensor (q := q) (n := n) tensor := by
  have ⟨n,hn⟩ := R.trimTensor_eq_append_zeros tensor
  conv =>
    rhs
    rw [hn]
  simp[R.fromTensor_eq_concat_zeroes]

theorem R.trimTensor_toTensor'_eq_trimTensor_toTensor [hqgt1 : Fact (q > 1)] (a : R q n) :
  trimTensor a.toTensor' = trimTensor a.toTensor := by
  apply R.trimTensor_append_zeroes_eq

namespace Poly

theorem eq_iff_coeff_eq [hqgt1 : Fact (q > 1)] (a b : R q n) : a = b ↔ Polynomial.coeff a.representative = Polynomial.coeff b.representative := by
  constructor
  .  intro h; rw [h]
  ·  intro h
     apply (eq_iff_rep_eq _ _).1
     apply Polynomial.coeff_inj.1
     exact h

theorem toTensor_length_eq_rep_length [hqgt1 : Fact (q > 1)] (a : R q n) :
  a.toTensor.length = a.rep_length := by
  simp [R.rep_length, R.toTensor]

-- Surely this doesn't need to be this annoying
theorem toTensor_length_eq_f_deg_plus_1 [hqgt1 : Fact (q > 1)] (a : R q n) :
  a.toTensor'.length = 2^n + 1 := by
  rw [R.toTensor', List.length_append, toTensor_length_eq_rep_length, List.length_replicate]
  have h : R.rep_length a ≤ 2^n  := Nat.le_of_lt_succ (R.rep_length_lt_n_plus_1 q n a)
  calc
       R.rep_length a + (2 ^ n - R.rep_length a + 1)
     = R.rep_length a + (Nat.succ (2 ^ n) - R.rep_length a) := by rw [Nat.add_comm _ 1, ← Nat.add_sub_assoc h, Nat.add_comm 1 (2^n)]
   _ = 2^n + 1 := by rw [Nat.add_sub_cancel' (Nat.le_succ_of_le h)]


theorem toTensor_trimTensor_eq_toTensor [hqgt1 : Fact (q > 1)] (a : R q n) :
  trimTensor a.toTensor = a.toTensor := by
  unfold R.toTensor
  cases h : Polynomial.degree a.representative with
  | none => simp [h, R.rep_length]
  | some n  =>
    simp [R.rep_length, h]
    rw [List.range_succ, List.map_append]
    simp
    have hNe := Polynomial.coeff_ne_zero_of_eq_degree h
    simp [R.coeff, hNe]
    have hNe': ZMod.toInt q (Polynomial.coeff (a.representative) n) ≠ 0 := by
      intro contra
      have contra' := (ZMod.toInt_zero_iff_zero _ _).2 contra
      contradiction
    apply R.trimTensor_append_not_zero  _ _ hNe'

theorem R.trim_toTensor'_eq_toTensor [hqgt1 : Fact (q > 1)] (a : R q n) :
  trimTensor a.toTensor' = a.toTensor := by
  rw [R.trimTensor_toTensor'_eq_trimTensor_toTensor, toTensor_trimTensor_eq_toTensor]


theorem toTensor_fromTensor [hqgt1 : Fact (q > 1)] (tensor : List Int) (i : Nat):
  (R.fromTensor tensor (q:=q) (n :=n)).toTensor.getD i 0 = (tensor.getD i 0) % q := by
  simp[R.toTensor_getD]

  simp[ZMod.toInt];
  simp[R.coeff_fromTensor]
  norm_cast
  simp[Int.cast, ZMod.cast]
  cases q;
  case zero =>
    exfalso
    simp at hqgt1
    exact (Fact.elim hqgt1)
  case succ q' =>
    simp
    simp[ZMod.cast]
    norm_cast
    simp[IntCast.intCast]
    norm_cast
    ring_nf
    rw[ZMod.cast_eq_val]
    rw[ZMod.val_int_cast]
    ring_nf

theorem toTensor_fromTensor_trimTensor_eq_trimTensor [hqgt1 : Fact (q > 1)] (a : R q n) (tensor : List Int) {l : Nat}:
  Polynomial.degree a.representative = .some l → tensor.length < l →
  (R.fromTensor (trimTensor tensor) (q:=q) (n :=n)).toTensor = trimTensor tensor := by
  intros hDeg hLen
  simp [R.fromTensor, R.toTensor]
  sorry

theorem toTensor_fromTensor_eq_trimTensor [hqgt1 : Fact (q > 1)] (a : R q n) (tensor : List Int) {l : Nat}:
  Polynomial.degree a.representative = .some l → tensor.length < l →
  (R.fromTensor tensor (q:=q) (n :=n)).toTensor = trimTensor tensor := by
  intros hDeg hLen
  --simp [R.fromTensor, R.toTensor]
  have ⟨n,hTrim⟩ := R.trimTensor_eq_append_zeros tensor
  rw [hTrim,R.trimTensor_append_zeroes_eq, R.fromTensor_eq_concat_zeroes, R.trimTensor_trimTensor]
  apply toTensor_fromTensor_trimTensor_eq_trimTensor _ _ hDeg hLen

theorem fromTensor_toTensor [hqgt1 : Fact (q > 1)] (a : R q n) : R.fromTensor a.toTensor = a := by
  cases h : Polynomial.degree (R.representative q n a) with
    | none =>
        have h' :=  Polynomial.degree_eq_bot.1 h
        rw [← rep_zero] at h'
        have h'':= (eq_iff_rep_eq _ _).1 h'
        simp [R.fromTensor, R.toTensor, R.rep_length]; rw [h, h'']
        simp
    | some deg =>
        apply (eq_iff_coeff_eq _ _).2
        have hCoeff := R.toTensor_getD' (q := q) (n := n)
        unfold R.coeff at hCoeff
        apply funext
        intro i
        rw [← hCoeff, ← hCoeff]
        rw [toTensor_fromTensor]
        rw[← ZMod.coe_int_cast]
        norm_cast

theorem fromTensor_toTensor' [hqgt1 : Fact (q > 1)] (a : R q n) : R.fromTensor a.toTensor' = a := by
  rw [← R.fromTensor_eq_fromTensor_trimTensor, R.trim_toTensor'_eq_toTensor]
  apply fromTensor_toTensor

end Poly

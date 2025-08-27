/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import SSA.Experimental.Bits.Fast.BitStream
import SSA.Experimental.Bits.SingleWidth.Defs

open Term

open BitStream in
/--
Evaluate a term `t` to the BitStream it represents,
given a value for the free variables in `t`.

Note that we don't keep track of how many free variable occur in `t`,
so eval requires us to give a value for each possible variable.
-/
def Term.eval (t : Term) (vars : List BitStream) : BitStream :=
  match t with
  | var n       => vars.getD n default
  | zero        => BitStream.zero
  | one         => BitStream.one
  | negOne      => BitStream.negOne
  | ofNat n     => BitStream.ofNat n
  | and t₁ t₂   => (t₁.eval vars) &&& (t₂.eval vars)
  | or t₁ t₂    => (t₁.eval vars) ||| (t₂.eval vars)
  | xor t₁ t₂   => (t₁.eval vars) ^^^ (t₂.eval vars)
  | not t       => ~~~(t.eval vars)
  | add t₁ t₂   => (Term.eval t₁ vars) + (Term.eval t₂ vars)
  | sub t₁ t₂   => (Term.eval t₁ vars) - (Term.eval t₂ vars)
  | neg t       => -(Term.eval t vars)
--   | incr t      => BitStream.incr (Term.eval t vars)
--   | decr t      => BitStream.decr (Term.eval t vars)
  | shiftL t n  => BitStream.shiftLeft (Term.eval t vars) n
 -- | repeatBit t => BitStream.repeatBit (Term.eval t vars)

/--
Evaluate a term `t` to the BitStream it represents.

This differs from `Term.eval` in that `Term.evalFin` uses `Term.arity` to
determine the number of free variables that occur in the given term,
and only require that many bitstream values to be given in `vars`.
-/
@[simp] def Term.evalFin (t : Term) (vars : Fin (arity t) → BitStream) : BitStream :=
  match t with
  | var n => vars (Fin.last n)
  | zero    => BitStream.zero
  | one     => BitStream.one
  | negOne  => BitStream.negOne
  | ofNat n => BitStream.ofNat n
  | and t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ &&& x₂
  | or t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ||| x₂
  | xor t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ^^^ x₂
  | not t     => ~~~(t.evalFin vars)
  | add t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ + x₂
  | sub t₁ t₂ =>
      let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ - x₂
  | neg t       => -(Term.evalFin t vars)
 --  | incr t      => BitStream.incr (Term.evalFin t vars)
 --  | decr t      => BitStream.decr (Term.evalFin t vars)
  | shiftL t n  => BitStream.shiftLeft (Term.evalFin t vars) n
  -- | repeatBit t => BitStream.repeatBit (Term.evalFin t vars)

/--
If they are equal so far, then `t1 ^^^ t2`.scanOr will be 0.
-/
def Predicate.evalEq (t₁ t₂ : BitStream) : BitStream := (t₁ ^^^ t₂).concat false |>.scanOr
/--
If they have been equal so far, then `BitStream.nxor t₁ t₂`.scanAnd will be 1.
Start by assuming that they are not (not equal) i.e. that they are equal, and the
   initial value of the preciate is false / `1`.
If their values ever differ, then we know that we will have `a[i] == b[i]` to be `false`.
From this point onward, they will always disagree, and thus the predicate should become `0`.
-/
def Predicate.evalNeq (t₁ t₂ : BitStream) : BitStream := (t₁.nxor t₂).concat true |>.scanAnd

/-
If they have been `0` so far, then `t1 &&& t2 |>.scanOr` will be `1`.
-/
def Predicate.evalLor (t₁ t₂ : BitStream) : BitStream := (t₁ &&& t₂)

-- | And does not seem to work?
def Predicate.evalLand (t₁ t₂ : BitStream) : BitStream := (t₁ ||| t₂)


/--
Evaluate whether 't₁ <ᵤ t₂'.
This is defined by computing the borrow bit of 't₁ - t₂'.
If the borrow bit is `1`, then we know that `t₁ < t₂', so we return a `0`.
Otherwise, we know that 't₁ ≥ t₂'.
-/
def Predicate.evalUlt (t₁ t₂ : BitStream) : BitStream := (~~~ (t₁.borrow t₂)).concat true


/--
Returns false if the MSBs are equal.
-/
def Predicate.evalMsbEq (t₁ t₂ : BitStream) : BitStream :=
  (t₁ ^^^ t₂).concat false


private theorem not_not_xor_not (a b : Bool) : ! ((!a).xor (!b)) = (a == b) := by
  revert a b
  decide

/--
Evaluate whether `t₁ <ₛ t₂`.
This is defined by computing the most significant bit of `t₁ - t₂`.
IF the `msb is 1`, then `t₁ - t₂ <s 0`, and thus `t₁ <s t₂`.

consider the cases:
  evalMsbEq | evalUlt |
  F         | F       | F (it's correct. MSBs are equal, and they are ULT)

-/
def Predicate.evalSlt (t₁ t₂ : BitStream) : BitStream :=
    (((Predicate.evalUlt t₁ t₂)) ^^^ (Predicate.evalMsbEq t₁ t₂))

open BitStream in
/--
Evaluate a term predicate `p` to the BitStream it represents,
where the predicate is `true` at index `i` if and only if the predicate,
when truncated to index `i`, is true.
-/
def Predicate.eval (p : Predicate) (vars : List BitStream) : BitStream :=
  match p with
  | .width .eq n => BitStream.falseIffEq n
  | .width .neq n => BitStream.falseIffNeq n
  | .width .lt n => BitStream.falseIffLt n
  | .width .le n => BitStream.falseIffLe n
  | .width .gt n => BitStream.falseIffGt n
  | .width .ge n => BitStream.falseIffGe n
  | lor p q => Predicate.evalLor (p.eval vars) (q.eval vars)
  | land p q => Predicate.evalLand (p.eval vars) (q.eval vars)
  | binary .eq t₁ t₂ => Predicate.evalEq (t₁.eval vars) (t₂.eval vars)
  /-
  If it is ever not equal, then we want to stay not equals for ever.
  So, if the 'a = b' returns 'false' at some index 'i', we will stay false
  for all indexes '≥ i'.
  -/
  | binary .neq t1 t2 => Predicate.evalNeq (t1.eval vars) (t2.eval vars)
  | binary .ult t₁ t₂ => Predicate.evalUlt (t₁.eval vars) (t₂.eval vars)
  | binary .ule t₁ t₂ =>
     Predicate.evalLor
       (Predicate.evalEq (t₁.eval vars) (t₂.eval vars))
       (Predicate.evalUlt (t₁.eval vars) (t₂.eval vars))
  | binary .slt t₁ t₂ => Predicate.evalSlt (t₁.eval vars) (t₂.eval vars)
  | binary .sle t₁ t₂ => Predicate.evalLor
       (Predicate.evalEq (t₁.eval vars) (t₂.eval vars))
       (Predicate.evalSlt (t₁.eval vars) (t₂.eval vars))

@[simp]
theorem Bool.xor_false_iff_eq : ∀ (a b : Bool), (a ^^ b) = false ↔ a = b := by decide

section Predicate
/-- If something is always true, then it is eventually always true. -/
theorem eventually_all_zeroes_of_all_zeroes (b : BitStream) (h : ∀ n, b n = false) : ∃ (N : Nat), ∀ n ≥ N, b n = false := by
  exists Nat.zero
  simp [h]


/-- If the scanOr of something is eventually always zeroes, then it must be all zeroes. -/
theorem all_zeroes_of_scanOr_eventually_all_zeroes (b : BitStream) (h : ∃ (N : Nat), ∀ n ≥ N, b.scanOr n = false) : ∀ n, b n = false := by
  intros n
  have ⟨N, h⟩ := h
  simp [BitStream.scanOr_false_iff] at h
  apply h (n := max N n) <;> omega

end Predicate

/-- Denote a predicate into a bitstream, where the ith bit tells us if it is true in the ith state -/
-- TODO: remove this from the @[simp] set.
@[simp] def Predicate.evalFin (p : Predicate) (vars : Fin (arity p) → BitStream) : BitStream :=
match p with
| .width .eq n => BitStream.falseIffEq n
| .width .neq n => BitStream.falseIffNeq n
| .width .lt n => BitStream.falseIffLt n
| .width .le n => BitStream.falseIffLe n
| .width .gt n => BitStream.falseIffGt n
| .width .ge n => BitStream.falseIffGe n
| .binary .eq t₁ t₂ =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalEq x₁ x₂
| .binary .neq t₁ t₂  =>
    let x₁ := t₁.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    let x₂ := t₂.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
    Predicate.evalNeq x₁ x₂
| .land p q =>
  -- if both `p` and `q` are logically true (i.e. the predicate is `false`),
  -- only then should we return a `false`.
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLand x₁ x₂
| .lor p q =>
  -- If either of the predicates are `false`, then result is `false`.
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor x₁ x₂
| .binary .slt p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalSlt x₁ x₂
| .binary .sle p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor (Predicate.evalSlt x₁ x₂) (Predicate.evalEq x₁ x₂)
| .binary .ult p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  (Predicate.evalUlt x₁ x₂)
| .binary .ule p q =>
  let x₁ := p.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  let x₂ := q.evalFin (fun i => vars (Fin.castLE (by simp [arity]) i))
  Predicate.evalLor (Predicate.evalUlt x₁ x₂) (Predicate.evalEq x₁ x₂)

/--
Evaluating the term and then coercing the term to a bitvector is equal to denoting the term directly.
-/
@[simp] theorem Term.eval_eq_denote (t : Term) (w : Nat) (vars : List (BitVec w)) :
    (t.eval (vars.map BitStream.ofBitVecSext)).toBitVec w = t.denote w vars := by
  induction t generalizing w vars
  case var x =>
    simp [eval, denote]
    cases x? : vars[x]?
    case none => simp [default]
    case some x => simp
  case zero => simp [eval, denote]
  case negOne => simp [eval, denote]; rw [← BitVec.neg_one_eq_allOnes]
  case one => simp [eval, denote]
  case ofNat n => simp [eval, denote]
  case and a b ha hb  => simp [eval, denote, ha, hb]
  case or a b ha hb => simp [eval, denote, ha, hb]
  case xor a b ha hb => simp [eval, denote, ha, hb]
  case not a ha => simp [eval, denote, ha]
  case add a b ha hb => simp [eval, denote, ha, hb]
  case sub a b ha hb => simp [eval, denote, ha, hb]
  case neg a ha => simp [eval, denote, ha]
  case shiftL a ha => simp [eval, denote, ha]

/-
This says that calling 'eval' at an index equals calling 'denote' and grabbing the bitstream
 at that index, as long as the value is inbounds, and if not, it's going to be 'false'
 -/
theorem Term.eval_eq_denote_apply (t : Term) {w : Nat} {vars : List (BitVec w)}
    {i : Nat} (hi : i < w) :
    (t.eval (vars.map BitStream.ofBitVecSext)) i = (t.denote w vars).getLsbD i := by
  have := t.eval_eq_denote w vars
  have :
    (BitStream.toBitVec w (t.eval (List.map .ofBitVecSext vars))).getLsbD i =
    (denote w t vars).getLsbD i := by simp [this]
  rw [BitStream.getLsbD_toBitVec] at this
  simp only [show i < w by omega, decide_true, Bool.true_and] at this
  simp [this]

/-
This says that calling 'eval' at an index equals calling 'denote' and grabbing the bitstream
 at that index, as long as the value is inbounds, and if not, it's going to be 'false'
 -/
theorem Term.denote_eq_eval_land_lt (t : Term) {w : Nat} {vars : List (BitVec w)}
    {i : Nat} :
    (t.denote w vars).getLsbD i = ((t.eval (vars.map .ofBitVecSext)) i && (decide (i < w))) := by
  have := t.eval_eq_denote w vars
  have :
    (BitStream.toBitVec w (t.eval (List.map .ofBitVecSext vars))).getLsbD i =
    (denote w t vars).getLsbD i := by simp [this]
  rw [BitStream.getLsbD_toBitVec] at this
  by_cases hi : i < w
  · simp [hi] at this
    simp [this, hi]
  · simpa [hi] using this

/-
if 'evalEq' evaluates to 'false', then indeed the denotations of the terms are equal.
-/
theorem Predicate.evalEq_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalEq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = false ↔
    Term.denote w a vars = Term.denote w b vars := by
  simp [evalEq]
  constructor
  · intros h
    /- Dear god, this proof is ugly. -/
    simp only [BitStream.scanOr_false_iff] at h
    apply BitVec.eq_of_getLsbD_eq
    intros i hi
    specialize h (i + 1) (by omega)
    simp at h
    rw [Term.eval_eq_denote_apply a hi, Term.eval_eq_denote_apply b  hi] at h
    exact h
  · intros h
    rw [BitStream.scanOr_false_iff]
    intros i hi
    rcases i with rfl | i
    · simp
    · simp
      rw [Term.eval_eq_denote_apply a (by omega), Term.eval_eq_denote_apply b (by omega), h]

/-- evalEq is true iff evalNeq is false -/
theorem Predicate.evalEq_iff_not_evalNeq (a b : BitStream) :
    ∀ (w : Nat), evalEq a b w ↔ ¬ (evalNeq a b w) := by
  intros w
  rcases w with rfl | w
  · simp [evalEq, evalNeq]
  · simp [evalEq, evalNeq]
    by_cases hab : a w = b w
    · simp [hab]
      by_cases heq : (BitStream.concat false (a ^^^ b)).scanOr w
      · simp [heq]
        rw [BitStream.scanAnd_false_iff]
        rw [BitStream.scanOr_true_iff] at heq
        obtain ⟨i, hi, hi'⟩ := heq
        exists i
        simp [hi]
        rcases i with rfl | i
        · simp at hi'
        · simpa using hi'
      · simp [heq]
        rw [BitStream.scanAnd_true_iff]
        simp at heq
        intros i hi
        rw [BitStream.scanOr_false_iff] at heq
        specialize (heq i hi)
        rcases i with rfl | i
        · simp
        · simpa using heq
    · simp [hab]




/-- 'evalNeq' correctly witnesses when terms are disequal -/
theorem Predicate.evalNeq_denote {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalNeq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = false ↔
    Term.denote w a vars ≠ Term.denote w b vars := by
  constructor
  · intros h
    apply Predicate.evalEq_denote_false_iff .. |>.not.mp
    simp only [Bool.not_eq_false]
    have := Predicate.evalEq_iff_not_evalNeq
      (a.eval (List.map .ofBitVecSext vars))
      (b.eval (List.map .ofBitVecSext vars))
    apply this .. |>.mpr
    simp [h]
  · intros h
    have this' := Predicate.evalEq_denote_false_iff .. |>.not.mpr h
    simp at this'
    have := Predicate.evalEq_iff_not_evalNeq
      (a.eval (List.map .ofBitVecSext vars))
      (b.eval (List.map .ofBitVecSext vars)) w |>.mp this'
    simpa using this

theorem Predicate.evalEq_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalEq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = true ↔
    Term.denote w a vars ≠ Term.denote w b vars := by
  rw [Predicate.evalEq_iff_not_evalNeq]
  simp [evalNeq_denote]


private theorem BitVec.lt_eq_decide_ult {x y : BitVec w} : (x < y) = decide (x.ult y) := by
  simp [BitVec.lt_def, BitVec.ult]

private theorem BitVec.lt_iff_ult {x y : BitVec w} : (x < y) ↔ (x.ult y) := by
  simp [BitVec.lt_def, BitVec.ult]

theorem Predicate.evalUlt_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalUlt (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = false ↔
    (Term.denote w a vars < Term.denote w b vars) := by
  simp [evalUlt, BitVec.lt_eq_decide_ult, BitVec.ult_eq_not_carry]
  rcases w with rfl | w
  · simp [BitVec.of_length_zero]
  · simp
    simp [BitStream.borrow, BitStream.subAux_eq_BitVec_carry (w := w + 1)]

theorem Predicate.evalUlt_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalUlt (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = true ↔
      (Term.denote w b vars) ≤ (Term.denote w a vars) := by
  obtain ⟨h₁, h₂⟩ := evalUlt_denote_false_iff a b vars
  constructor
  · intros h
    by_contra h'
    simp at h'
    specialize (h₂ h')
    simp [h₂] at h
  · intros h
    by_contra h'
    simp at h'
    specialize (h₁ h')
    bv_omega

private theorem evalMsbEq_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    Predicate.evalMsbEq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = false ↔
   ((Term.denote w a vars).msb = (Term.denote w b vars).msb) := by
  simp [Predicate.evalMsbEq]
  rcases w with rfl | w
  · simp [BitVec.of_length_zero]
  · simp [BitVec.msb_eq_getLsbD_last, Term.eval_eq_denote_apply]

private theorem evalMsbEq_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    Predicate.evalMsbEq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = true ↔
   ((Term.denote w a vars).msb ≠ (Term.denote w b vars).msb) := by
  simp [Predicate.evalMsbEq]
  rcases w with rfl | w
  · simp [BitVec.of_length_zero]
  · simp [BitVec.msb_eq_getLsbD_last, Term.eval_eq_denote_apply]

theorem eq_true_iff_of_eq_false_iff (b : Bool) (rhs : Prop) (h : (b = false) ↔ rhs) :
    (b = true) ↔ ¬ rhs := by
constructor
· intros h'
  apply h.not.mp
  simp [h']
· intros h'
  by_contra hcontra
  simp at hcontra
  have := h.mp hcontra
  exact h' this

/-- TODO: Minimize this proof by a metric fuckton. -/
private theorem Predicate.evalSlt_denote_false_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalSlt (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = false ↔
    (Term.denote w a vars).slt (Term.denote w b vars) := by
  simp [evalSlt, BitStream.xor_eq]
  have hult_iff := Predicate.evalUlt_denote_false_iff a b vars
  by_cases hUlt : evalUlt (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w
  · rw [hUlt]
    have hUlt' := evalUlt_denote_true_iff .. |>.mp hUlt
    simp
    by_cases hMsbEq : evalMsbEq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w
    · rw [hMsbEq]
      have hMsbEq' := evalMsbEq_denote_true_iff .. |>.mp hMsbEq
      simp
      rw [BitVec.slt_eq_ult]
      -- TODO: how to deal with booleans properly? This is making my life pretty miserable at the moment.
      have : ((Term.denote w a vars).msb != (Term.denote w b vars).msb) = true := by
        simp [hMsbEq']
      simp [this]
      rw [BitVec.ult]
      rw [BitVec.le_def] at hUlt'
      simp; omega
    · simp at hMsbEq
      have hMsbEq' := evalMsbEq_denote_false_iff .. |>.mp hMsbEq
      simp [hMsbEq]
      rw [BitVec.le_def] at hUlt'
      rw [BitVec.slt_eq_ult]
      rw [BitVec.ult]
      simp [show ¬ (Term.denote w a vars).toNat < (Term.denote w b vars).toNat by omega]
      simp [hMsbEq']
  · simp at hUlt
    rw [hUlt]
    have hUlt' := evalUlt_denote_false_iff .. |>.mp hUlt
    simp
    by_cases h' : evalMsbEq (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w
    · simp [h']
      rw [BitVec.slt_eq_ult]
      rw [BitVec.ult]
      rw [BitVec.lt_def] at hUlt'
      simp [hUlt']
      simp [evalMsbEq_denote_true_iff .. |>.mp h']
    · simp at h'
      simp [h']
      rw [BitVec.slt_eq_ult]
      rw [BitVec.ult]
      rw [BitVec.lt_def] at hUlt'
      simp [hUlt']
      simp [evalMsbEq_denote_false_iff .. |>.mp h']

private theorem Predicate.evalSlt_denote_true_iff {w : Nat} (a b : Term) (vars : List (BitVec w)) :
    evalSlt (a.eval (List.map .ofBitVecSext vars)) (b.eval (List.map .ofBitVecSext vars)) w = true ↔
    ¬ (Term.denote w a vars).slt (Term.denote w b vars) := by
  rw [eq_true_iff_of_eq_false_iff]
  simp [Predicate.evalSlt_denote_false_iff]

/-- TODO: ForLean -/
private theorem BitVec.ForLean.ule_iff_ult_or_eq (x y : BitVec w) : x ≤ y ↔ (x = y ∨ x < y) := by
  constructor <;> bv_omega

private theorem BitVec.ForLean.ule_iff_ult_or_eq' (x y : BitVec w) : (x.ule y) = (decide (x = y ∨ x < y)) := by
  simp only [BitVec.ule]
  by_cases hx : x = y ∨ x < y
  case pos => simp [hx]; bv_omega
  case neg => simp [hx]; bv_omega

private theorem BitVec.sle_iff_slt_or_eq (x y : BitVec w) : x.sle y ↔ (decide (x = y) ∨ x.slt y) := by
  simp [BitVec.slt, BitVec.sle]
  constructor
  · intros h
    suffices x.toInt = y.toInt ∨ x.toInt < y.toInt by
      rcases this with h | h
      · left
        apply BitVec.eq_of_toInt_eq h
      · right
        omega
    omega
  · intros h
    rcases h with rfl | h  <;> omega

theorem BitVec.ult_notation_eq_decide_ult (x y : BitVec w) : (x.ult y) = decide (x < y) := by
  simp [BitVec.lt_def, BitVec.ult]
/--
The semantics of a predicate:
The predicate, when evaluated, at index `i` is false iff the denotation is true.
-/
theorem Predicate.eval_eq_denote (w : Nat) (p : Predicate) (vars : List (BitVec w)) :
    (p.eval (vars.map .ofBitVecSext) w = false) ↔ p.denote w vars := by
  induction p generalizing vars w
  case width wp n => cases wp <;> simp [eval, denote]
  case binary p a b =>
    cases p with
    | eq => simp [eval, denote]; apply evalEq_denote_false_iff
    | neq => simp [eval, denote]; apply evalNeq_denote
    | ult =>
      simp [eval, denote]
      rw [BitVec.ult_notation_eq_decide_ult]
      by_cases h: Term.denote w a vars < Term.denote w b vars
      case pos => simp only [h, decide_true, Bool.not_true]; rw [evalUlt_denote_false_iff]; exact h
      case neg => simp only [h, decide_false, Bool.not_false]; rw [evalUlt_denote_true_iff]; simpa using h
    | slt =>
      simp [eval, denote];
      by_cases h : (Term.denote w a vars).slt (Term.denote w b vars)
      · rw [h]
        simp [Predicate.evalSlt_denote_false_iff, h]
      · simp at h
        rw [h]
        simp only [Bool.not_false]
        by_contra h'
        simp only [Bool.not_eq_true] at h'
        rw [Predicate.evalSlt_denote_false_iff] at h'
        simp only [h, Bool.false_eq_true] at h'
    | ule =>
      simp [eval, denote];
      simp only [evalLor, BitStream.and_eq]
      rw [BitVec.ForLean.ule_iff_ult_or_eq' (Term.denote w a vars) (Term.denote w b vars)]
      by_cases heq : Term.denote w a vars = Term.denote w b vars
      · rw [heq]
        simp [evalEq_denote_false_iff a b vars |>.mpr heq]
      · simp [heq]
        by_cases hlt : Term.denote w a vars < Term.denote w b vars
        · simp [hlt]
          simp [evalUlt_denote_false_iff a b vars |>.mpr hlt]
        · simp [hlt]
          have := evalEq_denote_false_iff a b vars |>.not |>.mpr heq
          simp only [this, true_and]
          have := evalUlt_denote_false_iff a b vars |>.not |>.mpr hlt
          simp only [this]
    | sle =>
      simp [eval, denote]
      simp only [evalLor, BitStream.and_eq]
      have h := BitVec.sle_iff_slt_or_eq (Term.denote w a vars) (Term.denote w b vars) |>.eq
      rcases hSle : (Term.denote w a vars).sle (Term.denote w b vars)
      · simp [hSle] at h ⊢
        obtain ⟨h₁, h₂⟩ := h
        simp [evalEq_denote_true_iff .. |>.mpr h₁]
        rw [evalSlt_denote_true_iff .. |>.mpr]
        simp [h₂]
      · simp [hSle] at h ⊢
        intros hEq
        simp [evalEq_denote_true_iff .. |>.mp hEq] at h
        apply evalSlt_denote_false_iff .. |>.mpr h
  case land p q hp hq => simp [eval, denote, hp, hq, evalLand]
  case lor p q hp hq =>
    simp [eval, denote]
    simp only [evalLor, BitStream.and_eq]
    constructor
    · intros heval
      by_cases hp' : p.denote w vars
      · simp [hp']
      · by_cases hq' : q.denote w vars
        · simp [hq']
        · have := hp .. |>.not |>.mpr hp'
          simp [this] at heval
          have := hq .. |>.not |>.mpr hq'
          simp [this] at heval
    · intros hdenote
      rcases hdenote with hp' | hq'
      · have := hp .. |>.mpr hp'
        simp [this]
      · have := hq .. |>.mpr hq'
        simp [this]

theorem Predicate.denote_of_eval {w : Nat} {p : Predicate} {vars : List (BitVec w)}
    (heval : (p.eval (vars.map .ofBitVecSext) w = false)) : p.denote w vars := by
  apply Predicate.eval_eq_denote w p vars |>.mp heval


/--
A predicate for a fixed width 'wn' can be expressed as universal quantification
over all width 'w', with a constraint that 'w = wn'
-/
theorem Predicate.width_eq_implies_iff (wn : Nat) {p : Nat → Prop} :
    p wn ↔ (∀ (w : Nat), w = wn → p w) := by
  constructor
  · intros hp h hwn
    subst hwn
    apply hp
  · intros hp
    apply hp
    rfl

/-- To prove that `p` holds, it suffices to show that `p.eval ... = false`. -/
theorem Predicate.denote_of_eval_eq {p : Predicate}
    (heval : ∀ (w : Nat) (vars : List BitStream), p.eval vars w = false) :
    ∀ (w : Nat) (vars : List (BitVec w)), p.denote w vars := by
  intros w vars
  apply p.eval_eq_denote w vars |>.mp (heval w <| vars.map .ofBitVecSext)


/-- To prove that `p` holds, it suffices to show that `p.eval ... = false`. -/
theorem Predicate.denote_of_eval_eq_fixedWidth {p : Predicate} (w : Nat)
    (heval : ∀ (vars : List BitStream), p.eval vars w = false) :
    ∀ (vars : List (BitVec w)), p.denote w vars := by
  intros vars
  apply p.eval_eq_denote w vars |>.mp (heval <| vars.map .ofBitVecSext)

/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

namespace BitVec


notation:50 x " ≥ᵤ " y => BitVec.ule y x
notation:50 x " >ᵤ " y => BitVec.ult y x
notation:50 x " ≤ᵤ " y => BitVec.ule x y
notation:50 x " <ᵤ " y => BitVec.ult x y

notation:50 x " ≥ₛ " y => BitVec.sle y x
notation:50 x " >ₛ " y => BitVec.slt y x
notation:50 x " ≤ₛ " y => BitVec.sle x y
notation:50 x " <ₛ " y => BitVec.slt x y

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)

-- A lot of this should probably go to a differet file here and not Mathlib
inductive Refinement {α : Type u} : Option α → Option α → Prop
  | bothSome {x y : α } : x = y → Refinement (some x) (some y)
  | noneAny {x? : Option α} : Refinement none x?

namespace Refinement

infix:50 (priority:=low) " ⊑ " => Refinement

@[simp]
theorem some_some {α : Type u} {x y : α} :
  (some x) ⊑ (some y) ↔ x = y :=
  ⟨by intro h; cases h; assumption, Refinement.bothSome⟩

@[simp]
theorem none_left :
  Refinement none x? := .noneAny

theorem none_right {x? : Option α} :
    x? ⊑ none ↔ x? = none := by
  cases x?
  · simp only [none_left]
  · simp only [reduceCtorEq, iff_false]
    rintro ⟨⟩

theorem some_left {x : α} {y? : Option α} :
    some x ⊑ y? ↔ y? = some x := by
  cases y? <;> simp [eq_comm, none_right]

@[simp]
theorem refl {α: Type u} : ∀ x : Option α, Refinement x x := by
  intro x ; cases x
  apply Refinement.noneAny
  apply Refinement.bothSome; rfl

theorem trans {α : Type u} : ∀ x y z : Option α, Refinement x y → Refinement y z → Refinement x z := by
  intro x y z h₁ h₂
  cases h₁ <;> cases h₂ <;> try { apply Refinement.noneAny } ; try {apply Refinement.bothSome; assumption}
  rename_i x y hxy y h
  rw [hxy, h]; apply refl

instance {α : Type u} [DEQ : DecidableEq α] : DecidableRel (@Refinement α) := by
  intro x y
  cases x <;> cases y
  { apply isTrue; exact Refinement.noneAny}
  { apply isTrue; exact Refinement.noneAny }
  { apply isFalse; intro h; cases h }
  { rename_i val val'
    cases (DEQ val val')
    { apply isFalse; intro h; cases h; contradiction }
    { apply isTrue; apply Refinement.bothSome; assumption }
  }

end Refinement

instance : Coe Bool (BitVec 1) := ⟨BitVec.ofBool⟩

def coeWidth {m n : Nat} : BitVec m → BitVec n
  | x => BitVec.ofNat n x.toNat

-- not sure what the right `Coe`is for this case
-- See: https://leanprover-community.github.io/mathlib4_docs/Init/Coe.html#Important-typeclasses
--instance {m n: Nat} : CoeTail (BitVec m) (BitVec n) := ⟨BitVec.coeWidth⟩

instance decPropToBitvec1 (p : Prop) [Decidable p] : CoeDep Prop p (BitVec 1) where
  coe := BitVec.ofBool $ decide p

open Std

theorem Int.natCast_pred_of_pos (x : Nat) (h : 0 < x) :
    (x : Int) - 1 = Nat.cast (x - 1) := by
  simp only [Nat.cast, NatCast.natCast]
  cases x
  case zero => contradiction
  case succ x =>
    simp only [(· - ·), Sub.sub, Int.sub, (· + ·), Add.add, Int.add,
      (-·), Int.neg, Int.negOfNat, Int.subNatNat]
    simp

@[simp]
theorem ofBool_eq_one_iff (b : Bool) :
    ofBool b = 1#1 ↔ b = true := by
  cases b <;> simp

theorem one_udiv (x : BitVec w) :
    (1#w) / x = if x = 1#w then 1#w else 0#w := by
  rcases w with _|w
  · simp
  · apply eq_of_toNat_eq
    have : x = 1#_ ↔ x.toNat = 1 := by
      constructor
      · rintro rfl; simp
      · intro h; apply eq_of_toNat_eq; simp [h]
    simp only [toNat_udiv, toNat_ofNat, Nat.zero_lt_succ, Nat.one_mod_two_pow, this]
    match x.toNat with
    | 0 | 1 | x + 2 => simp

theorem one_sdiv (x : BitVec w) :
    (1#w).sdiv x =
      if x = 1#w then
        1#w
      else if x = -1#w then
        -1#w
      else
        0#w := by
  simp [BitVec.sdiv]
  by_cases hw : w = 1
  · subst hw
    match x with
    | 0#1 | 1#1 => rfl
  · simp only [hw, decide_false]
    by_cases hx : x = 1#w
    · subst hx
      simp [hw]
    by_cases hx : x = -1#w
    · subst hx
      have : w ≠ 0 := by rintro rfl; contradiction
      have : (1#w != 0#w) = true := by simp [*]
      have : (1#w != intMin _) = true := by
        simp only [bne_iff_ne, ne_eq, intMin]
        intro contra
        have : (twoPow w (w - 1)).toNat = 1 := by
          simp [← contra]; omega
        obtain ⟨_, rfl⟩ := Nat.exists_eq_add_of_lt (by omega : 1 < w)
        rw [toNat_twoPow, Nat.mod_eq_of_lt] at this
        · simp at this
        · simp; omega
      simp [*, BitVec.msb_neg]
    · simp [*]
      cases hx : x.msb
      · simp [one_udiv, *]
      · simp [one_udiv, *]
        intro h_neg_x
        exfalso
        apply ‹x ≠ -1#w›
        rw [← BitVec.neg_neg (x := x), h_neg_x]

theorem eq_ofNat_iff_toNat_eq (x : BitVec w) (n : Nat) :
    x = BitVec.ofNat w n ↔ x.toNat = n % 2 ^ w := by
  constructor
  · rintro rfl; simp
  · intro h; apply BitVec.eq_of_toNat_eq; simpa

end BitVec

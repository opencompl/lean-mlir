/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

namespace BitVec


-- notation:50 x " ≥ᵤ " y => BitVec.ule y x
-- notation:50 x " >ᵤ " y => BitVec.ult y x
-- notation:50 x " ≤ᵤ " y => BitVec.ule x y
-- notation:50 x " <ᵤ " y => BitVec.ult x y

-- notation:50 x " ≥ₛ " y => BitVec.sle y x
-- notation:50 x " >ₛ " y => BitVec.slt y x
-- notation:50 x " ≤ₛ " y => BitVec.sle x y
-- notation:50 x " <ₛ " y => BitVec.slt x y

instance {n} : ShiftLeft (BitVec n) := ⟨fun x y => x <<< y.toNat⟩

instance {n} : ShiftRight (BitVec n) := ⟨fun x y => x >>> y.toNat⟩

infixl:75 ">>>ₛ" => fun x y => BitVec.sshiftRight x (BitVec.toNat y)


instance : Coe Bool (BitVec 1) := ⟨BitVec.ofBool⟩

def coeWidth {m n : Nat} : BitVec m → BitVec n
  | x => BitVec.ofNat n x.toNat


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

theorem ofBool_eq_one_iff (b : Bool) :
    ofBool b = 1#1 ↔ b = true := by
  cases b <;> simp

end BitVec

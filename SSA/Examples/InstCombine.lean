import SSA.WellTypedFramework
import Aesop

namespace InstCombine

inductive LengthIndexedList (α : Type u) : Nat → Type u where
   | nil : LengthIndexedList α 0
   | cons : α → LengthIndexedList α n → LengthIndexedList α (n + 1)
  deriving Repr, DecidableEq

def LengthIndexedList.fromList {α : Type u} (l : List α) : LengthIndexedList α (List.length l) :=
  match l with
  | [] => LengthIndexedList.nil
  | x :: xs => LengthIndexedList.cons x (LengthIndexedList.fromList xs)

@[simp]
def LengthIndexedList.foldl {α β : Type u} {n : Nat} (f : β → α → β) (acc : β) : LengthIndexedList α n → β
  | nil => acc
  | cons x xs => LengthIndexedList.foldl f (f acc x) xs

@[simp]
def LengthIndexedList.zipWith {α β γ : Type u} {n : Nat} (f : α → β → γ) :
    LengthIndexedList α n → LengthIndexedList β n → LengthIndexedList γ n
  | nil, nil => nil
  | cons x xs, cons y ys => cons (f x y) (zipWith f xs ys)

abbrev Width := Nat
--
structure BitVector (width : Width) where
  (bits : LengthIndexedList Bool width)
  deriving Repr, DecidableEq

def nextSignificantBit (val : Nat) (b : Bool) := 2 * val + if (b = true) then 1 else 0

-- We could instead just define this directly as Fin (2^width)
def RawBitVectorVal {w : Width} (x : LengthIndexedList Bool w) : Nat :=
  x.foldl nextSignificantBit 0

-- #eval RawBitVectorVal (LengthIndexedList.fromList [false,true]) -- 1
-- #eval RawBitVectorVal (LengthIndexedList.fromList [true,false,false,false]) -- 8
-- #eval RawBitVectorVal $ LengthIndexedList.fromList [true,true,false,false,false] -- 24
-- #eval RawBitVectorVal $ LengthIndexedList.fromList [true,false,false,false, true] -- 17
#eval RawBitVectorVal $ (LengthIndexedList.fromList [true,false,false,false]).cons true -- 24

theorem nextSignificantBitTrue {val : Nat} : nextSignificantBit val true = 2 * val + 1 := by
  simp [nextSignificantBit]

theorem nextSignificantBitFalse {val : Nat} : nextSignificantBit val false = 2 * val := by
  simp [nextSignificantBit]

theorem RawBitVectorFalse {w : Width} {x : LengthIndexedList Bool w} :
  (LengthIndexedList.cons false x).foldl nextSignificantBit 0 = x.foldl nextSignificantBit 0 := by simp[LengthIndexedList.foldl, nextSignificantBitFalse]

def testExample := fun n => [true,false,true].foldl nextSignificantBit n
#eval [0,1,2,3,4,5].map testExample
theorem foldNextSignificantBit {w : Nat} {x : LengthIndexedList Bool w} {v : Nat} :
  x.foldl nextSignificantBit n = 2^w + x.foldl nextSignificantBit 0 := by
    induction x with
      | nil => simp[LengthIndexedList.foldl, nextSignificantBit]
      | cons b bs ih => simp



theorem RawBitVectorValNil : RawBitVectorVal (LengthIndexedList.nil) = 0 := by
  simp [RawBitVectorVal]

-- Appends to the most significant bit
theorem RawBitVectorValConsTrue {w : Width} (x : LengthIndexedList Bool w) (b : Bool) :
    RawBitVectorVal (x.cons true) =  2 * RawBitVectorVal x + 1 := by
      simp [RawBitVectorVal, LengthIndexedList.foldl]
      rw [LengthIndexedList.foldl]



theorem RawBitVectorValGrowth {w : Width} (x : LengthIndexedList Bool (w - 1)) : ∀ b : Bool, RawBitVectorVal (x.cons b) ≤ 2 * RawBitVectorVal x := by
  intro b; cases b with
   | false => simp [RawBitVectorVal]; rw [Nat.two_mul]
              apply Nat.le_add_left
   | true => simp [RawBitVectorVal]; unfold LengthIndexedList.foldl <;> cases w


theorem BitVector.valRawLT {w : Width} (x : LengthIndexedList Bool w) : RawBitVectorVal x < 2^w := by
  simp [RawBitVectorVal]
  induction x with
  | nil => simp
  | cons b bs ih => cases b with
    | false => rw [Nat.pow_succ,Nat.mul_two]
               apply Nat.lt_add_right
               simp [LengthIndexedList.foldl] at *
               exact ih
    | true => simp  [LengthIndexedList.foldl] at *


def BitVector.val {w : Width} (x : BitVector w) : Fin (2^w) :=


inductive BaseType
  | bitvec (w : Width) : BaseType

instance : Goedel BaseType where
  toType := fun
    | .bitvec w => BitVector w

abbrev UserType := SSA.UserType BaseType

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
  | and (w : Width) : Op
  | or (w : Width) : Op
  | xor (w : Width) : Op
  | shr (w : Width) : Op
  | lshr (w : Width) : Op
  | ashr (w : Width) : Op
  deriving Repr, DecidableEq

-- Can we get rid of the code repetition here? (not that copilot has any trouble completing this)
def argUserType : Op → UserType
  | Op.and w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
  | Op.or w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
  | Op.xor w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
  | Op.shr w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
  | Op.lshr w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
  | Op.ashr w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))

def outUserType : Op → UserType
  | Op.and w => .base (BaseType.bitvec w)
  | Op.or w => .base (BaseType.bitvec w)
  | Op.xor w => .base (BaseType.bitvec w)
  | Op.shr w => .base (BaseType.bitvec w)
  | Op.lshr w => .base (BaseType.bitvec w)
  | Op.ashr w => .base (BaseType.bitvec w)

def rgnDom : Op → UserType := sorry
def rgnCod : Op → UserType := sorry

def BitVector.bitWiseOp : ∀ {w : Width}, (Bool → Bool → Bool) → BitVector w → BitVector w → BitVector w
  | _, f, {val := x}, {val := y} => {val := LengthIndexedList.zipWith (fun a b => f a b) x y}

def BitVector.and : ∀ {w : Width}, BitVector w → BitVector w → BitVector w := BitVector.bitWiseOp (· && ·)
def BitVector.or : ∀ {w : Width}, BitVector w → BitVector w → BitVector w := BitVector.bitWiseOp (· || ·)
def BitVector.xor : ∀ {w : Width}, BitVector w → BitVector w → BitVector w := BitVector.bitWiseOp (fun a b => (a || b) && (¬ a || ¬ b))

-- op1 * 2op2 mod 2n, where n is the width of the result
def eval : ∀ (o : Op), Goedel.toType (argUserType o) → (Goedel.toType (rgnDom o) →
    Goedel.toType (rgnCod o)) → Goedel.toType (outUserType o) :=
    fun o arg _ => match o, arg with
      | Op.and w, .pair x y => fun (x y : BitVector w) => .base {val := (LengthIndexedList.zipWith (fun a b => a && b) x.val y.val)}

instance : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

end InstCombine
/-
Optimization: InstCombineShift: 239
  %Op0 = shl %X, C
  %r = lshr %Op0, C
=>
  %r = and %X, (-1 u>> C)
-/

import SSA.WellTypedFramework
import Aesop

namespace InstCombine

abbrev Width := { x : Nat // x > 0 } -- difference with { x : Nat  | 0 < x }?

def Fin.coeLt {n m : Nat} : n ≤ m → Fin n → Fin m :=
  fun h i => match i with
    | ⟨i, h'⟩ => ⟨i, Nat.lt_of_lt_of_le h' h⟩


inductive LengthIndexedList (α : Type u) : Nat → Type u where
   | nil : LengthIndexedList α 0
   | cons : α → LengthIndexedList α n → LengthIndexedList α (n + 1)
  deriving Repr, DecidableEq

namespace LengthIndexedList

def fromList {α : Type u} (l : List α) : LengthIndexedList α (List.length l) :=
  match l with
  | [] => LengthIndexedList.nil
  | x :: xs => LengthIndexedList.cons x (LengthIndexedList.fromList xs)

def map {α β : Type u} (f : α → β) {n : Nat} : LengthIndexedList α n → LengthIndexedList β n
  | nil => nil
  | cons x xs => cons (f x) (map f xs)


@[simp]
def foldl {α β : Type u} {n : Nat} (f : β → α → β) (acc : β) : LengthIndexedList α n → β
  | nil => acc
  | cons x xs => LengthIndexedList.foldl f (f acc x) xs

@[simp]
def zipWith {α β γ : Type u} {n : Nat} (f : α → β → γ) :
    LengthIndexedList α n → LengthIndexedList β n → LengthIndexedList γ n
  | nil, nil => nil
  | cons x xs, cons y ys => cons (f x y) (zipWith f xs ys)

def nth {α : Type u} {n : Nat} (l : LengthIndexedList α n) (i : Fin n) : α :=
  match l, i with
  | LengthIndexedList.cons x _, ⟨0, _⟩ => x
  | LengthIndexedList.cons _ xs, ⟨i + 1, h⟩ => nth xs ⟨i, Nat.succ_lt_succ_iff.1 h⟩

instance : GetElem (LengthIndexedList α n) Nat α fun _xs i => LT.lt i n where
  getElem xs i h := nth xs ⟨i, h⟩

def NatEq {α : Type u} {n m : Nat} : n = m → LengthIndexedList α n → LengthIndexedList α m :=
  fun h l => match h, l with
    | rfl, l => l

def finRange (n : Nat) : LengthIndexedList (Fin n) n :=
  match n with
    | 0 => LengthIndexedList.nil
    | m + 1 =>
      let coeFun : Fin m → Fin (m + 1) := Fin.coeLt (Nat.le_succ m)
    LengthIndexedList.cons ⟨m, Nat.lt_succ_self m⟩ (LengthIndexedList.map coeFun (LengthIndexedList.finRange m))

@[simp]
theorem finRangeIndex {n : Nat} (i : Fin n) : nth (finRange n) i = i := by
  match i with
  | ⟨idx,hidx⟩ => sorry

end LengthIndexedList

inductive BaseType
  | bitvec (w : Width) : BaseType

structure BitVector (width : Width) where
  (bits : LengthIndexedList Bool width)
  deriving Repr, DecidableEq

instance (width : Width) : Inhabited (BitVector width) :=
  ⟨⟨by convert LengthIndexedList.fromList (List.replicate width true); simp⟩⟩

def BitVectorFun {width : Width} := Fin width.val → Bool

def BitVectorFun.fromList {width : Width} (l : LengthIndexedList Bool width.val) : @BitVectorFun width :=
  fun i => l[i]

def BitVectorFun.fromBitVector {width : Width} (bv : BitVector width) : @BitVectorFun width :=
  BitVectorFun.fromList bv.bits

def BitVectorFun.toList {width : Width} (f : @BitVectorFun width) : LengthIndexedList Bool width.val :=
  let indices := LengthIndexedList.finRange width.val
  indices.map f

def BitVectorFun.toBitVector {width : Width} (f : @BitVectorFun width) : BitVector width := ⟨BitVectorFun.toList f⟩

instance {width : Width} : Coe (@BitVectorFun width) (BitVector width) := ⟨BitVectorFun.toBitVector⟩
instance {width : Width} : Coe (BitVector width) (@BitVectorFun width) := ⟨BitVectorFun.fromBitVector⟩

theorem BitVectorFun.toListFromList {width : Width} (l : LengthIndexedList Bool width.val) :
  BitVectorFun.toList (BitVectorFun.fromList l) = l := by
    simp [BitVectorFun.toList, BitVectorFun.fromList]
    sorry

theorem BitVectorFun.toBitVectorFromBitVector {width : Width} (l : BitVector width) :
  BitVectorFun.toBitVector (BitVectorFun.fromBitVector l) = l := by
  simp [BitVectorFun.toBitVector, BitVectorFun.fromBitVector]
  try apply BitVectorFun.toListFromList
  sorry

def nextSignificantBit (val : Nat) (b : Bool) := 2 * val + if (b = true) then 1 else 0

def RawBitVectorVal {w : Width} (x : LengthIndexedList Bool w) : Nat :=
  x.foldl nextSignificantBit 0

def BitVector.asRawUInt {w : Width} (x : BitVector w) : Nat :=
  RawBitVectorVal x.bits

def BitVector.asUInt {w : Width} (x : BitVector w) : (Fin $ 2^w) :=
  ⟨x.asRawUInt, sorry⟩

def BitVector.twosCompliment {w : Width} (x : BitVector w) : Int :=
  match w, x.bits with
    | ⟨.succ n, _⟩, .cons s rest  =>
      let sign := if s = true then -1 else 1
      if h : n > 0 then
        let abs : BitVector ⟨n, h⟩ := ⟨rest⟩
        sign * (2^w.val - abs.asRawUInt)
      else
        0

theorem nextSignificantBitTrue {val : Nat} : nextSignificantBit val true = 2 * val + 1 := by
  simp [nextSignificantBit]

theorem nextSignificantBitFalse {val : Nat} : nextSignificantBit val false = 2 * val := by
  simp [nextSignificantBit]

theorem RawBitVectorFalse {w : Width} {x : LengthIndexedList Bool w} :
  (LengthIndexedList.cons false x).foldl nextSignificantBit 0 = x.foldl nextSignificantBit 0 := by simp[LengthIndexedList.foldl, nextSignificantBitFalse]

theorem foldNextSignificantBit {w : Nat} {x : LengthIndexedList Bool w} {v : Nat} :
  x.foldl nextSignificantBit n = 2^w + x.foldl nextSignificantBit 0 := sorry


-- theorem RawBitVectorValGrowth {w : Width} (x : LengthIndexedList Bool (w - 1)) : ∀ b : Bool, RawBitVectorVal (x.cons b) ≤ 2 * RawBitVectorVal x + 1 := by
--   intro b; cases b with
--    | false => simp [RawBitVectorVal]; rw [Nat.two_mul]
--               apply Nat.le_add_left
--    | true => simp [RawBitVectorVal]; unfold LengthIndexedList.foldl <;> cases w


theorem BitVector.valRawLT {w : Width} (x : LengthIndexedList Bool w) : RawBitVectorVal x < 2^w := by
  simp [RawBitVectorVal]
  sorry

def BitVector.unsigned {w : Width} (x : BitVector w) : Fin (2^w) :=
  ⟨x.asRawUInt, BitVector.valRawLT x.bits⟩

instance : Goedel BaseType where
toType := fun
  | .bitvec w => BitVector w

abbrev UserType := SSA.UserType BaseType

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
| and (w : Width) : Op
| or (w : Width) : Op
| xor (w : Width) : Op
| shl (w : Width) : Op
| lshr (w : Width) : Op
| ashr (w : Width) : Op
deriving Repr, DecidableEq

-- Can we get rid of the code repetition here? (not that copilot has any trouble completing this)
@[reducible]
def argUserType : Op → UserType
| Op.and w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.or w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.xor w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.shl w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.lshr w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.ashr w => .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))

def outUserType : Op → UserType
| Op.and w => .base (BaseType.bitvec w)
| Op.or w => .base (BaseType.bitvec w)
| Op.xor w => .base (BaseType.bitvec w)
| Op.shl w => .base (BaseType.bitvec w)
| Op.lshr w => .base (BaseType.bitvec w)
| Op.ashr w => .base (BaseType.bitvec w)

def rgnDom : Op → UserType := sorry
def rgnCod : Op → UserType := sorry

def _root_.Fin.toBitVector (w : Width) (x : Fin w.val) : BitVector w := sorry

theorem Nat.zero_lt_pow {m n : Nat} : (0 < n) → 0 < n^m := by
induction m with
| zero => simp
| succ m ih =>
  intro h
  rw [Nat.pow_succ]
  exact Nat.mul_pos (ih h) h

theorem Width.zero_lt_pow_2 {w : Width} : 0 < 2^w.val := by
have h : 0 < 2 := Nat.zero_lt_succ 1
exact @Nat.zero_lt_pow w.val 2 h

def Width.nat_pow (n : Nat) (w : Width) : Nat :=
n ^ w

theorem Nat.gt_of_lt {a b : Nat} : a < b → b > a := by simp

def _root_.Nat.asBitVector (n : Nat) {w : Width} : BitVector w :=
{ val := n % (2^w), isLt := (Nat.mod_lt n w.zero_lt_pow_2) }

def BitVector.and {w : Width} (x y : BitVector w) : BitVector w := x.asUInt &&& y.asUInt |>.toBitVector
def BitVector.or {w : Width} (x y : BitVector w) : BitVector w := x.asUInt ||| y.asUInt |>.toBitVector
def BitVector.xor {w : Width} (x y : BitVector w) : BitVector w := x.asUInt ^^^ y.asUInt |>.toBitVector
def BitVector.shl {w : Width} (x y : BitVector w) : BitVector w := x.asUInt <<< y.asUInt |>.toBitVector
def BitVector.lshr {w : Width} (x y : BitVector w) : BitVector w := x.asUInt >>> y.asUInt |>.toBitVector
def BitVector.ashr {w : Width} (x y : BitVector w) : BitVector w := x.twosCompliment >>> y.twosCompliment |>.toBitVector


def uncurry {α β γ : Type} (f : α → β → γ) : α × β → γ := fun ⟨a, b⟩ => f a b


-- https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/.E2.9C.94.20reduction.20of.20dependent.20return.20type/near/276044057
-- #check Op.casesOn
def eval : ∀ (o : Op), Goedel.toType (argUserType o) → (Goedel.toType (rgnDom o) →
  Option (Goedel.toType (rgnCod o))) → Option (Goedel.toType (outUserType o)) :=
  fun o =>
    match o with
    | Op.and _ => fun arg _ =>
        some $ uncurry BitVector.and arg
    | Op.or _ => fun arg _ =>
        some $ uncurry BitVector.or arg
    | Op.xor _ => fun arg _ =>
        some $ uncurry BitVector.xor arg
    | Op.shl _ => fun arg _ =>
        some $ uncurry BitVector.shl arg
    | Op.lshr _ => fun arg _ =>
        some $ uncurry BitVector.lshr arg
    | Op.ashr _ => fun arg _ =>
        some $ uncurry BitVector.ashr arg

instance : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval

/-
Optimization: InstCombineShift: 279
  %Op0 = lshr %X, C
  %r = shl %Op0, C
=>
  %r = and %X, (-1 << C)
-/

theorem InstCombineShift239_base : ∀ w : Width, ∀ x C : BitVector w,
  BitVector.lshr (BitVector.shl x C) C = BitVector.and x (BitVector.shl (BitVector.mk ⟨-1, sorry⟩ C)) :=


end InstCombine

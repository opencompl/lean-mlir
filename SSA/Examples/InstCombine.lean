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
  deriving DecidableEq

instance {w : Width} : Inhabited BaseType := ⟨BaseType.bitvec w⟩

structure BitVector (width : Width) where
  (bits : LengthIndexedList Bool width)
  deriving Repr, DecidableEq

def BitVector.width {width : Width} (_ : BitVector width) : Width := width

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

def BitVector.asInt {w : Width} (x : BitVector w) : Int :=
  x.twosCompliment

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
| const (val : BitVector w) : Op
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
| Op.const _ => .unit

def outUserType : Op → UserType
| Op.and w => .base (BaseType.bitvec w)
| Op.or w => .base (BaseType.bitvec w)
| Op.xor w => .base (BaseType.bitvec w)
| Op.shl w => .base (BaseType.bitvec w)
| Op.lshr w => .base (BaseType.bitvec w)
| Op.ashr w => .base (BaseType.bitvec w)
| Op.const c => .base (BaseType.bitvec c.width)

def rgnDom : Op → UserType := fun _ => .unit
def rgnCod : Op → UserType := fun _ => .unit

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

def _root_.Nat.toFinWidth (n : Nat) (w : Width) : Fin (2^w.val) :=
 { val := n % (2^w), isLt := (Nat.mod_lt n w.zero_lt_pow_2) }

def _root_.Fin.toBitVectorFun {w : Width} (x : Fin (2^w.val)) : @BitVectorFun w :=
  fun i => x.val.testBit i.val

def _root_.Fin.toBitVector {w : Width} (x : Fin (2^w.val)) : BitVector w :=
  x.toBitVectorFun.toBitVector

def _root_.Int.toBitVector {w : Width} (x : Int) : BitVector w :=
   Nat.toFinWidth x.natAbs w |>.toBitVector

def BitVector.and {w : Width} (x y : BitVector w) : BitVector w := x.asUInt &&& y.asUInt |>.toBitVector
def BitVector.or {w : Width} (x y : BitVector w) : BitVector w := x.asUInt ||| y.asUInt |>.toBitVector
def BitVector.xor {w : Width} (x y : BitVector w) : BitVector w := x.asUInt ^^^ y.asUInt |>.toBitVector
def BitVector.shl {w : Width} (x y : BitVector w) : BitVector w := x.asUInt <<< y.asUInt |>.toBitVector
def BitVector.lshr {w : Width} (x y : BitVector w) : BitVector w := x.asUInt >>> y.asUInt |>.toBitVector
def BitVector.ashr {w : Width} (x y : BitVector w) : BitVector w := default -- x.twosCompliment >>> y.twosCompliment |>.toBitVector


def uncurry (f : α → β → γ) (pair : α × β) : γ := f pair.fst pair.snd

def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Option (Goedel.toType (rgnCod o)))) :
  Option (Goedel.toType (outUserType o)) := .some <|
    match o with
    | Op.and _ => uncurry BitVector.and arg
    | Op.or _ => uncurry BitVector.or arg
    | Op.xor _ => uncurry BitVector.xor arg
    | Op.shl _ => uncurry BitVector.shl arg
    | Op.lshr _ => uncurry BitVector.lshr arg
    | Op.ashr _ => uncurry BitVector.ashr arg
    | Op.const c => c

instance TUS : SSA.TypedUserSemantics Op BaseType where
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

theorem InstCombineShift279_base : ∀ w : Width, ∀ x C : BitVector w,
  BitVector.lshr (BitVector.shl x C) C = BitVector.and x (BitVector.shl (-1).toBitVector C) :=
  sorry

syntax "lshr" ident : dsl_op
syntax "shl" ident : dsl_op
syntax "and" ident : dsl_op
syntax "const" ident : dsl_op
macro_rules
  | `([dsl_op| lshr $w ]) => `(Op.lshr $w)
  | `([dsl_op| shl $w ]) => `(Op.shl $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| const $w ]) => `(Op.const $w)



#check @SSA.SSA.teval
open SSA in
theorem InstCombineShift279 : ∀ w : Width, ∀ C : BitVector w,
  let minus_one : BitVector w := (-1).toBitVector
  let Γ : EnvU BaseType := ∅ -- for metavariable in typeclass
  --@SSA.teval BaseType instDecidableEqBaseType instGoedelBaseType SSAIndex.REGION Op TUS
  SSA.teval Γ [dsl_region| dsl_rgn %v0  =>
    %v1 := op: const C %v42;
    %v2 := pair: %v0 %v1;
    %v3 := op: lshr w %v2;
    %v4 := pair: %v3 %v1;
    %v5 := op: shl w %v4
    dsl_ret %v5] =
  SSA.teval Γ [dsl_region| dsl_rgn %v0 =>
    %v1 := op: const minus_one %v42;
    %v2 := op: const C %v42;
    %v3 := pair: %v1 %v2;
    %v4 := op: shl w %v3;
    %v5 := pair: %v0 %v4;
    %v6 := op: and w %v5
    dsl_ret %v6] := by
    simp [SSA.teval, EnvU.set, TypedUserSemantics.argUserType, TypedUserSemantics.outUserType, TypedUserSemantics.eval, Op.const, argUserType]

end InstCombine

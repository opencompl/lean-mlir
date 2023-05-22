import SSA.WellTypedFramework
import SSA.Util

namespace InstCombine

inductive BaseType
  | bitvec (w : ℕ+) : BaseType
  deriving DecidableEq

instance {w : ℕ+} : Inhabited BaseType := ⟨BaseType.bitvec w⟩

structure BitVector (width : ℕ+) where
  (bits : LengthIndexedList Bool width)
  deriving Repr, DecidableEq

@[simp]
def BitVector.width {width : ℕ+} (_ : BitVector width) : ℕ+ := width

instance (width : ℕ+) : Inhabited (BitVector width) :=
  ⟨⟨by convert LengthIndexedList.fromList (List.replicate width true); simp⟩⟩

def BitVectorFun {width : ℕ+} := Fin width.val → Bool

def BitVectorFun.fromList {width : ℕ+} (l : LengthIndexedList Bool width.val) : @BitVectorFun width :=
  fun i => l[i]

def BitVectorFun.fromBitVector {width : ℕ+} (bv : BitVector width) : @BitVectorFun width :=
  BitVectorFun.fromList bv.bits

def BitVectorFun.toList {width : ℕ+} (f : @BitVectorFun width) : LengthIndexedList Bool width.val :=
  let indices := LengthIndexedList.finRange width.val
  indices.map f

def BitVectorFun.toBitVector {width : ℕ+} (f : @BitVectorFun width) : BitVector width := ⟨BitVectorFun.toList f⟩

instance {width : ℕ+} : Coe (@BitVectorFun width) (BitVector width) := ⟨BitVectorFun.toBitVector⟩
instance {width : ℕ+} : Coe (BitVector width) (@BitVectorFun width) := ⟨BitVectorFun.fromBitVector⟩

theorem BitVectorFun.toListFromList {width : ℕ+} (l : LengthIndexedList Bool width.val) :
  BitVectorFun.toList (BitVectorFun.fromList l) = l := by
    simp [BitVectorFun.toList, BitVectorFun.fromList]
    sorry

theorem BitVectorFun.toBitVectorFromBitVector {width : ℕ+} (l : BitVector width) :
  BitVectorFun.toBitVector (BitVectorFun.fromBitVector l) = l := by
  simp [BitVectorFun.toBitVector, BitVectorFun.fromBitVector]
  try apply BitVectorFun.toListFromList
  sorry

def nextSignificantBit (val : Nat) (b : Bool) := 2 * val + if (b = true) then 1 else 0

def RawBitVectorVal {w : ℕ+} (x : LengthIndexedList Bool w) : Nat :=
  x.foldl nextSignificantBit 0

def BitVector.asRawUInt {w : ℕ+} (x : BitVector w) : Nat :=
  RawBitVectorVal x.bits

def BitVector.asUInt {w : ℕ+} (x : BitVector w) : (Fin $ 2^w) :=
  ⟨x.asRawUInt, sorry⟩

def BitVector.twosCompliment {w : ℕ+} (x : BitVector w) : Int :=
  match w, x.bits with
    | ⟨.succ n, _⟩, .cons s rest  =>
      let sign := if s = true then -1 else 1
      if h : n > 0 then
        let abs : BitVector ⟨n, h⟩ := ⟨rest⟩
        sign * (2^w.val - abs.asRawUInt)
      else
        0

def BitVector.asInt {w : ℕ+} (x : BitVector w) : Int :=
  x.twosCompliment

theorem nextSignificantBitTrue {val : Nat} : nextSignificantBit val true = 2 * val + 1 := by
  simp [nextSignificantBit]

theorem nextSignificantBitFalse {val : Nat} : nextSignificantBit val false = 2 * val := by
  simp [nextSignificantBit]

theorem RawBitVectorFalse {w : ℕ+} {x : LengthIndexedList Bool w} :
  (LengthIndexedList.cons false x).foldl nextSignificantBit 0 = x.foldl nextSignificantBit 0 := by simp[LengthIndexedList.foldl, nextSignificantBitFalse]

theorem foldNextSignificantBit {w : Nat} {x : LengthIndexedList Bool w} {v : Nat} :
  x.foldl nextSignificantBit n = 2^w + x.foldl nextSignificantBit 0 := sorry


-- theorem RawBitVectorValGrowth {w : ℕ+} (x : LengthIndexedList Bool (w - 1)) : ∀ b : Bool, RawBitVectorVal (x.cons b) ≤ 2 * RawBitVectorVal x + 1 := by
--   intro b; cases b with
--    | false => simp [RawBitVectorVal]; rw [Nat.two_mul]
--               apply Nat.le_add_left
--    | true => simp [RawBitVectorVal]; unfold LengthIndexedList.foldl <;> cases w


theorem BitVector.valRawLT {w : ℕ+} (x : LengthIndexedList Bool w) : RawBitVectorVal x < 2^w := by
  simp [RawBitVectorVal]
  sorry

def BitVector.unsigned {w : ℕ+} (x : BitVector w) : Fin (2^w) :=
  ⟨x.asRawUInt, BitVector.valRawLT x.bits⟩

instance : Goedel BaseType where
toType := fun
  | .bitvec w => BitVector w

abbrev UserType := SSA.UserType BaseType

-- See: https://releases.llvm.org/14.0.0/docs/LangRef.html#bitwise-binary-operations
inductive Op
| and (w : ℕ+) : Op
| or (w : ℕ+) : Op
| xor (w : ℕ+) : Op
| shl (w : ℕ+) : Op
| lshr (w : ℕ+) : Op
| ashr (w : ℕ+) : Op
| const (val : BitVector w) : Op
deriving Repr, DecidableEq

@[simp]
def argUserType : Op → UserType
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w => 
  .pair (.base (BaseType.bitvec w)) (.base (BaseType.bitvec w))
| Op.const _ => .unit

@[simp]
def outUserType : Op → UserType
| Op.and w | Op.or w | Op.xor w | Op.shl w | Op.lshr w | Op.ashr w => 
  .base (BaseType.bitvec w)
| Op.const c => .base (BaseType.bitvec c.width)

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit

theorem Nat.zero_lt_pow {m n : Nat} : (0 < n) → 0 < n^m := by
induction m with
| zero => simp
| succ m ih =>
  intro h
  rw [Nat.pow_succ]
  exact Nat.mul_pos (ih h) h

theorem _root_.PNat.zero_lt_pow_2 {w : ℕ+} : 0 < 2^w.val := by
have h : 0 < 2 := Nat.zero_lt_succ 1
exact @Nat.zero_lt_pow w.val 2 h

def _root_.PNat.nat_pow (n : Nat) (w : ℕ+) : Nat :=
n ^ w

theorem Nat.gt_of_lt {a b : Nat} : a < b → b > a := by simp

def _root_.Nat.toFinPNat (n : Nat) (w : ℕ+) : Fin (2^w.val) :=
 { val := n % (2^w), isLt := (Nat.mod_lt n w.zero_lt_pow_2) }

def _root_.Fin.toBitVectorFun {w : ℕ+} (x : Fin (2^w.val)) : @BitVectorFun w :=
  fun i => x.val.testBit i.val

def _root_.Fin.toBitVector {w : ℕ+} (x : Fin (2^w.val)) : BitVector w :=
  x.toBitVectorFun.toBitVector

def _root_.Int.toBitVector {w : ℕ+} (x : Int) : BitVector w :=
   Nat.toFinPNat x.natAbs w |>.toBitVector

def BitVector.and {w : ℕ+} (x y : BitVector w) : BitVector w := x.asUInt &&& y.asUInt |>.toBitVector
def BitVector.or {w : ℕ+} (x y : BitVector w) : BitVector w := x.asUInt ||| y.asUInt |>.toBitVector
def BitVector.xor {w : ℕ+} (x y : BitVector w) : BitVector w := x.asUInt ^^^ y.asUInt |>.toBitVector
def BitVector.shl {w : ℕ+} (x y : BitVector w) : BitVector w := x.asUInt <<< y.asUInt |>.toBitVector
def BitVector.lshr {w : ℕ+} (x y : BitVector w) : BitVector w := x.asUInt >>> y.asUInt |>.toBitVector
def BitVector.ashr {w : ℕ+} (x y : BitVector w) : BitVector w := default -- x.twosCompliment >>> y.twosCompliment |>.toBitVector


@[simp]
def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) := 
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

syntax "lshr" ident : dsl_op
syntax "shl" ident : dsl_op
syntax "and" ident : dsl_op
syntax "const" ident : dsl_op
macro_rules
  | `([dsl_op| lshr $w ]) => `(Op.lshr $w)
  | `([dsl_op| shl $w ]) => `(Op.shl $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| const $w ]) => `(Op.const $w)



      -- intros a b c;
      -- funext k1;
      -- funext k2;
      -- funext x;
      -- -- is the time due to it re-elaborating the syntax, or due to the proof steps?
      -- simp[Bind.bind];
      -- simp[Option.bind];
      -- simp[eval];

end InstCombine

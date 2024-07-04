-- open BitVec

def BitStream : Type := Nat → Bool

namespace BitStream

def ofNat (x : Nat) : BitStream
  | 0   => x % 2 == 1
  | i+1 => ofNat (x/2) i

instance : OfNat BitStream n := ⟨ofNat n⟩

def head (x : BitStream) : Bool      := x 0
def tail (x : BitStream) : BitStream := (x <| · + 1)


/-! # Conversions to and from `BitVec` -/
section ToBitVec

/-- Zero-extend a finite bitvector `x` to the infinite stream `0^ω ⋅ x`  -/
abbrev ofBitVec {w} (x : BitVec w) : BitStream :=
  x.getLsb

/-- `x.toBitVec w` returns the first `w` bits of bitstream `x` -/
def toBitVec (w : Nat) (x : BitStream) : BitVec w :=
  match w with
  | 0   => 0#0
  | w+1 => (x.toBitVec w).cons (x w)

/-- `EqualUpTo w x y` holds iff `x` and `y` are equal in the first `w` bits -/
def EqualUpTo (w : Nat) (x y : BitStream) : Prop :=
  ∀ i < w, x i = y i
local macro:50 x:term:50 " ={≤" w:term "} " y:term:51 : term =>
  `(EqualUpTo $w $x $y)

/-- `printPrefix x n` returns a string with the first `n` digits of the bitstream `x` -/
def printPrefix (x : BitStream) : Nat → String
  | 0   => "0b"
  | n+1 =>
    let h := if x.head then "1" else "0"
    let t := x.tail.printPrefix n
    t ++ h

section Lemmas

@[simp] theorem toBitVec_ofBitVec (x : BitVec w) (w' : Nat) :
    toBitVec w' (ofBitVec x) = x.truncate w' := by
  induction w'
  case zero      => simp only [BitVec.eq_nil]
  case succ w ih => rw [toBitVec, ih, BitVec.truncate_succ, ofBitVec];

theorem toBitVec_eq_of_equalUpTo {w : Nat} {x y : BitStream} (h : x ={≤w} y) :
    x.toBitVec w = y.toBitVec w := by
  sorry

theorem eq_of_ofBitVec_eq (x y : BitVec w) :
    ofBitVec x ={≤w} ofBitVec y → x = y := by
  intro h
  have := toBitVec_eq_of_equalUpTo h
  simpa

end Lemmas

/-! # Bitwise Operations -/
section BitwiseOps

/-- `map f` maps a (unary) function over a bitstreams -/
abbrev map (f : Bool → Bool) : BitStream → BitStream :=
  fun x i => f (x i)

/-- `map₂ f` maps a binary function over two bitstreams -/
abbrev map₂ (f : Bool → Bool → Bool) : BitStream → BitStream → BitStream :=
  fun x y i => f (x i) (y i)

instance : Complement BitStream := ⟨map Bool.not⟩
instance : AndOp BitStream := ⟨map₂ Bool.and⟩
instance :  OrOp BitStream := ⟨map₂ Bool.or⟩
instance :   Xor BitStream := ⟨map₂ Bool.xor⟩

section Lemmas
variable {w : Nat}

variable (x y : BitStream) (i : Nat)
@[simp] theorem not_eq :    (~~~x) i = !(x i)            := rfl
@[simp] theorem and_eq : (x &&& y) i = (x i && y i)      := rfl
@[simp] theorem  or_eq : (x ||| y) i = (x i || y i)      := rfl
@[simp] theorem xor_eq : (x ^^^ y) i = (xor (x i) (y i)) := rfl

variable (x y : BitVec w)

@[simp] theorem ofBitVec_complement : ofBitVec (~~~x) ={≤w} ~~~(ofBitVec x) := by
  intro i h; simp [h]

@[simp] theorem ofBitVec_and : ofBitVec (x &&& y) ={≤w} (ofBitVec x) &&& (ofBitVec y) := by
  intro i _; simp

@[simp] theorem ofBitVec_or : ofBitVec (x ||| y) ={≤w} (ofBitVec x) ||| (ofBitVec y) := by
  intro i _; simp

@[simp] theorem ofBitVec_xor : ofBitVec (x ^^^ y) ={≤w} (ofBitVec x) ^^^ (ofBitVec y) := by
  intro i _; simp

end Lemmas

end BitwiseOps

/-! # Addition -/
section Arith

/-- `mapAccum₂` ("binary map accumulate") maps a binary function `f` over two streams,
while accumulating some state -/
def mapAccum₂ {α} (f : α → Bool → Bool → α × Bool) (init : α) (x y : BitStream) : BitStream :=
  fun i => (go i).snd
where
  go : Nat → α × Bool
    | 0   => f init (x 0) (y 0)
    | i+1 =>
      let ⟨a, _⟩ := go i
      f a (x <| i + 1) (y <| i + 1)

instance : Add BitStream := ⟨mapAccum₂ BitVec.adcb false⟩

section Lemmas

theorem mapAccum₂_succ (f) (init : α) (x y) (i) :
    (mapAccum₂ f init x y) (i + 1)
    = (f (mapAccum₂.go f init x y i).fst (x (i+1)) (y (i+1))).snd := by
  simp [mapAccum₂, mapAccum₂.go]

-- theorem add_eq (x y : BitStream) (i : Nat) :
--     (x + y) i = _

theorem ofBitVec_add {w} (x y : BitVec w) :
    ofBitVec (x + y) ={≤w} (ofBitVec x) + (ofBitVec y) := by
  have ⟨h₁, h₂⟩ : True ∧ True := sorry
  sorry

end Lemmas

end Arith

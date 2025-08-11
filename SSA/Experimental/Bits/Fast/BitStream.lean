import Mathlib.Tactic.NormNum

import Mathlib.Logic.Function.Iterate
import SSA.Projects.InstCombine.ForLean
-- TODO: upstream the following section
section UpStream

namespace Int

theorem bmod_eq_of_ge_and_le (z : Int) (m : Nat)
    (hlower_bound : m/2 ≤ z) (hupper_bound : z < m/2) :
    z.bmod m = z := by
  omega

theorem bmod_ofNat_eq_of_lt (n m : Nat) (h : n < (m + 1) / 2) :
    (↑n : Int).bmod m = ↑(n % m) := by
  simp only [bmod, ite_eq_left_iff, show (n : Int) % (m : Int) = ((n % m : Nat) : Int) from rfl,
    Nat.mod_eq_of_lt (by omega : n < m)]
  omega

theorem emod_eq_of_neg {a b : Int} (H1 : a < 0) (H2 : 0 ≤ a + b.natAbs) :
    a % b = b.natAbs + a := by
      simp [HMod.hMod, Mod.mod, Int.emod]
      cases a
      all_goals (rename_i o)
      {
        have := Int.zero_le_ofNat o
        contradiction
      }
      simp only [Int.abs_eq_natAbs, subNatNat, HAdd.hAdd, Add.add, Int.add]
      have e : o.succ = (o.mod b.natAbs).add 1 := by
        simp only [Nat.mod, Nat.add]
        congr
        cases o
        all_goals simp
        rename_i g
        have l : ¬ (b.natAbs ≤ g + 1) := by
          have y : g + 2 ≤ ↑b.natAbs := by
            rw [← Int.ofNat_le]
            rw [Int.add_comm, Int.negSucc_eq] at H2
            omega
          omega
        simp [l]
      simp only [e]

end Int
end UpStream

/-!

## Reflection

We have a decision procedure which operates on BitStream operations, but we'd like

-/

def BitStream : Type := Nat → Bool

instance : Inhabited BitStream where
  default := fun _ => false

namespace BitStream

/-! # Preliminaries -/
section Basic

def head (x : BitStream) : Bool      := x 0
def tail (x : BitStream) : BitStream := (x <| · + 1)

/-- Append a single bit to the least significant end of a bitvector.
That is, the new bit is the least significant bit.
-/
def concat (b : Bool) (x : BitStream) : BitStream
  | 0   => b
  | i+1 => x i

@[simp]
theorem concat_zero (b : Bool) (x : BitStream) : concat b x 0 = b := rfl

@[simp]
theorem concat_succ (b : Bool) (x : BitStream) : concat b x (n+1) = x n := rfl

/-- `map f` maps a (unary) function over a bitstreams -/
abbrev map (f : Bool → Bool) : BitStream → BitStream :=
  fun x i => f (x i)

/-- `map₂ f` maps a binary function over two bitstreams -/
abbrev map₂ (f : Bool → Bool → Bool) : BitStream → BitStream → BitStream :=
  fun x y i => f (x i) (y i)

/--
Fold with intermediate steps also available as a bitstream.
(scanl init op s)[0] = op s[0] init
(scanl init op s)[i+1] = op (scanl init op s)[i] s[i+1]
-/
abbrev scanl (init : Bool) (f : Bool → Bool → Bool) (s : BitStream) : BitStream :=
  fun n => match n with
    | 0 => f init (s 0)
    | n+1 => f (scanl init f s n) (s (n + 1))

@[simp]
theorem scanl_zero (init : Bool) (f : Bool → Bool → Bool) (s : BitStream) : scanl init f s 0 = f init (s 0) := rfl

@[simp]
theorem scanl_succ (init : Bool) (f : Bool → Bool → Bool) (s : BitStream) : scanl init f s (n+1) = f (scanl init f s n) (s (n+1)) := rfl

def corec {β} (f : β → β × Bool) (b : β) : BitStream :=
  fun i => f ((Prod.fst ∘ f)^[i] b) |>.snd


/-- `mapAccum₂` ("binary map accumulate") maps a binary function `f` over two streams,
while accumulating some state -/
def mapAccum₂ {α} (f : α → Bool → Bool → α × Bool) (init : α) (x y : BitStream) : BitStream :=
  corec (β := α × BitStream × BitStream) (b := (init, x, y)) fun ⟨state, x, y⟩ =>
    let z := f state x.head y.head
    (⟨z.fst, x.tail, y.tail⟩, z.snd)

section Lemmas

@[ext]
theorem ext {x y : BitStream} (h : ∀ i, x i = y i) : x = y := by
  funext i; exact h i

/--
The field projection `.1` distributes over function composition, so we can compute
the first field of the result of the composition by repeatedly composing the first projection.
-/
theorem compose_first {α: Type u₁} (i : Nat) (a : α)
    (f : α → α × Bool) :
    (f ((Prod.fst ∘ f)^[i] a)).1 = (Prod.fst ∘ f)^[i] (f a).1 :=
  match i with
    | 0 => by simp
    | i + 1 => by simp [compose_first i ((f a).1) f]

/--
Coinduction principle for `corec`.
To show that `corec f a = corec g b`,
we must show that:
- The relation `R a b` is inhabited ["base case"]
- Given that `R a b` holds, then `R (f a) (g b)` holds [coinductive case]
-/
theorem corec_eq_corec {a : α} {b : β} {f g}
    (R : α → β → Prop)
    (thing : R a b)
    (h : ∀ a b, R a b →
          let x := f a
          let y := g b
          R x.fst y.fst ∧ x.snd = y.snd) :
    corec f a = corec g b := by
  ext i
  have lem : R ((Prod.fst ∘ f)^[i] (f a).1) ((Prod.fst ∘ g)^[i] (g b).1) ∧ corec f a i = corec g b i := by
    induction' i with i ih
    <;> simp only [Function.iterate_succ, Function.comp_apply, corec]
    · apply h
      exact thing
    · have m := h ((Prod.fst ∘ f)^[i] (f a).1) ((Prod.fst ∘ g)^[i] (g b).1) (ih.1)
      cases' m with l r
      rw [r, ← compose_first, ← @compose_first β]
      simp [l]
  cases lem
  assumption

end Lemmas

end Basic

/-! # OfNat -/
section OfNat

/-- Zero-extend a natural number to an infinite bitstream -/
def ofNat (x : Nat) : BitStream :=
  Nat.testBit x

@[simp(low)]
theorem ofNat_eq : ofNat x i = Nat.testBit x i := rfl

instance : OfNat BitStream n := ⟨ofNat n⟩

end OfNat

/-! # Conversions to and from `BitVec` -/
section ToBitVec

/-- Sign-extend a finite bitvector `x` to the infinite stream `(x.msb)^ω ⋅ x`  -/
abbrev ofBitVec {w} (x : BitVec w) : BitStream :=
  fun i => if i < w then x.getLsbD i else x.msb

/-- Make a bitstream of a unary natural number. -/
abbrev ofNatUnary (n : Nat) : BitStream :=
  fun i => decide (i ≤ n)

@[simp]
theorem eval_ofNatUnary (n : Nat) (i : Nat) :
    ofNatUnary n i = decide (i ≤ n) := rfl

/-- `x.toBitVec w` returns the first `w` bits of bitstream `x` -/
def toBitVec (w : Nat) (x : BitStream) : BitVec w :=
  match w with
  | 0   => 0#0
  | w+1 => (x.toBitVec w).cons (x w)

@[simp] theorem getLsbD_toBitVec (w : Nat) (x : BitStream) :
    (x.toBitVec w).getLsbD i = ((decide (i < w)) && x i) := by
  induction w generalizing x
  case zero => simp [toBitVec]
  case succ w ih =>
    simp [toBitVec]
    rw [BitVec.getLsbD_cons]
    by_cases hi : i = w
    · simp [hi]
    · simp [hi]
      by_cases hw : i < w + 1
      · simp [hw]
        rw [ih]
        simp; omega
      · simp [hw]
        apply BitVec.getLsbD_of_ge
        omega


@[simp] theorem getElem_toBitVec (w : Nat) (x : BitStream) (i : Nat) (hi : i < w) :
    (x.toBitVec w)[i] = ((decide (i < w)) && x i) := by
  rw [← BitVec.getLsbD_eq_getElem]
  simp

@[simp] theorem getElemFin_toBitVec (w : Nat) (x : BitStream) (i : Fin w) :
    (x.toBitVec w)[i] = ((decide (i < w)) && x i) := by
  simp [← BitVec.getLsbD_eq_getElem]

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
    toBitVec w' (ofBitVec x) = x.signExtend w' := by
  induction w'
  case zero      => simp only [BitVec.eq_nil]
  case succ w ih => rw [toBitVec, ih]; simp [BitVec.signExtend_succ]

theorem toBitVec_eq_of_equalUpTo {w : Nat} {x y : BitStream} (h : x ={≤w} y) :
    x.toBitVec w = y.toBitVec w := by
  simp [EqualUpTo] at h
  induction w
  all_goals simp [toBitVec]
  rename_i r f
  have a := h r (Nat.lt_add_of_pos_right (by decide))
  have b := f (fun y g => h y (by omega))
  rw [a,b]

theorem eq_of_ofBitVec_eq (x y : BitVec w) :
    ofBitVec x ={≤w} ofBitVec y → x = y := by
  intro h
  have := toBitVec_eq_of_equalUpTo h
  simp only [toBitVec_ofBitVec, BitVec.signExtend_eq] at this
  simpa

end Lemmas
end ToBitVec

/-! # Bitwise Operations -/
section BitwiseOps

instance : Complement BitStream := ⟨map Bool.not⟩
instance : AndOp BitStream := ⟨map₂ Bool.and⟩
instance :  OrOp BitStream := ⟨map₂ Bool.or⟩
instance :   XorOp BitStream := ⟨map₂ Bool.xor⟩

/-- Shift left by `k` bits, giving a new bitstream whose first `k` bits are zero. -/
def shiftLeft (x : BitStream) (k : Nat) : BitStream :=
  fun i => if i < k then false else x (i - k) -- i ≥ k

/-- Shift logical right by `k` bits, making the 'i'th output be the 'k+i'th input bit. -/
def logicalShiftRight (x : BitStream) (k : Nat) : BitStream :=
  fun i => x (k + i)

/--
Return a stream of pointwise equality of booleans.
This is the same as ~(a⊕b), and thus we call it `not xor`.
-/
def nxor (a b : BitStream) : BitStream := fun i => a i == b i

section Lemmas
variable {w : Nat}

variable (x y : BitStream) (i : Nat)
@[simp] theorem not_eq :    (~~~x) i = !(x i)            := rfl
@[simp] theorem and_eq : (x &&& y) i = (x i && y i)      := rfl
@[simp] theorem  or_eq : (x ||| y) i = (x i || y i)      := rfl
@[simp] theorem xor_eq : (x ^^^ y) i = (xor (x i) (y i)) := rfl
@[simp] theorem nxor_eq : (x.nxor y) i = (x i == y i) := rfl
variable (x y : BitVec (w+1))


@[simp] theorem eval_shiftLeft {x : BitStream} {k : Nat} :
  (shiftLeft x k) i = if i < k then false else x (i - k) := rfl

@[simp] theorem eval_shiftLeft_of_lt {x : BitStream} {k : Nat} (hi : i < k) :
  (shiftLeft x k) i = false := by simp [hi]

@[simp] theorem eval_shiftLeft_of_le {x : BitStream} {k : Nat} (hi : k ≤ i) :
  (shiftLeft x k) i = x (i - k) := by simp [hi]

@[simp] theorem eval_logicalShiftRight {x : BitStream} {k : Nat} :
  (logicalShiftRight x k) i = x (k + i) := rfl

@[simp] theorem ofBitVec_complement : ofBitVec (~~~x) = ~~~(ofBitVec x) := by
  funext i
  simp only [ofBitVec, BitVec.getLsbD_not, BitVec.msb_not, not_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_and {w : Nat} {x y : BitVec w} : ofBitVec (x &&& y) = (ofBitVec x) &&& (ofBitVec y) := by
  funext i
  simp only [ofBitVec, BitVec.getLsbD_and, BitVec.msb_and, and_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_or {w : Nat} {x y : BitVec w} : ofBitVec (x ||| y) = (ofBitVec x) ||| (ofBitVec y) := by
  funext i
  simp only [ofBitVec, BitVec.getLsbD_or, BitVec.msb_or, or_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_xor {w : Nat} {x y : BitVec w} : ofBitVec (x ^^^ y) = (ofBitVec x) ^^^ (ofBitVec y) := by
  funext i
  simp only [ofBitVec, BitVec.getLsbD_xor, xor_eq]
  split <;> simp_all

@[simp] theorem ofBitVec_not : ofBitVec (~~~ x) = ~~~ (ofBitVec x) := by
  funext i
  simp only [ofBitVec, BitVec.getLsbD_not, BitVec.msb_not, lt_add_iff_pos_left, add_pos_iff,
    zero_lt_one, or_true, decide_true, Bool.true_and, not_eq]
  split <;> simp_all

theorem and_comm (x y : BitStream) : x &&& y = y &&& x := by
  funext i
  simp [Bool.and_comm]

theorem or_comm (x y : BitStream) : x ||| y = y ||| x := by
  funext i
  simp [Bool.or_comm]

end Lemmas

end BitwiseOps

section Scan

/-- Scan the bitwise or operation on bitstreams -/
def scanOr (s : BitStream) : BitStream := scanl false Bool.or s

@[simp]
theorem scanOr_zero (s : BitStream) : scanOr s 0 = s 0 := rfl

@[simp]
theorem scanOr_succ (s : BitStream) : scanOr s (n+1) = ((s.scanOr n) || s (n + 1)) := rfl

/-- ScanOr is an idempotent operation -/
@[simp]
theorem scanOr_idem (s : BitStream) : s.scanOr.scanOr = s.scanOr := by
  ext n
  simp [scanOr]
  induction n
  case zero => simp
  case succ n ih => simp [ih]

/-- The result of `scanOr` is false at inde `i` if the bitstream has been false upto (and including) time `n`. -/
theorem scanOr_false_iff (s : BitStream) (n : Nat) : s.scanOr n = false ↔ ∀ (i : Nat), (hi : i ≤ n) → s i = false := by
  induction n
  · simp
  case succ n ih =>
    simp only [scanOr_succ, Bool.or_eq_false_iff]
    constructor
    · intros h i hi
      have hi' : i = n + 1 ∨ i < n + 1 := by omega
      rcases hi' with rfl | hi'
      · simp [h]
      · apply ih.mp
        · simp [h]
        · omega
    · intros h
      constructor
      · apply ih.mpr
        intros i hi
        exact h _ (by omega)
      · apply h _ (by omega)


/-- The result of `scanOr` is true at index `i` if the bitstream has been true at some index `i ≤ n`. -/
theorem scanOr_true_iff (s : BitStream) (n : Nat)
    : s.scanOr n = true ↔ ∃ (i : Nat), (i ≤ n) ∧ s i = true := by
  constructor
  · intros h
    contrapose h
    simp_all
    apply (scanOr_false_iff _ _).mpr (by assumption)
  · intros h
    contrapose h
    simp_all
    apply (scanOr_false_iff _ _).mp (by assumption)

theorem scanOr_eq_decide (s : BitStream) (n : Nat) :
    s.scanOr n = decide (∃ (i : Nat), i ≤ n ∧ s i = true) := by
  have := scanOr_true_iff s n
  by_cases hs : s.scanOr n <;> simp [hs] at ⊢ this <;> apply this


/--
(scan s)[0] = s[0]
(scan s)[i+1] = (scan s)[i] && s[i+1]
-/
def scanAnd (s : BitStream) : BitStream := scanl true Bool.and s


@[simp] theorem scanAnd_zero (s : BitStream) : scanAnd s 0 = s 0 := rfl

@[simp] theorem scanAnd_succ (s : BitStream) : scanAnd s (n+1) = ((s.scanAnd n) && s (n + 1)) := rfl

/-- ScanAnd is an idempotent operation. -/
@[simp]
theorem scanAnd_idem (s : BitStream) : s.scanAnd.scanAnd = s.scanAnd := by
  ext n
  simp [scanAnd]
  induction n
  case zero => simp
  case succ n ih => simp [ih]

/-- The result of `scanAnd` is true at index `i` if the bitstream has been true upto (and including) time `n`. -/
theorem scanAnd_true_iff (s : BitStream) (n : Nat) :
    s.scanAnd n = true ↔ ∀ (i : Nat), (hi : i ≤ n) → s i = true := by
  induction n
  · simp
  case succ n ih =>
    simp only [scanAnd_succ, Bool.and_eq_true]
    constructor
    · intros h i hi
      have hi' : i = n + 1 ∨ i < n + 1 := by omega
      rcases hi' with rfl | hi'
      · simp [h]
      · apply ih.mp
        · simp [h]
        · omega
    · intros h
      constructor
      · apply ih.mpr
        intros i hi
        exact h _ (by omega)
      · apply h _ (by omega)


/-- The result of `scanAnd` is true at index `i` if the bitstream has been true upto (and including) time `n`. -/
theorem scanAnd_false_iff (s : BitStream) (n : Nat)
    : s.scanAnd n = false ↔ ∃ (i : Nat), (i ≤ n) ∧ s i = false := by
  constructor
  · intros h
    contrapose h
    simp_all
    apply (scanAnd_true_iff _ _).mpr (by assumption)
  · intros h
    contrapose h
    simp_all
    apply (scanAnd_true_iff _ _).mp (by assumption)

theorem scanAnd_eq_decide (s : BitStream) (n : Nat) :
    s.scanAnd n = decide (∀ (i : Nat), i ≤ n → s i = true) := by
  have := scanAnd_true_iff s n
  by_cases hs : s.scanAnd n <;> simp [hs] at ⊢ this <;> apply this


end Scan

/-! # Addition, Subtraction, Negation -/
section Arith

def adcb (x y c : BitStream) (i : Nat) :  Bool × Bool :=
  Prod.swap (BitVec.adcb (x i) (y i) (c i))

def addAux (x y : BitStream) (i : Nat) :  Bool × Bool :=
  let carryIn : Bool := match i with
    | 0 => false
    | i + 1 => (addAux x y i).2
  Prod.swap (BitVec.adcb (x i) (y i) carryIn)

@[simp] theorem addAux_zero (x y : BitStream) : (x.addAux y 0) = ((x 0) ^^ (y 0), (x 0) && (y 0)) := by
  simp [addAux, addAux,BitVec.adcb]

@[simp] theorem addAux_succ (x y : BitStream) : (x.addAux y (i+1)) =
    let addAux := (addAux x y i)
    let a := x (i + 1)
    let b := y (i + 1)
    let carryOut := addAux.2
    (a ^^ b ^^ carryOut, Bool.atLeastTwo a  b carryOut) := by
  simp [addAux, BitVec.adcb, Bool.atLeastTwo]

def add (x y : BitStream) : BitStream :=
  fun n => (addAux x y n).1

def subAux (x y : BitStream) : Nat → Bool × Bool
  | 0 => (xor (x 0) (y 0), !(x 0) && y 0)
  | n+1 =>
    let borrow := (subAux x y n).2
    let a := x (n + 1)
    let b := y (n + 1)
    (xor a (xor b borrow), !a && b || ((!(xor a b)) && borrow))

def sub (x y : BitStream) : BitStream :=
  fun n => (subAux x y n).1


/-- The stream of borrow bits from the subtraction -/
def borrow (x y : BitStream) : BitStream :=
  fun n => (subAux x y n).2


@[simp] theorem borrow_zero (x y : BitStream) : (x.borrow y 0) = (!(x 0) && y 0) := rfl

@[simp] theorem borrow_succ (x y : BitStream) : (x.borrow y (i+1)) =
  let borrow := borrow x y i
  let a := x (i + 1)
  let b := y (i + 1)
  !a && b || ((!(xor a b)) && borrow) := rfl

def negAux (x : BitStream) : Nat → Bool × Bool
  | 0 => (x 0, !(x 0))
  | n+1 =>
    let borrow := (negAux x n).2
    let a := x (n + 1)
    (xor (!a) borrow, !a && borrow)

@[simp] theorem negAux_zero (x : BitStream) : x.negAux 0 = (x 0, ! (x 0)) := rfl

@[simp] theorem negAux_succ (x : BitStream) (n : Nat) : x.negAux (n + 1) =
    let borrow := (negAux x n).2
    let a := x (n + 1)
    (xor (!a) borrow, !a && borrow) := rfl


def neg (x : BitStream) : BitStream :=
  fun n => (negAux x n).1


def incrAux (x : BitStream) : Nat → Bool × Bool
  | 0 => (!(x 0), x 0)
  | n+1 =>
    let carry := (incrAux x n).2
    let a := x (n + 1)
    (xor a carry, a && carry)

def incr (x : BitStream) : BitStream :=
  fun n => (incrAux x n).1

def decrAux (x : BitStream) : Nat → Bool × Bool
  | 0 => (!(x 0), !(x 0))
  | (n+1) =>
    let borrow := (decrAux x n).2
    let a := x (n + 1)
    (xor a borrow, !a && borrow)

def decr (x : BitStream) : BitStream :=
  fun n => (decrAux x n).1

instance : Add BitStream := ⟨add⟩
instance : Neg BitStream := ⟨neg⟩
instance : Sub BitStream := ⟨sub⟩

theorem add_eq (a b : BitStream) : a.add b = a + b := rfl
theorem sub_eq (a b : BitStream) : a.sub b = a - b := rfl
theorem neg_eq (a : BitStream) : a.neg  = - a := rfl

theorem add_eq_addAux (x y : BitStream) : (x + y) i = (addAux x y i).1 := rfl
theorem sub_eq_subAux (x y : BitStream) : (x - y) i = (subAux x y i).1 := rfl
theorem neg_eq_negAux (x : BitStream) : (- x) i = (negAux x i).1 := rfl

abbrev zero   : BitStream := fun _ => false
abbrev one    : BitStream := (· == 0)
abbrev negOne : BitStream := fun _ => true

@[simp] theorem one_ext_zero : one 0 = true := rfl
@[simp] theorem one_ext_succ : one (i + 1) = false := rfl

theorem negAux_eq_addAux (x : BitStream) (i : Nat) :
    (negAux x i).1 =  (addAux (~~~ x) one i).1 ∧
    (negAux x i).2 =  (addAux (~~~ x) one i).2 := by
  induction i
  case zero => simp
  case succ ih => simp [ih]

theorem neg_eq_not_add_one (x : BitStream) : - x = (~~~ x) + one := by
  ext i
  rw [neg_eq_negAux, add_eq_addAux]
  obtain ⟨h₁, h₂⟩ := negAux_eq_addAux x i
  exact h₁

/-- `repeatBit xs` will repeat the first bit of `xs` which is `true`.
That is, it will be all-zeros iff `xs` is all-zeroes,
otherwise, there's some number `k` so that after dropping the `k` least
significant bits, `repeatBit xs` is all-ones. -/
def repeatBit (xs : BitStream) : BitStream :=
  corec (b := (false, xs)) fun (carry, xs) =>
    let carry := carry || xs 0
    let xs := xs.tail
    ((carry, xs), carry)

/-!
TODO: We should define addition and `carry` in terms of `mapAccum`.
For example:
`def add := mapAccum₂ BitVec.adcb false`
and
```
def carry : BitStream → BitStream → BitStream :=
  mapAccum₂ (fun c x₀ y₀ =>
    let c' := Bool.atLeastTwo c x₀ y₀
    (c', c')
  ) false
```
-/

section Lemmas

-- theorem add_eq (x y : BitStream) (i : Nat) :
--     (x + y) i = _

/-!
Following the same pattern as for `ofBitVec_and`, `_or`, etc., we would expect an equality like:
  `ofBitVec (x + y) = (ofBitVec x) + (ofBitVec y)`
However, this is not actually true, since the left hand side does addition on the bitvector level,
thus forgets the extra carry bit, while rhe rhs does addition on streams,
thus could have a bit set in the `w+1`th position.

Crucially, our decision procedure works by considering which equalities hold for *all* widths,

-/
variable {w : Nat} {x y : BitVec w} {a b a' b' : BitStream}

local infix:20 " ≈ʷ " => EqualUpTo w

theorem neg_neg : a = - - a := by
  ext i
  have neg_lemma :
    a.neg.negAux i = ⟨a i, (a.negAux i).2⟩ := by
    induction' i with i ih
    · simp [neg, negAux]
    · simp [neg, negAux, ih, Bool.xor_not_xor, Bool.not_xor_and_self, -Bool.not_bne',-Bool.not_bne]
  simp [Neg.neg, neg, neg_lemma]

/--
 Will subAux overflow/carry when computing a - b?
-/
def subCarries? (a b : BitStream) (i : Nat) : Bool :=
  let carry : Bool := match i with
  | 0 => false
  | i + 1 => a.subCarries? b i
  (!a i && b i || !xor (a i) (b i) && carry)

/--
  For any i : ℕ, either the ith bit of -b will not overflow,
  or the ith bit of (a + -b) will not overflow.
-/
theorem neg_or_add (i : Nat) :
    (b.negAux i).2 = false ∨ (a.addAux b.neg i).2 = false := by
  induction' i with i ih
  <;> simp only [negAux, addAux, BitVec.adcb, neg]
  · cases b 0
    <;> simp
  · cases' ih with l l
    <;> cases b (i + 1)
    <;> cases a (i + 1)
    <;> simp [l]

/--
  Whether a - b will overflow is equivalent to -b overflows = (a + - b) overflows.
-/
theorem subCarries?_correct (i : Nat) :
    a.subCarries? b i = ((b.negAux i).2 == (a.addAux b.neg i).2) := by
  induction' i with i ih
  · simp [subCarries?, negAux, addAux, BitVec.adcb, neg]
  · by_cases a1 : a (i + 1)
    <;> by_cases b1 : b (i + 1)
    <;> cases' @neg_or_add a b i with h h
    <;> simp [h, subCarries?, ih, negAux, addAux, BitVec.adcb, neg, a1, b1]

theorem subAux_inductive_lemma (i : Nat) :
    a.subAux b i = ⟨(a.addAux b.neg i).1, subCarries? a b i⟩ := by
  induction' i with i ih
  · simp [subAux, addAux, negAux, BitVec.adcb, subCarries?, neg]
  · simp [subAux, addAux, negAux, BitVec.adcb, ih, Bool.xor_ne_self, subCarries?, neg, Bool.xor_inv_left, subCarries?_correct i, -Bool.not_bne]

theorem sub_eq_add_neg : a - b = a + (-b) := by
  ext i
  simp [HAdd.hAdd, HSub.hSub, Neg.neg, Sub.sub, BitStream.sub, Add.add, BitStream.add, subAux_inductive_lemma i]

@[simp]
theorem ofBitVec_getLsbD (n : Nat) (h : n < w) : ofBitVec x n = x.getLsbD n := by
  simp [ofBitVec, h]

theorem ofBitVec_add : ofBitVec (x + y) ≈ʷ (ofBitVec x) + (ofBitVec y) := by
  intros n a
  have add_lemma : ⟨(x + y).getLsbD n, BitVec.carry (n + 1) x y false ⟩ = (ofBitVec x).addAux (ofBitVec y) n := by
    induction' n with n ih
    · simp [addAux, BitVec.adcb, a, BitVec.getLsbD, BitVec.carry, ← Bool.decide_and,
        Bool.xor_decide, Nat.two_le_add_iff_odd_and_odd, Nat.add_odd_iff_neq]
    · simp [addAux, ← ih (by omega), BitVec.adcb, a, BitVec.carry_succ, BitVec.getElem_add];
  simp [HAdd.hAdd, Add.add, BitStream.add, ← add_lemma, a, -BitVec.add_eq, -Nat.add_eq]

@[refl]
theorem equal_up_to_refl : a ≈ʷ a := by
  intros _ _
  rfl

@[symm]
theorem equal_up_to_symm (e : a ≈ʷ b) : b ≈ʷ a := by
  intros j h
  symm
  exact e j h

@[trans]
theorem equal_up_to_trans (e1 : a ≈ʷ b) (e2 : b ≈ʷ c) : a ≈ʷ c := by
  intros j h
  trans b j
  exact e1 j h
  exact e2 j h

instance congr_trans : Trans (EqualUpTo w) (EqualUpTo w) (EqualUpTo w) where
  trans := equal_up_to_trans

instance congr_equiv : Equivalence (EqualUpTo w) where
  refl := fun _ => equal_up_to_refl
  symm := equal_up_to_symm
  trans := equal_up_to_trans

theorem add_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a + c) ≈ʷ (b + d) := by
  intros n h
  have add_congr_lemma : a.addAux c n = b.addAux d n := by
    induction' n with _ ih
    · simp only [addAux, e1 _ h, e2 _ h]
    · simp only [addAux, e1 _ h, e2 _ h, ih (by omega)]
  simp [HAdd.hAdd, Add.add, BitStream.add, add_congr_lemma]

theorem and_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a &&& c) ≈ʷ (b &&& d) := by
  intros n h
  simp [e1 n h, e2 n h]

theorem or_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a ||| c) ≈ʷ (b ||| d) := by
  intros n h
  simp [e1 n h, e2 n h]

theorem xor_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a ^^^ c) ≈ʷ (b ^^^ d) := by
  intros n h
  simp [e1 n h, e2 n h]

theorem not_congr (e1 : a ≈ʷ b) : (~~~a) ≈ʷ ~~~b := by
  intros g h
  simp only [not_eq, e1 g h]

theorem ofBitVec_not_eqTo : ofBitVec (~~~ x) ≈ʷ ~~~ ofBitVec x := by
  intros _ a
  simp [ofBitVec, a]

theorem negAux_eq_not_addAux : a.negAux = (~~~a).addAux 1 := by
  funext i
  induction' i with _ ih
  · simp [negAux, addAux, BitVec.adcb, OfNat.ofNat, ofNat]
  · simp [negAux, addAux, BitVec.adcb, OfNat.ofNat, ofNat, ih,
      Nat.testBit_add_one]

theorem neg_eq_not_add : - a = ~~~ a + 1 := by
  ext _
  simp [negAux_eq_not_addAux, Neg.neg, neg, HAdd.hAdd, Add.add, add]

@[simp(high)]
theorem ofNat_one (i : Nat) : ofNat 1 i = decide (0 = i) := by
  cases i
  <;> simp [ofNat, Nat.testBit_add_one]

theorem ofBitVec_one_eqTo_ofNat : @ofBitVec w 1 ≈ʷ ofNat 1 := by
  by_cases h : w = 0
  · simp [EqualUpTo ,h]
  · intros n a
    simp [ofBitVec, a]
    omega

theorem ofBitVec_neg : ofBitVec (- x) ≈ʷ - (ofBitVec x) := by
  calc
  _ ≈ʷ ofBitVec (~~~ x + 1)            := by rw [BitVec.neg_eq_not_add]; rfl
  _ ≈ʷ ofBitVec (~~~ x) + (ofBitVec 1) := ofBitVec_add
  _ ≈ʷ ~~~ ofBitVec x   + 1            := add_congr ofBitVec_not_eqTo ofBitVec_one_eqTo_ofNat
  _ ≈ʷ - (ofBitVec x)                  := by rw [neg_eq_not_add]

theorem ofBitVec_sub : ofBitVec (x - y) ≈ʷ (ofBitVec x) - (ofBitVec y)  := by
  calc
  _ ≈ʷ ofBitVec (x + -y) := by rw [BitVec.sub_eq_add_neg]
  _ ≈ʷ ofBitVec x + ofBitVec (-y) := ofBitVec_add
  _ ≈ʷ ofBitVec x + -(ofBitVec y) := add_congr equal_up_to_refl ofBitVec_neg
  _ ≈ʷ ofBitVec x - ofBitVec y := by rw [sub_eq_add_neg]

theorem incr_add : a + (@ofBitVec w 1) ≈ʷ a.incr := by
  have incr_add_aux {i : Nat} (le : i < w) : a.addAux (@ofBitVec w 1) i = a.incrAux i := by
    induction' i with _ ih
    · simp [incrAux, addAux, BitVec.adcb, ofBitVec, le]
    · simp only [addAux, incrAux, ih (by omega)]
      simp [BitVec.adcb, Bool.atLeastTwo, ofBitVec, le]
  intros i le
  simp only [incr, HAdd.hAdd, Add.add, add, incr_add_aux le]

theorem ofBitVec_incr {n : Nat} : ofBitVec (BitVec.ofNat w n.succ) ≈ʷ (ofBitVec (BitVec.ofNat w n)).incr := by
  calc
  _ ≈ʷ ofBitVec (BitVec.ofNat w n + BitVec.ofNat w 1) := by intros _ il ; simp [ofBitVec, il, -BitVec.ofNat_eq_ofNat, Nat.testBit, BitVec.getLsbD]
  _ ≈ʷ ofBitVec (BitVec.ofNat w n) + ofBitVec 1 := ofBitVec_add
  _ ≈ʷ (ofBitVec (BitVec.ofNat w n)).incr := incr_add

theorem incr_congr (h : a ≈ʷ b) : a.incr ≈ʷ b.incr := by
  intros i le
  have incr_congr_lemma : a.incrAux i = b.incrAux i := by
    induction' i with n ih
    <;> simp only [incrAux, h _ le]
    simp [ih (by omega)]
  simp [incr, incr_congr_lemma]

theorem sub_congr (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a - c) ≈ʷ (b - d) := by
  intros n h
  have sub_congr_lemma : a.subAux c n = b.subAux d n := by
    induction' n with _ ih
    <;> simp only [subAux, Prod.mk.injEq, e1 _ h, e2 _ h]
    simp only [ih (by omega), and_self]
  simp only [HSub.hSub, Sub.sub, BitStream.sub, sub_congr_lemma]

theorem neg_congr (e1 : a ≈ʷ b) : (-a) ≈ʷ -b := by
  intros n h
  have neg_congr_lemma : a.negAux n = b.negAux n := by
    induction' n with _ ih
    <;> simp only [negAux, Prod.mk.injEq, (e1 _ h)]
    simp only [ih (by omega), and_self]
  simp only [Neg.neg, BitStream.neg, neg_congr_lemma]

theorem ofBitVec_add_congr (h1 : ofBitVec x ≈ʷ a) (h2 : ofBitVec y ≈ʷ b) : ofBitVec (x + y) ≈ʷ a + b := by
  calc
    _ ≈ʷ ofBitVec x + ofBitVec y := ofBitVec_add
    _ ≈ʷ a + b := add_congr h1 h2

theorem ofBitVec_sub_congr (h1 : ofBitVec x ≈ʷ a) (h2 : ofBitVec y ≈ʷ b) : ofBitVec (x - y) ≈ʷ a - b := by
  calc
    _ ≈ʷ ofBitVec x - ofBitVec y := ofBitVec_sub
    _ ≈ʷ a - b := sub_congr h1 h2

theorem ofBitVec_neg_congr (h1 : ofBitVec x ≈ʷ a)  : ofBitVec (- x) ≈ʷ - a  := by
  calc
    _ ≈ʷ - ofBitVec x := ofBitVec_neg
    _ ≈ʷ - a := neg_congr h1

theorem ofBitVec_xor_congr (h1 : ofBitVec x ≈ʷ a) (h2 : ofBitVec y ≈ʷ b) : ofBitVec (x ^^^ y) ≈ʷ a ^^^ b := by
  rw [ofBitVec_xor]
  exact xor_congr h1 h2

theorem ofBitVec_and_congr (h1 : ofBitVec x ≈ʷ a) (h2 : ofBitVec y ≈ʷ b) : ofBitVec (x &&& y) ≈ʷ a &&& b := by
  rw [ofBitVec_and]
  exact and_congr h1 h2

theorem ofBitVec_or_congr (h1 : ofBitVec x ≈ʷ a) (h2 : ofBitVec y ≈ʷ b) : ofBitVec (x ||| y) ≈ʷ a ||| b := by
  rw [ofBitVec_or]
  exact or_congr h1 h2

theorem ofBitVec_not_congr (h1 : ofBitVec x ≈ʷ a) : ofBitVec (~~~ x) ≈ʷ ~~~ a := by
  cases w
  · intros _ le
    simp at le
  · rw [ofBitVec_not]
    exact not_congr h1

theorem equal_congr_congr  (e1 : a ≈ʷ b) (e2 : c ≈ʷ d) : (a ≈ʷ c) = (b ≈ʷ d) := by
  apply propext
  constructor
  <;> intros h
  · apply equal_up_to_trans _ e2
    apply equal_up_to_trans _ h
    apply equal_up_to_symm
    assumption
  · apply equal_up_to_trans _
    apply (equal_up_to_symm e2)
    apply equal_up_to_trans _ h
    assumption

end Lemmas

end Arith

/-! # OfInt
Using `OfInt` we can convert an `Int` into the infinite bitstream that represents that
particular constant -/
section OfInt

open Int in
/-- Sign-extend an integer to its representation as a 2-adic number
(morally, an infinite width 2s complement representation) -/
def ofInt : Int → BitStream
  | .ofNat n  => ofNat n
  | -[n+1]    => -(ofNat (n+1))

/-- 'falseIffEq n i' = false ↔ i = n -/
abbrev falseIffEq (n : Nat) : BitStream := fun i => decide (i != n)
theorem falseIffEq_eq_false_iff (n i : Nat) :
    falseIffEq n i = false ↔ i = n := by simp

abbrev falseIffNeq (n : Nat) : BitStream := fun i => decide (i == n)
theorem falseIffNeq_eq_false_iff (n i : Nat) :
    falseIffNeq n i = false ↔ i ≠ n := by simp

abbrev falseIffLe (n : Nat) : BitStream := fun i => decide (i > n)
theorem falseIffLe_eq_false_iff (n i : Nat) :
    falseIffLe n i = false ↔ i ≤ n := by simp

abbrev falseIffLt (n : Nat) : BitStream := fun i => decide (i ≥ n)
theorem falseIffLt_eq_false_iff (n i : Nat) :
    falseIffLt n i = false ↔ i < n := by simp

abbrev falseIffGe (n : Nat) : BitStream := fun i => decide (i < n)
theorem falseIffGe_eq_false_iff (n i : Nat) :
    falseIffGe n i = false ↔ i ≥ n := by simp

abbrev falseIffGt (n : Nat) : BitStream := fun i => decide (i ≤ n)
theorem falseIffGt_eq_false_iff (n i : Nat) :
    falseIffGt n i = false ↔ i > n := by simp

section Lemmas

variable (i : Nat)

@[simp] theorem zero_eq : zero i = false    := rfl
@[simp] theorem one_eq  : one i = (i == 0)  := rfl
@[simp] theorem negOne_eq : negOne i = true := rfl

/-- The stream from `- (ofNat 1)` has all output bits `1` and all cary bits `0`. -/
@[simp] theorem negAux_ofNat_one_eq : negAux (BitStream.ofNat 1) i = (true, false) := by
  induction i
  case zero => simp [negAux]
  case succ i ih =>
    simp [negAux, ih]

/-- The stream from `- (ofNat 1)` has all output bits `1`, and is thus equal to `negOne`. -/
@[simp] theorem neg_ofNat_one_eq : - (BitStream.ofNat 1) = negOne := by
  rw [← neg_eq]
  unfold BitStream.neg
  simp

end Lemmas

end OfInt

/--
Denote a bitstream into the underlying bitvector, by using toBitVec
def denote (s : BitStream) (w : Nat) : BitVec w := s.toBitVec w
-/

@[simp] theorem toBitVec_zero : BitStream.toBitVec w BitStream.zero = 0#w := by
  induction w
  case zero => simp [toBitVec]
  case succ n ih =>
    simp [toBitVec, toBitVec, zero]
    have : 0#(n + 1) = BitVec.cons false 0#n := by simp
    rw [this, ih]

@[simp] theorem toBitVec_negOne : BitStream.toBitVec w BitStream.negOne = BitVec.allOnes w := by
  induction w
  case zero => simp [toBitVec]
  case succ n ih =>
    simp [toBitVec, toBitVec]
    rw [ih]
    apply BitVec.eq_of_getLsbD_eq
    simp only [BitVec.getLsbD_cons, BitVec.getLsbD_allOnes, Bool.if_true_left]
    intros i hi
    simp only [hi, decide_true, Bool.or_eq_true, decide_eq_true_eq]
    omega

@[simp] theorem toBitVec_one : BitStream.toBitVec w BitStream.one = 1#w := by
  induction w
  case zero => simp [toBitVec]
  case succ n ih =>
    simp [toBitVec, toBitVec, one]
    rw [ih]
    apply BitVec.eq_of_getLsbD_eq
    intros i hi
    simp [BitVec.getLsbD_cons]
    by_cases hi' : i = n
    · simp [hi']
      by_cases hn : n = 0 <;> simp [hn]
    · simp [hi']
      omega

@[simp]
theorem toBitVec_ofNat : BitStream.toBitVec w (BitStream.ofNat n) = BitVec.ofNat w n := by
  simp [ofNat]
  apply BitVec.eq_of_getLsbD_eq
  intros i
  simp [BitVec.getLsbD_ofNat]

@[simp]
theorem toBitVec_and (a b : BitStream) :
    (a &&& b).toBitVec w = a.toBitVec w &&& b.toBitVec w := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]

@[simp]
theorem toBitVec_or (a b : BitStream) :
    (a ||| b).toBitVec w = a.toBitVec w ||| b.toBitVec w := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]

@[simp]
theorem toBitVec_xor (a b : BitStream) :
    (a ^^^ b).toBitVec w = a.toBitVec w ^^^ b.toBitVec w := by
  apply BitVec.eq_of_getLsbD_eq
  intros i
  intros hi
  simp [hi]

@[simp]
theorem toBitVec_not (a : BitStream) :
    (~~~ a).toBitVec w = ~~~ (a.toBitVec w) := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]

theorem BitVec.add_getElem_zero {x y : BitVec w} (hw : 0 < w) : (x + y)[0] =
    ((x[0] ^^ y[0])) := by
  simp [BitVec.getElem_add hw]

theorem BitVec.add_getElem_succ (x y : BitVec w) (hw : i + 1 < w) : (x + y)[i + 1] =
    (x[i + 1] ^^ (y[i + 1]) ^^ BitVec.carry (i + 1) x y false) := by
  simp [BitVec.getElem_add hw]

/-- TODO: simplify this proof, something too complex is going on here. -/
@[simp] theorem toBitVec_add' (a b : BitStream) (w i : Nat) (hi : i < w) :
    ((a + b).toBitVec w).getLsbD i = ((a.toBitVec w) + (b.toBitVec w)).getLsbD i ∧
    (a.addAux b i).2 = (BitVec.carry (i + 1) (a.toBitVec w) (b.toBitVec w) false) := by
  simp [hi]
  rw [add_eq_addAux]
  induction i
  case zero =>
    simp
    rw [BitVec.add_getElem_zero hi]
    simp [hi]
    simp [BitVec.carry_succ, hi]
  case succ i ih =>
    simp
    rw [BitVec.add_getElem_succ _ _ hi]
    have : i < w := by omega
    specialize ih this
    obtain ⟨ih₁, ih₂⟩ := ih
    rw [ih₂]
    simp [hi]
    rw [BitVec.carry_succ (i + 1)]
    simp [hi]

@[simp] theorem toBitVec_add (a b : BitStream) :
    (a + b).toBitVec w = (a.toBitVec w) + (b.toBitVec w) := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  obtain ⟨h₁, h₂⟩ := toBitVec_add' a b w i hi
  exact h₁

@[simp]
theorem toBitVec_neg (a : BitStream) :
    (- a).toBitVec w = - (a.toBitVec w) := by
  simp [neg_eq_not_add_one, toBitVec_add, BitVec.neg_eq_not_add]

@[simp]
theorem toBitVec_sub (a b : BitStream) :
    (a - b).toBitVec w = (a.toBitVec w) - (b.toBitVec w) := by
  simp [BitVec.sub_eq_add_neg, sub_eq_add_neg]

@[simp] theorem subAux_eq_BitVec_carry (a b : BitStream) (w i : Nat) (hi : i < w) :
    (a.subAux b i).2 = !(BitVec.carry (i + 1) (a.toBitVec w) ((~~~b).toBitVec w) true) := by
  induction i
  case zero =>
    simp
    simp [BitVec.carry_succ, subAux, hi, Bool.atLeastTwo]
    rcases a 0 <;> rcases b 0 <;> rfl
  case succ i ih =>
    have : i < w := by omega
    specialize ih this
    rw [BitVec.carry_succ (i + 1)]
    simp [hi]
    rw [subAux, ih]
    simp
    rcases a (i + 1) <;> rcases b (i + 1) <;> simp

@[simp]
theorem toBitVec_shiftL (a : BitStream) (k : Nat) :
    (a.shiftLeft k).toBitVec w = (a.toBitVec w).shiftLeft k := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  simp [hi]
  by_cases hk : i < k
  · simp [hk]
  · simp [hk]; omega

@[simp]
theorem toBitVec_concat_zero (a : BitStream) :
    (a.concat b).toBitVec 0 = 0#0 := by simp [toBitVec]

@[simp]
theorem toBitVec_concat_succ (a : BitStream) :
    (a.concat b).toBitVec (w + 1) = (a.toBitVec w).concat b := by
  apply BitVec.eq_of_getLsbD_eq
  simp
  intros i hi
  simp [hi]
  rcases i with rfl | i
  · simp
  · simp; omega

@[simp]
theorem toBitVec_concat(a : BitStream) :
    (a.concat b).toBitVec w =
      match w with
      | 0 => 0#0
      | w + 1 => (a.toBitVec w).concat b  := by
  rcases w with rfl | w <;> simp

section InverseLimit

def Bitstream.ofBitvecSequence (bs : (w : ℕ) → BitVec w) : BitStream :=
    fun i => (bs (i + 1)).getLsbD i

/--
A bitvec sequence 'bs' is good, if it produces a sequence of bitvectors b₁, b₂, ..,
where the truncations agree with each other.
-/
def Bitstream.goodBitvecSequence (bs : (w : ℕ) → BitVec w) : Prop :=
  ∀ wsmall wlarge, wsmall ≤ wlarge →
    (bs wlarge).setWidth wsmall = bs wsmall
end InverseLimit

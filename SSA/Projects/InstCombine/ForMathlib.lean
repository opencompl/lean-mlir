import Mathlib.Data.Vector
import Mathlib.Data.Bitvec.Basic -- we should add a `Bitvec.lean` in Mathlib/Data/
import SSA.Experimental.Bits.Defs

namespace Vector

instance {α : Type u} {n : Nat} [NeZero n] : GetElem (Vector α n) (Fin n) α (fun _ _ => True) where
  getElem := fun v i _ => v.1[i.val]

end Vector
namespace Bitvec

def width : Bitvec n → Nat := fun _ => n

-- Shouldn't this be inferred from the instance above? (as Bitvec is @[reducible])
instance {n : Nat} [NeZero n] : GetElem (Bitvec n) (Fin n) Bool (fun _ _ => True) where
  getElem := fun v i _ => v.1[i.val]

instance (n : Nat) : Inhabited (Bitvec n) :=
  ⟨List.replicate n true, by apply List.length_replicate⟩

def Fun (width : Nat) := Fin width → Bool

def ofInt' (n : Nat) (z : Int) : Bitvec n :=
  match n with
    | 0 => ⟨List.nil, rfl⟩
    | m + 1 => Bitvec.ofInt m z

/-- convert `Bitvec n` to `Fin n → Bool` -/
def ofFun {width : Nat} : Fun width → Bitvec width :=
  match width with
    | 0 => fun _ => ⟨List.nil, rfl⟩
    | n + 1 => fun f => f (n + 1) ::ᵥ @ofFun n (fun i => f i)

/-- convert `Fin n → Bool` to `Bitvec n` -/
def toFun {width : Nat} : Bitvec width → Fun width :=
    match width with
        | 0 => fun _ => Fin.elim0
        | n + 1 => fun bv i => 
          have instNeZero : NeZero (n + 1) := inferInstance
          have instGetElem : GetElem (Bitvec (n + 1)) (Fin (n + 1)) Bool (fun _ _ => True) := inferInstance
          bv[i]

theorem ofFun_toFun {width : Nat} {f : Fun width} : toFun (ofFun f) = f := by
  funext i
  cases width
  case zero => exact Fin.elim0 i
  case succ n => 
    simp [toFun, ofFun]
    sorry

theorem toFun_ofFun {width : Nat} {bv : Bitvec width} : ofFun (toFun bv) = bv := by
  cases width
  case zero => simp
  case succ n => 
    simp [toFun, ofFun]
    sorry


instance {width : Nat} : Coe (Fun width) (Bitvec width) := ⟨@ofFun width⟩
instance {width : Nat} : Coe (Bitvec width) (Fun width) := ⟨@toFun width⟩

def ofVector : Vector Bool n → Bitvec n := id

-- inspired by: https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Defining.20my.20own.20numerals
-- not ideal solution, as hard to type, but should be ok for now
prefix:max "𝟶"   => fun v => ofVector (Vector.cons false v)
prefix:max "𝟷"   => fun v => ofVector (Vector.cons true v)
notation:max "𝟶"   => ofVector (Vector.cons false (@Vector.nil Bool))
notation:max "𝟷"   => ofVector (Vector.cons true (@Vector.nil Bool))

instance : Add (Bitvec n) where add := Bitvec.add
instance : Sub (Bitvec n) where sub := Bitvec.sub

-- examples:
-- #eval (𝟷𝟶𝟷𝟷).toNat
-- #eval (𝟶𝟷𝟷𝟷).toNat
-- #eval (𝟶𝟷𝟷𝟷) + (𝟷𝟶𝟷𝟷) |>.toNat
-- #eval 𝟷𝟶𝟷𝟷 + 𝟶𝟷𝟷𝟷
-- #eval Bitvec.adc (𝟷𝟶𝟷𝟷) (𝟶𝟷𝟷𝟷) true
-- #eval Bitvec.adc (𝟷𝟶𝟷𝟷) (𝟶𝟷𝟷𝟷) false
-- #eval Bitvec.adc (𝟷𝟶𝟷𝟷) (𝟶𝟷𝟷𝟷) true |>.toNat
-- #eval Bitvec.adc (𝟷𝟶𝟷𝟷) (𝟶𝟷𝟷𝟷) false |>.toNat
-- 
-- #eval Bitvec.adc (𝟶) (𝟶) true
-- #eval Bitvec.adc (𝟶) (𝟶) false

theorem adc_add_nat {n : Nat} {x y : Bitvec n} : (Bitvec.adc x y false).toNat = x.toNat + y.toNat := sorry

theorem add_add_nat_mod_2_pow_n {n : Nat} {x y : Bitvec n} : (x + y).toNat = (x.toNat + y.toNat) % 2^n := sorry

-- see https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Pattern.20matching.20subtypes
def add? {n : Nat} (x y : Bitvec n) : Option (Bitvec n) := match Bitvec.adc x y false with
  | ⟨false :: z,hcons⟩ => some ⟨z, by aesop⟩
  | _ => none -- overflow


theorem some_add?_eq_add {n : Nat} {x y z : Bitvec n} : add? x y = some z → x + y = z := sorry

/-
#eval  (𝟷𝟶𝟷𝟷).toNat * (𝟷𝟶𝟷𝟷).toNat
#eval  Bitvec.mul (𝟷𝟶𝟷𝟷) (𝟷𝟶𝟷𝟷) |>.toNat
-/
protected def mul? {n : Nat} (x y : Bitvec n) : Option (Bitvec n) := do
  let f r b := do 
    let op₁ ← Bitvec.add? r r 
    let op₂ ← Bitvec.add? op₁ y
    return cond b op₂ op₁
  (x.toList).foldlM f 0

/-
#eval  Bitvec.mul? (𝟷𝟶𝟷𝟷) (𝟷𝟶𝟷𝟷)
#eval  Bitvec.mul? (𝟶𝟶𝟶𝟶𝟶𝟶𝟷𝟶𝟷𝟷) (𝟶𝟶𝟶𝟶𝟶𝟶𝟷𝟶𝟷𝟷) |>.get!|>.toNat
-/
theorem mul?_some_eq_mul : ∀ {n : Nat} {x y z : Bitvec n}, Bitvec.mul? x y = some z → x * y = z := sorry

/--
The value produced is the unsigned integer quotient of the two operands.
Note that unsigned integer division and signed integer division are distinct operations; for signed integer division, use ‘sdiv’.
Division by zero is undefined behavior.
-/
def udiv? {w : Nat} (x y : Bitvec w) : Option $ Bitvec w :=
  match y.toNat with
    | 0 => none
    | _ => some $ Bitvec.ofNat w (x.toNat / y.toNat)

/--
The value produced is the signed integer quotient of the two operands rounded towards zero.
Note that signed integer division and unsigned integer division are distinct operations; for unsigned integer division, use ‘udiv’.
Division by zero is undefined behavior.
Overflow also leads to undefined behavior; this is a rare case, but can occur, for example, by doing a 32-bit division of -2147483648 by -1.
-/
def sdiv? {w : Nat} (x y : Bitvec w) : Option $ Bitvec w := 
  match y.toInt with
    | 0 => none
    | _ => some $ Bitvec.ofInt' w (x.toInt / y.toInt)

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def select {w : Nat} (c : Bitvec 1) (x y : Bitvec w) : Bitvec w :=
    if c = true ::ᵥ Vector.nil then x else y

theorem bitwise_eq_eq {w : Nat} (x y : Bitvec w) [ wneq0 : NeZero w] :
 (forall i : Fin w, x[i] = y[i]) ↔ x = y := sorry
    
-- from InstCombine/Shift:279
theorem shl_ushr_eq_and_shl {w : Nat} {x C : Bitvec w} :
  Bitvec.shl (Bitvec.ushr x C.toNat) C.toNat = Bitvec.and x (Bitvec.shl (Bitvec.ofInt' w (-1)) C.toNat) :=
  sorry -- TODO: make sure the semantics are the same here

-- from InstCombine/:805
theorem one_sdiv_eq_add_cmp_select {w : Nat} {x : Bitvec w} :
  Bitvec.sdiv? (Bitvec.ofInt' w 1) x = Option.some (Bitvec.select ((Nat.blt (Bitvec.add x (Bitvec.ofNat w 1)).toNat 3) ::ᵥ Vector.nil)  x (Bitvec.ofNat w 0)) :=
  sorry -- TODO: make sure the semantics are the same here
  -- Looks pretty ugly/random, can we make it more readable

abbrev NatFun := Nat → Bool -- TODO: find a better name

namespace NatFun

def ofBitvecFun {w : Nat} (x : Bitvec.Fun w) : NatFun := 
  fun n => if h : n < w 
    then x ⟨n, h⟩
    else false

def toBitvecFun {w : Nat} (x : NatFun) : Bitvec.Fun w :=
  fun ⟨n, _⟩ => x n

theorem toBitvecFun_ofBitvecFun {w : Nat} {x : Fun w} :
 NatFun.toBitvecFun (NatFun.ofBitvecFun x) = x := by
 funext x
 simp [NatFun.toBitvecFun, NatFun.ofBitvecFun]

theorem ofBitvecFun_toBitvecFun_eq_width {w : Nat} {x : NatFun} :
 ∀ i : Fin w, NatFun.ofBitvecFun (@NatFun.toBitvecFun w x) i = x i := by
 intro i
 simp [NatFun.toBitvecFun, NatFun.ofBitvecFun]

instance : Add NatFun := ⟨addSeq⟩


def ofBitvec {w : Nat} (x : Bitvec w) : NatFun := ofBitvecFun $ Bitvec.toFun x

@[reducible]
def toBitvec {w : Nat} (x : NatFun) : Bitvec w := Bitvec.ofFun $ toBitvecFun x

-- def toBitvec_eq_bit {w : Nat} [NeZero w] (x : NatFun) (n : Fin w) : (toBitvec x)[n] = x n.1 := by
--   simp [toBitvec, toBitvecFun, Bitvec.ofFun, Bitvec.toFun]

theorem toBitvec_ofBitvec {w : Nat} (x : NatFun) : 
  ∀ i : Fin w, ofBitvec (@toBitvec w x) i = x i := by
  simp [toBitvec, ofBitvec]
  intro i
  rw [ofFun_toFun, ofBitvecFun_toBitvecFun_eq_width]

theorem toBitvec_add_hom {x y : NatFun} {w : Nat} : @toBitvec w x + @NatFun.toBitvec w y = @NatFun.toBitvec w (x + y) := by
  simp [toBitvec, toBitvecFun, addSeq, Bitvec.ofFun, Bitvec.add, Add.add, ofFun]



end NatFun

end Bitvec

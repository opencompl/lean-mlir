import Mathlib.Data.Vector
import Mathlib.Data.Bitvec.Basic
import Mathlib.Algebra.Group.InjSurj
import Mathlib.Tactic.Ring
import Mathlib.Data.Int.Cast.Lemmas
import Mathlib.Data.ZMod.Basic

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

/-- convert `Bitvec n` to `Fin n → Bool` -/
def ofFun {width : Nat} : Fun width → Bitvec width :=
  Vector.ofFn

/-- convert `Fin n → Bool` to `Bitvec n` -/
def toFun {width : Nat} : Bitvec width → Fun width :=
    Vector.get

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

def toZMod {n : Nat} (x : Bitvec n) : ZMod (2 ^ n) := 
  x.toNat

theorem toZMod_val {n : ℕ} (v : Bitvec n) : (toZMod v).val = v.toNat := by
  rw [toZMod, ZMod.val_nat_cast, Nat.mod_eq_of_lt]
  apply toNat_lt

def ofZMod {n : ℕ} (x : ZMod (2 ^ n)) : Bitvec n := 
  Bitvec.ofNat _ x.val

theorem toZMod_ofZMod {n} (i : ZMod <| 2 ^ n) : (ofZMod i).toZMod = i :=
  ZMod.val_injective _ (by simp [toZMod_val, ofZMod, Bitvec.toNat_ofNat,
    Nat.mod_eq_of_lt (ZMod.val_lt i)])

theorem ofZMod_toZMod {n} (v : Bitvec n) : ofZMod (toZMod v) = v := by
  dsimp [ofZMod]
  rw [toZMod_val, ofNat_toNat]

theorem foldl_addLsb_add : ∀ (n k : ℕ) (x : List Bool), 
    x.foldl addLsb (n + k) = 2 ^ x.length * k + x.foldl addLsb n
  | n, k, [] => by simp [addLsb, add_comm, add_assoc, add_left_comm]
  | n, k, a::l => by
    rw [List.foldl_cons, List.foldl_cons, addLsb, addLsb]
    have : (n + k) + (n + k) + cond a 1 0 = (n + n + cond a 1 0) + (k + k) :=
      by simp [add_assoc, add_comm, add_left_comm]
    rw [this, foldl_addLsb_add _ (k + k) l]
    simp [pow_succ, two_mul, mul_add, add_mul, add_assoc]

theorem foldl_addLsb_eq_add_foldl_addLsb_zero (x : List Bool) (k : ℕ) :
    x.foldl addLsb k = 2 ^ x.length * k + x.foldl addLsb 0 := by
  rw [← foldl_addLsb_add, zero_add]

theorem foldl_addLsb_cons_zero (a : Bool) (x : List Bool) :
    (a::x).foldl addLsb 0 = 2^x.length * cond a 1 0 + x.foldl addLsb 0 :=
  calc (a::x).foldl addLsb 0
     = x.foldl addLsb (0 + 0 + cond a 1 0) := rfl
   _ = _ := by rw [foldl_addLsb_add]

theorem toNat_adc_aux : ∀ {x y: List Bool} (_h : List.length x = List.length y),
    List.foldl addLsb (addLsb 0 (List.mapAccumr₂ (fun x y c => (Bitvec.carry x y c, Bitvec.xor3 x y c)) x y false).fst)
      (List.mapAccumr₂ (fun x y c => (Bitvec.carry x y c, Bitvec.xor3 x y c)) x y false).snd =
    List.foldl addLsb 0 x + List.foldl addLsb 0 y 
| [], [], _ => rfl
| a::x, b::y, h => by
  simp only [List.length_cons, Nat.succ.injEq] at h
  rw [foldl_addLsb_cons_zero, foldl_addLsb_cons_zero, add_add_add_comm, ← toNat_adc_aux h,
    List.mapAccumr₂]
  dsimp only [Bitvec.carry, Bitvec.xor3]
  rw [foldl_addLsb_eq_add_foldl_addLsb_zero, foldl_addLsb_cons_zero,
    foldl_addLsb_eq_add_foldl_addLsb_zero _ (addLsb _ _)]
  cases a <;> cases b <;> 
  simp only [Bool.xor_false_right, Bool.xor_assoc, Bool.true_xor, List.length_cons, List.length_mapAccumr₂,
    h, min_self, pow_succ, two_mul, Bool.and_false, Bool.true_and, Bool.false_or, Bool.false_and, Bool.or_false,
    addLsb, add_zero, zero_add, add_mul, Bool.cond_not, add_left_comm, add_assoc, cond_true, mul_one, cond_false,
    mul_zero, add_comm, Bool.xor_false, Bool.false_xor, Bool.true_or, Bool.not_true] <;>
  cases (List.mapAccumr₂ (fun x y c => (x && y || x && c || y && c, xor x (xor y c))) x y false).fst <;> simp [h]  

theorem toNat_adc {n : Nat} {x y : Bitvec n} : (Bitvec.adc x y false).toNat = x.toNat + y.toNat := by
  rcases x with ⟨x, hx⟩
  rcases y with ⟨y, hy⟩
  subst n
  dsimp [Bitvec.toNat, bitsToNat]
  exact toNat_adc_aux hy.symm

theorem toNat_tail : ∀ {n : Nat} (x : Bitvec n), Bitvec.toNat x.tail = x.toNat % 2^(n-1)
  | 0, ⟨[], _⟩ => rfl
  | n+1, ⟨a::l, h⟩ => by
    conv_lhs => rw [← Nat.mod_eq_of_lt (Bitvec.toNat_lt (Vector.tail ⟨a::l, h⟩))]
    simp only [List.length_cons, Nat.succ.injEq] at h
    simp only [Bitvec.toNat, bitsToNat, foldl_addLsb_cons_zero, Vector.toList, h]   
    simp only [Vector.tail_val, List.tail_cons, ge_iff_le, add_le_iff_nonpos_left, nonpos_iff_eq_zero,
      add_tsub_cancel_right]
    rw [mul_comm, Nat.mul_add_mod]

@[simp]
theorem toNat_add {n : Nat} (x y : Bitvec n) : (x + y).toNat = (x.toNat + y.toNat) % 2^n := by
  show Bitvec.toNat (x.adc y false).tail = (x.toNat + y.toNat) % 2^n
  rw [toNat_tail, toNat_adc, add_tsub_cancel_right]


theorem toZMod_add {n : ℕ} (x y : Bitvec n) : (x + y).toZMod = (x.toZMod + y.toZMod) := by
  apply ZMod.val_injective
  rw [toZMod_val, ZMod.val_add, toNat_add, toZMod_val, toZMod_val]

theorem ofZMod_add {n : ℕ} (x y : ZMod (2 ^n)) : 
    Bitvec.ofZMod (x + y) = Bitvec.ofZMod x + Bitvec.ofZMod y := by 
  rw [← toZMod_ofZMod x, ← toZMod_ofZMod y, ← toZMod_add, toZMod_ofZMod, toZMod_ofZMod, ofZMod_toZMod]

theorem toList_zero : Vector.toList (0 : Bitvec n) = List.replicate n false := rfl

@[simp]
theorem toNat_zero : ∀ {n : Nat}, (0 : Bitvec n).toNat = 0
  | 0 => rfl
  | n+1 => by simpa [Bitvec.toNat, toList_zero, bitsToNat] using @toNat_zero n

@[simp]
theorem toZMod_zero : ∀ {n : Nat}, (0 : Bitvec n).toZMod = 0 := 
  by simp [toZMod]

@[simp]
theorem ofZMod_zero : Bitvec.ofZMod (0 : ZMod (2^n)) = 0 := by
  rw [← toZMod_zero, ofZMod_toZMod]

theorem toList_one {n : ℕ} : (1 : Bitvec (n + 1)).toList = List.replicate n false ++ [true] := rfl 

theorem toNat_one : ∀ {n : Nat}, (1 : Bitvec n).toNat = if n = 0 then 0 else 1
  | 0 => rfl
  | 1 => rfl
  | n+2 => by
    have := @toNat_one (n+1)
    simp only [Bitvec.toNat, bitsToNat, List.foldl, Nat.add_eq, add_zero, List.append_eq, 
      List.foldl_append, add_eq_zero, and_false, ite_false, toList_one] at *
    simp only [addLsb, cond_true, add_left_eq_self, add_eq_zero, and_self] at this
    rw [foldl_addLsb_eq_add_foldl_addLsb_zero, this]
    simp [addLsb]

@[simp]
theorem toZMod_one : ∀ {n : Nat}, (1 : Bitvec n).toZMod = 1 := by
  simp [toZMod, toNat_one]

@[simp]
theorem ofZMod_one : Bitvec.ofZMod (1 : ZMod (2^n)) = 1 := by
  rw [← toZMod_one, ofZMod_toZMod]

instance : SMul ℕ (Bitvec n) := ⟨nsmulRec⟩

theorem nsmul_def {n : ℕ} (x : Bitvec n) (y : ℕ) : y • x = nsmulRec y x := rfl

@[simp]
theorem toZMod_nsmul {n : ℕ} (x : Bitvec n) (y : ℕ) : (y • x).toZMod = y • x.toZMod := by
  induction y with
  | zero => simp [zero_nsmul, nsmul_def, nsmulRec];
  | succ y ih => rw [nsmul_def, nsmulRec, toZMod_add, ← nsmul_def, ih]; simp [add_mul, add_comm]

theorem toInt_sub_aux : ∀ {x y : List Bool} (_hx : List.length x = List.length y),
    (↑(List.foldl addLsb 0 (List.mapAccumr₂ (fun x y c => (Bitvec.carry (!x) y c, Bitvec.xor3 x y c)) x y false).snd) : ℤ)
    - 2 ^ x.length * cond (List.mapAccumr₂ (fun x y c => (Bitvec.carry (!x) y c, Bitvec.xor3 x y c)) x y false).fst 1 0 =
  ↑(List.foldl addLsb 0 x) + -↑(List.foldl addLsb 0 y) 
| [], [], _ => rfl
|  a::x, b::y, h => by
  simp only [List.length_cons, Nat.succ.injEq] at h
  rw [foldl_addLsb_cons_zero, foldl_addLsb_cons_zero, Nat.cast_add, 
    Nat.cast_add, neg_add, add_add_add_comm, ← toInt_sub_aux h, List.mapAccumr₂]
  dsimp only [Bitvec.carry, Bitvec.xor3]
  rw [foldl_addLsb_eq_add_foldl_addLsb_zero, foldl_addLsb_cons_zero]
  cases a <;> cases b <;> 
  simp only [Bool.xor_false_right, Bool.xor_assoc, Bool.true_xor, List.length_cons, List.length_mapAccumr₂,
    h, min_self, pow_succ, two_mul, Bool.and_false, Bool.true_and, Bool.false_or, Bool.false_and, Bool.or_false,
    addLsb, add_zero, zero_add, add_mul, Bool.cond_not, add_left_comm, add_assoc, cond_true, mul_one, cond_false,
    mul_zero, add_comm, Bool.xor_false, Bool.false_xor, Bool.true_or, Bool.not_true, Bool.not_false,
    Nat.cast_mul, Nat.cast_pow, Nat.cast_add, Nat.cast_zero, neg_zero, sub_eq_add_neg, two_mul] <;>
  ring_nf <;>
  cases (List.mapAccumr₂ (fun x y c => (!x && y || !x && c || y && c, xor x (xor y c))) x y false).fst 
    <;> simp <;> ring

instance (n : ℕ) : NeZero (2 ^ n) := ⟨Nat.pos_iff_ne_zero.1 <| pow_pos (by norm_num) _⟩

theorem toZMod_sbb {n : ℕ} (x y : Bitvec n) : (x.sbb y false).2.toZMod = x.toZMod - y.toZMod := by
  rcases x with ⟨x, hx⟩
  rcases y with ⟨y, hy⟩
  simp [Bitvec.toNat, toZMod, bitsToNat, Vector.toList, sbb, Vector.mapAccumr₂]
  have h2n : (2 ^ n : ZMod (2 ^ n)) = 0 := by 
    rw [← Nat.cast_two (R := ZMod (2 ^ n)), ← Nat.cast_pow, ZMod.nat_cast_self]
  have := congr_arg ((↑) : ℤ → ZMod (2^n)) (toInt_sub_aux (hx.trans hy.symm))
  simpa [hx, h2n, sub_eq_add_neg] using this

theorem toZMod_sub {n : ℕ} (x y : Bitvec n) : (x - y).toZMod = x.toZMod - y.toZMod :=
  toZMod_sbb x y

theorem toInt_neg_aux : ∀ (x : List Bool),
    ((List.foldl addLsb (0 : ℕ) (List.mapAccumr (fun y c => (y || c, xor y c)) x false).snd : ℕ) 
      - 2 ^ x.length * cond (List.mapAccumr (fun y c => (y || c, xor y c)) x false).fst 1 0 : ℤ) = 
      -(List.foldl addLsb 0 x)
  | [] => rfl
  | a::x => by 
    dsimp only [List.mapAccumr]
    rw [foldl_addLsb_cons_zero, foldl_addLsb_cons_zero, Nat.cast_add,
      Nat.cast_add, neg_add, ← toInt_neg_aux x]
    simp
    cases a <;> cases (List.mapAccumr (fun y c => (y || c, xor y c)) x false).fst <;>
    simp [pow_succ, two_mul, sub_eq_add_neg] <;> ring
    
theorem toZMod_neg {n : ℕ} (x : Bitvec n) : (-x).toZMod = -x.toZMod := by
  show x.neg.toZMod = -x.toZMod
  rcases x with ⟨x, hx⟩
  simp [Bitvec.neg, Bitvec.toNat, bitsToNat, Vector.toList, Vector.mapAccumr, toZMod]
  have h2n : (2 ^ n : ZMod (2 ^ n)) = 0 := by 
    rw [← Nat.cast_two (R := ZMod (2 ^ n)), ← Nat.cast_pow, ZMod.nat_cast_self]
  have := congr_arg ((↑) : ℤ → ZMod (2^n)) (toInt_neg_aux x) 
  subst n
  simpa [h2n, sub_eq_add_neg] using this

instance : SMul ℤ (Bitvec n) := ⟨zsmulRec⟩

theorem zsmul_def {n : ℕ} (x : Bitvec n) (y : ℤ) : y • x = zsmulRec y x := rfl

@[simp]
theorem toZMod_zsmul {n : ℕ} (x : Bitvec n) (y : ℤ) : (y • x).toZMod = y • x.toZMod := by
  induction y with
  | ofNat y => simp [zsmul_def, zsmulRec, ← nsmul_def]
  | negSucc y => simp [zsmul_def, zsmulRec, ← nsmul_def, toZMod_neg, add_mul]

instance : AddCommGroup (Bitvec n) := 
  Function.Injective.addCommGroup toZMod 
    (Function.injective_iff_hasLeftInverse.2 ⟨_, ofZMod_toZMod⟩) 
    toZMod_zero toZMod_add toZMod_neg toZMod_sub toZMod_nsmul toZMod_zsmul

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
    | _ => match w with
      | 0 => some Vector.nil
      | w' + 1 => some $ Bitvec.ofInt w' (x.toInt / y.toInt)

/--
 If the condition is an i1 and it evaluates to 1, the instruction returns the first value argument; otherwise, it returns the second value argument.
-/
def select {w : Nat} (c : Bitvec 1) (x y : Bitvec w) : Bitvec w :=
    if c = true ::ᵥ Vector.nil then x else y

theorem bitwise_eq_eq {w : Nat} (x y : Bitvec w) [ wneq0 : NeZero w] :
 (forall i : Fin w, x[i] = y[i]) ↔ x = y := sorry
    
-- from InstCombine/Shift:279
theorem shl_ushr_eq_and_shl {w : Nat} {x C : Bitvec w.succ} :
  Bitvec.shl (Bitvec.ushr x C.toNat) C.toNat = Bitvec.and x (Bitvec.shl (Bitvec.ofInt w (-1)) C.toNat) :=
  sorry -- TODO: make sure the semantics are the same here

-- from InstCombine/:805
theorem one_sdiv_eq_add_cmp_select {w : Nat} {x : Bitvec w.succ} :
  Bitvec.sdiv? (Bitvec.ofInt w 1) x = Option.some (Bitvec.select ((Nat.blt (Bitvec.add x (Bitvec.ofNat w.succ 1)).toNat 3) ::ᵥ Vector.nil)  x (Bitvec.ofNat w.succ 0)) :=
  sorry -- TODO: make sure the semantics are the same here
  -- Looks pretty ugly/random, can we make it more readable


end Bitvec
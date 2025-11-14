import Blase
set_option warn.sorry false
open BitVec

-- 1 1 1 = 7
-- 1 0 0 = 4
-- x.msb ↔ x.zext(w + 1) + x.zext(w+1) ≥u twoPow w (w + 1)



-- | TODO: Needs 'getLsbD'. doable, but complex. We should handle by having a predicate
-- 'x.getLsbD = v', and then casing on this value.
-- | TODO HIGH: allOnes → -1 [DONE]
/--
error: unsolved goals
w : ℕ
x : BitVec w
⊢ x &&& 1#w = setWidth w (ofBool (x.getLsbD 0))
-/
#guard_msgs in theorem AvoidCollision_and_one_eq_setWidth_ofBool_getLsbD {x : BitVec w} :
    (x &&& 1#w) = setWidth w (ofBool (x.getLsbD 0))  := by bv_multi_width_normalize
-- NOTPOSSIBLE: append, width addition
theorem AvoidCollision_and_setWidth_allOnes (w' w : Nat) (b : BitVec (w' + w)) :
    b &&& (BitVec.allOnes w).setWidth (w' + w) = 0#w' ++ b.setWidth w  := sorry
-- TODO LOW: setWidth'
-- NOTPOSSIBLE: append
theorem AvoidCollision_append_def (x : BitVec v) (y : BitVec w) :
    x ++ y = (shiftLeftZeroExtend x w ||| setWidth' (Nat.le_add_left w v) y)  := sorry
-- TODO HIGH: BitVec.cast | cannot, need to unify Term and Predicate to be able to write 'v = w' in the [DONE]
-- calculus.
theorem AvoidCollision_cast_setWidth (h : v = v') (x : BitVec w) :
    (x.setWidth v).cast h = x.setWidth v' := by bv_multi_width
-- TODO LOW: reflection bug
theorem AvoidCollision_getElem_signExtend {x  : BitVec w} {v i : Nat} (h : i < v) :
    (x.signExtend v)[i] = if h : i < w then x[i] else x.msb  := sorry
-- TODO LOW: Reflection bug
theorem AvoidCollision_getElem?_setWidth (m : Nat) (x : BitVec n) (i : Nat) :
    (x.setWidth m)[i]? = if i < m then some (x.getLsbD i) else none  := by sorry
-- TODO LOW: Reflection bug
theorem AvoidCollision_getLsbD_setWidth (m : Nat) (x : BitVec n) (i : Nat) :
    getLsbD (setWidth m x) i = (decide (i < m) && getLsbD x i)  := sorry
-- TODO LOW: Reflection bug
-- TODO LOW: getLsbD
theorem AvoidCollision_getLsbD_signExtend (x  : BitVec w) {v i : Nat} :
    (x.signExtend v).getLsbD i = (decide (i < v) && if i < w then x.getLsbD i else x.msb)  := sorry
-- TODO LOW: Reflection bug
-- TODO LOW: getMsbD
theorem AvoidCollision_getMsbD_setWidth {m : Nat} {x : BitVec n} {i : Nat} :
    getMsbD (setWidth m x) i = (decide (m - n ≤ i) && getMsbD x (i + n - m))  := by sorry
-- TODO LOW: getMsbD, subtraction of indices (hard?)
theorem AvoidCollision_getMsbD_setWidth_add {x : BitVec w} (h : k ≤ i) :
    (x.setWidth (w + k)).getMsbD i = x.getMsbD (i - k)  := by sorry
-- TODO LOW: Reflection bug
theorem AvoidCollision_getMsbD_signExtend {x : BitVec w} {v i : Nat} :
    (x.signExtend v).getMsbD i =
      (decide (i < v) && if v - w ≤ i then x.getMsbD (i + w - v) else x.msb)  := by sorry
-- TODO low: getLsbD
theorem AvoidCollision_msb_setWidth (x : BitVec w) : (x.setWidth v).msb = (decide (0 < v) && x.getLsbD (v - 1))  := by sorry
-- TODO low: getMsbD
theorem AvoidCollision_msb_signExtend {x : BitVec w} :
    (x.signExtend v).msb = (decide (0 < v) && if w ≥ v then x.getMsbD (w - v) else x.msb)  := sorry
-- IMPOSSIBLE: mul
theorem AvoidCollision_neg_eq_neg_one_mul (b : BitVec w) : -b = -1#w * b :=
  BitVec.eq_of_toInt_eq (by simp)

-- IMPOSSIBLE: mul
theorem setWidth_mul (x y : BitVec w) (h : i ≤ w) :
    (x * y).setWidth i = x.setWidth i * y.setWidth i  := sorry
  -- DONE
theorem AvoidCollision_setWidth_add (x y : BitVec w) (h : i ≤ w) :
    (x + y).setWidth i = x.setWidth i + y.setWidth i  := sorry
-- IMPOSSIBLE: mod
theorem AvoidCollision_setWidth_add_eq_mod {x y : BitVec w} : BitVec.setWidth i (x + y) = (BitVec.setWidth i x + BitVec.setWidth i y) % (BitVec.twoPow i w)  := sorry
theorem AvoidCollision_setWidth_and {x y : BitVec w} :
    (x &&& y).setWidth k = x.setWidth k &&& y.setWidth k  := sorry
-- IMPOSSIBLE: append
theorem AvoidCollision_setWidth_append {x : BitVec w} {y : BitVec v} :
    (x ++ y).setWidth k = if h : k ≤ v then y.setWidth k else (x.setWidth (k - v) ++ y).cast (by omega)  := sorry
-- IMPOSSIBLE: append
theorem AvoidCollision_setWidth_append_append_append_eq_shiftLeft_setWidth_or {b : BitVec w} {b' : BitVec w'} {b'' : BitVec w''} {b''' : BitVec w'''} :
    (b ++ b' ++ b'' ++ b''').setWidth w'''' = (b.setWidth w'''' <<< (w' + w'' + w''')) ||| (b'.setWidth w'''' <<< (w'' + w''')) |||
      (b''.setWidth w'''' <<< w''') ||| b'''.setWidth w''''  := sorry
-- IMPOSSIBLE: append
theorem AvoidCollision_setWidth_append_append_eq_shiftLeft_setWidth_or {b : BitVec w} {b' : BitVec w'} {b'' : BitVec w''} :
    (b ++ b' ++ b'').setWidth w''' = (b.setWidth w''' <<< (w' + w'')) ||| (b'.setWidth w''' <<< w'') ||| b''.setWidth w'''  := sorry
-- IMPOSSIBLE: append
theorem AvoidCollision_setWidth_append_eq_right {a : BitVec w} {b : BitVec w'} : (a ++ b).setWidth w' = b  := sorry
-- IMPOSSIBLE: append
theorem AvoidCollision_setWidth_append_eq_shiftLeft_setWidth_or {b : BitVec w} {b' : BitVec w'} :
    (b ++ b').setWidth w'' = (b.setWidth w'' <<< w') ||| b'.setWidth w''  := sorry
theorem AvoidCollision_setWidth_append_of_eq {x : BitVec v} {y : BitVec w} (h : w' = w) :
    setWidth (v' + w') (x ++ y) = setWidth v' x ++ setWidth w' y  := sorry
-- TODO HIGH: cast [DONE]
theorem AvoidCollision_setWidth_cast {x : BitVec w} {h : w = v} : (x.cast h).setWidth k = x.setWidth k  := by bv_multi_width
-- TODO HIGH: cons
theorem AvoidCollision_setWidth_cons {x : BitVec w} : (cons a x).setWidth w = x  := by sorry
-- DONE
theorem AvoidCollision_setWidth_eq (x : BitVec n) : setWidth n x = x  := sorry
-- IMPOSSIBLE: append
theorem AvoidCollision_setWidth_eq_append {v : Nat} {x : BitVec v} {w : Nat} (h : v ≤ w) :
    x.setWidth w = ((0#(w - v)) ++ x).cast (by omega)  := sorry
-- DONE
theorem AvoidCollision_setWidth_not {x : BitVec w} (_ : k ≤ w) :
    (~~~x).setWidth k = ~~~(x.setWidth k)  := sorry
-- TODO HIGH: ofNat
theorem AvoidCollision_setWidth_ofNat_of_le (h : v ≤ w) (x : Nat) : setWidth v (BitVec.ofNat w x) = BitVec.ofNat v x  := by sorry
-- TODO HIGH: ofNat
theorem AvoidCollision_setWidth_ofNat_one_eq_ofNat_one_of_lt {v w : Nat} (hv : 0 < v) :
    (BitVec.ofNat v 1).setWidth w = BitVec.ofNat w 1  := sorry
-- TODO LOW: getLsbD
theorem AvoidCollision_setWidth_one {x : BitVec w} :
    x.setWidth 1 = ofBool (x.getLsbD 0)  := sorry
-- TODO LOW: getLsbD
theorem AvoidCollision_setWidth_one_eq_ofBool_getLsb_zero (x : BitVec w) :
    x.setWidth 1 = BitVec.ofBool (x.getLsbD 0)  := sorry
theorem AvoidCollision_setWidth_or {x y : BitVec w} :
    (x ||| y).setWidth k = x.setWidth k ||| y.setWidth k  := sorry
theorem AvoidCollision_setWidth_setWidth {x : BitVec u} {w v : Nat} (h : ¬ (v < u ∧ v < w)) :
    setWidth w (setWidth v x) = setWidth w x  := sorry
-- NOTPOSSIBLE: twoPow with symbolic natural number as index? Wait, maybe possible? Needs thought!
-- TODO HIGH: twoPow [done]
#guard_msgs in theorem AvoidCollision_setWidth_setWidth_eq_self {a : BitVec w} {w' : Nat} (h : a < BitVec.twoPow w w') : (a.setWidth w').setWidth w = a  := by bv_multi_width
-- DONE
theorem AvoidCollision_setWidth_setWidth_of_le (x : BitVec w) (h : k ≤ l) :
    (x.setWidth l).setWidth k = x.setWidth k  := sorry
-- TODO LOW: getLsbD, twoPow
theorem AvoidCollision_setWidth_setWidth_succ_eq_setWidth_setWidth_of_getLsbD_false {x : BitVec w} {i : Nat} (hx : x.getLsbD i = false) :
    setWidth w (x.setWidth (i + 1)) =
      setWidth w (x.setWidth i)  := sorry
-- TODO LOW: twoPow, getLsbD
theorem AvoidCollision_setWidth_setWidth_succ_eq_setWidth_setWidth_or_twoPow_of_getLsbD_true {x : BitVec w} {i : Nat} (hx : x.getLsbD i = true) :
    setWidth w (x.setWidth (i + 1)) =
      setWidth w (x.setWidth i) ||| (twoPow w i)  := sorry
-- NOTPOSSIBLE left shift
theorem AvoidCollision_setWidth_shiftLeft_of_le {x : BitVec w} {y : Nat} (hi : i ≤ w)  :
    (x <<< y).setWidth i = x.setWidth i <<< y :=
  eq_of_getElem_eq (fun j hj => Bool.eq_iff_iff.2 (by simp; omega))
-- NOTPOSSIBLE left shift
theorem shiftLeft_eq' {x : BitVec w₁} {y : BitVec w₂} : x <<< y = x <<< y.toNat  := sorry
-- TODO LOW: cons
theorem AvoidCollision_setWidth_succ (x : BitVec w) :
    setWidth (i+1) x = cons (getLsbD x i) (setWidth i x)  := by sorry
-- NOTPOSSIBLE: right shift by unk constant.
theorem AvoidCollision_setWidth_ushiftRight {x : BitVec w} {y : Nat} (hi : w ≤ i) :
    (x >>> y).setWidth i = x.setWidth i >>> y  := sorry
-- NOTPOSSIBLE: right shift by unk constant.
theorem AvoidCollision_setWidth_ushiftRight_eq_extractLsb {b : BitVec w} : (b >>> w').setWidth w'' = b.extractLsb' w' w''  := sorry
-- DONE
theorem AvoidCollision_setWidth_xor {x y : BitVec w} :
    (x ^^^ y).setWidth k = x.setWidth k ^^^ y.setWidth k  := sorry
-- DONE
theorem AvoidCollision_setWidth_zero (m n : Nat) : setWidth m 0#n = 0#m  := sorry
-- NOTPOSSIBLE: w + n, not solvable.
theorem AvoidCollision_shiftLeftZeroExtend_eq {x : BitVec w} :
    shiftLeftZeroExtend x n = setWidth (w+n) x <<< n  := by sorry
-- DONE
theorem AvoidCollision_signExtend_and {x y : BitVec w} :
    (x &&& y).signExtend v = (x.signExtend v) &&& (y.signExtend v)  := sorry
-- TODO LOW: if, msb, cast.
theorem AvoidCollision_signExtend_eq_append_of_le {w v : Nat} {x : BitVec w} (h : w ≤ v) :
    x.signExtend v =
    ((if x.msb then allOnes (v - w) else 0#(v - w)) ++ x).cast (by omega)  := sorry
-- TODO HIGH: msb.
theorem AvoidCollision_signExtend_eq_not_setWidth_not_of_msb_true {x : BitVec w} {v : Nat} (hmsb : x.msb = true) :
    x.signExtend v = ~~~((~~~x).setWidth v)  := sorry
-- DONE
theorem AvoidCollision_signExtend_eq_setWidth_of_le (x : BitVec w) {v : Nat} (hv : v ≤ w) :
  x.signExtend v = x.setWidth v  := sorry
-- DONE, TODO: fix the problem statement in the zip file we create.
theorem AvoidCollision_signExtend_eq_setWidth_of_lt (x : BitVec w) {v : Nat} (hv : v ≤ w) :
  x.signExtend v = x.setWidth v := sorry
-- DONE
theorem signExtend_eq (x : BitVec w) : x.signExtend w = x  := sorry

-- | We are solving this now.
-- v
-- TODO HIGH: x.msb
#guard_msgs in theorem AvoidCollision_signExtend_eq_setWidth_of_msb_false {x : BitVec w} {v : Nat} (hmsb : x.msb = false) :
    x.signExtend v = x.setWidth v  := by revert hmsb; bv_multi_width_normalize; bv_multi_width
-- DONE
theorem AvoidCollision_signExtend_not {x : BitVec w} (h : 0 < w) :
    (~~~x).signExtend v = ~~~(x.signExtend v)  := sorry
-- DONE
theorem AvoidCollision_signExtend_or {x y : BitVec w} :
    (x ||| y).signExtend v = (x.signExtend v) ||| (y.signExtend v)  := sorry
-- DONE
theorem AvoidCollision_signExtend_xor {x y : BitVec w} :
    (x ^^^ y).signExtend v = (x.signExtend v) ^^^ (y.signExtend v)  := sorry
-- TODO LOW: Fin
theorem AvoidCollision_toFin_setWidth {x : BitVec w} :
    (x.setWidth v).toFin = Fin.ofNat (2^v) x.toNat  := sorry
-- TODO LOW: Fin
theorem AvoidCollision_toFin_signExtend (x : BitVec w) :
    (x.signExtend v).toFin = Fin.ofNat (2 ^ v) (x.toNat + if x.msb = true then 2 ^ v - 2 ^ w else 0) := sorry
-- TODO LOW: Fin
theorem AvoidCollision_toFin_signExtend_of_le {x : BitVec w} (hv : v ≤ w):
    (x.signExtend v).toFin = Fin.ofNat (2 ^ v) x.toNat  := sorry
-- IMOSSIBLE: mult
theorem AvoidCollision_toInt_mul_toInt_lt_neg_two_pow_iff {x y : BitVec w} :
    x.toInt * y.toInt < - 2 ^ (w - 1) ↔
      (signExtend (w * 2) x * signExtend (w * 2) y).slt (signExtend (w * 2) (intMin w))  := sorry
-- TODO HIGH: Int.bmod of (twoPow)
theorem AvoidCollision_toInt_setWidth (x : BitVec w) :
    (x.setWidth v).toInt = Int.bmod x.toNat (2^v)  := sorry
-- TODO HIGH: Int.bmod of (twoPow)
theorem AvoidCollision_toInt_signExtend (x : BitVec w) :
    (x.signExtend v).toInt = x.toInt.bmod (2 ^ min v w)  := sorry
-- TODO HIGH: Int.bmod of (twoPow)
theorem AvoidCollision_toInt_signExtend_eq_toInt_bmod_of_le (x : BitVec w) (h : v ≤ w) :
    (x.signExtend v).toInt = x.toInt.bmod (2 ^ v)  := sorry
-- TODO HIGH: Int.bmod of (twoPow)
theorem AvoidCollision_toInt_signExtend_eq_toNat_bmod (x : BitVec w) :
    (x.signExtend v).toInt = Int.bmod x.toNat (2 ^ min v w)  := sorry
-- TODO HIGH: Int.bmod of (twoPow)
theorem AvoidCollision_toInt_signExtend_eq_toNat_bmod_of_le {x : BitVec w} (hv : v ≤ w) :
    (x.signExtend v).toInt = Int.bmod x.toNat (2^v)  := by sorry
-- TODO LOW: reflection bug
-- TODO HIGH: toInt
theorem AvoidCollision_toInt_signExtend_of_le {x : BitVec w} (h : w ≤ v) :
    (x.signExtend v).toInt = x.toInt  := by sorry
theorem AvoidCollision_toNat_setWidth_of_le {w w' : Nat} {b : BitVec w} (h : w ≤ w') : (b.setWidth w').toNat = b.toNat  := sorry
-- TODO: toNat, msb, 2^v (note: every 2^v should be encoded as a width variable, not a nat variable.
theorem AvoidCollision_toNat_signExtend (x : BitVec w) {v : Nat} :
    (x.signExtend v).toNat = (x.setWidth v).toNat + if x.msb then 2^v - 2^w else 0  := sorry
-- TODO: toNat, msb, 2^v (note: every 2^v should be encoded as a width variable, not a nat variable.
-- [msb done, next add toNAt]
theorem AvoidCollision_toNat_signExtend_of_le (x : BitVec w) {v : Nat} (hv : w ≤ v) :
    (x.signExtend v).toNat = x.toNat + if x.msb then 2^v - 2^w else 0  := sorry
-- DONE
theorem AvoidCollision_truncate_eq_setWidth {v : Nat} {x : BitVec w} :
  truncate v x = setWidth v x  := sorry
-- IMPOSSIBLE: mul
theorem AvoidCollision_two_pow_le_toInt_mul_toInt_iff {x y : BitVec w} :
    2 ^ (w - 1) ≤ x.toInt * y.toInt ↔
      (signExtend (w * 2) (intMax w)).slt (signExtend (w * 2) x * signExtend (w * 2) y)  := sorry
-- DONE
theorem AvoidCollision_zeroExtend_eq_setWidth {v : Nat} {x : BitVec w} :
  zeroExtend v x = setWidth v x  := sorry

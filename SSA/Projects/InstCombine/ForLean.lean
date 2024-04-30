import Mathlib.Data.Nat.Size -- TODO: remove and get rid of shiftLeft_eq_mul_pow use
import SSA.Projects.InstCombine.Tactic -- TODO: remove and get rid of ring_nf use

namespace BitVec

def ushr_xor_distrib (a b c : BitVec w) :
    (a ^^^ b) >>> c = (a >>> c) ^^^ (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_and_distrib (a b c : BitVec w) :
    (a &&& b) >>> c = (a >>> c) &&& (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_or_distrib (a b c : BitVec w) :
    (a ||| b) >>> c = (a >>> c) ||| (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def xor_assoc (a b c : BitVec w) :
    a ^^^ b ^^^ c = a ^^^ (b ^^^ c) := by
  ext i
  simp [Bool.xor_assoc]

def and_assoc (a b c : BitVec w) :
    a &&& b &&& c = a &&& (b &&& c) := by
  ext i
  simp [Bool.and_assoc]

def or_assoc (a b c : BitVec w) :
    a ||| b ||| c = a ||| (b ||| c) := by
  ext i
  simp [Bool.or_assoc]

@[simp, bv_toNat]
lemma toNat_shiftLeft' (A B : BitVec w) :
    BitVec.toNat (A <<< B) = (BitVec.toNat A) * 2 ^ BitVec.toNat B % 2 ^w := by
  unfold HShiftLeft.hShiftLeft instHShiftLeftBitVec
  simp only [toNat_shiftLeft, Nat.shiftLeft_eq_mul_pow]

lemma one_shiftLeft_mul_eq_shiftLeft {A B : BitVec w} (h : BitVec.toNat B < w):
    (1 <<< B * A) = (A <<< B) := by
  apply BitVec.eq_of_toNat_eq
  simp only [bv_toNat, Nat.mod_mul_mod, one_mul]
  ring_nf

end BitVec

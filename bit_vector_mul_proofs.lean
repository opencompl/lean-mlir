import SSA.Projects.InstCombine.TacticAuto
import Std.Tactic.BVDecide

-- currently devoloping it in the webbrowser
namespace ProofsOnBitVectors_Mul


-- defining my own theorems --

-- modelling of registers
variable {w: Nat} { reg1 reg2 reg3 : BitVec w } -- modelling register as bitvector of variable length

-- PROOFS:

--CONSTANT "FOLDINGS":

-- x * 0 = 0 ---> diffrent proof techniques
theorem a_mul_zero :
    reg1 * 0#w = 0#w := by
  bv_auto

theorem mul_zero :
    reg1 * 0#w = 0#w := by
    rw [BitVec.mul_zero]

--(version where we explictly write the proof out )
theorem expl_mul_zero :
    reg1 * 0#w = 0#w := by
    apply BitVec.eq_of_toInt_eq
    rw [BitVec.toInt_mul]
    rw [BitVec.toInt_zero]
    rw [Int.mul_zero]
    rw [Int.bmod_zero]
--(version using simplify)
theorem simp_mul_zero :
    reg1 * 0#w = 0#w := by
    simp
--
-- x * 1 = x
theorem a_mul_one :
    reg1 * 1#w = reg1 := by
  bv_auto

theorem mul_one_decide :
    reg1 * 1#w = reg1 := by
  bv_decide

theorem mul_one :
    reg1 * 1#w = reg1 := by
  rw[BitVec.mul_one]

-- -1 * x = x
theorem a_neg_eq_minus_one :
  BitVec.neg reg1 = -1 * reg1 := by
  bv_auto

theorem neg_eq_minus_one :
  BitVec.neg reg1 = -1#w * reg1 := by
  rw [BitVec.neg_mul, BitVec.one_mul]
  rfl

-- ARITHEMTIC BASICS

--  - x * -y = x * y
theorem a_neg_mult_neg :
    (-reg1) * (-reg2) = reg1 * reg2 := by
  bv_auto

theorem neg_mult_neg :
    (-reg1) * (-reg2) = reg1 * reg2 := by
  rw [← BitVec.neg_eq, ← BitVec.neg_eq ]
  rw [neg_eq_minus_one, neg_eq_minus_one]
  nth_rewrite 2 [BitVec.neg_mul]
  rw [BitVec.neg_mul]
  rw [BitVec.one_mul, BitVec.one_mul]
  rw [BitVec.mul_neg, BitVec.neg_mul ]
  rw [BitVec.neg_neg]

-- --x = x
theorem a_neg_neg :
      - -reg1 = reg1 := by
    bv_auto

theorem neg_neg :
      - -reg1 = reg1 := by
    rw [BitVec.neg_neg]


-- STRENGTH REDUCTIONS :

theorem a_mul_2_add :
    reg1 * 2 = reg1 + reg1 := by
  bv_auto

theorem mul_2_add :
    reg1 * 2#w = reg1 + reg1 := by
  rw [BitVec.mul_two]

 /-theorem a_double_mul :
    reg1 * 2 = reg1 <<< 1 := by
  bv_auto -- couldn't be solved by bv_auto
  -/
  theorem a_double_mul_32 (reg : BitVec 32):
    reg * 2 = reg <<< 1#32 := by
  bv_decide


theorem double_mul :--TO DO try to prove it by hand 
    reg1 * 2 = reg1 <<< 1 := by
    apply BitVec.eq_of_toNat_eq -- instead of showing equality can show same toNat




end ProofsOnBitVectors_Mul

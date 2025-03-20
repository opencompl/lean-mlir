import SSA.Projects.InstCombine.TacticAuto
import Std.Tactic.BVDecide

-- currently devoloping it in the webbrowser
namespace ProofsOnBitVectors_Add


-- defining my own theorems --

-- modelling of registers
variable {w: Nat} { reg1 reg2 reg3 : BitVec w } -- modelling register as bitvector of variable length

-- PROOFS:

--CONSTANT "FOLDINGS":
-- x + 0 = x
theorem a_constant_fold_0 :
    reg1 + 0#w = reg1 := by
  bv_auto

theorem constant_fold_0 :
    reg1 + 0#w = reg1 := by
  rw [BitVec.add_zero]
--

-- ARITHEMTIC BASICS
-- -x + x = 0
theorem a_cancle_32_bv_auto  (reg : BitVec 32) :
    reg + (-1 * reg) = 0#32 := by
  bv_auto

theorem cancle_32_bv_decide (reg : BitVec 32) :
    reg + (-1 * reg) = 0#32 := by
  rw [BitVec.neg_mul] -- need that else it times out
  bv_decide

theorem a_cancle_generic_bv_auto {w : Nat} (reg : BitVec w) :
    reg + (-1 * reg) = 0#w := by
  bv_auto

theorem a_cancle_generic_bv_decide64  (reg : BitVec 64) :
    reg + (-1 * reg) = 0#64 := by
  bv_decide
  

-- generic case only works with bv_auto because bv_decide does bitblasting into a sat solver


-- STRENGTH REDUCTIONS :
-- 2 * x = x + x
theorem a_mul_2_add :
    reg1 * 2 = reg1 + reg1 := by
  bv_auto

theorem mul_2_add :
    reg1 * 2#w = reg1 + reg1 := by
  rw [BitVec.mul_two]

/- theorem a_double_mul :
    reg1 * 2 = reg1 <<< 1 := by
  bv_auto -- couldn't be solved by bv_auto
-/

theorem double_mul :
    reg1 * 2 = reg1 <<< 1 := by
    apply BitVec.eq_of_toNat_eq -- instead of showing equality can show same toNat



end ProofsOnBitVectors_Add

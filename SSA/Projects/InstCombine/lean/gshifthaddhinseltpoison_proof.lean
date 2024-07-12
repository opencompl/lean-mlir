
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem ashr_C1_add_A_C2_i32_thm (x : _root_.BitVec 32) :
  (if 32 ≤ (5 + (x.toNat &&& 65535)) % 4294967296 then none
    else some ((6#32).sshiftRight ((5 + (x.toNat &&& 65535)) % 4294967296))) ⊑
    some 0#32 := sorry

theorem lshr_C1_add_A_C2_i32_thm (x : _root_.BitVec 32) :
  (if 32 ≤ (5 + (x.toNat &&& 65535)) % 4294967296 then none else some (6#32 <<< ((x &&& 65535#32) + 5#32))) ⊑
    if 32 ≤ x.toNat &&& 65535 then none else some (192#32 <<< (x &&& 65535#32)) := sorry


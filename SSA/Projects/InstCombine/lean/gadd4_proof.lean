
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem match_andAsRem_lshrAsDiv_shlAsMul_thm (x : _root_.BitVec 64) :
  (x &&& 63#64) + BitVec.ofNat 64 (x.toNat >>> 6 % 9) <<< 6 = BitVec.ofNat 64 (x.toNat % 576) := sorry

theorem match_signed_thm (x : _root_.BitVec 64) :
  x + 299#64 * (x.sdiv 299#64).sdiv 64#64 * 18446744073709551552#64 + x.sdiv 19136#64 * 19136#64 +
      (x.sdiv 19136#64).sdiv 9#64 * 18446744073709379392#64 =
    x + x.sdiv 172224#64 * 18446744073709379392#64 := sorry

theorem not_match_inconsistent_signs_thm (x : _root_.BitVec 64) :
  BitVec.ofNat 64 ((x.sdiv 299#64).toNat % 64) * 299#64 = 299#64 * (x.sdiv 299#64 &&& 63#64) := sorry


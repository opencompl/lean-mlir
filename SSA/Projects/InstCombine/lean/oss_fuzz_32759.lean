import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  oss_fuzz_32759
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def oss_fuzz_32759_before := [llvmfunc|
  llvm.func @oss_fuzz_32759(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %arg0 : i1 to i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.ashr %5, %1  : i32
    %7 = llvm.srem %6, %2  : i32
    %8 = llvm.xor %7, %6  : i32
    llvm.br ^bb2(%8 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.icmp "eq" %9, %3 : i32
    llvm.return %10 : i1
  }]

def oss_fuzz_32759_combined := [llvmfunc|
  llvm.func @oss_fuzz_32759(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i1
  }]

theorem inst_combine_oss_fuzz_32759   : oss_fuzz_32759_before  ⊑  oss_fuzz_32759_combined := by
  unfold oss_fuzz_32759_before oss_fuzz_32759_combined
  simp_alive_peephole
  sorry

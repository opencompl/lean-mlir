import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr38897
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sharpening_before := [llvmfunc|
  llvm.func @sharpening(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.select %arg1, %arg3, %arg4 : i1, i32
    %4 = llvm.select %arg2, %arg5, %arg6 : i1, i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.icmp "sgt" %5, %1 : i32
    %7 = llvm.select %6, %5, %1 : i1, i32
    %8 = llvm.xor %7, %2  : i32
    %9 = llvm.icmp "sgt" %3, %8 : i32
    %10 = llvm.select %9, %3, %8 : i1, i32
    %11 = llvm.xor %10, %2  : i32
    llvm.return %11 : i32
  }]

def sharpening_combined := [llvmfunc|
  llvm.func @sharpening(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i32
    %3 = llvm.select %arg2, %arg5, %arg6 : i1, i32
    %4 = llvm.add %3, %0  : i32
    %5 = llvm.intr.smin(%4, %1)  : (i32, i32) -> i32
    %6 = llvm.intr.smax(%2, %5)  : (i32, i32) -> i32
    %7 = llvm.xor %6, %1  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_sharpening   : sharpening_before  ⊑  sharpening_combined := by
  unfold sharpening_before sharpening_combined
  simp_alive_peephole
  sorry

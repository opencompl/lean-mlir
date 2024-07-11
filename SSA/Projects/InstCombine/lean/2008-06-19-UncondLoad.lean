import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-06-19-UncondLoad
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def b_before := [llvmfunc|
  llvm.func @b(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.add %1, %2  : i32
    %4 = llvm.call @x(%arg0) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "ne" %3, %0 : i32
    %6 = llvm.select %5, %arg1, %arg0 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %7 : i32
  }]

def b_combined := [llvmfunc|
  llvm.func @b(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
    %2 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @x(%arg0) : (!llvm.ptr) -> i32
    %4 = llvm.sub %0, %2  : i32
    %5 = llvm.icmp "eq" %1, %4 : i32
    %6 = llvm.select %5, %arg0, %arg1 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
    llvm.return %7 : i32
  }]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry

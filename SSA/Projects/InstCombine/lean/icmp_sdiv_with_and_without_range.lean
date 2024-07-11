import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp_sdiv_with_and_without_range
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def without_range_before := [llvmfunc|
  llvm.func @without_range(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32]

    %3 = llvm.sdiv %2, %0  : i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def with_range_before := [llvmfunc|
  llvm.func @with_range(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32]

    %3 = llvm.sdiv %2, %0  : i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def without_range_combined := [llvmfunc|
  llvm.func @without_range(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_without_range   : without_range_before  ⊑  without_range_combined := by
  unfold without_range_before without_range_combined
  simp_alive_peephole
  sorry
def with_range_combined := [llvmfunc|
  llvm.func @with_range(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_with_range   : with_range_before  ⊑  with_range_combined := by
  unfold with_range_before with_range_combined
  simp_alive_peephole
  sorry

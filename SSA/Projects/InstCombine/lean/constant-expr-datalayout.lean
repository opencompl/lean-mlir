import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  constant-expr-datalayout
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"test1.struct", (i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"test1.struct", (i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"test1.struct", (i32, i32)> 
    %5 = llvm.mlir.addressof @test1.aligned_glbl : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"test1.struct", (i32, i32)>
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.and %7, %8  : i64
    llvm.store %9, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def OpenFilter_before := [llvmfunc|
  llvm.func @OpenFilter(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @channel_wg4idx : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i8
    %4 = llvm.zext %3 : i8 to i64
    llvm.return %4 : i64
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def OpenFilter_combined := [llvmfunc|
  llvm.func @OpenFilter(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @channel_wg4idx : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.trunc %arg0 : i64 to i8
    %3 = llvm.sub %2, %1  : i8
    %4 = llvm.zext %3 : i8 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_OpenFilter   : OpenFilter_before  ⊑  OpenFilter_combined := by
  unfold OpenFilter_before OpenFilter_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call-cast-target
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @ctime : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_struct_ret_before := [llvmfunc|
  llvm.func @test_struct_ret() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @foo(%0) : (!llvm.ptr) -> !llvm.struct<(i8)>
    llvm.return
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn1 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn2 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn3 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn4 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @fn5 : !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.struct<(i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr inbounds %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %6 = llvm.getelementptr inbounds %3[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.call %2(%5, %7) : !llvm.ptr, (i32, i32) -> i1
    llvm.return %8 : i1
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @ctime(%0) : (!llvm.ptr) -> !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
def test_struct_ret_combined := [llvmfunc|
  llvm.func @test_struct_ret() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @foo(%0) : (!llvm.ptr) -> !llvm.struct<(i8)>
    llvm.return
  }]

theorem inst_combine_test_struct_ret   : test_struct_ret_before  ⊑  test_struct_ret_combined := by
  unfold test_struct_ret_before test_struct_ret_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.call @fn1(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn2 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn3 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @fn4 : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @fn5 : !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.struct<(i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.getelementptr inbounds %3[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.call %2(%4, %6) : !llvm.ptr, (i32, i32) -> i1
    llvm.return %7 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry

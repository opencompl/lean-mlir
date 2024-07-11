import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-12-28-IcmpSub2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "ule" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "sle" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "sge" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    llvm.return %6 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.sub %3, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    llvm.return %6 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry

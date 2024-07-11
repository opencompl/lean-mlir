import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bswap-known-bits
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(511 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.intr.bswap(%2)  : (i16) -> i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.intr.bswap(%2)  : (i16) -> i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.intr.bswap(%2)  : (i16) -> i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.return %5 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.bswap(%2)  : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry

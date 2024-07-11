import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitreverse-known-bits
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.intr.bitreverse(%4)  : (i32) -> i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    llvm.return %6 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.intr.bitreverse(%3)  : (i32) -> i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def add_bitreverse_before := [llvmfunc|
  llvm.func @add_bitreverse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(-16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.intr.bitreverse(%2)  : (i8) -> i8
    %4 = llvm.add %3, %1  : i8
    llvm.return %4 : i8
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def add_bitreverse_combined := [llvmfunc|
  llvm.func @add_bitreverse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.intr.bitreverse(%1)  : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_add_bitreverse   : add_bitreverse_before  ⊑  add_bitreverse_combined := by
  unfold add_bitreverse_before add_bitreverse_combined
  simp_alive_peephole
  sorry

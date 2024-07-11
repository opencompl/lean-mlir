import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-set
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.bitcast %arg0 : i32 to i32
    %1 = llvm.bitcast %arg1 : i32 to i32
    %2 = llvm.icmp "ne" %0, %1 : i32
    llvm.return %2 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to i32
    llvm.return %3 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test6a_before := [llvmfunc|
  llvm.func @test6a(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6a_combined := [llvmfunc|
  llvm.func @test6a(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test6a   : test6a_before  ⊑  test6a_combined := by
  unfold test6a_before test6a_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry

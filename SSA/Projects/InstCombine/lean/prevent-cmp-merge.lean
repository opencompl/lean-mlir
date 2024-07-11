import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  prevent-cmp-merge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1(%arg0: i32, %arg1: i32) -> _before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %2, %arg1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def test1_logical(%arg0: i32, %arg1: i32) -> _before := [llvmfunc|
  llvm.func @test1_logical(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %3, %arg1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def test2(%arg0: i32, %arg1: i32) -> _before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %2, %1 : i32
    %5 = llvm.xor %3, %4  : i1
    llvm.return %5 : i1
  }]

def test3(%arg0: i32, %arg1: i32) -> _before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %2, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def test3_logical(%arg0: i32, %arg1: i32) -> _before := [llvmfunc|
  llvm.func @test3_logical(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %3, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def test1(%arg0: i32, %arg1: i32) -> _combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.icmp "eq" %2, %arg1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_test1(%arg0: i32, %arg1: i32) ->    : test1(%arg0: i32, %arg1: i32) -> _before  ⊑  test1(%arg0: i32, %arg1: i32) -> _combined := by
  unfold test1(%arg0: i32, %arg1: i32) -> _before test1(%arg0: i32, %arg1: i32) -> _combined
  simp_alive_peephole
  sorry
def test1_logical(%arg0: i32, %arg1: i32) -> _combined := [llvmfunc|
  llvm.func @test1_logical(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "eq" %3, %arg1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test1_logical(%arg0: i32, %arg1: i32) ->    : test1_logical(%arg0: i32, %arg1: i32) -> _before  ⊑  test1_logical(%arg0: i32, %arg1: i32) -> _combined := by
  unfold test1_logical(%arg0: i32, %arg1: i32) -> _before test1_logical(%arg0: i32, %arg1: i32) -> _combined
  simp_alive_peephole
  sorry
def test2(%arg0: i32, %arg1: i32) -> _combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %2, %1 : i32
    %5 = llvm.xor %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_test2(%arg0: i32, %arg1: i32) ->    : test2(%arg0: i32, %arg1: i32) -> _before  ⊑  test2(%arg0: i32, %arg1: i32) -> _combined := by
  unfold test2(%arg0: i32, %arg1: i32) -> _before test2(%arg0: i32, %arg1: i32) -> _combined
  simp_alive_peephole
  sorry
def test3(%arg0: i32, %arg1: i32) -> _combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    %3 = llvm.icmp "eq" %1, %0 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test3(%arg0: i32, %arg1: i32) ->    : test3(%arg0: i32, %arg1: i32) -> _before  ⊑  test3(%arg0: i32, %arg1: i32) -> _combined := by
  unfold test3(%arg0: i32, %arg1: i32) -> _before test3(%arg0: i32, %arg1: i32) -> _combined
  simp_alive_peephole
  sorry
def test3_logical(%arg0: i32, %arg1: i32) -> _combined := [llvmfunc|
  llvm.func @test3_logical(%arg0: i32, %arg1: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.icmp "eq" %2, %0 : i32
    %5 = llvm.select %3, %1, %4 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_test3_logical(%arg0: i32, %arg1: i32) ->    : test3_logical(%arg0: i32, %arg1: i32) -> _before  ⊑  test3_logical(%arg0: i32, %arg1: i32) -> _combined := by
  unfold test3_logical(%arg0: i32, %arg1: i32) -> _before test3_logical(%arg0: i32, %arg1: i32) -> _combined
  simp_alive_peephole
  sorry

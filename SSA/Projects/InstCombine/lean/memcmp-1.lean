import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @hel : !llvm.ptr
    %2 = llvm.mlir.constant("hello_u\00") : !llvm.array<8 x i8>
    %3 = llvm.mlir.addressof @hello_u : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @hel : !llvm.ptr
    %2 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @foo : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @foo : !llvm.ptr
    %2 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @hel : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %3 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.store %arg1, %4 {alignment = 8 : i64} : i64, !llvm.ptr]

    %5 = llvm.call @memcmp(%3, %4, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %arg1, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.call @memcmp(%3, %4, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %3 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %arg1, %4 {alignment = 2 : i64} : i16, !llvm.ptr]

    %5 = llvm.call @memcmp(%3, %4, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_simplify10_before := [llvmfunc|
  llvm.func @test_simplify10(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
    %1 = llvm.zext %0 : i8 to i32
    %2 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i16
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_combined := [llvmfunc|
  llvm.func @test_simplify10(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_simplify10   : test_simplify10_before  ⊑  test_simplify10_combined := by
  unfold test_simplify10_before test_simplify10_combined
  simp_alive_peephole
  sorry

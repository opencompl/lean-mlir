import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  wcslen-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi16>) : !llvm.array<1 x i16>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @nullstring : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    llvm.return %4 : i1
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @wcslen(%arg0) : (!llvm.ptr) -> i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7() -> i1 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    llvm.return %4 : i1
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @wcslen(%arg0) : (!llvm.ptr) -> i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    llvm.return %2 : i1
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[108, 111, 110, 103, 101, 114, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %3 = llvm.mlir.addressof @longer : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }]

def test_simplify10_before := [llvmfunc|
  llvm.func @test_simplify10(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<6 x i16>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }]

def test_simplify11_before := [llvmfunc|
  llvm.func @test_simplify11(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi16>) : !llvm.array<13 x i16>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<13 x i16>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi16>) : !llvm.array<32 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def test_no_simplify2_before := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<7 x i16>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }]

def test_no_simplify3_before := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi16>) : !llvm.array<13 x i16>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<13 x i16>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }]

def test_no_simplify4_before := [llvmfunc|
  llvm.func @test_no_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @str32 : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %2 = llvm.icmp "ne" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_combined := [llvmfunc|
  llvm.func @test_simplify10(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.sext %arg0 : i16 to i64
    %2 = llvm.sub %0, %1 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test_simplify10   : test_simplify10_before  ⊑  test_simplify10_combined := by
  unfold test_simplify10_before test_simplify10_combined
  simp_alive_peephole
  sorry
def test_simplify11_combined := [llvmfunc|
  llvm.func @test_simplify11(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(9 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i16
    %4 = llvm.zext %3 : i16 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test_simplify11   : test_simplify11_before  ⊑  test_simplify11_combined := by
  unfold test_simplify11_before test_simplify11_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi16>) : !llvm.array<32 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_combined := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sext %arg0 : i16 to i64
    %4 = llvm.getelementptr inbounds %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i16>
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_no_simplify2   : test_no_simplify2_before  ⊑  test_no_simplify2_combined := by
  unfold test_no_simplify2_before test_no_simplify2_combined
  simp_alive_peephole
  sorry
def test_no_simplify3_combined := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi16>) : !llvm.array<13 x i16>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.zext %4 : i16 to i64
    %6 = llvm.getelementptr inbounds %2[%3, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i16>
    %7 = llvm.call @wcslen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_test_no_simplify3   : test_no_simplify3_before  ⊑  test_no_simplify3_combined := by
  unfold test_no_simplify3_before test_no_simplify3_combined
  simp_alive_peephole
  sorry
def test_no_simplify4_combined := [llvmfunc|
  llvm.func @test_no_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_no_simplify4   : test_no_simplify4_before  ⊑  test_no_simplify4_combined := by
  unfold test_no_simplify4_before test_no_simplify4_combined
  simp_alive_peephole
  sorry

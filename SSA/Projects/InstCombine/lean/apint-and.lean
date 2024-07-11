import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-and
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i39) -> i39 {
    %0 = llvm.mlir.constant(0 : i39) : i39
    %1 = llvm.and %arg0, %0  : i39
    llvm.return %1 : i39
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i15) -> i15 {
    %0 = llvm.mlir.constant(-1 : i15) : i15
    %1 = llvm.and %arg0, %0  : i15
    llvm.return %1 : i15
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(127 : i23) : i23
    %1 = llvm.mlir.constant(128 : i23) : i23
    %2 = llvm.and %arg0, %0  : i23
    %3 = llvm.and %2, %1  : i23
    llvm.return %3 : i23
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i37) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i37) : i37
    %1 = llvm.mlir.constant(0 : i37) : i37
    %2 = llvm.and %arg0, %0  : i37
    %3 = llvm.icmp "ne" %2, %1 : i37
    llvm.return %3 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i7, %arg1: !llvm.ptr) -> i7 {
    %0 = llvm.mlir.constant(3 : i7) : i7
    %1 = llvm.mlir.constant(12 : i7) : i7
    %2 = llvm.or %arg0, %0  : i7
    %3 = llvm.xor %2, %1  : i7
    llvm.store %3, %arg1 {alignment = 1 : i64} : i7, !llvm.ptr]

    %4 = llvm.and %3, %0  : i7
    llvm.return %4 : i7
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(39 : i47) : i47
    %1 = llvm.mlir.constant(255 : i47) : i47
    %2 = llvm.ashr %arg0, %0  : i47
    %3 = llvm.and %2, %1  : i47
    llvm.return %3 : i47
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i999) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.and %arg0, %0  : i999
    llvm.return %1 : i999
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i1005) -> i1005 {
    %0 = llvm.mlir.constant(-1 : i1005) : i1005
    %1 = llvm.and %arg0, %0  : i1005
    llvm.return %1 : i1005
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i123) -> i123 {
    %0 = llvm.mlir.constant(127 : i123) : i123
    %1 = llvm.mlir.constant(128 : i123) : i123
    %2 = llvm.and %arg0, %0  : i123
    %3 = llvm.and %2, %1  : i123
    llvm.return %3 : i123
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i737) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i737) : i737
    %1 = llvm.mlir.constant(0 : i737) : i737
    %2 = llvm.and %arg0, %0  : i737
    %3 = llvm.icmp "ne" %2, %1 : i737
    llvm.return %3 : i1
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i117, %arg1: !llvm.ptr) -> i117 {
    %0 = llvm.mlir.constant(3 : i117) : i117
    %1 = llvm.mlir.constant(12 : i117) : i117
    %2 = llvm.or %arg0, %0  : i117
    %3 = llvm.xor %2, %1  : i117
    llvm.store %3, %arg1 {alignment = 4 : i64} : i117, !llvm.ptr]

    %4 = llvm.and %3, %0  : i117
    llvm.return %4 : i117
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1016 : i1024) : i1024
    %1 = llvm.mlir.constant(255 : i1024) : i1024
    %2 = llvm.ashr %arg0, %0  : i1024
    %3 = llvm.and %2, %1  : i1024
    llvm.return %3 : i1024
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i39) -> i39 {
    %0 = llvm.mlir.constant(0 : i39) : i39
    llvm.return %0 : i39
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i15) -> i15 {
    llvm.return %arg0 : i15
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(0 : i23) : i23
    llvm.return %0 : i23
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i37) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i37) : i37
    %1 = llvm.icmp "ugt" %arg0, %0 : i37
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i7, %arg1: !llvm.ptr) -> i7 {
    %0 = llvm.mlir.constant(-4 : i7) : i7
    %1 = llvm.mlir.constant(15 : i7) : i7
    %2 = llvm.mlir.constant(3 : i7) : i7
    %3 = llvm.and %arg0, %0  : i7
    %4 = llvm.xor %3, %1  : i7
    llvm.store %4, %arg1 {alignment = 1 : i64} : i7, !llvm.ptr
    llvm.return %2 : i7
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(39 : i47) : i47
    %1 = llvm.lshr %arg0, %0  : i47
    llvm.return %1 : i47
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i999) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    llvm.return %0 : i999
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i1005) -> i1005 {
    llvm.return %arg0 : i1005
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i123) -> i123 {
    %0 = llvm.mlir.constant(0 : i123) : i123
    llvm.return %0 : i123
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i737) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i737) : i737
    %1 = llvm.icmp "ugt" %arg0, %0 : i737
    llvm.return %1 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i117, %arg1: !llvm.ptr) -> i117 {
    %0 = llvm.mlir.constant(-4 : i117) : i117
    %1 = llvm.mlir.constant(15 : i117) : i117
    %2 = llvm.mlir.constant(3 : i117) : i117
    %3 = llvm.and %arg0, %0  : i117
    %4 = llvm.xor %3, %1  : i117
    llvm.store %4, %arg1 {alignment = 4 : i64} : i117, !llvm.ptr
    llvm.return %2 : i117
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1016 : i1024) : i1024
    %1 = llvm.lshr %arg0, %0  : i1024
    llvm.return %1 : i1024
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry

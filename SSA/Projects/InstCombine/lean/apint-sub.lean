import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i23) -> i23 {
    %0 = llvm.sub %arg0, %arg0  : i23
    llvm.return %0 : i23
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(0 : i47) : i47
    %1 = llvm.sub %arg0, %0  : i47
    llvm.return %1 : i47
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i97) -> i97 {
    %0 = llvm.mlir.constant(0 : i97) : i97
    %1 = llvm.sub %0, %arg0  : i97
    %2 = llvm.sub %0, %1  : i97
    llvm.return %2 : i97
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i108, %arg1: i108) -> i108 {
    %0 = llvm.mlir.constant(0 : i108) : i108
    %1 = llvm.sub %0, %arg0  : i108
    %2 = llvm.sub %arg1, %1  : i108
    llvm.return %2 : i108
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i19, %arg1: i19, %arg2: i19) -> i19 {
    %0 = llvm.sub %arg1, %arg2  : i19
    %1 = llvm.sub %arg0, %0  : i19
    llvm.return %1 : i19
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i57, %arg1: i57) -> i57 {
    %0 = llvm.and %arg0, %arg1  : i57
    %1 = llvm.sub %arg0, %0  : i57
    llvm.return %1 : i57
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i77) -> i77 {
    %0 = llvm.mlir.constant(-1 : i77) : i77
    %1 = llvm.sub %0, %arg0  : i77
    llvm.return %1 : i77
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i27) -> i27 {
    %0 = llvm.mlir.constant(9 : i27) : i27
    %1 = llvm.mul %0, %arg0  : i27
    %2 = llvm.sub %1, %arg0  : i27
    llvm.return %2 : i27
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(3 : i42) : i42
    %1 = llvm.mul %0, %arg0  : i42
    %2 = llvm.sub %arg0, %1  : i42
    llvm.return %2 : i42
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(0 : i9) : i9
    %1 = llvm.sub %arg0, %arg1  : i9
    %2 = llvm.icmp "ne" %1, %0 : i9
    llvm.return %2 : i1
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i43) -> i43 {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.mlir.constant(0 : i43) : i43
    %2 = llvm.ashr %arg0, %0  : i43
    %3 = llvm.sub %1, %2  : i43
    llvm.return %3 : i43
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i79) -> i79 {
    %0 = llvm.mlir.constant(78 : i79) : i79
    %1 = llvm.mlir.constant(0 : i79) : i79
    %2 = llvm.lshr %arg0, %0  : i79
    %3 = llvm.sub %1, %2  : i79
    llvm.return %3 : i79
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1023 : i1024) : i1024
    %1 = llvm.mlir.constant(0 : i1024) : i1024
    %2 = llvm.lshr %arg0, %0  : i1024
    %3 = llvm.bitcast %2 : i1024 to i1024
    %4 = llvm.sub %1, %3  : i1024
    llvm.return %4 : i1024
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i51) -> i51 {
    %0 = llvm.mlir.constant(1123 : i51) : i51
    %1 = llvm.mlir.constant(0 : i51) : i51
    %2 = llvm.sdiv %arg0, %0  : i51
    %3 = llvm.sub %1, %2  : i51
    llvm.return %3 : i51
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(0 : i25) : i25
    %1 = llvm.mlir.constant(1234 : i25) : i25
    %2 = llvm.sub %0, %arg0  : i25
    %3 = llvm.sdiv %2, %1  : i25
    llvm.return %3 : i25
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(2 : i128) : i128
    %1 = llvm.shl %arg0, %0  : i128
    %2 = llvm.shl %arg0, %0  : i128
    %3 = llvm.sub %1, %2  : i128
    llvm.return %3 : i128
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i39, %arg1: i39) -> i39 {
    %0 = llvm.sub %arg0, %arg1  : i39
    %1 = llvm.add %0, %arg1  : i39
    llvm.return %1 : i39
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i33
    %1 = llvm.icmp "ne" %0, %arg0 : i33
    llvm.return %1 : i1
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i256, %arg1: i256) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i256
    %1 = llvm.icmp "ne" %0, %arg0 : i256
    llvm.return %1 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(0 : i23) : i23
    llvm.return %0 : i23
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i47) -> i47 {
    llvm.return %arg0 : i47
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i97) -> i97 {
    llvm.return %arg0 : i97
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i108, %arg1: i108) -> i108 {
    %0 = llvm.add %arg1, %arg0  : i108
    llvm.return %0 : i108
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i19, %arg1: i19, %arg2: i19) -> i19 {
    %0 = llvm.sub %arg2, %arg1  : i19
    %1 = llvm.add %0, %arg0  : i19
    llvm.return %1 : i19
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i57, %arg1: i57) -> i57 {
    %0 = llvm.mlir.constant(-1 : i57) : i57
    %1 = llvm.xor %arg1, %0  : i57
    %2 = llvm.and %1, %arg0  : i57
    llvm.return %2 : i57
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i77) -> i77 {
    %0 = llvm.mlir.constant(-1 : i77) : i77
    %1 = llvm.xor %arg0, %0  : i77
    llvm.return %1 : i77
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i27) -> i27 {
    %0 = llvm.mlir.constant(3 : i27) : i27
    %1 = llvm.shl %arg0, %0  : i27
    llvm.return %1 : i27
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(-2 : i42) : i42
    %1 = llvm.mul %arg0, %0  : i42
    llvm.return %1 : i42
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i9
    llvm.return %0 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i43) -> i43 {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.lshr %arg0, %0  : i43
    llvm.return %1 : i43
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i79) -> i79 {
    %0 = llvm.mlir.constant(78 : i79) : i79
    %1 = llvm.ashr %arg0, %0  : i79
    llvm.return %1 : i79
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1023 : i1024) : i1024
    %1 = llvm.ashr %arg0, %0  : i1024
    llvm.return %1 : i1024
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i51) -> i51 {
    %0 = llvm.mlir.constant(-1123 : i51) : i51
    %1 = llvm.sdiv %arg0, %0  : i51
    llvm.return %1 : i51
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(0 : i25) : i25
    %1 = llvm.mlir.constant(1234 : i25) : i25
    %2 = llvm.sub %0, %arg0  : i25
    %3 = llvm.sdiv %2, %1  : i25
    llvm.return %3 : i25
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    llvm.return %0 : i128
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i39, %arg1: i39) -> i39 {
    llvm.return %arg0 : i39
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.icmp "ne" %arg1, %0 : i33
    llvm.return %1 : i1
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i256, %arg1: i256) -> i1 {
    %0 = llvm.mlir.constant(0 : i256) : i256
    %1 = llvm.icmp "ne" %arg1, %0 : i256
    llvm.return %1 : i1
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sign-test-and-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "slt" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def test1_splat_before := [llvmfunc|
  llvm.func @test1_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %3 = llvm.icmp "slt" %arg1, %1 : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test1_logical_before := [llvmfunc|
  llvm.func @test1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def test2_logical_before := [llvmfunc|
  llvm.func @test2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "slt" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def test3_logical_before := [llvmfunc|
  llvm.func @test3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def test4_logical_before := [llvmfunc|
  llvm.func @test4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test5_logical_before := [llvmfunc|
  llvm.func @test5_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.icmp "sgt" %arg0, %2 : i32
    %7 = llvm.select %5, %6, %3 : i1, i1
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test6_logical_before := [llvmfunc|
  llvm.func @test6_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test7_logical_before := [llvmfunc|
  llvm.func @test7_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test8_logical_before := [llvmfunc|
  llvm.func @test8_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

def test9_logical_before := [llvmfunc|
  llvm.func @test9_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.icmp "sgt" %arg0, %2 : i32
    %7 = llvm.select %5, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "ult" %arg0, %2 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

def test10_logical_before := [llvmfunc|
  llvm.func @test10_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.icmp "ult" %arg0, %2 : i32
    %7 = llvm.select %5, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "ugt" %arg0, %2 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

def test11_logical_before := [llvmfunc|
  llvm.func @test11_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.icmp "ugt" %arg0, %2 : i32
    %7 = llvm.select %5, %3, %6 : i1, i1
    llvm.return %7 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_splat_combined := [llvmfunc|
  llvm.func @test1_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test1_splat   : test1_splat_before  ⊑  test1_splat_combined := by
  unfold test1_splat_before test1_splat_combined
  simp_alive_peephole
  sorry
def test1_logical_combined := [llvmfunc|
  llvm.func @test1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test1_logical   : test1_logical_before  ⊑  test1_logical_combined := by
  unfold test1_logical_before test1_logical_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_logical_combined := [llvmfunc|
  llvm.func @test2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test2_logical   : test2_logical_before  ⊑  test2_logical_combined := by
  unfold test2_logical_before test2_logical_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3_logical_combined := [llvmfunc|
  llvm.func @test3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test3_logical   : test3_logical_before  ⊑  test3_logical_combined := by
  unfold test3_logical_before test3_logical_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4_logical_combined := [llvmfunc|
  llvm.func @test4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test4_logical   : test4_logical_before  ⊑  test4_logical_combined := by
  unfold test4_logical_before test4_logical_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test5_logical_combined := [llvmfunc|
  llvm.func @test5_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test5_logical   : test5_logical_before  ⊑  test5_logical_combined := by
  unfold test5_logical_before test5_logical_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_logical_combined := [llvmfunc|
  llvm.func @test6_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test6_logical   : test6_logical_before  ⊑  test6_logical_combined := by
  unfold test6_logical_before test6_logical_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7_logical_combined := [llvmfunc|
  llvm.func @test7_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test7_logical   : test7_logical_before  ⊑  test7_logical_combined := by
  unfold test7_logical_before test7_logical_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_logical_combined := [llvmfunc|
  llvm.func @test8_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(-2013265920 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test8_logical   : test8_logical_before  ⊑  test8_logical_combined := by
  unfold test8_logical_before test8_logical_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1073741824 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_logical_combined := [llvmfunc|
  llvm.func @test9_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1073741824 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test9_logical   : test9_logical_before  ⊑  test9_logical_combined := by
  unfold test9_logical_before test9_logical_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_logical_combined := [llvmfunc|
  llvm.func @test10_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test10_logical   : test10_logical_before  ⊑  test10_logical_combined := by
  unfold test10_logical_before test10_logical_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_logical_combined := [llvmfunc|
  llvm.func @test11_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test11_logical   : test11_logical_before  ⊑  test11_logical_combined := by
  unfold test11_logical_before test11_logical_combined
  simp_alive_peephole
  sorry

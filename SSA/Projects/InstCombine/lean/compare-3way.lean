import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  compare-3way
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_low_sgt_before := [llvmfunc|
  llvm.func @test_low_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sgt" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_low_slt_before := [llvmfunc|
  llvm.func @test_low_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "slt" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_low_sge_before := [llvmfunc|
  llvm.func @test_low_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sge" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_low_sle_before := [llvmfunc|
  llvm.func @test_low_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sle" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_low_ne_before := [llvmfunc|
  llvm.func @test_low_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "ne" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_low_eq_before := [llvmfunc|
  llvm.func @test_low_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_mid_sgt_before := [llvmfunc|
  llvm.func @test_mid_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_mid_slt_before := [llvmfunc|
  llvm.func @test_mid_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "slt" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_mid_sge_before := [llvmfunc|
  llvm.func @test_mid_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sge" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_mid_sle_before := [llvmfunc|
  llvm.func @test_mid_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sle" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_mid_ne_before := [llvmfunc|
  llvm.func @test_mid_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_mid_eq_before := [llvmfunc|
  llvm.func @test_mid_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_high_sgt_before := [llvmfunc|
  llvm.func @test_high_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_high_slt_before := [llvmfunc|
  llvm.func @test_high_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "slt" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_high_sge_before := [llvmfunc|
  llvm.func @test_high_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sge" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_high_sle_before := [llvmfunc|
  llvm.func @test_high_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sle" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_high_ne_before := [llvmfunc|
  llvm.func @test_high_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def test_high_eq_before := [llvmfunc|
  llvm.func @test_high_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def non_standard_low_before := [llvmfunc|
  llvm.func @non_standard_low(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def non_standard_mid_before := [llvmfunc|
  llvm.func @non_standard_mid(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def non_standard_high_before := [llvmfunc|
  llvm.func @non_standard_high(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }]

def non_standard_bound1_before := [llvmfunc|
  llvm.func @non_standard_bound1(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.mlir.constant(-20 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    llvm.cond_br %8, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

def non_standard_bound2_before := [llvmfunc|
  llvm.func @non_standard_bound2(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    llvm.cond_br %8, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

def test_low_sgt_combined := [llvmfunc|
  llvm.func @test_low_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_low_sgt   : test_low_sgt_before  ⊑  test_low_sgt_combined := by
  unfold test_low_sgt_before test_low_sgt_combined
  simp_alive_peephole
  sorry
def test_low_slt_combined := [llvmfunc|
  llvm.func @test_low_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test_low_slt   : test_low_slt_before  ⊑  test_low_slt_combined := by
  unfold test_low_slt_before test_low_slt_combined
  simp_alive_peephole
  sorry
def test_low_sge_combined := [llvmfunc|
  llvm.func @test_low_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %3, %6 : i1, i32
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_low_sge   : test_low_sge_before  ⊑  test_low_sge_combined := by
  unfold test_low_sge_before test_low_sge_combined
  simp_alive_peephole
  sorry
def test_low_sle_combined := [llvmfunc|
  llvm.func @test_low_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_low_sle   : test_low_sle_before  ⊑  test_low_sle_combined := by
  unfold test_low_sle_before test_low_sle_combined
  simp_alive_peephole
  sorry
def test_low_ne_combined := [llvmfunc|
  llvm.func @test_low_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_low_ne   : test_low_ne_before  ⊑  test_low_ne_combined := by
  unfold test_low_ne_before test_low_ne_combined
  simp_alive_peephole
  sorry
def test_low_eq_combined := [llvmfunc|
  llvm.func @test_low_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_low_eq   : test_low_eq_before  ⊑  test_low_eq_combined := by
  unfold test_low_eq_before test_low_eq_combined
  simp_alive_peephole
  sorry
def test_mid_sgt_combined := [llvmfunc|
  llvm.func @test_mid_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_mid_sgt   : test_mid_sgt_before  ⊑  test_mid_sgt_combined := by
  unfold test_mid_sgt_before test_mid_sgt_combined
  simp_alive_peephole
  sorry
def test_mid_slt_combined := [llvmfunc|
  llvm.func @test_mid_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_mid_slt   : test_mid_slt_before  ⊑  test_mid_slt_combined := by
  unfold test_mid_slt_before test_mid_slt_combined
  simp_alive_peephole
  sorry
def test_mid_sge_combined := [llvmfunc|
  llvm.func @test_mid_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg0, %arg1 : i64
    %2 = llvm.zext %1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_mid_sge   : test_mid_sge_before  ⊑  test_mid_sge_combined := by
  unfold test_mid_sge_before test_mid_sge_combined
  simp_alive_peephole
  sorry
def test_mid_sle_combined := [llvmfunc|
  llvm.func @test_mid_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_mid_sle   : test_mid_sle_before  ⊑  test_mid_sle_combined := by
  unfold test_mid_sle_before test_mid_sle_combined
  simp_alive_peephole
  sorry
def test_mid_ne_combined := [llvmfunc|
  llvm.func @test_mid_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %3 = llvm.icmp "slt" %arg0, %arg1 : i64
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_mid_ne   : test_mid_ne_before  ⊑  test_mid_ne_combined := by
  unfold test_mid_ne_before test_mid_ne_combined
  simp_alive_peephole
  sorry
def test_mid_eq_combined := [llvmfunc|
  llvm.func @test_mid_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_mid_eq   : test_mid_eq_before  ⊑  test_mid_eq_combined := by
  unfold test_mid_eq_before test_mid_eq_combined
  simp_alive_peephole
  sorry
def test_high_sgt_combined := [llvmfunc|
  llvm.func @test_high_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test_high_sgt   : test_high_sgt_before  ⊑  test_high_sgt_combined := by
  unfold test_high_sgt_before test_high_sgt_combined
  simp_alive_peephole
  sorry
def test_high_slt_combined := [llvmfunc|
  llvm.func @test_high_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_high_slt   : test_high_slt_before  ⊑  test_high_slt_combined := by
  unfold test_high_slt_before test_high_slt_combined
  simp_alive_peephole
  sorry
def test_high_sge_combined := [llvmfunc|
  llvm.func @test_high_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_high_sge   : test_high_sge_before  ⊑  test_high_sge_combined := by
  unfold test_high_sge_before test_high_sge_combined
  simp_alive_peephole
  sorry
def test_high_sle_combined := [llvmfunc|
  llvm.func @test_high_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %3, %6 : i1, i32
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_high_sle   : test_high_sle_before  ⊑  test_high_sle_combined := by
  unfold test_high_sle_before test_high_sle_combined
  simp_alive_peephole
  sorry
def test_high_ne_combined := [llvmfunc|
  llvm.func @test_high_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_high_ne   : test_high_ne_before  ⊑  test_high_ne_combined := by
  unfold test_high_ne_before test_high_ne_combined
  simp_alive_peephole
  sorry
def test_high_eq_combined := [llvmfunc|
  llvm.func @test_high_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_high_eq   : test_high_eq_before  ⊑  test_high_eq_combined := by
  unfold test_high_eq_before test_high_eq_combined
  simp_alive_peephole
  sorry
def non_standard_low_combined := [llvmfunc|
  llvm.func @non_standard_low(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_non_standard_low   : non_standard_low_before  ⊑  non_standard_low_combined := by
  unfold non_standard_low_before non_standard_low_combined
  simp_alive_peephole
  sorry
def non_standard_mid_combined := [llvmfunc|
  llvm.func @non_standard_mid(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_non_standard_mid   : non_standard_mid_before  ⊑  non_standard_mid_combined := by
  unfold non_standard_mid_before non_standard_mid_combined
  simp_alive_peephole
  sorry
def non_standard_high_combined := [llvmfunc|
  llvm.func @non_standard_high(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_non_standard_high   : non_standard_high_before  ⊑  non_standard_high_combined := by
  unfold non_standard_high_before non_standard_high_combined
  simp_alive_peephole
  sorry
def non_standard_bound1_combined := [llvmfunc|
  llvm.func @non_standard_bound1(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_non_standard_bound1   : non_standard_bound1_before  ⊑  non_standard_bound1_combined := by
  unfold non_standard_bound1_before non_standard_bound1_combined
  simp_alive_peephole
  sorry
def non_standard_bound2_combined := [llvmfunc|
  llvm.func @non_standard_bound2(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_non_standard_bound2   : non_standard_bound2_before  ⊑  non_standard_bound2_combined := by
  unfold non_standard_bound2_before non_standard_bound2_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fpclass-from-dom-cond
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %3 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(9.9999999747524271E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "olt" %arg0, %0 : f64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %1 : f64
    llvm.return %4 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.99999997E-7 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : f32
  ^bb2:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %1 : f32
    %5 = llvm.fdiv %2, %arg0  : f32
    %6 = llvm.select %4, %2, %5 : i1, f32
    llvm.return %6 : f32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: f64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb4(%0 : f64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.fcmp "uno" %arg0, %1 : f64
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i1
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%arg0 : f64)
  ^bb4(%4: f64):  // 2 preds: ^bb0, ^bb3
    %5 = "llvm.intr.is.fpclass"(%4) <{bit = 411 : i32}> : (f64) -> i1]

    llvm.return %5 : i1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %3 = llvm.fcmp "ogt" %arg0, %0 : f64
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %5 = llvm.bitcast %4 : f64 to i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    llvm.return %7 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 345 : i32}> : (f32) -> i1]

    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 456 : i32}> : (f32) -> i1]

    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 456 : i32}> : (f32) -> i1]

    llvm.return %2 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 575 : i32}> : (f32) -> i1]

    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 575 : i32}> : (f32) -> i1]

    llvm.return %4 : i1
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %2 : f32
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.fneg %arg0  : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test11_and_before := [llvmfunc|
  llvm.func @test11_and(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.fneg %arg0  : f32
    %5 = llvm.and %3, %arg1  : i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test12_or_before := [llvmfunc|
  llvm.func @test12_or(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    %3 = llvm.or %2, %arg1  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %4 : i1
  }]

def test1_no_dominating_before := [llvmfunc|
  llvm.func @test1_no_dominating(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i1
  ^bb3:  // 2 preds: ^bb0, ^bb1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

    llvm.return %3 : i1
  }]

def test_signbit_check_before := [llvmfunc|
  llvm.func @test_signbit_check(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%3 : f32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : f32)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%arg0 : f32)
  ^bb4(%4: f32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }]

def test_signbit_check_fail_before := [llvmfunc|
  llvm.func @test_signbit_check_fail(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%3 : f32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : f32)
  ^bb3:  // pred: ^bb2
    %4 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%4 : f32)
  ^bb4(%5: f32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %6 = llvm.intr.fabs(%5)  : (f32) -> f32
    llvm.return %6 : f32
  }]

def test_signbit_check_wrong_type_before := [llvmfunc|
  llvm.func @test_signbit_check_wrong_type(%arg0: vector<2xf32>, %arg1: i1) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : vector<2xf32>
    llvm.br ^bb4(%3 : vector<2xf32>)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : vector<2xf32>)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%arg0 : vector<2xf32>)
  ^bb4(%4: vector<2xf32>):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.intr.fabs(%4)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(9.9999999747524271E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "olt" %arg0, %0 : f64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %1 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.99999997E-7 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : f32
  ^bb2:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %1 : f32
    %5 = llvm.fdiv %2, %arg0  : f32
    %6 = llvm.select %4, %2, %5 : i1, f32
    llvm.return %6 : f32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: f64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb4(%0 : f64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.fcmp "uno" %arg0, %1 : f64
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i1
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%arg0 : f64)
  ^bb4(%4: f64):  // 2 preds: ^bb0, ^bb3
    %5 = "llvm.intr.is.fpclass"(%4) <{bit = 411 : i32}> : (f64) -> i1]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %3 = llvm.fcmp "ogt" %arg0, %0 : f64
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %5 = llvm.bitcast %4 : f64 to i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    llvm.return %7 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 345 : i32}> : (f32) -> i1]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 456 : i32}> : (f32) -> i1]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 456 : i32}> : (f32) -> i1]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 575 : i32}> : (f32) -> i1]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 575 : i32}> : (f32) -> i1]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %2 : f32
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %2 : f32
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_and_combined := [llvmfunc|
  llvm.func @test11_and(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.and %3, %arg1  : i1
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.fcmp "oeq" %arg0, %2 : f32
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test11_and   : test11_and_before  ⊑  test11_and_combined := by
  unfold test11_and_before test11_and_combined
  simp_alive_peephole
  sorry
def test12_or_combined := [llvmfunc|
  llvm.func @test12_or(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    %3 = llvm.or %2, %arg1  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

theorem inst_combine_test12_or   : test12_or_before  ⊑  test12_or_combined := by
  unfold test12_or_before test12_or_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_test12_or   : test12_or_before  ⊑  test12_or_combined := by
  unfold test12_or_before test12_or_combined
  simp_alive_peephole
  sorry
def test1_no_dominating_combined := [llvmfunc|
  llvm.func @test1_no_dominating(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i1
  ^bb3:  // 2 preds: ^bb0, ^bb1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1]

theorem inst_combine_test1_no_dominating   : test1_no_dominating_before  ⊑  test1_no_dominating_combined := by
  unfold test1_no_dominating_before test1_no_dominating_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i1
  }]

theorem inst_combine_test1_no_dominating   : test1_no_dominating_before  ⊑  test1_no_dominating_combined := by
  unfold test1_no_dominating_before test1_no_dominating_combined
  simp_alive_peephole
  sorry
def test_signbit_check_combined := [llvmfunc|
  llvm.func @test_signbit_check(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%3 : f32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : f32)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%arg0 : f32)
  ^bb4(%4: f32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }]

theorem inst_combine_test_signbit_check   : test_signbit_check_before  ⊑  test_signbit_check_combined := by
  unfold test_signbit_check_before test_signbit_check_combined
  simp_alive_peephole
  sorry
def test_signbit_check_fail_combined := [llvmfunc|
  llvm.func @test_signbit_check_fail(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%3 : f32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : f32)
  ^bb3:  // pred: ^bb2
    %4 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%4 : f32)
  ^bb4(%5: f32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %6 = llvm.intr.fabs(%5)  : (f32) -> f32
    llvm.return %6 : f32
  }]

theorem inst_combine_test_signbit_check_fail   : test_signbit_check_fail_before  ⊑  test_signbit_check_fail_combined := by
  unfold test_signbit_check_fail_before test_signbit_check_fail_combined
  simp_alive_peephole
  sorry
def test_signbit_check_wrong_type_combined := [llvmfunc|
  llvm.func @test_signbit_check_wrong_type(%arg0: vector<2xf32>, %arg1: i1) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : vector<2xf32>
    llvm.br ^bb4(%3 : vector<2xf32>)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : vector<2xf32>)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%arg0 : vector<2xf32>)
  ^bb4(%4: vector<2xf32>):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.intr.fabs(%4)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }]

theorem inst_combine_test_signbit_check_wrong_type   : test_signbit_check_wrong_type_before  ⊑  test_signbit_check_wrong_type_combined := by
  unfold test_signbit_check_wrong_type_before test_signbit_check_wrong_type_combined
  simp_alive_peephole
  sorry

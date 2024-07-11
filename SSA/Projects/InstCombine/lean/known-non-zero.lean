import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  known-non-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    %4 = llvm.trunc %3 : i64 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    %4 = llvm.trunc %3 : i64 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: vector<8xi64>) -> vector<8xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %1 : vector<8xi64>
    %4 = llvm.bitcast %3 : vector<8xi1> to i8
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.cond_br %5, ^bb2(%1 : vector<8xi64>), ^bb1
  ^bb1:  // pred: ^bb0
    %6 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<8xi64>) -> vector<8xi64>]

    llvm.br ^bb2(%6 : vector<8xi64>)
  ^bb2(%7: vector<8xi64>):  // 2 preds: ^bb0, ^bb1
    llvm.return %7 : vector<8xi64>
  }]

def D60846_miscompile_before := [llvmfunc|
  llvm.func @D60846_miscompile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(2 : i16) : i16
    llvm.br ^bb1(%0 : i16)
  ^bb1(%3: i16):  // 2 preds: ^bb0, ^bb3
    %4 = llvm.icmp "eq" %3, %0 : i16
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.icmp "eq" %3, %1 : i16
    llvm.store %5, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %6 = llvm.add %3, %1  : i16
    %7 = llvm.icmp "ult" %6, %2 : i16
    llvm.cond_br %7, ^bb1(%6 : i16), ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return
  }]

def test_sgt_zero_before := [llvmfunc|
  llvm.func @test_sgt_zero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

def test_slt_neg_ten_before := [llvmfunc|
  llvm.func @test_slt_neg_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-10 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

def test_slt_ten_before := [llvmfunc|
  llvm.func @test_slt_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

def test_ugt_unknown_before := [llvmfunc|
  llvm.func @test_ugt_unknown(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %2 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }]

def test_sle_zero_before := [llvmfunc|
  llvm.func @test_sle_zero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "sle" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

def test_sge_neg_ten_before := [llvmfunc|
  llvm.func @test_sge_neg_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-10 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

def test_sge_ten_before := [llvmfunc|
  llvm.func @test_sge_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

def test_ule_unknown_before := [llvmfunc|
  llvm.func @test_ule_unknown(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "ule" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %2 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
    %4 = llvm.trunc %3 : i64 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %4 = llvm.trunc %3 : i64 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: vector<8xi64>) -> vector<8xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg0, %1 : vector<8xi64>
    %4 = llvm.bitcast %3 : vector<8xi1> to i8
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.cond_br %5, ^bb2(%1 : vector<8xi64>), ^bb1
  ^bb1:  // pred: ^bb0
    %6 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<8xi64>) -> vector<8xi64>]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2(%6 : vector<8xi64>)
  ^bb2(%7: vector<8xi64>):  // 2 preds: ^bb0, ^bb1
    llvm.return %7 : vector<8xi64>
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def D60846_miscompile_combined := [llvmfunc|
  llvm.func @D60846_miscompile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(2 : i16) : i16
    llvm.br ^bb1(%0 : i16)
  ^bb1(%3: i16):  // 2 preds: ^bb0, ^bb3
    %4 = llvm.icmp "eq" %3, %0 : i16
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.icmp "eq" %3, %1 : i16
    llvm.store %5, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_D60846_miscompile   : D60846_miscompile_before  ⊑  D60846_miscompile_combined := by
  unfold D60846_miscompile_before D60846_miscompile_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %6 = llvm.add %3, %1  : i16
    %7 = llvm.icmp "ult" %6, %2 : i16
    llvm.cond_br %7, ^bb1(%6 : i16), ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return
  }]

theorem inst_combine_D60846_miscompile   : D60846_miscompile_before  ⊑  D60846_miscompile_combined := by
  unfold D60846_miscompile_before D60846_miscompile_combined
  simp_alive_peephole
  sorry
def test_sgt_zero_combined := [llvmfunc|
  llvm.func @test_sgt_zero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64]

theorem inst_combine_test_sgt_zero   : test_sgt_zero_before  ⊑  test_sgt_zero_combined := by
  unfold test_sgt_zero_before test_sgt_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

theorem inst_combine_test_sgt_zero   : test_sgt_zero_before  ⊑  test_sgt_zero_combined := by
  unfold test_sgt_zero_before test_sgt_zero_combined
  simp_alive_peephole
  sorry
def test_slt_neg_ten_combined := [llvmfunc|
  llvm.func @test_slt_neg_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-10 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

theorem inst_combine_test_slt_neg_ten   : test_slt_neg_ten_before  ⊑  test_slt_neg_ten_combined := by
  unfold test_slt_neg_ten_before test_slt_neg_ten_combined
  simp_alive_peephole
  sorry
def test_slt_ten_combined := [llvmfunc|
  llvm.func @test_slt_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

theorem inst_combine_test_slt_ten   : test_slt_ten_before  ⊑  test_slt_ten_combined := by
  unfold test_slt_ten_before test_slt_ten_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

theorem inst_combine_test_slt_ten   : test_slt_ten_before  ⊑  test_slt_ten_combined := by
  unfold test_slt_ten_before test_slt_ten_combined
  simp_alive_peephole
  sorry
def test_ugt_unknown_combined := [llvmfunc|
  llvm.func @test_ugt_unknown(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64]

theorem inst_combine_test_ugt_unknown   : test_ugt_unknown_before  ⊑  test_ugt_unknown_combined := by
  unfold test_ugt_unknown_before test_ugt_unknown_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }]

theorem inst_combine_test_ugt_unknown   : test_ugt_unknown_before  ⊑  test_ugt_unknown_combined := by
  unfold test_ugt_unknown_before test_ugt_unknown_combined
  simp_alive_peephole
  sorry
def test_sle_zero_combined := [llvmfunc|
  llvm.func @test_sle_zero(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64]

theorem inst_combine_test_sle_zero   : test_sle_zero_before  ⊑  test_sle_zero_combined := by
  unfold test_sle_zero_before test_sle_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

theorem inst_combine_test_sle_zero   : test_sle_zero_before  ⊑  test_sle_zero_combined := by
  unfold test_sle_zero_before test_sle_zero_combined
  simp_alive_peephole
  sorry
def test_sge_neg_ten_combined := [llvmfunc|
  llvm.func @test_sge_neg_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-11 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i64
  }]

theorem inst_combine_test_sge_neg_ten   : test_sge_neg_ten_before  ⊑  test_sge_neg_ten_combined := by
  unfold test_sge_neg_ten_before test_sge_neg_ten_combined
  simp_alive_peephole
  sorry
def test_sge_ten_combined := [llvmfunc|
  llvm.func @test_sge_ten(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64]

theorem inst_combine_test_sge_ten   : test_sge_ten_before  ⊑  test_sge_ten_combined := by
  unfold test_sge_ten_before test_sge_ten_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i64
  }]

theorem inst_combine_test_sge_ten   : test_sge_ten_before  ⊑  test_sge_ten_combined := by
  unfold test_sge_ten_before test_sge_ten_combined
  simp_alive_peephole
  sorry
def test_ule_unknown_combined := [llvmfunc|
  llvm.func @test_ule_unknown(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64]

theorem inst_combine_test_ule_unknown   : test_ule_unknown_before  ⊑  test_ule_unknown_combined := by
  unfold test_ule_unknown_before test_ule_unknown_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }]

theorem inst_combine_test_ule_unknown   : test_ule_unknown_before  ⊑  test_ule_unknown_combined := by
  unfold test_ule_unknown_before test_ule_unknown_combined
  simp_alive_peephole
  sorry

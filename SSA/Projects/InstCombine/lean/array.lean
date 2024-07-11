import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  array
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_add_res_moreoneuse_before := [llvmfunc|
  llvm.func @test_add_res_moreoneuse(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %1 : i32
  }]

def test_addop_nonsw_flag_before := [llvmfunc|
  llvm.func @test_addop_nonsw_flag(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_add_op2_not_constant_before := [llvmfunc|
  llvm.func @test_add_op2_not_constant(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_zext_nneg_before := [llvmfunc|
  llvm.func @test_zext_nneg(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_zext_missing_nneg_before := [llvmfunc|
  llvm.func @test_zext_missing_nneg(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def gep_inbounds_add_nsw_nonneg_before := [llvmfunc|
  llvm.func @gep_inbounds_add_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def gep_inbounds_add_nsw_not_nonneg1_before := [llvmfunc|
  llvm.func @gep_inbounds_add_nsw_not_nonneg1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def gep_inbounds_add_nsw_not_nonneg2_before := [llvmfunc|
  llvm.func @gep_inbounds_add_nsw_not_nonneg2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def gep_not_inbounds_add_nsw_nonneg_before := [llvmfunc|
  llvm.func @gep_not_inbounds_add_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %arg2 overflow<nsw>  : i64
    %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def gep_inbounds_add_not_nsw_nonneg_before := [llvmfunc|
  llvm.func @gep_inbounds_add_not_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %arg2  : i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def gep_inbounds_sext_add_nonneg_before := [llvmfunc|
  llvm.func @gep_inbounds_sext_add_nonneg(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

def gep_inbounds_sext_add_not_nonneg_1_before := [llvmfunc|
  llvm.func @gep_inbounds_sext_add_not_nonneg_1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

def gep_inbounds_sext_add_not_nonneg_2_before := [llvmfunc|
  llvm.func @gep_inbounds_sext_add_not_nonneg_2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def gep_not_inbounds_sext_add_nonneg_before := [llvmfunc|
  llvm.func @gep_not_inbounds_sext_add_nonneg(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_add_res_moreoneuse_combined := [llvmfunc|
  llvm.func @test_add_res_moreoneuse(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %1 : i32
  }]

theorem inst_combine_test_add_res_moreoneuse   : test_add_res_moreoneuse_before  ⊑  test_add_res_moreoneuse_combined := by
  unfold test_add_res_moreoneuse_before test_add_res_moreoneuse_combined
  simp_alive_peephole
  sorry
def test_addop_nonsw_flag_combined := [llvmfunc|
  llvm.func @test_addop_nonsw_flag(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_addop_nonsw_flag   : test_addop_nonsw_flag_before  ⊑  test_addop_nonsw_flag_combined := by
  unfold test_addop_nonsw_flag_before test_addop_nonsw_flag_combined
  simp_alive_peephole
  sorry
def test_add_op2_not_constant_combined := [llvmfunc|
  llvm.func @test_add_op2_not_constant(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.add %arg1, %arg2  : i32
    %1 = llvm.sext %0 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_add_op2_not_constant   : test_add_op2_not_constant_before  ⊑  test_add_op2_not_constant_combined := by
  unfold test_add_op2_not_constant_before test_add_op2_not_constant_combined
  simp_alive_peephole
  sorry
def test_zext_nneg_combined := [llvmfunc|
  llvm.func @test_zext_nneg(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_zext_nneg   : test_zext_nneg_before  ⊑  test_zext_nneg_combined := by
  unfold test_zext_nneg_before test_zext_nneg_combined
  simp_alive_peephole
  sorry
def test_zext_missing_nneg_combined := [llvmfunc|
  llvm.func @test_zext_missing_nneg(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_zext_missing_nneg   : test_zext_missing_nneg_before  ⊑  test_zext_missing_nneg_combined := by
  unfold test_zext_missing_nneg_before test_zext_missing_nneg_combined
  simp_alive_peephole
  sorry
def gep_inbounds_add_nsw_nonneg_combined := [llvmfunc|
  llvm.func @gep_inbounds_add_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_add_nsw_nonneg   : gep_inbounds_add_nsw_nonneg_before  ⊑  gep_inbounds_add_nsw_nonneg_combined := by
  unfold gep_inbounds_add_nsw_nonneg_before gep_inbounds_add_nsw_nonneg_combined
  simp_alive_peephole
  sorry
def gep_inbounds_add_nsw_not_nonneg1_combined := [llvmfunc|
  llvm.func @gep_inbounds_add_nsw_not_nonneg1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_add_nsw_not_nonneg1   : gep_inbounds_add_nsw_not_nonneg1_before  ⊑  gep_inbounds_add_nsw_not_nonneg1_combined := by
  unfold gep_inbounds_add_nsw_not_nonneg1_before gep_inbounds_add_nsw_not_nonneg1_combined
  simp_alive_peephole
  sorry
def gep_inbounds_add_nsw_not_nonneg2_combined := [llvmfunc|
  llvm.func @gep_inbounds_add_nsw_not_nonneg2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_add_nsw_not_nonneg2   : gep_inbounds_add_nsw_not_nonneg2_before  ⊑  gep_inbounds_add_nsw_not_nonneg2_combined := by
  unfold gep_inbounds_add_nsw_not_nonneg2_before gep_inbounds_add_nsw_not_nonneg2_combined
  simp_alive_peephole
  sorry
def gep_not_inbounds_add_nsw_nonneg_combined := [llvmfunc|
  llvm.func @gep_not_inbounds_add_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_gep_not_inbounds_add_nsw_nonneg   : gep_not_inbounds_add_nsw_nonneg_before  ⊑  gep_not_inbounds_add_nsw_nonneg_combined := by
  unfold gep_not_inbounds_add_nsw_nonneg_before gep_not_inbounds_add_nsw_nonneg_combined
  simp_alive_peephole
  sorry
def gep_inbounds_add_not_nsw_nonneg_combined := [llvmfunc|
  llvm.func @gep_inbounds_add_not_nsw_nonneg(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "sgt" %arg1, %0 : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg2, %0 : i64
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_add_not_nsw_nonneg   : gep_inbounds_add_not_nsw_nonneg_before  ⊑  gep_inbounds_add_not_nsw_nonneg_combined := by
  unfold gep_inbounds_add_not_nsw_nonneg_before gep_inbounds_add_not_nsw_nonneg_combined
  simp_alive_peephole
  sorry
def gep_inbounds_sext_add_nonneg_combined := [llvmfunc|
  llvm.func @gep_inbounds_sext_add_nonneg(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_sext_add_nonneg   : gep_inbounds_sext_add_nonneg_before  ⊑  gep_inbounds_sext_add_nonneg_combined := by
  unfold gep_inbounds_sext_add_nonneg_before gep_inbounds_sext_add_nonneg_combined
  simp_alive_peephole
  sorry
def gep_inbounds_sext_add_not_nonneg_1_combined := [llvmfunc|
  llvm.func @gep_inbounds_sext_add_not_nonneg_1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-10 : i64) : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_sext_add_not_nonneg_1   : gep_inbounds_sext_add_not_nonneg_1_before  ⊑  gep_inbounds_sext_add_not_nonneg_1_combined := by
  unfold gep_inbounds_sext_add_not_nonneg_1_before gep_inbounds_sext_add_not_nonneg_1_combined
  simp_alive_peephole
  sorry
def gep_inbounds_sext_add_not_nonneg_2_combined := [llvmfunc|
  llvm.func @gep_inbounds_sext_add_not_nonneg_2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_gep_inbounds_sext_add_not_nonneg_2   : gep_inbounds_sext_add_not_nonneg_2_before  ⊑  gep_inbounds_sext_add_not_nonneg_2_combined := by
  unfold gep_inbounds_sext_add_not_nonneg_2_before gep_inbounds_sext_add_not_nonneg_2_combined
  simp_alive_peephole
  sorry
def gep_not_inbounds_sext_add_nonneg_combined := [llvmfunc|
  llvm.func @gep_not_inbounds_sext_add_nonneg(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_not_inbounds_sext_add_nonneg   : gep_not_inbounds_sext_add_nonneg_before  ⊑  gep_not_inbounds_sext_add_nonneg_combined := by
  unfold gep_not_inbounds_sext_add_nonneg_before gep_not_inbounds_sext_add_nonneg_combined
  simp_alive_peephole
  sorry

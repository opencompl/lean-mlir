import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor-icmps
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_zero_before := [llvmfunc|
  llvm.func @eq_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    %2 = llvm.icmp "eq" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def ne_zero_before := [llvmfunc|
  llvm.func @ne_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def eq_ne_zero_before := [llvmfunc|
  llvm.func @eq_ne_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_zero_before := [llvmfunc|
  llvm.func @slt_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    %2 = llvm.icmp "slt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_zero_extra_uses_before := [llvmfunc|
  llvm.func @slt_zero_extra_uses(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    %2 = llvm.icmp "slt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

def sgt_zero_before := [llvmfunc|
  llvm.func @sgt_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    %2 = llvm.icmp "sgt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_minus1_before := [llvmfunc|
  llvm.func @sgt_minus1(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    %2 = llvm.icmp "sgt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_zero_sgt_minus1_before := [llvmfunc|
  llvm.func @slt_zero_sgt_minus1(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.icmp "slt" %arg0, %0 : i4
    %3 = llvm.icmp "sgt" %arg1, %1 : i4
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def sgt_minus1_slt_zero_sgt_before := [llvmfunc|
  llvm.func @sgt_minus1_slt_zero_sgt(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.icmp "sgt" %arg0, %1 : vector<2xi4>
    %5 = llvm.icmp "slt" %arg1, %3 : vector<2xi4>
    %6 = llvm.xor %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def different_type_cmp_ops_before := [llvmfunc|
  llvm.func @different_type_cmp_ops(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.icmp "ne" %arg1, %arg0 : i8
    %2 = llvm.xor %0, %1  : i1
    llvm.return %2 : i1
  }]

def xor_icmp_ptr_before := [llvmfunc|
  llvm.func @xor_icmp_ptr(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "slt" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

def xor_icmp_true_signed_before := [llvmfunc|
  llvm.func @xor_icmp_true_signed(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_true_signed_multiuse1_before := [llvmfunc|
  llvm.func @xor_icmp_true_signed_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_true_signed_multiuse2_before := [llvmfunc|
  llvm.func @xor_icmp_true_signed_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_true_signed_commuted_before := [llvmfunc|
  llvm.func @xor_icmp_true_signed_commuted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_true_unsigned_before := [llvmfunc|
  llvm.func @xor_icmp_true_unsigned(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_to_ne_before := [llvmfunc|
  llvm.func @xor_icmp_to_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_to_ne_multiuse1_before := [llvmfunc|
  llvm.func @xor_icmp_to_ne_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_to_icmp_add_before := [llvmfunc|
  llvm.func @xor_icmp_to_icmp_add(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_invalid_range_before := [llvmfunc|
  llvm.func @xor_icmp_invalid_range(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_to_ne_multiuse2_before := [llvmfunc|
  llvm.func @xor_icmp_to_ne_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_to_icmp_add_multiuse1_before := [llvmfunc|
  llvm.func @xor_icmp_to_icmp_add_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def xor_icmp_to_icmp_add_multiuse2_before := [llvmfunc|
  llvm.func @xor_icmp_to_icmp_add_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

def eq_zero_combined := [llvmfunc|
  llvm.func @eq_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    %2 = llvm.icmp "eq" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_zero   : eq_zero_before  ⊑  eq_zero_combined := by
  unfold eq_zero_before eq_zero_combined
  simp_alive_peephole
  sorry
def ne_zero_combined := [llvmfunc|
  llvm.func @ne_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_ne_zero   : ne_zero_before  ⊑  ne_zero_combined := by
  unfold ne_zero_before ne_zero_combined
  simp_alive_peephole
  sorry
def eq_ne_zero_combined := [llvmfunc|
  llvm.func @eq_ne_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_ne_zero   : eq_ne_zero_before  ⊑  eq_ne_zero_combined := by
  unfold eq_ne_zero_before eq_ne_zero_combined
  simp_alive_peephole
  sorry
def slt_zero_combined := [llvmfunc|
  llvm.func @slt_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

theorem inst_combine_slt_zero   : slt_zero_before  ⊑  slt_zero_combined := by
  unfold slt_zero_before slt_zero_combined
  simp_alive_peephole
  sorry
def slt_zero_extra_uses_combined := [llvmfunc|
  llvm.func @slt_zero_extra_uses(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    %2 = llvm.icmp "slt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_zero_extra_uses   : slt_zero_extra_uses_before  ⊑  slt_zero_extra_uses_combined := by
  unfold slt_zero_extra_uses_before slt_zero_extra_uses_combined
  simp_alive_peephole
  sorry
def sgt_zero_combined := [llvmfunc|
  llvm.func @sgt_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    %2 = llvm.icmp "sgt" %arg1, %0 : i4
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_zero   : sgt_zero_before  ⊑  sgt_zero_combined := by
  unfold sgt_zero_before sgt_zero_combined
  simp_alive_peephole
  sorry
def sgt_minus1_combined := [llvmfunc|
  llvm.func @sgt_minus1(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

theorem inst_combine_sgt_minus1   : sgt_minus1_before  ⊑  sgt_minus1_combined := by
  unfold sgt_minus1_before sgt_minus1_combined
  simp_alive_peephole
  sorry
def slt_zero_sgt_minus1_combined := [llvmfunc|
  llvm.func @slt_zero_sgt_minus1(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

theorem inst_combine_slt_zero_sgt_minus1   : slt_zero_sgt_minus1_before  ⊑  slt_zero_sgt_minus1_combined := by
  unfold slt_zero_sgt_minus1_before slt_zero_sgt_minus1_combined
  simp_alive_peephole
  sorry
def sgt_minus1_slt_zero_sgt_combined := [llvmfunc|
  llvm.func @sgt_minus1_slt_zero_sgt(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi4>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_sgt_minus1_slt_zero_sgt   : sgt_minus1_slt_zero_sgt_before  ⊑  sgt_minus1_slt_zero_sgt_combined := by
  unfold sgt_minus1_slt_zero_sgt_before sgt_minus1_slt_zero_sgt_combined
  simp_alive_peephole
  sorry
def different_type_cmp_ops_combined := [llvmfunc|
  llvm.func @different_type_cmp_ops(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i64
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_different_type_cmp_ops   : different_type_cmp_ops_before  ⊑  different_type_cmp_ops_combined := by
  unfold different_type_cmp_ops_before different_type_cmp_ops_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def xor_icmp_ptr_combined := [llvmfunc|
  llvm.func @xor_icmp_ptr(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "slt" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_icmp_ptr   : xor_icmp_ptr_before  ⊑  xor_icmp_ptr_combined := by
  unfold xor_icmp_ptr_before xor_icmp_ptr_combined
  simp_alive_peephole
  sorry
def xor_icmp_true_signed_combined := [llvmfunc|
  llvm.func @xor_icmp_true_signed(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_xor_icmp_true_signed   : xor_icmp_true_signed_before  ⊑  xor_icmp_true_signed_combined := by
  unfold xor_icmp_true_signed_before xor_icmp_true_signed_combined
  simp_alive_peephole
  sorry
def xor_icmp_true_signed_multiuse1_combined := [llvmfunc|
  llvm.func @xor_icmp_true_signed_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_icmp_true_signed_multiuse1   : xor_icmp_true_signed_multiuse1_before  ⊑  xor_icmp_true_signed_multiuse1_combined := by
  unfold xor_icmp_true_signed_multiuse1_before xor_icmp_true_signed_multiuse1_combined
  simp_alive_peephole
  sorry
def xor_icmp_true_signed_multiuse2_combined := [llvmfunc|
  llvm.func @xor_icmp_true_signed_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%4) : (i1) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_xor_icmp_true_signed_multiuse2   : xor_icmp_true_signed_multiuse2_before  ⊑  xor_icmp_true_signed_multiuse2_combined := by
  unfold xor_icmp_true_signed_multiuse2_before xor_icmp_true_signed_multiuse2_combined
  simp_alive_peephole
  sorry
def xor_icmp_true_signed_commuted_combined := [llvmfunc|
  llvm.func @xor_icmp_true_signed_commuted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_xor_icmp_true_signed_commuted   : xor_icmp_true_signed_commuted_before  ⊑  xor_icmp_true_signed_commuted_combined := by
  unfold xor_icmp_true_signed_commuted_before xor_icmp_true_signed_commuted_combined
  simp_alive_peephole
  sorry
def xor_icmp_true_unsigned_combined := [llvmfunc|
  llvm.func @xor_icmp_true_unsigned(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_xor_icmp_true_unsigned   : xor_icmp_true_unsigned_before  ⊑  xor_icmp_true_unsigned_combined := by
  unfold xor_icmp_true_unsigned_before xor_icmp_true_unsigned_combined
  simp_alive_peephole
  sorry
def xor_icmp_to_ne_combined := [llvmfunc|
  llvm.func @xor_icmp_to_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_xor_icmp_to_ne   : xor_icmp_to_ne_before  ⊑  xor_icmp_to_ne_combined := by
  unfold xor_icmp_to_ne_before xor_icmp_to_ne_combined
  simp_alive_peephole
  sorry
def xor_icmp_to_ne_multiuse1_combined := [llvmfunc|
  llvm.func @xor_icmp_to_ne_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_icmp_to_ne_multiuse1   : xor_icmp_to_ne_multiuse1_before  ⊑  xor_icmp_to_ne_multiuse1_combined := by
  unfold xor_icmp_to_ne_multiuse1_before xor_icmp_to_ne_multiuse1_combined
  simp_alive_peephole
  sorry
def xor_icmp_to_icmp_add_combined := [llvmfunc|
  llvm.func @xor_icmp_to_icmp_add(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_icmp_to_icmp_add   : xor_icmp_to_icmp_add_before  ⊑  xor_icmp_to_icmp_add_combined := by
  unfold xor_icmp_to_icmp_add_before xor_icmp_to_icmp_add_combined
  simp_alive_peephole
  sorry
def xor_icmp_invalid_range_combined := [llvmfunc|
  llvm.func @xor_icmp_invalid_range(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_xor_icmp_invalid_range   : xor_icmp_invalid_range_before  ⊑  xor_icmp_invalid_range_combined := by
  unfold xor_icmp_invalid_range_before xor_icmp_invalid_range_combined
  simp_alive_peephole
  sorry
def xor_icmp_to_ne_multiuse2_combined := [llvmfunc|
  llvm.func @xor_icmp_to_ne_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_icmp_to_ne_multiuse2   : xor_icmp_to_ne_multiuse2_before  ⊑  xor_icmp_to_ne_multiuse2_combined := by
  unfold xor_icmp_to_ne_multiuse2_before xor_icmp_to_ne_multiuse2_combined
  simp_alive_peephole
  sorry
def xor_icmp_to_icmp_add_multiuse1_combined := [llvmfunc|
  llvm.func @xor_icmp_to_icmp_add_multiuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_icmp_to_icmp_add_multiuse1   : xor_icmp_to_icmp_add_multiuse1_before  ⊑  xor_icmp_to_icmp_add_multiuse1_combined := by
  unfold xor_icmp_to_icmp_add_multiuse1_before xor_icmp_to_icmp_add_multiuse1_combined
  simp_alive_peephole
  sorry
def xor_icmp_to_icmp_add_multiuse2_combined := [llvmfunc|
  llvm.func @xor_icmp_to_icmp_add_multiuse2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_xor_icmp_to_icmp_add_multiuse2   : xor_icmp_to_icmp_add_multiuse2_before  ⊑  xor_icmp_to_icmp_add_multiuse2_combined := by
  unfold xor_icmp_to_icmp_add_multiuse2_before xor_icmp_to_icmp_add_multiuse2_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-cmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.return %2 : i1
  }]

def icmp_ne_common_op00_before := [llvmfunc|
  llvm.func @icmp_ne_common_op00(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i6
    %1 = llvm.icmp "ne" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ne_common_op01_before := [llvmfunc|
  llvm.func @icmp_ne_common_op01(%arg0: i1, %arg1: i3, %arg2: i3, %arg3: i3) -> i1 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i3
    %1 = llvm.icmp "ne" %arg3, %arg1 : i3
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ne_common_op10_before := [llvmfunc|
  llvm.func @icmp_ne_common_op10(%arg0: i1, %arg1: i4, %arg2: i4, %arg3: i4) -> i1 {
    %0 = llvm.icmp "ne" %arg2, %arg1 : i4
    %1 = llvm.icmp "ne" %arg1, %arg3 : i4
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ne_common_op11_before := [llvmfunc|
  llvm.func @icmp_ne_common_op11(%arg0: vector<3xi1>, %arg1: vector<3xi17>, %arg2: vector<3xi17>, %arg3: vector<3xi17>) -> vector<3xi1> {
    %0 = llvm.icmp "ne" %arg2, %arg1 : vector<3xi17>
    %1 = llvm.icmp "ne" %arg3, %arg1 : vector<3xi17>
    %2 = llvm.select %arg0, %0, %1 : vector<3xi1>, vector<3xi1>
    llvm.return %2 : vector<3xi1>
  }]

def icmp_eq_common_op00_before := [llvmfunc|
  llvm.func @icmp_eq_common_op00(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i1 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i5
    %1 = llvm.icmp "eq" %arg1, %arg3 : i5
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_eq_common_op01_before := [llvmfunc|
  llvm.func @icmp_eq_common_op01(%arg0: vector<5xi1>, %arg1: vector<5xi7>, %arg2: vector<5xi7>, %arg3: vector<5xi7>) -> vector<5xi1> {
    %0 = llvm.icmp "eq" %arg1, %arg2 : vector<5xi7>
    %1 = llvm.icmp "eq" %arg3, %arg1 : vector<5xi7>
    %2 = llvm.select %arg0, %0, %1 : vector<5xi1>, vector<5xi1>
    llvm.return %2 : vector<5xi1>
  }]

def icmp_eq_common_op10_before := [llvmfunc|
  llvm.func @icmp_eq_common_op10(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i32
    %1 = llvm.icmp "eq" %arg1, %arg3 : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_eq_common_op11_before := [llvmfunc|
  llvm.func @icmp_eq_common_op11(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i64
    %1 = llvm.icmp "eq" %arg3, %arg1 : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_common_one_use_1_before := [llvmfunc|
  llvm.func @icmp_common_one_use_1(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.icmp "eq" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_slt_common_before := [llvmfunc|
  llvm.func @icmp_slt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg2 : i6
    %1 = llvm.icmp "slt" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_sgt_common_before := [llvmfunc|
  llvm.func @icmp_sgt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg2 : i6
    %1 = llvm.icmp "sgt" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_sle_common_before := [llvmfunc|
  llvm.func @icmp_sle_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sle" %arg2, %arg1 : i6
    %1 = llvm.icmp "sle" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_sge_common_before := [llvmfunc|
  llvm.func @icmp_sge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sge" %arg2, %arg1 : i6
    %1 = llvm.icmp "sge" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_slt_sgt_common_before := [llvmfunc|
  llvm.func @icmp_slt_sgt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg2 : i6
    %1 = llvm.icmp "sgt" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_sle_sge_common_before := [llvmfunc|
  llvm.func @icmp_sle_sge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "sle" %arg2, %arg1 : i6
    %1 = llvm.icmp "sge" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ult_common_before := [llvmfunc|
  llvm.func @icmp_ult_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg2 : i6
    %1 = llvm.icmp "ult" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ule_common_before := [llvmfunc|
  llvm.func @icmp_ule_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ule" %arg2, %arg1 : i6
    %1 = llvm.icmp "ule" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ugt_common_before := [llvmfunc|
  llvm.func @icmp_ugt_common(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg2, %arg1 : i8
    %1 = llvm.icmp "ugt" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_uge_common_before := [llvmfunc|
  llvm.func @icmp_uge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "uge" %arg2, %arg1 : i6
    %1 = llvm.icmp "uge" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ult_ugt_common_before := [llvmfunc|
  llvm.func @icmp_ult_ugt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg2 : i6
    %1 = llvm.icmp "ugt" %arg3, %arg1 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_ule_uge_common_before := [llvmfunc|
  llvm.func @icmp_ule_uge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.icmp "ule" %arg2, %arg1 : i6
    %1 = llvm.icmp "uge" %arg1, %arg3 : i6
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_common_pred_different_before := [llvmfunc|
  llvm.func @icmp_common_pred_different(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    %1 = llvm.icmp "ne" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_common_pred_not_swap_before := [llvmfunc|
  llvm.func @icmp_common_pred_not_swap(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg1 : i8
    %1 = llvm.icmp "sle" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_common_pred_not_commute_pred_before := [llvmfunc|
  llvm.func @icmp_common_pred_not_commute_pred(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg1 : i8
    %1 = llvm.icmp "sgt" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_common_one_use_0_before := [llvmfunc|
  llvm.func @icmp_common_one_use_0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.icmp "eq" %arg3, %arg1 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def icmp_no_common_before := [llvmfunc|
  llvm.func @icmp_no_common(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "eq" %arg3, %arg1 : i8
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test_select_inverse_eq_before := [llvmfunc|
  llvm.func @test_select_inverse_eq(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test_select_inverse_signed_before := [llvmfunc|
  llvm.func @test_select_inverse_signed(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    llvm.return %4 : i1
  }]

def test_select_inverse_unsigned_before := [llvmfunc|
  llvm.func @test_select_inverse_unsigned(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(11 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.icmp "ugt" %arg0, %1 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    llvm.return %4 : i1
  }]

def test_select_inverse_eq_ptr_before := [llvmfunc|
  llvm.func @test_select_inverse_eq_ptr(%arg0: !llvm.ptr, %arg1: i1) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test_select_inverse_fail_before := [llvmfunc|
  llvm.func @test_select_inverse_fail(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test_select_inverse_vec_before := [llvmfunc|
  llvm.func @test_select_inverse_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    %4 = llvm.select %arg1, %2, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test_select_inverse_vec_fail_before := [llvmfunc|
  llvm.func @test_select_inverse_vec_fail(%arg0: vector<2xi64>, %arg1: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    %4 = llvm.select %arg1, %2, %3 : i1, vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def test_select_inverse_nonconst1_before := [llvmfunc|
  llvm.func @test_select_inverse_nonconst1(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def test_select_inverse_nonconst2_before := [llvmfunc|
  llvm.func @test_select_inverse_nonconst2(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg1, %arg0 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def test_select_inverse_nonconst3_before := [llvmfunc|
  llvm.func @test_select_inverse_nonconst3(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def test_select_inverse_nonconst4_before := [llvmfunc|
  llvm.func @test_select_inverse_nonconst4(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg2, %arg1 : i64
    %2 = llvm.select %arg3, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def icmp_ne_common_op00_combined := [llvmfunc|
  llvm.func @icmp_ne_common_op00(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "ne" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_common_op00   : icmp_ne_common_op00_before  ⊑  icmp_ne_common_op00_combined := by
  unfold icmp_ne_common_op00_before icmp_ne_common_op00_combined
  simp_alive_peephole
  sorry
def icmp_ne_common_op01_combined := [llvmfunc|
  llvm.func @icmp_ne_common_op01(%arg0: i1, %arg1: i3, %arg2: i3, %arg3: i3) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i3
    %1 = llvm.icmp "ne" %0, %arg1 : i3
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_common_op01   : icmp_ne_common_op01_before  ⊑  icmp_ne_common_op01_combined := by
  unfold icmp_ne_common_op01_before icmp_ne_common_op01_combined
  simp_alive_peephole
  sorry
def icmp_ne_common_op10_combined := [llvmfunc|
  llvm.func @icmp_ne_common_op10(%arg0: i1, %arg1: i4, %arg2: i4, %arg3: i4) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i4
    %1 = llvm.icmp "ne" %0, %arg1 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_common_op10   : icmp_ne_common_op10_before  ⊑  icmp_ne_common_op10_combined := by
  unfold icmp_ne_common_op10_before icmp_ne_common_op10_combined
  simp_alive_peephole
  sorry
def icmp_ne_common_op11_combined := [llvmfunc|
  llvm.func @icmp_ne_common_op11(%arg0: vector<3xi1>, %arg1: vector<3xi17>, %arg2: vector<3xi17>, %arg3: vector<3xi17>) -> vector<3xi1> {
    %0 = llvm.select %arg0, %arg2, %arg3 : vector<3xi1>, vector<3xi17>
    %1 = llvm.icmp "ne" %0, %arg1 : vector<3xi17>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_icmp_ne_common_op11   : icmp_ne_common_op11_before  ⊑  icmp_ne_common_op11_combined := by
  unfold icmp_ne_common_op11_before icmp_ne_common_op11_combined
  simp_alive_peephole
  sorry
def icmp_eq_common_op00_combined := [llvmfunc|
  llvm.func @icmp_eq_common_op00(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i5
    %1 = llvm.icmp "eq" %0, %arg1 : i5
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_common_op00   : icmp_eq_common_op00_before  ⊑  icmp_eq_common_op00_combined := by
  unfold icmp_eq_common_op00_before icmp_eq_common_op00_combined
  simp_alive_peephole
  sorry
def icmp_eq_common_op01_combined := [llvmfunc|
  llvm.func @icmp_eq_common_op01(%arg0: vector<5xi1>, %arg1: vector<5xi7>, %arg2: vector<5xi7>, %arg3: vector<5xi7>) -> vector<5xi1> {
    %0 = llvm.select %arg0, %arg2, %arg3 : vector<5xi1>, vector<5xi7>
    %1 = llvm.icmp "eq" %0, %arg1 : vector<5xi7>
    llvm.return %1 : vector<5xi1>
  }]

theorem inst_combine_icmp_eq_common_op01   : icmp_eq_common_op01_before  ⊑  icmp_eq_common_op01_combined := by
  unfold icmp_eq_common_op01_before icmp_eq_common_op01_combined
  simp_alive_peephole
  sorry
def icmp_eq_common_op10_combined := [llvmfunc|
  llvm.func @icmp_eq_common_op10(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i32
    %1 = llvm.icmp "eq" %0, %arg1 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_common_op10   : icmp_eq_common_op10_before  ⊑  icmp_eq_common_op10_combined := by
  unfold icmp_eq_common_op10_before icmp_eq_common_op10_combined
  simp_alive_peephole
  sorry
def icmp_eq_common_op11_combined := [llvmfunc|
  llvm.func @icmp_eq_common_op11(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i64
    %1 = llvm.icmp "eq" %0, %arg1 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_common_op11   : icmp_eq_common_op11_before  ⊑  icmp_eq_common_op11_combined := by
  unfold icmp_eq_common_op11_before icmp_eq_common_op11_combined
  simp_alive_peephole
  sorry
def icmp_common_one_use_1_combined := [llvmfunc|
  llvm.func @icmp_common_one_use_1(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_common_one_use_1   : icmp_common_one_use_1_before  ⊑  icmp_common_one_use_1_combined := by
  unfold icmp_common_one_use_1_before icmp_common_one_use_1_combined
  simp_alive_peephole
  sorry
def icmp_slt_common_combined := [llvmfunc|
  llvm.func @icmp_slt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "sgt" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_slt_common   : icmp_slt_common_before  ⊑  icmp_slt_common_combined := by
  unfold icmp_slt_common_before icmp_slt_common_combined
  simp_alive_peephole
  sorry
def icmp_sgt_common_combined := [llvmfunc|
  llvm.func @icmp_sgt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "slt" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt_common   : icmp_sgt_common_before  ⊑  icmp_sgt_common_combined := by
  unfold icmp_sgt_common_before icmp_sgt_common_combined
  simp_alive_peephole
  sorry
def icmp_sle_common_combined := [llvmfunc|
  llvm.func @icmp_sle_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "sle" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle_common   : icmp_sle_common_before  ⊑  icmp_sle_common_combined := by
  unfold icmp_sle_common_before icmp_sle_common_combined
  simp_alive_peephole
  sorry
def icmp_sge_common_combined := [llvmfunc|
  llvm.func @icmp_sge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "sge" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sge_common   : icmp_sge_common_before  ⊑  icmp_sge_common_combined := by
  unfold icmp_sge_common_before icmp_sge_common_combined
  simp_alive_peephole
  sorry
def icmp_slt_sgt_common_combined := [llvmfunc|
  llvm.func @icmp_slt_sgt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "sgt" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_slt_sgt_common   : icmp_slt_sgt_common_before  ⊑  icmp_slt_sgt_common_combined := by
  unfold icmp_slt_sgt_common_before icmp_slt_sgt_common_combined
  simp_alive_peephole
  sorry
def icmp_sle_sge_common_combined := [llvmfunc|
  llvm.func @icmp_sle_sge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "sle" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle_sge_common   : icmp_sle_sge_common_before  ⊑  icmp_sle_sge_common_combined := by
  unfold icmp_sle_sge_common_before icmp_sle_sge_common_combined
  simp_alive_peephole
  sorry
def icmp_ult_common_combined := [llvmfunc|
  llvm.func @icmp_ult_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "ugt" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_common   : icmp_ult_common_before  ⊑  icmp_ult_common_combined := by
  unfold icmp_ult_common_before icmp_ult_common_combined
  simp_alive_peephole
  sorry
def icmp_ule_common_combined := [llvmfunc|
  llvm.func @icmp_ule_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "ule" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ule_common   : icmp_ule_common_before  ⊑  icmp_ule_common_combined := by
  unfold icmp_ule_common_before icmp_ule_common_combined
  simp_alive_peephole
  sorry
def icmp_ugt_common_combined := [llvmfunc|
  llvm.func @icmp_ugt_common(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ugt_common   : icmp_ugt_common_before  ⊑  icmp_ugt_common_combined := by
  unfold icmp_ugt_common_before icmp_ugt_common_combined
  simp_alive_peephole
  sorry
def icmp_uge_common_combined := [llvmfunc|
  llvm.func @icmp_uge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "uge" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_uge_common   : icmp_uge_common_before  ⊑  icmp_uge_common_combined := by
  unfold icmp_uge_common_before icmp_uge_common_combined
  simp_alive_peephole
  sorry
def icmp_ult_ugt_common_combined := [llvmfunc|
  llvm.func @icmp_ult_ugt_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "ugt" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_ugt_common   : icmp_ult_ugt_common_before  ⊑  icmp_ult_ugt_common_combined := by
  unfold icmp_ult_ugt_common_before icmp_ult_ugt_common_combined
  simp_alive_peephole
  sorry
def icmp_ule_uge_common_combined := [llvmfunc|
  llvm.func @icmp_ule_uge_common(%arg0: i1, %arg1: i6, %arg2: i6, %arg3: i6) -> i1 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i6
    %1 = llvm.icmp "ule" %0, %arg1 : i6
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ule_uge_common   : icmp_ule_uge_common_before  ⊑  icmp_ule_uge_common_combined := by
  unfold icmp_ule_uge_common_before icmp_ule_uge_common_combined
  simp_alive_peephole
  sorry
def icmp_common_pred_different_combined := [llvmfunc|
  llvm.func @icmp_common_pred_different(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    %1 = llvm.icmp "ne" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_common_pred_different   : icmp_common_pred_different_before  ⊑  icmp_common_pred_different_combined := by
  unfold icmp_common_pred_different_before icmp_common_pred_different_combined
  simp_alive_peephole
  sorry
def icmp_common_pred_not_swap_combined := [llvmfunc|
  llvm.func @icmp_common_pred_not_swap(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg1 : i8
    %1 = llvm.icmp "sle" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_common_pred_not_swap   : icmp_common_pred_not_swap_before  ⊑  icmp_common_pred_not_swap_combined := by
  unfold icmp_common_pred_not_swap_before icmp_common_pred_not_swap_combined
  simp_alive_peephole
  sorry
def icmp_common_pred_not_commute_pred_combined := [llvmfunc|
  llvm.func @icmp_common_pred_not_commute_pred(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg2, %arg1 : i8
    %1 = llvm.icmp "sgt" %arg3, %arg1 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_common_pred_not_commute_pred   : icmp_common_pred_not_commute_pred_before  ⊑  icmp_common_pred_not_commute_pred_combined := by
  unfold icmp_common_pred_not_commute_pred_before icmp_common_pred_not_commute_pred_combined
  simp_alive_peephole
  sorry
def icmp_common_one_use_0_combined := [llvmfunc|
  llvm.func @icmp_common_one_use_0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg1 : i8
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.icmp "eq" %arg3, %arg1 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_common_one_use_0   : icmp_common_one_use_0_before  ⊑  icmp_common_one_use_0_combined := by
  unfold icmp_common_one_use_0_before icmp_common_one_use_0_combined
  simp_alive_peephole
  sorry
def icmp_no_common_combined := [llvmfunc|
  llvm.func @icmp_no_common(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "eq" %arg3, %arg1 : i8
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_no_common   : icmp_no_common_before  ⊑  icmp_no_common_combined := by
  unfold icmp_no_common_before icmp_no_common_combined
  simp_alive_peephole
  sorry
def test_select_inverse_eq_combined := [llvmfunc|
  llvm.func @test_select_inverse_eq(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_select_inverse_eq   : test_select_inverse_eq_before  ⊑  test_select_inverse_eq_combined := by
  unfold test_select_inverse_eq_before test_select_inverse_eq_combined
  simp_alive_peephole
  sorry
def test_select_inverse_signed_combined := [llvmfunc|
  llvm.func @test_select_inverse_signed(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.icmp "slt" %arg0, %1 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_select_inverse_signed   : test_select_inverse_signed_before  ⊑  test_select_inverse_signed_combined := by
  unfold test_select_inverse_signed_before test_select_inverse_signed_combined
  simp_alive_peephole
  sorry
def test_select_inverse_unsigned_combined := [llvmfunc|
  llvm.func @test_select_inverse_unsigned(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(11 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.icmp "ugt" %arg0, %1 : i64
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_select_inverse_unsigned   : test_select_inverse_unsigned_before  ⊑  test_select_inverse_unsigned_combined := by
  unfold test_select_inverse_unsigned_before test_select_inverse_unsigned_combined
  simp_alive_peephole
  sorry
def test_select_inverse_eq_ptr_combined := [llvmfunc|
  llvm.func @test_select_inverse_eq_ptr(%arg0: !llvm.ptr, %arg1: i1) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_select_inverse_eq_ptr   : test_select_inverse_eq_ptr_before  ⊑  test_select_inverse_eq_ptr_combined := by
  unfold test_select_inverse_eq_ptr_before test_select_inverse_eq_ptr_combined
  simp_alive_peephole
  sorry
def test_select_inverse_fail_combined := [llvmfunc|
  llvm.func @test_select_inverse_fail(%arg0: i64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_test_select_inverse_fail   : test_select_inverse_fail_before  ⊑  test_select_inverse_fail_combined := by
  unfold test_select_inverse_fail_before test_select_inverse_fail_combined
  simp_alive_peephole
  sorry
def test_select_inverse_vec_combined := [llvmfunc|
  llvm.func @test_select_inverse_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    %4 = llvm.select %arg1, %2, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test_select_inverse_vec   : test_select_inverse_vec_before  ⊑  test_select_inverse_vec_combined := by
  unfold test_select_inverse_vec_before test_select_inverse_vec_combined
  simp_alive_peephole
  sorry
def test_select_inverse_vec_fail_combined := [llvmfunc|
  llvm.func @test_select_inverse_vec_fail(%arg0: vector<2xi64>, %arg1: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    %4 = llvm.select %arg1, %2, %3 : i1, vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test_select_inverse_vec_fail   : test_select_inverse_vec_fail_before  ⊑  test_select_inverse_vec_fail_combined := by
  unfold test_select_inverse_vec_fail_before test_select_inverse_vec_fail_combined
  simp_alive_peephole
  sorry
def test_select_inverse_nonconst1_combined := [llvmfunc|
  llvm.func @test_select_inverse_nonconst1(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_select_inverse_nonconst1   : test_select_inverse_nonconst1_before  ⊑  test_select_inverse_nonconst1_combined := by
  unfold test_select_inverse_nonconst1_before test_select_inverse_nonconst1_combined
  simp_alive_peephole
  sorry
def test_select_inverse_nonconst2_combined := [llvmfunc|
  llvm.func @test_select_inverse_nonconst2(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg1, %arg0 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_select_inverse_nonconst2   : test_select_inverse_nonconst2_before  ⊑  test_select_inverse_nonconst2_combined := by
  unfold test_select_inverse_nonconst2_before test_select_inverse_nonconst2_combined
  simp_alive_peephole
  sorry
def test_select_inverse_nonconst3_combined := [llvmfunc|
  llvm.func @test_select_inverse_nonconst3(%arg0: i64, %arg1: i64, %arg2: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg0, %arg1 : i64
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_select_inverse_nonconst3   : test_select_inverse_nonconst3_before  ⊑  test_select_inverse_nonconst3_combined := by
  unfold test_select_inverse_nonconst3_before test_select_inverse_nonconst3_combined
  simp_alive_peephole
  sorry
def test_select_inverse_nonconst4_combined := [llvmfunc|
  llvm.func @test_select_inverse_nonconst4(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.icmp "uge" %arg2, %arg1 : i64
    %2 = llvm.select %arg3, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_select_inverse_nonconst4   : test_select_inverse_nonconst4_before  ⊑  test_select_inverse_nonconst4_combined := by
  unfold test_select_inverse_nonconst4_before test_select_inverse_nonconst4_combined
  simp_alive_peephole
  sorry

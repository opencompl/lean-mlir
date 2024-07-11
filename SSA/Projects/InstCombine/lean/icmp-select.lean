import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_select_const_before := [llvmfunc|
  llvm.func @icmp_select_const(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    llvm.return %3 : i1
  }]

def icmp_select_var_before := [llvmfunc|
  llvm.func @icmp_select_var(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

def icmp_select_var_commuted_before := [llvmfunc|
  llvm.func @icmp_select_var_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.udiv %0, %arg2  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %arg1 : i1, i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def icmp_select_var_select_before := [llvmfunc|
  llvm.func @icmp_select_var_select(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.select %arg2, %arg0, %arg1 : i1, i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "eq" %1, %3 : i8
    llvm.return %4 : i1
  }]

def icmp_select_var_both_fold_before := [llvmfunc|
  llvm.func @icmp_select_var_both_fold(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.or %arg2, %0  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

def icmp_select_var_extra_use_before := [llvmfunc|
  llvm.func @icmp_select_var_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

def icmp_select_var_both_fold_extra_use_before := [llvmfunc|
  llvm.func @icmp_select_var_both_fold_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.or %arg2, %0  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

def icmp_select_var_pred_ne_before := [llvmfunc|
  llvm.func @icmp_select_var_pred_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

def icmp_select_var_pred_ult_before := [llvmfunc|
  llvm.func @icmp_select_var_pred_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

def icmp_select_var_pred_uge_before := [llvmfunc|
  llvm.func @icmp_select_var_pred_uge(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    %5 = llvm.icmp "uge" %4, %2 : i8
    llvm.return %5 : i1
  }]

def icmp_select_var_pred_uge_commuted_before := [llvmfunc|
  llvm.func @icmp_select_var_pred_uge_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    %5 = llvm.icmp "uge" %2, %4 : i8
    llvm.return %5 : i1
  }]

def icmp_select_implied_cond_before := [llvmfunc|
  llvm.func @icmp_select_implied_cond(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_select_implied_cond_ne_before := [llvmfunc|
  llvm.func @icmp_select_implied_cond_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_select_implied_cond_swapped_select_before := [llvmfunc|
  llvm.func @icmp_select_implied_cond_swapped_select(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg1, %0 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_select_implied_cond_swapped_select_with_inv_cond_before := [llvmfunc|
  llvm.func @icmp_select_implied_cond_swapped_select_with_inv_cond(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %0 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_select_implied_cond_relational_before := [llvmfunc|
  llvm.func @icmp_select_implied_cond_relational(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_select_implied_cond_relational_off_by_one_before := [llvmfunc|
  llvm.func @icmp_select_implied_cond_relational_off_by_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def umin_seq_comparison_before := [llvmfunc|
  llvm.func @umin_seq_comparison(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %0, %1 : i1, i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def select_constants_and_icmp_eq0_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_eq0_uses_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_eq0_vec_splat_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_vec_splat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i9) : i9
    %1 = llvm.mlir.constant(dense<3> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(48 : i9) : i9
    %3 = llvm.mlir.constant(dense<48> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.mlir.constant(0 : i9) : i9
    %5 = llvm.mlir.constant(dense<0> : vector<2xi9>) : vector<2xi9>
    %6 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi9>
    %7 = llvm.select %arg1, %1, %3 : vector<2xi1>, vector<2xi9>
    %8 = llvm.and %6, %7  : vector<2xi9>
    %9 = llvm.icmp "eq" %8, %5 : vector<2xi9>
    llvm.return %9 : vector<2xi1>
  }]

def select_constants_and_icmp_eq0_common_bit_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_common_bit(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_eq0_no_common_op1_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_no_common_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(24 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %2, %1 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "eq" %6, %3 : i8
    llvm.return %7 : i1
  }]

def select_constants_and_icmp_eq0_no_common_op2_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_no_common_op2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %0, %2 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "eq" %6, %3 : i8
    llvm.return %7 : i1
  }]

def select_constants_and_icmp_eq0_zero_tval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_zero_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_eq0_zero_fval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_zero_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_eq_tval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_eq_fval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_ne0_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_ne0_uses_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_ne0_all_uses_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_all_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_ne0_vec_splat_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_vec_splat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i9) : i9
    %1 = llvm.mlir.constant(dense<3> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(48 : i9) : i9
    %3 = llvm.mlir.constant(dense<48> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.mlir.constant(0 : i9) : i9
    %5 = llvm.mlir.constant(dense<0> : vector<2xi9>) : vector<2xi9>
    %6 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi9>
    %7 = llvm.select %arg1, %1, %3 : vector<2xi1>, vector<2xi9>
    %8 = llvm.and %6, %7  : vector<2xi9>
    %9 = llvm.icmp "ne" %8, %5 : vector<2xi9>
    llvm.return %9 : vector<2xi1>
  }]

def select_constants_and_icmp_ne0_common_bit_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_common_bit(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def select_constants_and_icmp_ne0_no_common_op1_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_no_common_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(24 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %2, %1 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }]

def select_constants_and_icmp_ne0_no_common_op2_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_no_common_op2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %0, %2 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }]

def select_constants_and_icmp_ne0_zero_tval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_zero_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_ne0_zero_fval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_zero_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_ne_tval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }]

def select_constants_and_icmp_ne_fval_before := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }]

def icmp_eq_select_before := [llvmfunc|
  llvm.func @icmp_eq_select(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def icmp_slt_select_before := [llvmfunc|
  llvm.func @icmp_slt_select(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def icmp_select_const_combined := [llvmfunc|
  llvm.func @icmp_select_const(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_const   : icmp_select_const_before  ⊑  icmp_select_const_combined := by
  unfold icmp_select_const_before icmp_select_const_combined
  simp_alive_peephole
  sorry
def icmp_select_var_combined := [llvmfunc|
  llvm.func @icmp_select_var(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %arg2 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_var   : icmp_select_var_before  ⊑  icmp_select_var_combined := by
  unfold icmp_select_var_before icmp_select_var_combined
  simp_alive_peephole
  sorry
def icmp_select_var_commuted_combined := [llvmfunc|
  llvm.func @icmp_select_var_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.udiv %0, %arg2  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.icmp "eq" %3, %arg1 : i8
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_select_var_commuted   : icmp_select_var_commuted_before  ⊑  icmp_select_var_commuted_combined := by
  unfold icmp_select_var_commuted_before icmp_select_var_commuted_combined
  simp_alive_peephole
  sorry
def icmp_select_var_select_combined := [llvmfunc|
  llvm.func @icmp_select_var_select(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i8
    %4 = llvm.xor %arg2, %1  : i1
    %5 = llvm.select %2, %1, %4 : i1, i1
    %6 = llvm.select %5, %1, %3 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_select_var_select   : icmp_select_var_select_before  ⊑  icmp_select_var_select_combined := by
  unfold icmp_select_var_select_before icmp_select_var_select_combined
  simp_alive_peephole
  sorry
def icmp_select_var_both_fold_combined := [llvmfunc|
  llvm.func @icmp_select_var_both_fold(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_select_var_both_fold   : icmp_select_var_both_fold_before  ⊑  icmp_select_var_both_fold_combined := by
  unfold icmp_select_var_both_fold_before icmp_select_var_both_fold_combined
  simp_alive_peephole
  sorry
def icmp_select_var_extra_use_combined := [llvmfunc|
  llvm.func @icmp_select_var_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_select_var_extra_use   : icmp_select_var_extra_use_before  ⊑  icmp_select_var_extra_use_combined := by
  unfold icmp_select_var_extra_use_before icmp_select_var_extra_use_combined
  simp_alive_peephole
  sorry
def icmp_select_var_both_fold_extra_use_combined := [llvmfunc|
  llvm.func @icmp_select_var_both_fold_extra_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.or %arg2, %0  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_var_both_fold_extra_use   : icmp_select_var_both_fold_extra_use_before  ⊑  icmp_select_var_both_fold_extra_use_combined := by
  unfold icmp_select_var_both_fold_extra_use_before icmp_select_var_both_fold_extra_use_combined
  simp_alive_peephole
  sorry
def icmp_select_var_pred_ne_combined := [llvmfunc|
  llvm.func @icmp_select_var_pred_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg1, %arg2 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_var_pred_ne   : icmp_select_var_pred_ne_before  ⊑  icmp_select_var_pred_ne_combined := by
  unfold icmp_select_var_pred_ne_before icmp_select_var_pred_ne_combined
  simp_alive_peephole
  sorry
def icmp_select_var_pred_ult_combined := [llvmfunc|
  llvm.func @icmp_select_var_pred_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.icmp "ugt" %3, %arg1 : i8
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_select_var_pred_ult   : icmp_select_var_pred_ult_before  ⊑  icmp_select_var_pred_ult_combined := by
  unfold icmp_select_var_pred_ult_before icmp_select_var_pred_ult_combined
  simp_alive_peephole
  sorry
def icmp_select_var_pred_uge_combined := [llvmfunc|
  llvm.func @icmp_select_var_pred_uge(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %4 = llvm.icmp "ne" %arg0, %1 : i8
    %5 = llvm.icmp "ule" %3, %arg1 : i8
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_select_var_pred_uge   : icmp_select_var_pred_uge_before  ⊑  icmp_select_var_pred_uge_combined := by
  unfold icmp_select_var_pred_uge_before icmp_select_var_pred_uge_combined
  simp_alive_peephole
  sorry
def icmp_select_var_pred_uge_commuted_combined := [llvmfunc|
  llvm.func @icmp_select_var_pred_uge_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.add %arg2, %0 overflow<nuw>  : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.icmp "uge" %3, %arg1 : i8
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_select_var_pred_uge_commuted   : icmp_select_var_pred_uge_commuted_before  ⊑  icmp_select_var_pred_uge_commuted_combined := by
  unfold icmp_select_var_pred_uge_commuted_before icmp_select_var_pred_uge_commuted_combined
  simp_alive_peephole
  sorry
def icmp_select_implied_cond_combined := [llvmfunc|
  llvm.func @icmp_select_implied_cond(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_implied_cond   : icmp_select_implied_cond_before  ⊑  icmp_select_implied_cond_combined := by
  unfold icmp_select_implied_cond_before icmp_select_implied_cond_combined
  simp_alive_peephole
  sorry
def icmp_select_implied_cond_ne_combined := [llvmfunc|
  llvm.func @icmp_select_implied_cond_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg1, %arg0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_implied_cond_ne   : icmp_select_implied_cond_ne_before  ⊑  icmp_select_implied_cond_ne_combined := by
  unfold icmp_select_implied_cond_ne_before icmp_select_implied_cond_ne_combined
  simp_alive_peephole
  sorry
def icmp_select_implied_cond_swapped_select_combined := [llvmfunc|
  llvm.func @icmp_select_implied_cond_swapped_select(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_implied_cond_swapped_select   : icmp_select_implied_cond_swapped_select_before  ⊑  icmp_select_implied_cond_swapped_select_combined := by
  unfold icmp_select_implied_cond_swapped_select_before icmp_select_implied_cond_swapped_select_combined
  simp_alive_peephole
  sorry
def icmp_select_implied_cond_swapped_select_with_inv_cond_combined := [llvmfunc|
  llvm.func @icmp_select_implied_cond_swapped_select_with_inv_cond(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %arg1, %arg0 : i8
    %4 = llvm.xor %2, %1  : i1
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_icmp_select_implied_cond_swapped_select_with_inv_cond   : icmp_select_implied_cond_swapped_select_with_inv_cond_before  ⊑  icmp_select_implied_cond_swapped_select_with_inv_cond_combined := by
  unfold icmp_select_implied_cond_swapped_select_with_inv_cond_before icmp_select_implied_cond_swapped_select_with_inv_cond_combined
  simp_alive_peephole
  sorry
def icmp_select_implied_cond_relational_combined := [llvmfunc|
  llvm.func @icmp_select_implied_cond_relational(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_implied_cond_relational   : icmp_select_implied_cond_relational_before  ⊑  icmp_select_implied_cond_relational_combined := by
  unfold icmp_select_implied_cond_relational_before icmp_select_implied_cond_relational_combined
  simp_alive_peephole
  sorry
def icmp_select_implied_cond_relational_off_by_one_combined := [llvmfunc|
  llvm.func @icmp_select_implied_cond_relational_off_by_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_select_implied_cond_relational_off_by_one   : icmp_select_implied_cond_relational_off_by_one_before  ⊑  icmp_select_implied_cond_relational_off_by_one_combined := by
  unfold icmp_select_implied_cond_relational_off_by_one_before icmp_select_implied_cond_relational_off_by_one_combined
  simp_alive_peephole
  sorry
def umin_seq_comparison_combined := [llvmfunc|
  llvm.func @umin_seq_comparison(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_umin_seq_comparison   : umin_seq_comparison_before  ⊑  umin_seq_comparison_combined := by
  unfold umin_seq_comparison_before umin_seq_comparison_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0   : select_constants_and_icmp_eq0_before  ⊑  select_constants_and_icmp_eq0_combined := by
  unfold select_constants_and_icmp_eq0_before select_constants_and_icmp_eq0_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_uses_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.and %2, %3  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.xor %arg0, %arg1  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0_uses   : select_constants_and_icmp_eq0_uses_before  ⊑  select_constants_and_icmp_eq0_uses_combined := by
  unfold select_constants_and_icmp_eq0_uses_before select_constants_and_icmp_eq0_uses_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_vec_splat_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_vec_splat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_select_constants_and_icmp_eq0_vec_splat   : select_constants_and_icmp_eq0_vec_splat_before  ⊑  select_constants_and_icmp_eq0_vec_splat_combined := by
  unfold select_constants_and_icmp_eq0_vec_splat_before select_constants_and_icmp_eq0_vec_splat_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_common_bit_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_common_bit(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0_common_bit   : select_constants_and_icmp_eq0_common_bit_before  ⊑  select_constants_and_icmp_eq0_common_bit_combined := by
  unfold select_constants_and_icmp_eq0_common_bit_before select_constants_and_icmp_eq0_common_bit_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_no_common_op1_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_no_common_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(24 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %2, %1 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "eq" %6, %3 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0_no_common_op1   : select_constants_and_icmp_eq0_no_common_op1_before  ⊑  select_constants_and_icmp_eq0_no_common_op1_combined := by
  unfold select_constants_and_icmp_eq0_no_common_op1_before select_constants_and_icmp_eq0_no_common_op1_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_no_common_op2_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_no_common_op2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %0, %2 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "eq" %6, %3 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0_no_common_op2   : select_constants_and_icmp_eq0_no_common_op2_before  ⊑  select_constants_and_icmp_eq0_no_common_op2_combined := by
  unfold select_constants_and_icmp_eq0_no_common_op2_before select_constants_and_icmp_eq0_no_common_op2_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_zero_tval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_zero_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0_zero_tval   : select_constants_and_icmp_eq0_zero_tval_before  ⊑  select_constants_and_icmp_eq0_zero_tval_combined := by
  unfold select_constants_and_icmp_eq0_zero_tval_before select_constants_and_icmp_eq0_zero_tval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq0_zero_fval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq0_zero_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq0_zero_fval   : select_constants_and_icmp_eq0_zero_fval_before  ⊑  select_constants_and_icmp_eq0_zero_fval_combined := by
  unfold select_constants_and_icmp_eq0_zero_fval_before select_constants_and_icmp_eq0_zero_fval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq_tval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq_tval   : select_constants_and_icmp_eq_tval_before  ⊑  select_constants_and_icmp_eq_tval_combined := by
  unfold select_constants_and_icmp_eq_tval_before select_constants_and_icmp_eq_tval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_eq_fval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_eq_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_select_constants_and_icmp_eq_fval   : select_constants_and_icmp_eq_fval_before  ⊑  select_constants_and_icmp_eq_fval_combined := by
  unfold select_constants_and_icmp_eq_fval_before select_constants_and_icmp_eq_fval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0   : select_constants_and_icmp_ne0_before  ⊑  select_constants_and_icmp_ne0_combined := by
  unfold select_constants_and_icmp_ne0_before select_constants_and_icmp_ne0_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_uses_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.xor %arg0, %arg1  : i1
    %6 = llvm.xor %5, %2  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_uses   : select_constants_and_icmp_ne0_uses_before  ⊑  select_constants_and_icmp_ne0_uses_combined := by
  unfold select_constants_and_icmp_ne0_uses_before select_constants_and_icmp_ne0_uses_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_all_uses_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_all_uses(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_all_uses   : select_constants_and_icmp_ne0_all_uses_before  ⊑  select_constants_and_icmp_ne0_all_uses_combined := by
  unfold select_constants_and_icmp_ne0_all_uses_before select_constants_and_icmp_ne0_all_uses_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_vec_splat_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_vec_splat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_select_constants_and_icmp_ne0_vec_splat   : select_constants_and_icmp_ne0_vec_splat_before  ⊑  select_constants_and_icmp_ne0_vec_splat_combined := by
  unfold select_constants_and_icmp_ne0_vec_splat_before select_constants_and_icmp_ne0_vec_splat_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_common_bit_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_common_bit(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_common_bit   : select_constants_and_icmp_ne0_common_bit_before  ⊑  select_constants_and_icmp_ne0_common_bit_combined := by
  unfold select_constants_and_icmp_ne0_common_bit_before select_constants_and_icmp_ne0_common_bit_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_no_common_op1_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_no_common_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(24 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %2, %1 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_no_common_op1   : select_constants_and_icmp_ne0_no_common_op1_before  ⊑  select_constants_and_icmp_ne0_no_common_op1_combined := by
  unfold select_constants_and_icmp_ne0_no_common_op1_before select_constants_and_icmp_ne0_no_common_op1_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_no_common_op2_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_no_common_op2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg1, %0, %2 : i1, i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_no_common_op2   : select_constants_and_icmp_ne0_no_common_op2_before  ⊑  select_constants_and_icmp_ne0_no_common_op2_combined := by
  unfold select_constants_and_icmp_ne0_no_common_op2_before select_constants_and_icmp_ne0_no_common_op2_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_zero_tval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_zero_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_zero_tval   : select_constants_and_icmp_ne0_zero_tval_before  ⊑  select_constants_and_icmp_ne0_zero_tval_combined := by
  unfold select_constants_and_icmp_ne0_zero_tval_before select_constants_and_icmp_ne0_zero_tval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne0_zero_fval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne0_zero_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne0_zero_fval   : select_constants_and_icmp_ne0_zero_fval_before  ⊑  select_constants_and_icmp_ne0_zero_fval_combined := by
  unfold select_constants_and_icmp_ne0_zero_fval_before select_constants_and_icmp_ne0_zero_fval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne_tval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne_tval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne_tval   : select_constants_and_icmp_ne_tval_before  ⊑  select_constants_and_icmp_ne_tval_combined := by
  unfold select_constants_and_icmp_ne_tval_before select_constants_and_icmp_ne_tval_combined
  simp_alive_peephole
  sorry
def select_constants_and_icmp_ne_fval_combined := [llvmfunc|
  llvm.func @select_constants_and_icmp_ne_fval(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_select_constants_and_icmp_ne_fval   : select_constants_and_icmp_ne_fval_before  ⊑  select_constants_and_icmp_ne_fval_combined := by
  unfold select_constants_and_icmp_ne_fval_before select_constants_and_icmp_ne_fval_combined
  simp_alive_peephole
  sorry
def icmp_eq_select_combined := [llvmfunc|
  llvm.func @icmp_eq_select(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_eq_select   : icmp_eq_select_before  ⊑  icmp_eq_select_combined := by
  unfold icmp_eq_select_before icmp_eq_select_combined
  simp_alive_peephole
  sorry
def icmp_slt_select_combined := [llvmfunc|
  llvm.func @icmp_slt_select(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_slt_select   : icmp_slt_select_before  ⊑  icmp_slt_select_combined := by
  unfold icmp_slt_select_before icmp_slt_select_combined
  simp_alive_peephole
  sorry

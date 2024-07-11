import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-and-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def logical_and_before := [llvmfunc|
  llvm.func @logical_and(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

def logical_or_before := [llvmfunc|
  llvm.func @logical_or(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

def logical_and_not_before := [llvmfunc|
  llvm.func @logical_and_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

def logical_or_not_before := [llvmfunc|
  llvm.func @logical_or_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

def logical_and_cond_reuse_before := [llvmfunc|
  llvm.func @logical_and_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg0 : i1, i1
    llvm.return %0 : i1
  }]

def logical_or_cond_reuse_before := [llvmfunc|
  llvm.func @logical_or_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.select %arg0, %arg0, %arg1 : i1, i1
    llvm.return %0 : i1
  }]

def logical_and_not_cond_reuse_before := [llvmfunc|
  llvm.func @logical_and_not_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %arg0, %arg1, %1 : i1, i1
    llvm.return %2 : i1
  }]

def logical_or_not_cond_reuse_before := [llvmfunc|
  llvm.func @logical_or_not_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %arg0, %1, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def logical_or_implies_before := [llvmfunc|
  llvm.func @logical_or_implies(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def logical_or_implies_folds_before := [llvmfunc|
  llvm.func @logical_or_implies_folds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def logical_and_implies_before := [llvmfunc|
  llvm.func @logical_and_implies(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def logical_and_implies_folds_before := [llvmfunc|
  llvm.func @logical_and_implies_folds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def logical_or_noundef_a_before := [llvmfunc|
  llvm.func @logical_or_noundef_a(%arg0: i1 {llvm.noundef}, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

def logical_or_noundef_b_before := [llvmfunc|
  llvm.func @logical_or_noundef_b(%arg0: i1, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

def logical_and_noundef_a_before := [llvmfunc|
  llvm.func @logical_and_noundef_a(%arg0: i1 {llvm.noundef}, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

def logical_and_noundef_b_before := [llvmfunc|
  llvm.func @logical_and_noundef_b(%arg0: i1, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

def not_not_true_before := [llvmfunc|
  llvm.func @not_not_true(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def not_not_false_before := [llvmfunc|
  llvm.func @not_not_false(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def not_true_not_before := [llvmfunc|
  llvm.func @not_true_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def not_false_not_before := [llvmfunc|
  llvm.func @not_false_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def not_not_true_use1_before := [llvmfunc|
  llvm.func @not_not_true_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def not_not_false_use1_before := [llvmfunc|
  llvm.func @not_not_false_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def not_true_not_use1_before := [llvmfunc|
  llvm.func @not_true_not_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def not_false_not_use1_before := [llvmfunc|
  llvm.func @not_false_not_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def not_not_true_use2_before := [llvmfunc|
  llvm.func @not_not_true_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def not_not_false_use2_before := [llvmfunc|
  llvm.func @not_not_false_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def not_true_not_use2_before := [llvmfunc|
  llvm.func @not_true_not_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def not_false_not_use2_before := [llvmfunc|
  llvm.func @not_false_not_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def not_not_true_use3_before := [llvmfunc|
  llvm.func @not_not_true_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def not_not_false_use3_before := [llvmfunc|
  llvm.func @not_not_false_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def not_true_not_use3_before := [llvmfunc|
  llvm.func @not_true_not_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def not_false_not_use3_before := [llvmfunc|
  llvm.func @not_false_not_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def demorgan_select_infloop1_before := [llvmfunc|
  llvm.func @demorgan_select_infloop1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.addressof @g2 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.xor %arg0, %0  : i1
    %7 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %8 = llvm.add %7, %7  : i1
    %9 = llvm.xor %8, %0  : i1
    %10 = llvm.select %6, %9, %5 : i1, i1
    llvm.return %10 : i1
  }]

def demorgan_select_infloop2_before := [llvmfunc|
  llvm.func @demorgan_select_infloop2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %4 = llvm.mlir.addressof @g2 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %6 = llvm.mlir.constant(false) : i1
    %7 = llvm.xor %arg0, %0  : i1
    %8 = llvm.icmp "eq" %3, %2 : !llvm.ptr
    %9 = llvm.icmp "eq" %5, %2 : !llvm.ptr
    %10 = llvm.add %8, %9  : i1
    %11 = llvm.xor %10, %0  : i1
    %12 = llvm.select %7, %11, %6 : i1, i1
    llvm.return %12 : i1
  }]

def and_or1_before := [llvmfunc|
  llvm.func @and_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or2_before := [llvmfunc|
  llvm.func @and_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or1_commuted_before := [llvmfunc|
  llvm.func @and_or1_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %arg2, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or2_commuted_before := [llvmfunc|
  llvm.func @and_or2_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %arg1, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or1_multiuse_before := [llvmfunc|
  llvm.func @and_or1_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or2_multiuse_before := [llvmfunc|
  llvm.func @and_or2_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or1_vec_before := [llvmfunc|
  llvm.func @and_or1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg0, %1  : vector<2xi1>
    %4 = llvm.or %3, %2  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def and_or2_vec_before := [llvmfunc|
  llvm.func @and_or2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.and %3, %arg1  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def and_or1_vec_commuted_before := [llvmfunc|
  llvm.func @and_or1_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg0, %1  : vector<2xi1>
    %4 = llvm.or %2, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def and_or2_vec_commuted_before := [llvmfunc|
  llvm.func @and_or2_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.and %arg1, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def and_or1_wrong_operand_before := [llvmfunc|
  llvm.func @and_or1_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    %3 = llvm.select %2, %arg3, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def and_or2_wrong_operand_before := [llvmfunc|
  llvm.func @and_or2_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    %3 = llvm.select %2, %arg0, %arg3 : i1, i1
    llvm.return %3 : i1
  }]

def and_or3_before := [llvmfunc|
  llvm.func @and_or3(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %arg1, %0  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def and_or3_commuted_before := [llvmfunc|
  llvm.func @and_or3_commuted(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def and_or3_not_free_to_invert_before := [llvmfunc|
  llvm.func @and_or3_not_free_to_invert(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.and %arg1, %arg2  : i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

def and_or3_multiuse_before := [llvmfunc|
  llvm.func @and_or3_multiuse(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %arg1, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def and_or3_vec_before := [llvmfunc|
  llvm.func @and_or3_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.and %arg1, %0  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def and_or3_vec_commuted_before := [llvmfunc|
  llvm.func @and_or3_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.and %0, %arg1  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def and_or3_wrong_operand_before := [llvmfunc|
  llvm.func @and_or3_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %arg1, %0  : i1
    %2 = llvm.select %1, %arg0, %arg4 : i1, i1
    llvm.return %2 : i1
  }]

def or_and1_before := [llvmfunc|
  llvm.func @or_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg2  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and2_before := [llvmfunc|
  llvm.func @or_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and1_commuted_before := [llvmfunc|
  llvm.func @or_and1_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %arg2, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and2_commuted_before := [llvmfunc|
  llvm.func @or_and2_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %arg0, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and1_multiuse_before := [llvmfunc|
  llvm.func @or_and1_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and2_multiuse_before := [llvmfunc|
  llvm.func @or_and2_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and1_vec_before := [llvmfunc|
  llvm.func @or_and1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg1, %1  : vector<2xi1>
    %4 = llvm.and %2, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def or_and2_vec_before := [llvmfunc|
  llvm.func @or_and2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.or %arg0, %3  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def or_and1_vec_commuted_before := [llvmfunc|
  llvm.func @or_and1_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %arg1, %1  : vector<2xi1>
    %4 = llvm.and %3, %2  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def or_and2_vec_commuted_before := [llvmfunc|
  llvm.func @or_and2_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.or %3, %arg0  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def or_and1_wrong_operand_before := [llvmfunc|
  llvm.func @or_and1_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %arg2, %1  : i1
    %3 = llvm.select %2, %arg0, %arg3 : i1, i1
    llvm.return %3 : i1
  }]

def or_and2_wrong_operand_before := [llvmfunc|
  llvm.func @or_and2_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %arg0, %1  : i1
    %3 = llvm.select %2, %arg3, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def pr64558_before := [llvmfunc|
  llvm.func @pr64558(%arg0: i1 {llvm.noundef}, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

def or_and3_before := [llvmfunc|
  llvm.func @or_and3(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def or_and3_commuted_before := [llvmfunc|
  llvm.func @or_and3_commuted(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %0, %arg0  : i1
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def or_and3_not_free_to_invert_before := [llvmfunc|
  llvm.func @or_and3_not_free_to_invert(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg0, %arg2  : i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

def or_and3_multiuse_before := [llvmfunc|
  llvm.func @or_and3_multiuse(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def or_and3_vec_before := [llvmfunc|
  llvm.func @or_and3_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.or %arg0, %0  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def or_and3_vec_commuted_before := [llvmfunc|
  llvm.func @or_and3_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg2, %arg3 : vector<2xi32>
    %1 = llvm.or %0, %arg0  : vector<2xi1>
    %2 = llvm.select %1, %arg0, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def or_and3_wrong_operand_before := [llvmfunc|
  llvm.func @or_and3_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg4, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

def test_or_umax_before := [llvmfunc|
  llvm.func @test_or_umax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_or_umin_before := [llvmfunc|
  llvm.func @test_or_umin(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def test_and_umax_before := [llvmfunc|
  llvm.func @test_and_umax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_and_umin_before := [llvmfunc|
  llvm.func @test_and_umin(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def test_or_umax_bitwise1_before := [llvmfunc|
  llvm.func @test_or_umax_bitwise1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %1, %2  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

def test_or_umax_bitwise2_before := [llvmfunc|
  llvm.func @test_or_umax_bitwise2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %2, %1  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

def test_and_umax_bitwise1_before := [llvmfunc|
  llvm.func @test_and_umax_bitwise1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

def test_and_umax_bitwise2_before := [llvmfunc|
  llvm.func @test_and_umax_bitwise2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.and %2, %1  : i1
    %4 = llvm.select %3, %arg0, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

def test_or_smax_before := [llvmfunc|
  llvm.func @test_or_smax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_or_abs_before := [llvmfunc|
  llvm.func @test_or_abs(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.select %arg1, %2, %3 : i1, i1
    %6 = llvm.select %5, %arg0, %4 : i1, i8
    llvm.return %6 : i8
  }]

def test_or_fmaxnum_before := [llvmfunc|
  llvm.func @test_or_fmaxnum(%arg0: f32, %arg1: f32, %arg2: i1) -> f32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

def test_or_umax_invalid_logical_before := [llvmfunc|
  llvm.func @test_or_umax_invalid_logical(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_and_umax_invalid_logical_before := [llvmfunc|
  llvm.func @test_and_umax_invalid_logical(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %1, %arg2, %0 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_or_umax_multiuse_cond_before := [llvmfunc|
  llvm.func @test_or_umax_multiuse_cond(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_or_eq_a_b_before := [llvmfunc|
  llvm.func @test_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def test_and_ne_a_b_before := [llvmfunc|
  llvm.func @test_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i8
    %1 = llvm.and %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def test_or_eq_a_b_commuted_before := [llvmfunc|
  llvm.func @test_or_eq_a_b_commuted(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.return %2 : i8
  }]

def test_and_ne_a_b_commuted_before := [llvmfunc|
  llvm.func @test_and_ne_a_b_commuted(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i8
    %1 = llvm.and %arg0, %0  : i1
    %2 = llvm.select %1, %arg2, %arg1 : i1, i8
    llvm.return %2 : i8
  }]

def test_or_eq_different_operands_before := [llvmfunc|
  llvm.func @test_or_eq_different_operands(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i8
    %1 = llvm.icmp "eq" %arg1, %arg0 : i8
    %2 = llvm.or %0, %1  : i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

def test_or_eq_a_b_multi_use_before := [llvmfunc|
  llvm.func @test_or_eq_a_b_multi_use(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def test_or_eq_a_b_vec_before := [llvmfunc|
  llvm.func @test_or_eq_a_b_vec(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "eq" %arg1, %arg2 : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi1>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def test_or_ne_a_b_before := [llvmfunc|
  llvm.func @test_or_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg1, %arg2 : i8
    %1 = llvm.or %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def test_and_ne_different_operands_fail_before := [llvmfunc|
  llvm.func @test_and_ne_different_operands_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg2 : i8
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def test_logical_or_eq_a_b_before := [llvmfunc|
  llvm.func @test_logical_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def test_logical_commuted_or_eq_a_b_before := [llvmfunc|
  llvm.func @test_logical_commuted_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def test_logical_and_ne_a_b_before := [llvmfunc|
  llvm.func @test_logical_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def test_logical_commuted_and_ne_a_b_before := [llvmfunc|
  llvm.func @test_logical_commuted_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def logical_and_combined := [llvmfunc|
  llvm.func @logical_and(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_and   : logical_and_before  ⊑  logical_and_combined := by
  unfold logical_and_before logical_and_combined
  simp_alive_peephole
  sorry
def logical_or_combined := [llvmfunc|
  llvm.func @logical_or(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_or   : logical_or_before  ⊑  logical_or_combined := by
  unfold logical_or_before logical_or_combined
  simp_alive_peephole
  sorry
def logical_and_not_combined := [llvmfunc|
  llvm.func @logical_and_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logical_and_not   : logical_and_not_before  ⊑  logical_and_not_combined := by
  unfold logical_and_not_before logical_and_not_combined
  simp_alive_peephole
  sorry
def logical_or_not_combined := [llvmfunc|
  llvm.func @logical_or_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_logical_or_not   : logical_or_not_before  ⊑  logical_or_not_combined := by
  unfold logical_or_not_before logical_or_not_combined
  simp_alive_peephole
  sorry
def logical_and_cond_reuse_combined := [llvmfunc|
  llvm.func @logical_and_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_and_cond_reuse   : logical_and_cond_reuse_before  ⊑  logical_and_cond_reuse_combined := by
  unfold logical_and_cond_reuse_before logical_and_cond_reuse_combined
  simp_alive_peephole
  sorry
def logical_or_cond_reuse_combined := [llvmfunc|
  llvm.func @logical_or_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_or_cond_reuse   : logical_or_cond_reuse_before  ⊑  logical_or_cond_reuse_combined := by
  unfold logical_or_cond_reuse_before logical_or_cond_reuse_combined
  simp_alive_peephole
  sorry
def logical_and_not_cond_reuse_combined := [llvmfunc|
  llvm.func @logical_and_not_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_logical_and_not_cond_reuse   : logical_and_not_cond_reuse_before  ⊑  logical_and_not_cond_reuse_combined := by
  unfold logical_and_not_cond_reuse_before logical_and_not_cond_reuse_combined
  simp_alive_peephole
  sorry
def logical_or_not_cond_reuse_combined := [llvmfunc|
  llvm.func @logical_or_not_cond_reuse(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logical_or_not_cond_reuse   : logical_or_not_cond_reuse_before  ⊑  logical_or_not_cond_reuse_combined := by
  unfold logical_or_not_cond_reuse_before logical_or_not_cond_reuse_combined
  simp_alive_peephole
  sorry
def logical_or_implies_combined := [llvmfunc|
  llvm.func @logical_or_implies(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_logical_or_implies   : logical_or_implies_before  ⊑  logical_or_implies_combined := by
  unfold logical_or_implies_before logical_or_implies_combined
  simp_alive_peephole
  sorry
def logical_or_implies_folds_combined := [llvmfunc|
  llvm.func @logical_or_implies_folds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_logical_or_implies_folds   : logical_or_implies_folds_before  ⊑  logical_or_implies_folds_combined := by
  unfold logical_or_implies_folds_before logical_or_implies_folds_combined
  simp_alive_peephole
  sorry
def logical_and_implies_combined := [llvmfunc|
  llvm.func @logical_and_implies(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_logical_and_implies   : logical_and_implies_before  ⊑  logical_and_implies_combined := by
  unfold logical_and_implies_before logical_and_implies_combined
  simp_alive_peephole
  sorry
def logical_and_implies_folds_combined := [llvmfunc|
  llvm.func @logical_and_implies_folds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_and_implies_folds   : logical_and_implies_folds_before  ⊑  logical_and_implies_folds_combined := by
  unfold logical_and_implies_folds_before logical_and_implies_folds_combined
  simp_alive_peephole
  sorry
def logical_or_noundef_a_combined := [llvmfunc|
  llvm.func @logical_or_noundef_a(%arg0: i1 {llvm.noundef}, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_or_noundef_a   : logical_or_noundef_a_before  ⊑  logical_or_noundef_a_combined := by
  unfold logical_or_noundef_a_before logical_or_noundef_a_combined
  simp_alive_peephole
  sorry
def logical_or_noundef_b_combined := [llvmfunc|
  llvm.func @logical_or_noundef_b(%arg0: i1, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_logical_or_noundef_b   : logical_or_noundef_b_before  ⊑  logical_or_noundef_b_combined := by
  unfold logical_or_noundef_b_before logical_or_noundef_b_combined
  simp_alive_peephole
  sorry
def logical_and_noundef_a_combined := [llvmfunc|
  llvm.func @logical_and_noundef_a(%arg0: i1 {llvm.noundef}, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_logical_and_noundef_a   : logical_and_noundef_a_before  ⊑  logical_and_noundef_a_combined := by
  unfold logical_and_noundef_a_before logical_and_noundef_a_combined
  simp_alive_peephole
  sorry
def logical_and_noundef_b_combined := [llvmfunc|
  llvm.func @logical_and_noundef_b(%arg0: i1, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_logical_and_noundef_b   : logical_and_noundef_b_before  ⊑  logical_and_noundef_b_combined := by
  unfold logical_and_noundef_b_before logical_and_noundef_b_combined
  simp_alive_peephole
  sorry
def not_not_true_combined := [llvmfunc|
  llvm.func @not_not_true(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_not_true   : not_not_true_before  ⊑  not_not_true_combined := by
  unfold not_not_true_before not_not_true_combined
  simp_alive_peephole
  sorry
def not_not_false_combined := [llvmfunc|
  llvm.func @not_not_false(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_not_false   : not_not_false_before  ⊑  not_not_false_combined := by
  unfold not_not_false_before not_not_false_combined
  simp_alive_peephole
  sorry
def not_true_not_combined := [llvmfunc|
  llvm.func @not_true_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_true_not   : not_true_not_before  ⊑  not_true_not_combined := by
  unfold not_true_not_before not_true_not_combined
  simp_alive_peephole
  sorry
def not_false_not_combined := [llvmfunc|
  llvm.func @not_false_not(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_false_not   : not_false_not_before  ⊑  not_false_not_combined := by
  unfold not_false_not_before not_false_not_combined
  simp_alive_peephole
  sorry
def not_not_true_use1_combined := [llvmfunc|
  llvm.func @not_not_true_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %arg0, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_not_true_use1   : not_not_true_use1_before  ⊑  not_not_true_use1_combined := by
  unfold not_not_true_use1_before not_not_true_use1_combined
  simp_alive_peephole
  sorry
def not_not_false_use1_combined := [llvmfunc|
  llvm.func @not_not_false_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_not_false_use1   : not_not_false_use1_before  ⊑  not_not_false_use1_combined := by
  unfold not_not_false_use1_before not_not_false_use1_combined
  simp_alive_peephole
  sorry
def not_true_not_use1_combined := [llvmfunc|
  llvm.func @not_true_not_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %arg0, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_true_not_use1   : not_true_not_use1_before  ⊑  not_true_not_use1_combined := by
  unfold not_true_not_use1_before not_true_not_use1_combined
  simp_alive_peephole
  sorry
def not_false_not_use1_combined := [llvmfunc|
  llvm.func @not_false_not_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %arg0, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_false_not_use1   : not_false_not_use1_before  ⊑  not_false_not_use1_combined := by
  unfold not_false_not_use1_before not_false_not_use1_combined
  simp_alive_peephole
  sorry
def not_not_true_use2_combined := [llvmfunc|
  llvm.func @not_not_true_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_not_true_use2   : not_not_true_use2_before  ⊑  not_not_true_use2_combined := by
  unfold not_not_true_use2_before not_not_true_use2_combined
  simp_alive_peephole
  sorry
def not_not_false_use2_combined := [llvmfunc|
  llvm.func @not_not_false_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_not_false_use2   : not_not_false_use2_before  ⊑  not_not_false_use2_combined := by
  unfold not_not_false_use2_before not_not_false_use2_combined
  simp_alive_peephole
  sorry
def not_true_not_use2_combined := [llvmfunc|
  llvm.func @not_true_not_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %arg0, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_true_not_use2   : not_true_not_use2_before  ⊑  not_true_not_use2_combined := by
  unfold not_true_not_use2_before not_true_not_use2_combined
  simp_alive_peephole
  sorry
def not_false_not_use2_combined := [llvmfunc|
  llvm.func @not_false_not_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_false_not_use2   : not_false_not_use2_before  ⊑  not_false_not_use2_combined := by
  unfold not_false_not_use2_before not_false_not_use2_combined
  simp_alive_peephole
  sorry
def not_not_true_use3_combined := [llvmfunc|
  llvm.func @not_not_true_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %arg0, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_not_true_use3   : not_not_true_use3_before  ⊑  not_not_true_use3_combined := by
  unfold not_not_true_use3_before not_not_true_use3_combined
  simp_alive_peephole
  sorry
def not_not_false_use3_combined := [llvmfunc|
  llvm.func @not_not_false_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_not_false_use3   : not_not_false_use3_before  ⊑  not_not_false_use3_combined := by
  unfold not_not_false_use3_before not_not_false_use3_combined
  simp_alive_peephole
  sorry
def not_true_not_use3_combined := [llvmfunc|
  llvm.func @not_true_not_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_true_not_use3   : not_true_not_use3_before  ⊑  not_true_not_use3_combined := by
  unfold not_true_not_use3_before not_true_not_use3_combined
  simp_alive_peephole
  sorry
def not_false_not_use3_combined := [llvmfunc|
  llvm.func @not_false_not_use3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %arg0, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_false_not_use3   : not_false_not_use3_before  ⊑  not_false_not_use3_combined := by
  unfold not_false_not_use3_before not_false_not_use3_combined
  simp_alive_peephole
  sorry
def demorgan_select_infloop1_combined := [llvmfunc|
  llvm.func @demorgan_select_infloop1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.addressof @g1 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %5 = llvm.icmp "ne" %4, %1 : !llvm.ptr
    %6 = llvm.icmp "eq" %4, %1 : !llvm.ptr
    %7 = llvm.xor %6, %5  : i1
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.xor %arg0, %0  : i1
    %10 = llvm.select %9, %7, %8 : i1, i1
    llvm.return %10 : i1
  }]

theorem inst_combine_demorgan_select_infloop1   : demorgan_select_infloop1_before  ⊑  demorgan_select_infloop1_combined := by
  unfold demorgan_select_infloop1_before demorgan_select_infloop1_combined
  simp_alive_peephole
  sorry
def demorgan_select_infloop2_combined := [llvmfunc|
  llvm.func @demorgan_select_infloop2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.addressof @g1 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %5 = llvm.icmp "ne" %4, %1 : !llvm.ptr
    %6 = llvm.mlir.constant(false) : i1
    %7 = llvm.xor %arg0, %0  : i1
    %8 = llvm.select %7, %5, %6 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_demorgan_select_infloop2   : demorgan_select_infloop2_before  ⊑  demorgan_select_infloop2_combined := by
  unfold demorgan_select_infloop2_before demorgan_select_infloop2_combined
  simp_alive_peephole
  sorry
def and_or1_combined := [llvmfunc|
  llvm.func @and_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or1   : and_or1_before  ⊑  and_or1_combined := by
  unfold and_or1_before and_or1_combined
  simp_alive_peephole
  sorry
def and_or2_combined := [llvmfunc|
  llvm.func @and_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg1, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or2   : and_or2_before  ⊑  and_or2_combined := by
  unfold and_or2_before and_or2_combined
  simp_alive_peephole
  sorry
def and_or1_commuted_combined := [llvmfunc|
  llvm.func @and_or1_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or1_commuted   : and_or1_commuted_before  ⊑  and_or1_commuted_combined := by
  unfold and_or1_commuted_before and_or1_commuted_combined
  simp_alive_peephole
  sorry
def and_or2_commuted_combined := [llvmfunc|
  llvm.func @and_or2_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg1, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or2_commuted   : and_or2_commuted_before  ⊑  and_or2_commuted_combined := by
  unfold and_or2_commuted_before and_or2_commuted_combined
  simp_alive_peephole
  sorry
def and_or1_multiuse_combined := [llvmfunc|
  llvm.func @and_or1_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or1_multiuse   : and_or1_multiuse_before  ⊑  and_or1_multiuse_combined := by
  unfold and_or1_multiuse_before and_or1_multiuse_combined
  simp_alive_peephole
  sorry
def and_or2_multiuse_combined := [llvmfunc|
  llvm.func @and_or2_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or2_multiuse   : and_or2_multiuse_before  ⊑  and_or2_multiuse_combined := by
  unfold and_or2_multiuse_before and_or2_multiuse_combined
  simp_alive_peephole
  sorry
def and_or1_vec_combined := [llvmfunc|
  llvm.func @and_or1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %1, %arg1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg0, %5, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_and_or1_vec   : and_or1_vec_before  ⊑  and_or1_vec_combined := by
  unfold and_or1_vec_before and_or1_vec_combined
  simp_alive_peephole
  sorry
def and_or2_vec_combined := [llvmfunc|
  llvm.func @and_or2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %1, %arg0 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %5, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_and_or2_vec   : and_or2_vec_before  ⊑  and_or2_vec_combined := by
  unfold and_or2_vec_before and_or2_vec_combined
  simp_alive_peephole
  sorry
def and_or1_vec_commuted_combined := [llvmfunc|
  llvm.func @and_or1_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %1, %arg1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg0, %5, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_and_or1_vec_commuted   : and_or1_vec_commuted_before  ⊑  and_or1_vec_commuted_combined := by
  unfold and_or1_vec_commuted_before and_or1_vec_commuted_combined
  simp_alive_peephole
  sorry
def and_or2_vec_commuted_combined := [llvmfunc|
  llvm.func @and_or2_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %1, %arg0 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %5, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_and_or2_vec_commuted   : and_or2_vec_commuted_before  ⊑  and_or2_vec_commuted_combined := by
  unfold and_or2_vec_commuted_before and_or2_vec_commuted_combined
  simp_alive_peephole
  sorry
def and_or1_wrong_operand_combined := [llvmfunc|
  llvm.func @and_or1_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg2  : i1
    %3 = llvm.select %2, %arg3, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or1_wrong_operand   : and_or1_wrong_operand_before  ⊑  and_or1_wrong_operand_combined := by
  unfold and_or1_wrong_operand_before and_or1_wrong_operand_combined
  simp_alive_peephole
  sorry
def and_or2_wrong_operand_combined := [llvmfunc|
  llvm.func @and_or2_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    %3 = llvm.select %2, %arg0, %arg3 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_or2_wrong_operand   : and_or2_wrong_operand_before  ⊑  and_or2_wrong_operand_combined := by
  unfold and_or2_wrong_operand_before and_or2_wrong_operand_combined
  simp_alive_peephole
  sorry
def and_or3_combined := [llvmfunc|
  llvm.func @and_or3(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i1
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_and_or3   : and_or3_before  ⊑  and_or3_combined := by
  unfold and_or3_before and_or3_combined
  simp_alive_peephole
  sorry
def and_or3_commuted_combined := [llvmfunc|
  llvm.func @and_or3_commuted(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i1
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_and_or3_commuted   : and_or3_commuted_before  ⊑  and_or3_commuted_combined := by
  unfold and_or3_commuted_before and_or3_commuted_combined
  simp_alive_peephole
  sorry
def and_or3_not_free_to_invert_combined := [llvmfunc|
  llvm.func @and_or3_not_free_to_invert(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.and %arg1, %arg2  : i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_and_or3_not_free_to_invert   : and_or3_not_free_to_invert_before  ⊑  and_or3_not_free_to_invert_combined := by
  unfold and_or3_not_free_to_invert_before and_or3_not_free_to_invert_combined
  simp_alive_peephole
  sorry
def and_or3_multiuse_combined := [llvmfunc|
  llvm.func @and_or3_multiuse(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %0, %arg1  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_and_or3_multiuse   : and_or3_multiuse_before  ⊑  and_or3_multiuse_combined := by
  unfold and_or3_multiuse_before and_or3_multiuse_combined
  simp_alive_peephole
  sorry
def and_or3_vec_combined := [llvmfunc|
  llvm.func @and_or3_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.icmp "ne" %arg2, %arg3 : vector<2xi32>
    %5 = llvm.select %4, %1, %arg0 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %5, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_and_or3_vec   : and_or3_vec_before  ⊑  and_or3_vec_combined := by
  unfold and_or3_vec_before and_or3_vec_combined
  simp_alive_peephole
  sorry
def and_or3_vec_commuted_combined := [llvmfunc|
  llvm.func @and_or3_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.icmp "ne" %arg2, %arg3 : vector<2xi32>
    %5 = llvm.select %4, %1, %arg0 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %5, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_and_or3_vec_commuted   : and_or3_vec_commuted_before  ⊑  and_or3_vec_commuted_combined := by
  unfold and_or3_vec_commuted_before and_or3_vec_commuted_combined
  simp_alive_peephole
  sorry
def and_or3_wrong_operand_combined := [llvmfunc|
  llvm.func @and_or3_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.and %0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %arg4 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_and_or3_wrong_operand   : and_or3_wrong_operand_before  ⊑  and_or3_wrong_operand_combined := by
  unfold and_or3_wrong_operand_before and_or3_wrong_operand_combined
  simp_alive_peephole
  sorry
def or_and1_combined := [llvmfunc|
  llvm.func @or_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg0, %0 : i1, i1
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and1   : or_and1_before  ⊑  or_and1_combined := by
  unfold or_and1_before or_and1_combined
  simp_alive_peephole
  sorry
def or_and2_combined := [llvmfunc|
  llvm.func @or_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and2   : or_and2_before  ⊑  or_and2_combined := by
  unfold or_and2_before or_and2_combined
  simp_alive_peephole
  sorry
def or_and1_commuted_combined := [llvmfunc|
  llvm.func @or_and1_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg0, %0 : i1, i1
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and1_commuted   : or_and1_commuted_before  ⊑  or_and1_commuted_combined := by
  unfold or_and1_commuted_before or_and1_commuted_combined
  simp_alive_peephole
  sorry
def or_and2_commuted_combined := [llvmfunc|
  llvm.func @or_and2_commuted(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and2_commuted   : or_and2_commuted_before  ⊑  or_and2_commuted_combined := by
  unfold or_and2_commuted_before or_and2_commuted_combined
  simp_alive_peephole
  sorry
def or_and1_multiuse_combined := [llvmfunc|
  llvm.func @or_and1_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg2  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and1_multiuse   : or_and1_multiuse_before  ⊑  or_and1_multiuse_combined := by
  unfold or_and1_multiuse_before or_and1_multiuse_combined
  simp_alive_peephole
  sorry
def or_and2_multiuse_combined := [llvmfunc|
  llvm.func @or_and2_multiuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and2_multiuse   : or_and2_multiuse_before  ⊑  or_and2_multiuse_combined := by
  unfold or_and2_multiuse_before or_and2_multiuse_combined
  simp_alive_peephole
  sorry
def or_and1_vec_combined := [llvmfunc|
  llvm.func @or_and1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %arg0, %1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %3, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_or_and1_vec   : or_and1_vec_before  ⊑  or_and1_vec_combined := by
  unfold or_and1_vec_before or_and1_vec_combined
  simp_alive_peephole
  sorry
def or_and2_vec_combined := [llvmfunc|
  llvm.func @or_and2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg0, %3, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_or_and2_vec   : or_and2_vec_before  ⊑  or_and2_vec_combined := by
  unfold or_and2_vec_before or_and2_vec_combined
  simp_alive_peephole
  sorry
def or_and1_vec_commuted_combined := [llvmfunc|
  llvm.func @or_and1_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %arg0, %1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %3, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_or_and1_vec_commuted   : or_and1_vec_commuted_before  ⊑  or_and1_vec_commuted_combined := by
  unfold or_and1_vec_commuted_before or_and1_vec_commuted_combined
  simp_alive_peephole
  sorry
def or_and2_vec_commuted_combined := [llvmfunc|
  llvm.func @or_and2_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.call @gen_v2i1() : () -> vector<2xi1>
    %5 = llvm.select %4, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg0, %3, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_or_and2_vec_commuted   : or_and2_vec_commuted_before  ⊑  or_and2_vec_commuted_combined := by
  unfold or_and2_vec_commuted_before or_and2_vec_commuted_combined
  simp_alive_peephole
  sorry
def or_and1_wrong_operand_combined := [llvmfunc|
  llvm.func @or_and1_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg2  : i1
    %3 = llvm.select %2, %arg0, %arg3 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and1_wrong_operand   : or_and1_wrong_operand_before  ⊑  or_and1_wrong_operand_combined := by
  unfold or_and1_wrong_operand_before or_and1_wrong_operand_combined
  simp_alive_peephole
  sorry
def or_and2_wrong_operand_combined := [llvmfunc|
  llvm.func @or_and2_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    %3 = llvm.select %2, %arg3, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_and2_wrong_operand   : or_and2_wrong_operand_before  ⊑  or_and2_wrong_operand_combined := by
  unfold or_and2_wrong_operand_before or_and2_wrong_operand_combined
  simp_alive_peephole
  sorry
def pr64558_combined := [llvmfunc|
  llvm.func @pr64558(%arg0: i1 {llvm.noundef}, %arg1: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_pr64558   : pr64558_before  ⊑  pr64558_combined := by
  unfold pr64558_before pr64558_combined
  simp_alive_peephole
  sorry
def or_and3_combined := [llvmfunc|
  llvm.func @or_and3(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %arg1, %0 : i1, i1
    %4 = llvm.select %arg0, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_or_and3   : or_and3_before  ⊑  or_and3_combined := by
  unfold or_and3_before or_and3_combined
  simp_alive_peephole
  sorry
def or_and3_commuted_combined := [llvmfunc|
  llvm.func @or_and3_commuted(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %arg1, %0 : i1, i1
    %4 = llvm.select %arg0, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_or_and3_commuted   : or_and3_commuted_before  ⊑  or_and3_commuted_combined := by
  unfold or_and3_commuted_before or_and3_commuted_combined
  simp_alive_peephole
  sorry
def or_and3_not_free_to_invert_combined := [llvmfunc|
  llvm.func @or_and3_not_free_to_invert(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg0, %arg2  : i1
    %1 = llvm.select %0, %arg0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_or_and3_not_free_to_invert   : or_and3_not_free_to_invert_before  ⊑  or_and3_not_free_to_invert_combined := by
  unfold or_and3_not_free_to_invert_before or_and3_not_free_to_invert_combined
  simp_alive_peephole
  sorry
def or_and3_multiuse_combined := [llvmfunc|
  llvm.func @or_and3_multiuse(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %0, %arg0  : i1
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_or_and3_multiuse   : or_and3_multiuse_before  ⊑  or_and3_multiuse_combined := by
  unfold or_and3_multiuse_before or_and3_multiuse_combined
  simp_alive_peephole
  sorry
def or_and3_vec_combined := [llvmfunc|
  llvm.func @or_and3_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.icmp "ne" %arg2, %arg3 : vector<2xi32>
    %5 = llvm.select %4, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg0, %3, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_or_and3_vec   : or_and3_vec_before  ⊑  or_and3_vec_combined := by
  unfold or_and3_vec_before or_and3_vec_combined
  simp_alive_peephole
  sorry
def or_and3_vec_commuted_combined := [llvmfunc|
  llvm.func @or_and3_vec_commuted(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi32>, %arg3: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.icmp "ne" %arg2, %arg3 : vector<2xi32>
    %5 = llvm.select %4, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg0, %3, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_or_and3_vec_commuted   : or_and3_vec_commuted_before  ⊑  or_and3_vec_commuted_combined := by
  unfold or_and3_vec_commuted_before or_and3_vec_commuted_combined
  simp_alive_peephole
  sorry
def or_and3_wrong_operand_combined := [llvmfunc|
  llvm.func @or_and3_wrong_operand(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "eq" %arg2, %arg3 : i32
    %1 = llvm.or %0, %arg0  : i1
    %2 = llvm.select %1, %arg4, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_or_and3_wrong_operand   : or_and3_wrong_operand_before  ⊑  or_and3_wrong_operand_combined := by
  unfold or_and3_wrong_operand_before or_and3_wrong_operand_combined
  simp_alive_peephole
  sorry
def test_or_umax_combined := [llvmfunc|
  llvm.func @test_or_umax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.select %arg2, %arg0, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_or_umax   : test_or_umax_before  ⊑  test_or_umax_combined := by
  unfold test_or_umax_before test_or_umax_combined
  simp_alive_peephole
  sorry
def test_or_umin_combined := [llvmfunc|
  llvm.func @test_or_umin(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.select %arg2, %arg1, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_or_umin   : test_or_umin_before  ⊑  test_or_umin_combined := by
  unfold test_or_umin_before test_or_umin_combined
  simp_alive_peephole
  sorry
def test_and_umax_combined := [llvmfunc|
  llvm.func @test_and_umax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.select %arg2, %0, %arg1 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_and_umax   : test_and_umax_before  ⊑  test_and_umax_combined := by
  unfold test_and_umax_before test_and_umax_combined
  simp_alive_peephole
  sorry
def test_and_umin_combined := [llvmfunc|
  llvm.func @test_and_umin(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.select %arg2, %0, %arg0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_and_umin   : test_and_umin_before  ⊑  test_and_umin_combined := by
  unfold test_and_umin_before test_and_umin_combined
  simp_alive_peephole
  sorry
def test_or_umax_bitwise1_combined := [llvmfunc|
  llvm.func @test_or_umax_bitwise1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_or_umax_bitwise1   : test_or_umax_bitwise1_before  ⊑  test_or_umax_bitwise1_combined := by
  unfold test_or_umax_bitwise1_before test_or_umax_bitwise1_combined
  simp_alive_peephole
  sorry
def test_or_umax_bitwise2_combined := [llvmfunc|
  llvm.func @test_or_umax_bitwise2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_or_umax_bitwise2   : test_or_umax_bitwise2_before  ⊑  test_or_umax_bitwise2_combined := by
  unfold test_or_umax_bitwise2_before test_or_umax_bitwise2_combined
  simp_alive_peephole
  sorry
def test_and_umax_bitwise1_combined := [llvmfunc|
  llvm.func @test_and_umax_bitwise1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.select %1, %2, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_and_umax_bitwise1   : test_and_umax_bitwise1_before  ⊑  test_and_umax_bitwise1_combined := by
  unfold test_and_umax_bitwise1_before test_and_umax_bitwise1_combined
  simp_alive_peephole
  sorry
def test_and_umax_bitwise2_combined := [llvmfunc|
  llvm.func @test_and_umax_bitwise2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg2, %0 : i8
    %2 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.select %1, %2, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_and_umax_bitwise2   : test_and_umax_bitwise2_before  ⊑  test_and_umax_bitwise2_combined := by
  unfold test_and_umax_bitwise2_before test_and_umax_bitwise2_combined
  simp_alive_peephole
  sorry
def test_or_smax_combined := [llvmfunc|
  llvm.func @test_or_smax(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.select %arg2, %arg0, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_or_smax   : test_or_smax_before  ⊑  test_or_smax_combined := by
  unfold test_or_smax_before test_or_smax_combined
  simp_alive_peephole
  sorry
def test_or_abs_combined := [llvmfunc|
  llvm.func @test_or_abs(%arg0: i8, %arg1: i1) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    %1 = llvm.select %arg1, %arg0, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_or_abs   : test_or_abs_before  ⊑  test_or_abs_combined := by
  unfold test_or_abs_before test_or_abs_combined
  simp_alive_peephole
  sorry
def test_or_fmaxnum_combined := [llvmfunc|
  llvm.func @test_or_fmaxnum(%arg0: f32, %arg1: f32, %arg2: i1) -> f32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test_or_fmaxnum   : test_or_fmaxnum_before  ⊑  test_or_fmaxnum_combined := by
  unfold test_or_fmaxnum_before test_or_fmaxnum_combined
  simp_alive_peephole
  sorry
def test_or_umax_invalid_logical_combined := [llvmfunc|
  llvm.func @test_or_umax_invalid_logical(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_or_umax_invalid_logical   : test_or_umax_invalid_logical_before  ⊑  test_or_umax_invalid_logical_combined := by
  unfold test_or_umax_invalid_logical_before test_or_umax_invalid_logical_combined
  simp_alive_peephole
  sorry
def test_and_umax_invalid_logical_combined := [llvmfunc|
  llvm.func @test_and_umax_invalid_logical(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %1, %arg2, %0 : i1, i1
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_and_umax_invalid_logical   : test_and_umax_invalid_logical_before  ⊑  test_and_umax_invalid_logical_combined := by
  unfold test_and_umax_invalid_logical_before test_and_umax_invalid_logical_combined
  simp_alive_peephole
  sorry
def test_or_umax_multiuse_cond_combined := [llvmfunc|
  llvm.func @test_or_umax_multiuse_cond(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg0, %arg1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_or_umax_multiuse_cond   : test_or_umax_multiuse_cond_before  ⊑  test_or_umax_multiuse_cond_combined := by
  unfold test_or_umax_multiuse_cond_before test_or_umax_multiuse_cond_combined
  simp_alive_peephole
  sorry
def test_or_eq_a_b_combined := [llvmfunc|
  llvm.func @test_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_or_eq_a_b   : test_or_eq_a_b_before  ⊑  test_or_eq_a_b_combined := by
  unfold test_or_eq_a_b_before test_or_eq_a_b_combined
  simp_alive_peephole
  sorry
def test_and_ne_a_b_combined := [llvmfunc|
  llvm.func @test_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_and_ne_a_b   : test_and_ne_a_b_before  ⊑  test_and_ne_a_b_combined := by
  unfold test_and_ne_a_b_before test_and_ne_a_b_combined
  simp_alive_peephole
  sorry
def test_or_eq_a_b_commuted_combined := [llvmfunc|
  llvm.func @test_or_eq_a_b_commuted(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg2, %arg1 : i1, i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_or_eq_a_b_commuted   : test_or_eq_a_b_commuted_before  ⊑  test_or_eq_a_b_commuted_combined := by
  unfold test_or_eq_a_b_commuted_before test_or_eq_a_b_commuted_combined
  simp_alive_peephole
  sorry
def test_and_ne_a_b_commuted_combined := [llvmfunc|
  llvm.func @test_and_ne_a_b_commuted(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg2, %arg1 : i1, i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_and_ne_a_b_commuted   : test_and_ne_a_b_commuted_before  ⊑  test_and_ne_a_b_commuted_combined := by
  unfold test_and_ne_a_b_commuted_before test_and_ne_a_b_commuted_combined
  simp_alive_peephole
  sorry
def test_or_eq_different_operands_combined := [llvmfunc|
  llvm.func @test_or_eq_different_operands(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i8
    %1 = llvm.select %0, %arg0, %arg1 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test_or_eq_different_operands   : test_or_eq_different_operands_before  ⊑  test_or_eq_different_operands_combined := by
  unfold test_or_eq_different_operands_before test_or_eq_different_operands_combined
  simp_alive_peephole
  sorry
def test_or_eq_a_b_multi_use_combined := [llvmfunc|
  llvm.func @test_or_eq_a_b_multi_use(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg1, %arg2 : i8
    %1 = llvm.or %0, %arg0  : i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test_or_eq_a_b_multi_use   : test_or_eq_a_b_multi_use_before  ⊑  test_or_eq_a_b_multi_use_combined := by
  unfold test_or_eq_a_b_multi_use_before test_or_eq_a_b_multi_use_combined
  simp_alive_peephole
  sorry
def test_or_eq_a_b_vec_combined := [llvmfunc|
  llvm.func @test_or_eq_a_b_vec(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.select %arg0, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_test_or_eq_a_b_vec   : test_or_eq_a_b_vec_before  ⊑  test_or_eq_a_b_vec_combined := by
  unfold test_or_eq_a_b_vec_before test_or_eq_a_b_vec_combined
  simp_alive_peephole
  sorry
def test_or_ne_a_b_combined := [llvmfunc|
  llvm.func @test_or_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    llvm.return %arg1 : i8
  }]

theorem inst_combine_test_or_ne_a_b   : test_or_ne_a_b_before  ⊑  test_or_ne_a_b_combined := by
  unfold test_or_ne_a_b_before test_or_ne_a_b_combined
  simp_alive_peephole
  sorry
def test_and_ne_different_operands_fail_combined := [llvmfunc|
  llvm.func @test_and_ne_different_operands_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg2 : i8
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.select %2, %arg1, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_and_ne_different_operands_fail   : test_and_ne_different_operands_fail_before  ⊑  test_and_ne_different_operands_fail_combined := by
  unfold test_and_ne_different_operands_fail_before test_and_ne_different_operands_fail_combined
  simp_alive_peephole
  sorry
def test_logical_or_eq_a_b_combined := [llvmfunc|
  llvm.func @test_logical_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_logical_or_eq_a_b   : test_logical_or_eq_a_b_before  ⊑  test_logical_or_eq_a_b_combined := by
  unfold test_logical_or_eq_a_b_before test_logical_or_eq_a_b_combined
  simp_alive_peephole
  sorry
def test_logical_commuted_or_eq_a_b_combined := [llvmfunc|
  llvm.func @test_logical_commuted_or_eq_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_logical_commuted_or_eq_a_b   : test_logical_commuted_or_eq_a_b_before  ⊑  test_logical_commuted_or_eq_a_b_combined := by
  unfold test_logical_commuted_or_eq_a_b_before test_logical_commuted_or_eq_a_b_combined
  simp_alive_peephole
  sorry
def test_logical_and_ne_a_b_combined := [llvmfunc|
  llvm.func @test_logical_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_logical_and_ne_a_b   : test_logical_and_ne_a_b_before  ⊑  test_logical_and_ne_a_b_combined := by
  unfold test_logical_and_ne_a_b_before test_logical_and_ne_a_b_combined
  simp_alive_peephole
  sorry
def test_logical_commuted_and_ne_a_b_combined := [llvmfunc|
  llvm.func @test_logical_commuted_and_ne_a_b(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_test_logical_commuted_and_ne_a_b   : test_logical_commuted_and_ne_a_b_before  ⊑  test_logical_commuted_and_ne_a_b_combined := by
  unfold test_logical_commuted_and_ne_a_b_before test_logical_commuted_and_ne_a_b_combined
  simp_alive_peephole
  sorry

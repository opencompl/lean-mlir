import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unrecognized_three-way-comparison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def compare_against_arbitrary_value_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_zero_before := [llvmfunc|
  llvm.func @compare_against_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_one_before := [llvmfunc|
  llvm.func @compare_against_one(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_two_before := [llvmfunc|
  llvm.func @compare_against_two(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_three_before := [llvmfunc|
  llvm.func @compare_against_three(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_four_before := [llvmfunc|
  llvm.func @compare_against_four(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_five_before := [llvmfunc|
  llvm.func @compare_against_five(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_six_before := [llvmfunc|
  llvm.func @compare_against_six(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_arbitrary_value_non_idiomatic_1_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_non_idiomatic_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.constant(425 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_zero_non_idiomatic_add_before := [llvmfunc|
  llvm.func @compare_against_zero_non_idiomatic_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.mlir.constant(425 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_arbitrary_value_non_idiomatic_2_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_non_idiomatic_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(425 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_zero_non_idiomatic_or_before := [llvmfunc|
  llvm.func @compare_against_zero_non_idiomatic_or(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.mlir.constant(425 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_arbitrary_value_type_mismatch_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_type_mismatch(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_zero_type_mismatch_idiomatic_before := [llvmfunc|
  llvm.func @compare_against_zero_type_mismatch_idiomatic(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg0, %0 : i64
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_zero_type_mismatch_non_idiomatic_1_before := [llvmfunc|
  llvm.func @compare_against_zero_type_mismatch_non_idiomatic_1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg0, %0 : i64
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_zero_type_mismatch_non_idiomatic_2_before := [llvmfunc|
  llvm.func @compare_against_zero_type_mismatch_non_idiomatic_2(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg0, %0 : i64
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_fortytwo_commutatibility_0_before := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(84 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_fortytwo_commutatibility_1_before := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(84 : i32) : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %7, %3 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def compare_against_fortytwo_commutatibility_2_before := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(84 : i32) : i32
    %6 = llvm.icmp "eq" %arg0, %0 : i32
    %7 = llvm.icmp "sgt" %arg0, %1 : i32
    %8 = llvm.select %7, %2, %3 : i1, i32
    %9 = llvm.select %6, %4, %8 : i1, i32
    %10 = llvm.icmp "sgt" %9, %4 : i32
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%9) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

def compare_against_fortytwo_commutatibility_3_before := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(84 : i32) : i32
    %6 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.icmp "sgt" %arg0, %1 : i32
    %8 = llvm.select %7, %2, %3 : i1, i32
    %9 = llvm.select %6, %8, %4 : i1, i32
    %10 = llvm.icmp "sgt" %9, %4 : i32
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%9) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

def compare_against_arbitrary_value_commutativity0_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_arbitrary_value_commutativity1_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_arbitrary_value_commutativity2_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %6, %2 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_arbitrary_value_commutativity3_before := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %6, %2 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

def compare_against_arbitrary_value_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value   : compare_against_arbitrary_value_before  ⊑  compare_against_arbitrary_value_combined := by
  unfold compare_against_arbitrary_value_before compare_against_arbitrary_value_combined
  simp_alive_peephole
  sorry
def compare_against_zero_combined := [llvmfunc|
  llvm.func @compare_against_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_zero   : compare_against_zero_before  ⊑  compare_against_zero_combined := by
  unfold compare_against_zero_before compare_against_zero_combined
  simp_alive_peephole
  sorry
def compare_against_one_combined := [llvmfunc|
  llvm.func @compare_against_one(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_one   : compare_against_one_before  ⊑  compare_against_one_combined := by
  unfold compare_against_one_before compare_against_one_combined
  simp_alive_peephole
  sorry
def compare_against_two_combined := [llvmfunc|
  llvm.func @compare_against_two(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_two   : compare_against_two_before  ⊑  compare_against_two_combined := by
  unfold compare_against_two_before compare_against_two_combined
  simp_alive_peephole
  sorry
def compare_against_three_combined := [llvmfunc|
  llvm.func @compare_against_three(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_three   : compare_against_three_before  ⊑  compare_against_three_combined := by
  unfold compare_against_three_before compare_against_three_combined
  simp_alive_peephole
  sorry
def compare_against_four_combined := [llvmfunc|
  llvm.func @compare_against_four(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_four   : compare_against_four_before  ⊑  compare_against_four_combined := by
  unfold compare_against_four_before compare_against_four_combined
  simp_alive_peephole
  sorry
def compare_against_five_combined := [llvmfunc|
  llvm.func @compare_against_five(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_five   : compare_against_five_before  ⊑  compare_against_five_combined := by
  unfold compare_against_five_before compare_against_five_combined
  simp_alive_peephole
  sorry
def compare_against_six_combined := [llvmfunc|
  llvm.func @compare_against_six(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_six   : compare_against_six_before  ⊑  compare_against_six_combined := by
  unfold compare_against_six_before compare_against_six_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_non_idiomatic_1_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_non_idiomatic_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(425 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_non_idiomatic_1   : compare_against_arbitrary_value_non_idiomatic_1_before  ⊑  compare_against_arbitrary_value_non_idiomatic_1_combined := by
  unfold compare_against_arbitrary_value_non_idiomatic_1_before compare_against_arbitrary_value_non_idiomatic_1_combined
  simp_alive_peephole
  sorry
def compare_against_zero_non_idiomatic_add_combined := [llvmfunc|
  llvm.func @compare_against_zero_non_idiomatic_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(425 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_zero_non_idiomatic_add   : compare_against_zero_non_idiomatic_add_before  ⊑  compare_against_zero_non_idiomatic_add_combined := by
  unfold compare_against_zero_non_idiomatic_add_before compare_against_zero_non_idiomatic_add_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_non_idiomatic_2_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_non_idiomatic_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(425 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_non_idiomatic_2   : compare_against_arbitrary_value_non_idiomatic_2_before  ⊑  compare_against_arbitrary_value_non_idiomatic_2_combined := by
  unfold compare_against_arbitrary_value_non_idiomatic_2_before compare_against_arbitrary_value_non_idiomatic_2_combined
  simp_alive_peephole
  sorry
def compare_against_zero_non_idiomatic_or_combined := [llvmfunc|
  llvm.func @compare_against_zero_non_idiomatic_or(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(425 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_zero_non_idiomatic_or   : compare_against_zero_non_idiomatic_or_before  ⊑  compare_against_zero_non_idiomatic_or_combined := by
  unfold compare_against_zero_non_idiomatic_or_before compare_against_zero_non_idiomatic_or_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_type_mismatch_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_type_mismatch(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_type_mismatch   : compare_against_arbitrary_value_type_mismatch_before  ⊑  compare_against_arbitrary_value_type_mismatch_combined := by
  unfold compare_against_arbitrary_value_type_mismatch_before compare_against_arbitrary_value_type_mismatch_combined
  simp_alive_peephole
  sorry
def compare_against_zero_type_mismatch_idiomatic_combined := [llvmfunc|
  llvm.func @compare_against_zero_type_mismatch_idiomatic(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_zero_type_mismatch_idiomatic   : compare_against_zero_type_mismatch_idiomatic_before  ⊑  compare_against_zero_type_mismatch_idiomatic_combined := by
  unfold compare_against_zero_type_mismatch_idiomatic_before compare_against_zero_type_mismatch_idiomatic_combined
  simp_alive_peephole
  sorry
def compare_against_zero_type_mismatch_non_idiomatic_1_combined := [llvmfunc|
  llvm.func @compare_against_zero_type_mismatch_non_idiomatic_1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_zero_type_mismatch_non_idiomatic_1   : compare_against_zero_type_mismatch_non_idiomatic_1_before  ⊑  compare_against_zero_type_mismatch_non_idiomatic_1_combined := by
  unfold compare_against_zero_type_mismatch_non_idiomatic_1_before compare_against_zero_type_mismatch_non_idiomatic_1_combined
  simp_alive_peephole
  sorry
def compare_against_zero_type_mismatch_non_idiomatic_2_combined := [llvmfunc|
  llvm.func @compare_against_zero_type_mismatch_non_idiomatic_2(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_zero_type_mismatch_non_idiomatic_2   : compare_against_zero_type_mismatch_non_idiomatic_2_before  ⊑  compare_against_zero_type_mismatch_non_idiomatic_2_combined := by
  unfold compare_against_zero_type_mismatch_non_idiomatic_2_before compare_against_zero_type_mismatch_non_idiomatic_2_combined
  simp_alive_peephole
  sorry
def compare_against_fortytwo_commutatibility_0_combined := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(84 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_fortytwo_commutatibility_0   : compare_against_fortytwo_commutatibility_0_before  ⊑  compare_against_fortytwo_commutatibility_0_combined := by
  unfold compare_against_fortytwo_commutatibility_0_before compare_against_fortytwo_commutatibility_0_combined
  simp_alive_peephole
  sorry
def compare_against_fortytwo_commutatibility_1_combined := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(84 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_fortytwo_commutatibility_1   : compare_against_fortytwo_commutatibility_1_before  ⊑  compare_against_fortytwo_commutatibility_1_combined := by
  unfold compare_against_fortytwo_commutatibility_1_before compare_against_fortytwo_commutatibility_1_combined
  simp_alive_peephole
  sorry
def compare_against_fortytwo_commutatibility_2_combined := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(84 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_fortytwo_commutatibility_2   : compare_against_fortytwo_commutatibility_2_before  ⊑  compare_against_fortytwo_commutatibility_2_combined := by
  unfold compare_against_fortytwo_commutatibility_2_before compare_against_fortytwo_commutatibility_2_combined
  simp_alive_peephole
  sorry
def compare_against_fortytwo_commutatibility_3_combined := [llvmfunc|
  llvm.func @compare_against_fortytwo_commutatibility_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(84 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%1) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_compare_against_fortytwo_commutatibility_3   : compare_against_fortytwo_commutatibility_3_before  ⊑  compare_against_fortytwo_commutatibility_3_combined := by
  unfold compare_against_fortytwo_commutatibility_3_before compare_against_fortytwo_commutatibility_3_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_commutativity0_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_commutativity0   : compare_against_arbitrary_value_commutativity0_before  ⊑  compare_against_arbitrary_value_commutativity0_combined := by
  unfold compare_against_arbitrary_value_commutativity0_before compare_against_arbitrary_value_commutativity0_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_commutativity1_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_commutativity1   : compare_against_arbitrary_value_commutativity1_before  ⊑  compare_against_arbitrary_value_commutativity1_combined := by
  unfold compare_against_arbitrary_value_commutativity1_before compare_against_arbitrary_value_commutativity1_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_commutativity2_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_commutativity2   : compare_against_arbitrary_value_commutativity2_before  ⊑  compare_against_arbitrary_value_commutativity2_combined := by
  unfold compare_against_arbitrary_value_commutativity2_before compare_against_arbitrary_value_commutativity2_combined
  simp_alive_peephole
  sorry
def compare_against_arbitrary_value_commutativity3_combined := [llvmfunc|
  llvm.func @compare_against_arbitrary_value_commutativity3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%0) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_compare_against_arbitrary_value_commutativity3   : compare_against_arbitrary_value_commutativity3_before  ⊑  compare_against_arbitrary_value_commutativity3_combined := by
  unfold compare_against_arbitrary_value_commutativity3_before compare_against_arbitrary_value_commutativity3_combined
  simp_alive_peephole
  sorry

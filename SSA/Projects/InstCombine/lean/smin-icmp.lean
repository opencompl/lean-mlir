import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  smin-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_smin1_before := [llvmfunc|
  llvm.func @eq_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_smin2_before := [llvmfunc|
  llvm.func @eq_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_smin3_before := [llvmfunc|
  llvm.func @eq_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_smin4_before := [llvmfunc|
  llvm.func @eq_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sge_smin1_before := [llvmfunc|
  llvm.func @sge_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sge_smin2_before := [llvmfunc|
  llvm.func @sge_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sge_smin3_before := [llvmfunc|
  llvm.func @sge_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sle" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sge_smin4_before := [llvmfunc|
  llvm.func @sge_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sle" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_smin1_before := [llvmfunc|
  llvm.func @ne_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_smin2_before := [llvmfunc|
  llvm.func @ne_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_smin3_before := [llvmfunc|
  llvm.func @ne_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_smin4_before := [llvmfunc|
  llvm.func @ne_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def slt_smin1_before := [llvmfunc|
  llvm.func @slt_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def slt_smin2_before := [llvmfunc|
  llvm.func @slt_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def slt_smin3_before := [llvmfunc|
  llvm.func @slt_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def slt_smin4_before := [llvmfunc|
  llvm.func @slt_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sle_smin1_before := [llvmfunc|
  llvm.func @sle_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sle_smin2_before := [llvmfunc|
  llvm.func @sle_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sle_smin3_before := [llvmfunc|
  llvm.func @sle_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sle_smin4_before := [llvmfunc|
  llvm.func @sle_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sgt_smin1_before := [llvmfunc|
  llvm.func @sgt_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sgt_smin2_before := [llvmfunc|
  llvm.func @sgt_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sgt_smin3_before := [llvmfunc|
  llvm.func @sgt_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sgt_smin4_before := [llvmfunc|
  llvm.func @sgt_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_smin_contextual_before := [llvmfunc|
  llvm.func @eq_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def eq_smin_contextual_commuted_before := [llvmfunc|
  llvm.func @eq_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def slt_smin_contextual_before := [llvmfunc|
  llvm.func @slt_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def slt_smin_contextual_commuted_before := [llvmfunc|
  llvm.func @slt_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def sle_smin_contextual_before := [llvmfunc|
  llvm.func @sle_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def sle_smin_contextual_commuted_before := [llvmfunc|
  llvm.func @sle_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def sgt_smin_contextual_before := [llvmfunc|
  llvm.func @sgt_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def sgt_smin_contextual_commuted_before := [llvmfunc|
  llvm.func @sgt_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def sge_smin_contextual_before := [llvmfunc|
  llvm.func @sge_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def sge_smin_contextual_commuted_before := [llvmfunc|
  llvm.func @sge_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def eq_smin_v2i32_before := [llvmfunc|
  llvm.func @eq_smin_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %1 = llvm.icmp "slt" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%1) : (vector<2xi1>) -> ()
    %2 = llvm.icmp "sle" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    %3 = llvm.icmp "sgt" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sge" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "ult" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "ule" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ugt" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "uge" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "eq" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ne" %0, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    llvm.return
  }]

def eq_smin_v2i32_constant_before := [llvmfunc|
  llvm.func @eq_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    %3 = llvm.icmp "sle" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sgt" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sge" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ule" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ugt" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "uge" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    llvm.return
  }]

def slt_smin_v2i32_constant_before := [llvmfunc|
  llvm.func @slt_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }]

def sle_smin_v2i32_constant_before := [llvmfunc|
  llvm.func @sle_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }]

def sgt_smin_v2i32_constant_before := [llvmfunc|
  llvm.func @sgt_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }]

def sge_smin_v2i32_constant_before := [llvmfunc|
  llvm.func @sge_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[15, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }]

def unknown_smin_v2i32_constant_before := [llvmfunc|
  llvm.func @unknown_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[5, 15]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.smin(%0, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %4 = llvm.icmp "sle" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %5 = llvm.icmp "sgt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }]

def smin_or_bitwise_before := [llvmfunc|
  llvm.func @smin_or_bitwise(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def smin_and_bitwise_before := [llvmfunc|
  llvm.func @smin_and_bitwise(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def eq_smin_nofold_before := [llvmfunc|
  llvm.func @eq_smin_nofold(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def eq_smin1_combined := [llvmfunc|
  llvm.func @eq_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_smin1   : eq_smin1_before  ⊑  eq_smin1_combined := by
  unfold eq_smin1_before eq_smin1_combined
  simp_alive_peephole
  sorry
def eq_smin2_combined := [llvmfunc|
  llvm.func @eq_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_smin2   : eq_smin2_before  ⊑  eq_smin2_combined := by
  unfold eq_smin2_before eq_smin2_combined
  simp_alive_peephole
  sorry
def eq_smin3_combined := [llvmfunc|
  llvm.func @eq_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_smin3   : eq_smin3_before  ⊑  eq_smin3_combined := by
  unfold eq_smin3_before eq_smin3_combined
  simp_alive_peephole
  sorry
def eq_smin4_combined := [llvmfunc|
  llvm.func @eq_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_smin4   : eq_smin4_before  ⊑  eq_smin4_combined := by
  unfold eq_smin4_before eq_smin4_combined
  simp_alive_peephole
  sorry
def sge_smin1_combined := [llvmfunc|
  llvm.func @sge_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_smin1   : sge_smin1_before  ⊑  sge_smin1_combined := by
  unfold sge_smin1_before sge_smin1_combined
  simp_alive_peephole
  sorry
def sge_smin2_combined := [llvmfunc|
  llvm.func @sge_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_smin2   : sge_smin2_before  ⊑  sge_smin2_combined := by
  unfold sge_smin2_before sge_smin2_combined
  simp_alive_peephole
  sorry
def sge_smin3_combined := [llvmfunc|
  llvm.func @sge_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sge_smin3   : sge_smin3_before  ⊑  sge_smin3_combined := by
  unfold sge_smin3_before sge_smin3_combined
  simp_alive_peephole
  sorry
def sge_smin4_combined := [llvmfunc|
  llvm.func @sge_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sge_smin4   : sge_smin4_before  ⊑  sge_smin4_combined := by
  unfold sge_smin4_before sge_smin4_combined
  simp_alive_peephole
  sorry
def ne_smin1_combined := [llvmfunc|
  llvm.func @ne_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_smin1   : ne_smin1_before  ⊑  ne_smin1_combined := by
  unfold ne_smin1_before ne_smin1_combined
  simp_alive_peephole
  sorry
def ne_smin2_combined := [llvmfunc|
  llvm.func @ne_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_smin2   : ne_smin2_before  ⊑  ne_smin2_combined := by
  unfold ne_smin2_before ne_smin2_combined
  simp_alive_peephole
  sorry
def ne_smin3_combined := [llvmfunc|
  llvm.func @ne_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_smin3   : ne_smin3_before  ⊑  ne_smin3_combined := by
  unfold ne_smin3_before ne_smin3_combined
  simp_alive_peephole
  sorry
def ne_smin4_combined := [llvmfunc|
  llvm.func @ne_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_smin4   : ne_smin4_before  ⊑  ne_smin4_combined := by
  unfold ne_smin4_before ne_smin4_combined
  simp_alive_peephole
  sorry
def slt_smin1_combined := [llvmfunc|
  llvm.func @slt_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_smin1   : slt_smin1_before  ⊑  slt_smin1_combined := by
  unfold slt_smin1_before slt_smin1_combined
  simp_alive_peephole
  sorry
def slt_smin2_combined := [llvmfunc|
  llvm.func @slt_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_smin2   : slt_smin2_before  ⊑  slt_smin2_combined := by
  unfold slt_smin2_before slt_smin2_combined
  simp_alive_peephole
  sorry
def slt_smin3_combined := [llvmfunc|
  llvm.func @slt_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_slt_smin3   : slt_smin3_before  ⊑  slt_smin3_combined := by
  unfold slt_smin3_before slt_smin3_combined
  simp_alive_peephole
  sorry
def slt_smin4_combined := [llvmfunc|
  llvm.func @slt_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_slt_smin4   : slt_smin4_before  ⊑  slt_smin4_combined := by
  unfold slt_smin4_before slt_smin4_combined
  simp_alive_peephole
  sorry
def sle_smin1_combined := [llvmfunc|
  llvm.func @sle_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_smin1   : sle_smin1_before  ⊑  sle_smin1_combined := by
  unfold sle_smin1_before sle_smin1_combined
  simp_alive_peephole
  sorry
def sle_smin2_combined := [llvmfunc|
  llvm.func @sle_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_smin2   : sle_smin2_before  ⊑  sle_smin2_combined := by
  unfold sle_smin2_before sle_smin2_combined
  simp_alive_peephole
  sorry
def sle_smin3_combined := [llvmfunc|
  llvm.func @sle_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_smin3   : sle_smin3_before  ⊑  sle_smin3_combined := by
  unfold sle_smin3_before sle_smin3_combined
  simp_alive_peephole
  sorry
def sle_smin4_combined := [llvmfunc|
  llvm.func @sle_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_smin4   : sle_smin4_before  ⊑  sle_smin4_combined := by
  unfold sle_smin4_before sle_smin4_combined
  simp_alive_peephole
  sorry
def sgt_smin1_combined := [llvmfunc|
  llvm.func @sgt_smin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_smin1   : sgt_smin1_before  ⊑  sgt_smin1_combined := by
  unfold sgt_smin1_before sgt_smin1_combined
  simp_alive_peephole
  sorry
def sgt_smin2_combined := [llvmfunc|
  llvm.func @sgt_smin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_smin2   : sgt_smin2_before  ⊑  sgt_smin2_combined := by
  unfold sgt_smin2_before sgt_smin2_combined
  simp_alive_peephole
  sorry
def sgt_smin3_combined := [llvmfunc|
  llvm.func @sgt_smin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_smin3   : sgt_smin3_before  ⊑  sgt_smin3_combined := by
  unfold sgt_smin3_before sgt_smin3_combined
  simp_alive_peephole
  sorry
def sgt_smin4_combined := [llvmfunc|
  llvm.func @sgt_smin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_smin4   : sgt_smin4_before  ⊑  sgt_smin4_combined := by
  unfold sgt_smin4_before sgt_smin4_combined
  simp_alive_peephole
  sorry
def eq_smin_contextual_combined := [llvmfunc|
  llvm.func @eq_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %arg1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %5 = llvm.icmp "sge" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_smin_contextual   : eq_smin_contextual_before  ⊑  eq_smin_contextual_combined := by
  unfold eq_smin_contextual_before eq_smin_contextual_combined
  simp_alive_peephole
  sorry
def eq_smin_contextual_commuted_combined := [llvmfunc|
  llvm.func @eq_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %arg1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %5 = llvm.icmp "sge" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_smin_contextual_commuted   : eq_smin_contextual_commuted_before  ⊑  eq_smin_contextual_commuted_combined := by
  unfold eq_smin_contextual_commuted_before eq_smin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def slt_smin_contextual_combined := [llvmfunc|
  llvm.func @slt_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %4 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_slt_smin_contextual   : slt_smin_contextual_before  ⊑  slt_smin_contextual_combined := by
  unfold slt_smin_contextual_before slt_smin_contextual_combined
  simp_alive_peephole
  sorry
def slt_smin_contextual_commuted_combined := [llvmfunc|
  llvm.func @slt_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %4 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_slt_smin_contextual_commuted   : slt_smin_contextual_commuted_before  ⊑  slt_smin_contextual_commuted_combined := by
  unfold slt_smin_contextual_commuted_before slt_smin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def sle_smin_contextual_combined := [llvmfunc|
  llvm.func @sle_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %5 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %3, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %3, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sle_smin_contextual   : sle_smin_contextual_before  ⊑  sle_smin_contextual_combined := by
  unfold sle_smin_contextual_before sle_smin_contextual_combined
  simp_alive_peephole
  sorry
def sle_smin_contextual_commuted_combined := [llvmfunc|
  llvm.func @sle_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %5 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %3, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %3, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sle_smin_contextual_commuted   : sle_smin_contextual_commuted_before  ⊑  sle_smin_contextual_commuted_combined := by
  unfold sle_smin_contextual_commuted_before sle_smin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def sgt_smin_contextual_combined := [llvmfunc|
  llvm.func @sgt_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %arg1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %arg1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %arg1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %arg1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %arg1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sgt_smin_contextual   : sgt_smin_contextual_before  ⊑  sgt_smin_contextual_combined := by
  unfold sgt_smin_contextual_before sgt_smin_contextual_combined
  simp_alive_peephole
  sorry
def sgt_smin_contextual_commuted_combined := [llvmfunc|
  llvm.func @sgt_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %arg1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %arg1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %arg1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %arg1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %arg1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sgt_smin_contextual_commuted   : sgt_smin_contextual_commuted_before  ⊑  sgt_smin_contextual_commuted_combined := by
  unfold sgt_smin_contextual_commuted_before sgt_smin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def sge_smin_contextual_combined := [llvmfunc|
  llvm.func @sge_smin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %arg1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sge_smin_contextual   : sge_smin_contextual_before  ⊑  sge_smin_contextual_combined := by
  unfold sge_smin_contextual_before sge_smin_contextual_combined
  simp_alive_peephole
  sorry
def sge_smin_contextual_commuted_combined := [llvmfunc|
  llvm.func @sge_smin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %arg1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sge_smin_contextual_commuted   : sge_smin_contextual_commuted_before  ⊑  sge_smin_contextual_commuted_combined := by
  unfold sge_smin_contextual_commuted_before sge_smin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def eq_smin_v2i32_combined := [llvmfunc|
  llvm.func @eq_smin_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%1) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "sge" %arg1, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "ult" %4, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "ule" %4, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ugt" %4, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "uge" %4, %arg0 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_eq_smin_v2i32   : eq_smin_v2i32_before  ⊑  eq_smin_v2i32_combined := by
  unfold eq_smin_v2i32_before eq_smin_v2i32_combined
  simp_alive_peephole
  sorry
def eq_smin_v2i32_constant_combined := [llvmfunc|
  llvm.func @eq_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %5 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %6 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %7 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %8 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "sgt" %arg0, %5 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ult" %7, %0 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ult" %7, %6 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ugt" %7, %0 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    %13 = llvm.icmp "ugt" %7, %5 : vector<2xi32>
    llvm.call @use_v2i1(%13) : (vector<2xi1>) -> ()
    %14 = llvm.icmp "sgt" %arg0, %5 : vector<2xi32>
    llvm.call @use_v2i1(%14) : (vector<2xi1>) -> ()
    %15 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    llvm.call @use_v2i1(%15) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_eq_smin_v2i32_constant   : eq_smin_v2i32_constant_before  ⊑  eq_smin_v2i32_constant_combined := by
  unfold eq_smin_v2i32_constant_before eq_smin_v2i32_constant_combined
  simp_alive_peephole
  sorry
def slt_smin_v2i32_constant_combined := [llvmfunc|
  llvm.func @slt_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %5 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %6 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %7 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ult" %8, %5 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ult" %8, %6 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ugt" %8, %5 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ugt" %8, %7 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%4) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%2) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_slt_smin_v2i32_constant   : slt_smin_v2i32_constant_before  ⊑  slt_smin_v2i32_constant_combined := by
  unfold slt_smin_v2i32_constant_before slt_smin_v2i32_constant_combined
  simp_alive_peephole
  sorry
def sle_smin_v2i32_constant_combined := [llvmfunc|
  llvm.func @sle_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[5, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %7 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %9 = llvm.icmp "slt" %8, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%3) : (vector<2xi1>) -> ()
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "sgt" %8, %6 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ult" %8, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ult" %8, %7 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    %13 = llvm.icmp "ugt" %8, %1 : vector<2xi32>
    llvm.call @use_v2i1(%13) : (vector<2xi1>) -> ()
    %14 = llvm.icmp "ugt" %8, %6 : vector<2xi32>
    llvm.call @use_v2i1(%14) : (vector<2xi1>) -> ()
    %15 = llvm.icmp "eq" %8, %1 : vector<2xi32>
    llvm.call @use_v2i1(%15) : (vector<2xi1>) -> ()
    %16 = llvm.icmp "ne" %8, %1 : vector<2xi32>
    llvm.call @use_v2i1(%16) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_sle_smin_v2i32_constant   : sle_smin_v2i32_constant_before  ⊑  sle_smin_v2i32_constant_combined := by
  unfold sle_smin_v2i32_constant_before sle_smin_v2i32_constant_combined
  simp_alive_peephole
  sorry
def sgt_smin_v2i32_constant_combined := [llvmfunc|
  llvm.func @sgt_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "slt" %arg0, %2 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "sgt" %arg0, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "sgt" %arg0, %3 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ult" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ugt" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ugt" %4, %3 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    %13 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.call @use_v2i1(%13) : (vector<2xi1>) -> ()
    %14 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.call @use_v2i1(%14) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_sgt_smin_v2i32_constant   : sgt_smin_v2i32_constant_before  ⊑  sgt_smin_v2i32_constant_combined := by
  unfold sgt_smin_v2i32_constant_before sgt_smin_v2i32_constant_combined
  simp_alive_peephole
  sorry
def sge_smin_v2i32_constant_combined := [llvmfunc|
  llvm.func @sge_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[15, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "slt" %4, %2 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "sgt" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "sgt" %arg0, %3 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ult" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ugt" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ugt" %4, %3 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    %13 = llvm.icmp "eq" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%13) : (vector<2xi1>) -> ()
    %14 = llvm.icmp "ne" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%14) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_sge_smin_v2i32_constant   : sge_smin_v2i32_constant_before  ⊑  sge_smin_v2i32_constant_combined := by
  unfold sge_smin_v2i32_constant_before sge_smin_v2i32_constant_combined
  simp_alive_peephole
  sorry
def unknown_smin_v2i32_constant_combined := [llvmfunc|
  llvm.func @unknown_smin_v2i32_constant(%arg0: vector<2xi32>) {
    %0 = llvm.mlir.constant(dense<[5, 15]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<11> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.intr.smin(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%5) : (vector<2xi1>) -> ()
    %6 = llvm.icmp "slt" %4, %2 : vector<2xi32>
    llvm.call @use_v2i1(%6) : (vector<2xi1>) -> ()
    %7 = llvm.icmp "sgt" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%7) : (vector<2xi1>) -> ()
    %8 = llvm.icmp "sgt" %4, %3 : vector<2xi32>
    llvm.call @use_v2i1(%8) : (vector<2xi1>) -> ()
    %9 = llvm.icmp "ult" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%9) : (vector<2xi1>) -> ()
    %10 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    llvm.call @use_v2i1(%10) : (vector<2xi1>) -> ()
    %11 = llvm.icmp "ugt" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%11) : (vector<2xi1>) -> ()
    %12 = llvm.icmp "ugt" %4, %3 : vector<2xi32>
    llvm.call @use_v2i1(%12) : (vector<2xi1>) -> ()
    %13 = llvm.icmp "eq" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%13) : (vector<2xi1>) -> ()
    %14 = llvm.icmp "ne" %4, %1 : vector<2xi32>
    llvm.call @use_v2i1(%14) : (vector<2xi1>) -> ()
    llvm.return
  }]

theorem inst_combine_unknown_smin_v2i32_constant   : unknown_smin_v2i32_constant_before  ⊑  unknown_smin_v2i32_constant_combined := by
  unfold unknown_smin_v2i32_constant_before unknown_smin_v2i32_constant_combined
  simp_alive_peephole
  sorry
def smin_or_bitwise_combined := [llvmfunc|
  llvm.func @smin_or_bitwise(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_smin_or_bitwise   : smin_or_bitwise_before  ⊑  smin_or_bitwise_combined := by
  unfold smin_or_bitwise_before smin_or_bitwise_combined
  simp_alive_peephole
  sorry
def smin_and_bitwise_combined := [llvmfunc|
  llvm.func @smin_and_bitwise(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_smin_and_bitwise   : smin_and_bitwise_before  ⊑  smin_and_bitwise_combined := by
  unfold smin_and_bitwise_before smin_and_bitwise_combined
  simp_alive_peephole
  sorry
def eq_smin_nofold_combined := [llvmfunc|
  llvm.func @eq_smin_nofold(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_smin_nofold   : eq_smin_nofold_before  ⊑  eq_smin_nofold_combined := by
  unfold eq_smin_nofold_before eq_smin_nofold_combined
  simp_alive_peephole
  sorry

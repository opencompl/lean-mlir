import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  smax-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_smax1_before := [llvmfunc|
  llvm.func @eq_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_smax2_before := [llvmfunc|
  llvm.func @eq_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_smax3_before := [llvmfunc|
  llvm.func @eq_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_smax4_before := [llvmfunc|
  llvm.func @eq_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sle_smax1_before := [llvmfunc|
  llvm.func @sle_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sle_smax2_before := [llvmfunc|
  llvm.func @sle_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sle_smax3_before := [llvmfunc|
  llvm.func @sle_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sle_smax4_before := [llvmfunc|
  llvm.func @sle_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "sge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_smax1_before := [llvmfunc|
  llvm.func @ne_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_smax2_before := [llvmfunc|
  llvm.func @ne_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_smax3_before := [llvmfunc|
  llvm.func @ne_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_smax4_before := [llvmfunc|
  llvm.func @ne_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sgt_smax1_before := [llvmfunc|
  llvm.func @sgt_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sgt_smax2_before := [llvmfunc|
  llvm.func @sgt_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sgt_smax3_before := [llvmfunc|
  llvm.func @sgt_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sgt_smax4_before := [llvmfunc|
  llvm.func @sgt_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_smax_contextual_before := [llvmfunc|
  llvm.func @eq_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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

def eq_smax_contextual_commuted_before := [llvmfunc|
  llvm.func @eq_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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

def slt_smax_contextual_before := [llvmfunc|
  llvm.func @slt_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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

def slt_smax_contextual_commuted_before := [llvmfunc|
  llvm.func @slt_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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

def sle_smax_contextual_before := [llvmfunc|
  llvm.func @sle_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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

def sle_smax_contextual_commuted_before := [llvmfunc|
  llvm.func @sle_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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

def sgt_smax_contextual_before := [llvmfunc|
  llvm.func @sgt_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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

def sgt_smax_contextual_commuted_before := [llvmfunc|
  llvm.func @sgt_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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

def sge_smax_contextual_before := [llvmfunc|
  llvm.func @sge_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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

def sge_smax_contextual_commuted_before := [llvmfunc|
  llvm.func @sge_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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

def test_smax_ugt_before := [llvmfunc|
  llvm.func @test_smax_ugt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_smax_ugt_neg1_before := [llvmfunc|
  llvm.func @test_smax_ugt_neg1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_smax_ugt_neg2_before := [llvmfunc|
  llvm.func @test_smax_ugt_neg2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def eq_smax1_combined := [llvmfunc|
  llvm.func @eq_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_smax1   : eq_smax1_before  ⊑  eq_smax1_combined := by
  unfold eq_smax1_before eq_smax1_combined
  simp_alive_peephole
  sorry
def eq_smax2_combined := [llvmfunc|
  llvm.func @eq_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_smax2   : eq_smax2_before  ⊑  eq_smax2_combined := by
  unfold eq_smax2_before eq_smax2_combined
  simp_alive_peephole
  sorry
def eq_smax3_combined := [llvmfunc|
  llvm.func @eq_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_smax3   : eq_smax3_before  ⊑  eq_smax3_combined := by
  unfold eq_smax3_before eq_smax3_combined
  simp_alive_peephole
  sorry
def eq_smax4_combined := [llvmfunc|
  llvm.func @eq_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_smax4   : eq_smax4_before  ⊑  eq_smax4_combined := by
  unfold eq_smax4_before eq_smax4_combined
  simp_alive_peephole
  sorry
def sle_smax1_combined := [llvmfunc|
  llvm.func @sle_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_smax1   : sle_smax1_before  ⊑  sle_smax1_combined := by
  unfold sle_smax1_before sle_smax1_combined
  simp_alive_peephole
  sorry
def sle_smax2_combined := [llvmfunc|
  llvm.func @sle_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_smax2   : sle_smax2_before  ⊑  sle_smax2_combined := by
  unfold sle_smax2_before sle_smax2_combined
  simp_alive_peephole
  sorry
def sle_smax3_combined := [llvmfunc|
  llvm.func @sle_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sle_smax3   : sle_smax3_before  ⊑  sle_smax3_combined := by
  unfold sle_smax3_before sle_smax3_combined
  simp_alive_peephole
  sorry
def sle_smax4_combined := [llvmfunc|
  llvm.func @sle_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sle_smax4   : sle_smax4_before  ⊑  sle_smax4_combined := by
  unfold sle_smax4_before sle_smax4_combined
  simp_alive_peephole
  sorry
def ne_smax1_combined := [llvmfunc|
  llvm.func @ne_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_smax1   : ne_smax1_before  ⊑  ne_smax1_combined := by
  unfold ne_smax1_before ne_smax1_combined
  simp_alive_peephole
  sorry
def ne_smax2_combined := [llvmfunc|
  llvm.func @ne_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_smax2   : ne_smax2_before  ⊑  ne_smax2_combined := by
  unfold ne_smax2_before ne_smax2_combined
  simp_alive_peephole
  sorry
def ne_smax3_combined := [llvmfunc|
  llvm.func @ne_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_smax3   : ne_smax3_before  ⊑  ne_smax3_combined := by
  unfold ne_smax3_before ne_smax3_combined
  simp_alive_peephole
  sorry
def ne_smax4_combined := [llvmfunc|
  llvm.func @ne_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_smax4   : ne_smax4_before  ⊑  ne_smax4_combined := by
  unfold ne_smax4_before ne_smax4_combined
  simp_alive_peephole
  sorry
def sgt_smax1_combined := [llvmfunc|
  llvm.func @sgt_smax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_smax1   : sgt_smax1_before  ⊑  sgt_smax1_combined := by
  unfold sgt_smax1_before sgt_smax1_combined
  simp_alive_peephole
  sorry
def sgt_smax2_combined := [llvmfunc|
  llvm.func @sgt_smax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_smax2   : sgt_smax2_before  ⊑  sgt_smax2_combined := by
  unfold sgt_smax2_before sgt_smax2_combined
  simp_alive_peephole
  sorry
def sgt_smax3_combined := [llvmfunc|
  llvm.func @sgt_smax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sgt_smax3   : sgt_smax3_before  ⊑  sgt_smax3_combined := by
  unfold sgt_smax3_before sgt_smax3_combined
  simp_alive_peephole
  sorry
def sgt_smax4_combined := [llvmfunc|
  llvm.func @sgt_smax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sgt_smax4   : sgt_smax4_before  ⊑  sgt_smax4_combined := by
  unfold sgt_smax4_before sgt_smax4_combined
  simp_alive_peephole
  sorry
def eq_smax_contextual_combined := [llvmfunc|
  llvm.func @eq_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.call @use(%0) : (i1) -> ()
    %4 = llvm.icmp "sle" %arg1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sgt" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_smax_contextual   : eq_smax_contextual_before  ⊑  eq_smax_contextual_combined := by
  unfold eq_smax_contextual_before eq_smax_contextual_combined
  simp_alive_peephole
  sorry
def eq_smax_contextual_commuted_combined := [llvmfunc|
  llvm.func @eq_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.call @use(%0) : (i1) -> ()
    %4 = llvm.icmp "sle" %arg1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sgt" %arg1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_smax_contextual_commuted   : eq_smax_contextual_commuted_before  ⊑  eq_smax_contextual_commuted_combined := by
  unfold eq_smax_contextual_commuted_before eq_smax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def slt_smax_contextual_combined := [llvmfunc|
  llvm.func @slt_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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

theorem inst_combine_slt_smax_contextual   : slt_smax_contextual_before  ⊑  slt_smax_contextual_combined := by
  unfold slt_smax_contextual_before slt_smax_contextual_combined
  simp_alive_peephole
  sorry
def slt_smax_contextual_commuted_combined := [llvmfunc|
  llvm.func @slt_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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

theorem inst_combine_slt_smax_contextual_commuted   : slt_smax_contextual_commuted_before  ⊑  slt_smax_contextual_commuted_combined := by
  unfold slt_smax_contextual_commuted_before slt_smax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def sle_smax_contextual_combined := [llvmfunc|
  llvm.func @sle_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %arg1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %arg1, %arg2 : i32
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

theorem inst_combine_sle_smax_contextual   : sle_smax_contextual_before  ⊑  sle_smax_contextual_combined := by
  unfold sle_smax_contextual_before sle_smax_contextual_combined
  simp_alive_peephole
  sorry
def sle_smax_contextual_commuted_combined := [llvmfunc|
  llvm.func @sle_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %arg1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %arg1, %arg2 : i32
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

theorem inst_combine_sle_smax_contextual_commuted   : sle_smax_contextual_commuted_before  ⊑  sle_smax_contextual_commuted_combined := by
  unfold sle_smax_contextual_commuted_before sle_smax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def sgt_smax_contextual_combined := [llvmfunc|
  llvm.func @sgt_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
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
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sgt_smax_contextual   : sgt_smax_contextual_before  ⊑  sgt_smax_contextual_combined := by
  unfold sgt_smax_contextual_before sgt_smax_contextual_combined
  simp_alive_peephole
  sorry
def sgt_smax_contextual_commuted_combined := [llvmfunc|
  llvm.func @sgt_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
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
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_sgt_smax_contextual_commuted   : sgt_smax_contextual_commuted_before  ⊑  sgt_smax_contextual_commuted_combined := by
  unfold sgt_smax_contextual_commuted_before sgt_smax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def sge_smax_contextual_combined := [llvmfunc|
  llvm.func @sge_smax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.call @use(%0) : (i1) -> ()
    %4 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
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

theorem inst_combine_sge_smax_contextual   : sge_smax_contextual_before  ⊑  sge_smax_contextual_combined := by
  unfold sge_smax_contextual_before sge_smax_contextual_combined
  simp_alive_peephole
  sorry
def sge_smax_contextual_commuted_combined := [llvmfunc|
  llvm.func @sge_smax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.call @use(%0) : (i1) -> ()
    %4 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
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

theorem inst_combine_sge_smax_contextual_commuted   : sge_smax_contextual_commuted_before  ⊑  sge_smax_contextual_commuted_combined := by
  unfold sge_smax_contextual_commuted_before sge_smax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def test_smax_ugt_combined := [llvmfunc|
  llvm.func @test_smax_ugt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_smax_ugt   : test_smax_ugt_before  ⊑  test_smax_ugt_combined := by
  unfold test_smax_ugt_before test_smax_ugt_combined
  simp_alive_peephole
  sorry
def test_smax_ugt_neg1_combined := [llvmfunc|
  llvm.func @test_smax_ugt_neg1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_smax_ugt_neg1   : test_smax_ugt_neg1_before  ⊑  test_smax_ugt_neg1_combined := by
  unfold test_smax_ugt_neg1_before test_smax_ugt_neg1_combined
  simp_alive_peephole
  sorry
def test_smax_ugt_neg2_combined := [llvmfunc|
  llvm.func @test_smax_ugt_neg2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test_smax_ugt_neg2   : test_smax_ugt_neg2_before  ⊑  test_smax_ugt_neg2_combined := by
  unfold test_smax_ugt_neg2_before test_smax_ugt_neg2_combined
  simp_alive_peephole
  sorry

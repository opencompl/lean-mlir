import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  umin-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_umin1_before := [llvmfunc|
  llvm.func @eq_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_umin2_before := [llvmfunc|
  llvm.func @eq_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_umin3_before := [llvmfunc|
  llvm.func @eq_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_umin4_before := [llvmfunc|
  llvm.func @eq_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def uge_umin1_before := [llvmfunc|
  llvm.func @uge_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "uge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def uge_umin2_before := [llvmfunc|
  llvm.func @uge_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "uge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def uge_umin3_before := [llvmfunc|
  llvm.func @uge_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ule" %1, %3 : i32
    llvm.return %4 : i1
  }]

def uge_umin4_before := [llvmfunc|
  llvm.func @uge_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ule" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_umin1_before := [llvmfunc|
  llvm.func @ne_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_umin2_before := [llvmfunc|
  llvm.func @ne_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_umin3_before := [llvmfunc|
  llvm.func @ne_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_umin4_before := [llvmfunc|
  llvm.func @ne_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ult_umin1_before := [llvmfunc|
  llvm.func @ult_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ult_umin2_before := [llvmfunc|
  llvm.func @ult_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ult_umin3_before := [llvmfunc|
  llvm.func @ult_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ult_umin4_before := [llvmfunc|
  llvm.func @ult_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_umin_contextual_before := [llvmfunc|
  llvm.func @eq_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
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

def eq_umin_contextual_commuted_before := [llvmfunc|
  llvm.func @eq_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
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

def ult_umin_contextual_before := [llvmfunc|
  llvm.func @ult_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
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

def ult_umin_contextual_commuted_before := [llvmfunc|
  llvm.func @ult_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
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

def ule_umin_contextual_before := [llvmfunc|
  llvm.func @ule_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
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

def ule_umin_contextual_commuted_before := [llvmfunc|
  llvm.func @ule_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
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

def ugt_umin_contextual_before := [llvmfunc|
  llvm.func @ugt_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
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

def ugt_umin_contextual_commuted_before := [llvmfunc|
  llvm.func @ugt_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
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

def uge_umin_contextual_before := [llvmfunc|
  llvm.func @uge_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "uge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
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

def uge_umin_contextual_commuted_before := [llvmfunc|
  llvm.func @uge_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "uge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
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

def eq_umin1_combined := [llvmfunc|
  llvm.func @eq_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_umin1   : eq_umin1_before  ⊑  eq_umin1_combined := by
  unfold eq_umin1_before eq_umin1_combined
  simp_alive_peephole
  sorry
def eq_umin2_combined := [llvmfunc|
  llvm.func @eq_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_umin2   : eq_umin2_before  ⊑  eq_umin2_combined := by
  unfold eq_umin2_before eq_umin2_combined
  simp_alive_peephole
  sorry
def eq_umin3_combined := [llvmfunc|
  llvm.func @eq_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_umin3   : eq_umin3_before  ⊑  eq_umin3_combined := by
  unfold eq_umin3_before eq_umin3_combined
  simp_alive_peephole
  sorry
def eq_umin4_combined := [llvmfunc|
  llvm.func @eq_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_umin4   : eq_umin4_before  ⊑  eq_umin4_combined := by
  unfold eq_umin4_before eq_umin4_combined
  simp_alive_peephole
  sorry
def uge_umin1_combined := [llvmfunc|
  llvm.func @uge_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_umin1   : uge_umin1_before  ⊑  uge_umin1_combined := by
  unfold uge_umin1_before uge_umin1_combined
  simp_alive_peephole
  sorry
def uge_umin2_combined := [llvmfunc|
  llvm.func @uge_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_umin2   : uge_umin2_before  ⊑  uge_umin2_combined := by
  unfold uge_umin2_before uge_umin2_combined
  simp_alive_peephole
  sorry
def uge_umin3_combined := [llvmfunc|
  llvm.func @uge_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_uge_umin3   : uge_umin3_before  ⊑  uge_umin3_combined := by
  unfold uge_umin3_before uge_umin3_combined
  simp_alive_peephole
  sorry
def uge_umin4_combined := [llvmfunc|
  llvm.func @uge_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_uge_umin4   : uge_umin4_before  ⊑  uge_umin4_combined := by
  unfold uge_umin4_before uge_umin4_combined
  simp_alive_peephole
  sorry
def ne_umin1_combined := [llvmfunc|
  llvm.func @ne_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_umin1   : ne_umin1_before  ⊑  ne_umin1_combined := by
  unfold ne_umin1_before ne_umin1_combined
  simp_alive_peephole
  sorry
def ne_umin2_combined := [llvmfunc|
  llvm.func @ne_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_umin2   : ne_umin2_before  ⊑  ne_umin2_combined := by
  unfold ne_umin2_before ne_umin2_combined
  simp_alive_peephole
  sorry
def ne_umin3_combined := [llvmfunc|
  llvm.func @ne_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_umin3   : ne_umin3_before  ⊑  ne_umin3_combined := by
  unfold ne_umin3_before ne_umin3_combined
  simp_alive_peephole
  sorry
def ne_umin4_combined := [llvmfunc|
  llvm.func @ne_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_umin4   : ne_umin4_before  ⊑  ne_umin4_combined := by
  unfold ne_umin4_before ne_umin4_combined
  simp_alive_peephole
  sorry
def ult_umin1_combined := [llvmfunc|
  llvm.func @ult_umin1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_umin1   : ult_umin1_before  ⊑  ult_umin1_combined := by
  unfold ult_umin1_before ult_umin1_combined
  simp_alive_peephole
  sorry
def ult_umin2_combined := [llvmfunc|
  llvm.func @ult_umin2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_umin2   : ult_umin2_before  ⊑  ult_umin2_combined := by
  unfold ult_umin2_before ult_umin2_combined
  simp_alive_peephole
  sorry
def ult_umin3_combined := [llvmfunc|
  llvm.func @ult_umin3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ult_umin3   : ult_umin3_before  ⊑  ult_umin3_combined := by
  unfold ult_umin3_before ult_umin3_combined
  simp_alive_peephole
  sorry
def ult_umin4_combined := [llvmfunc|
  llvm.func @ult_umin4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ult_umin4   : ult_umin4_before  ⊑  ult_umin4_combined := by
  unfold ult_umin4_before ult_umin4_combined
  simp_alive_peephole
  sorry
def eq_umin_contextual_combined := [llvmfunc|
  llvm.func @eq_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ult" %arg1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %9 = llvm.icmp "uge" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_umin_contextual   : eq_umin_contextual_before  ⊑  eq_umin_contextual_combined := by
  unfold eq_umin_contextual_before eq_umin_contextual_combined
  simp_alive_peephole
  sorry
def eq_umin_contextual_commuted_combined := [llvmfunc|
  llvm.func @eq_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ult" %arg1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %9 = llvm.icmp "uge" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_umin_contextual_commuted   : eq_umin_contextual_commuted_before  ⊑  eq_umin_contextual_commuted_combined := by
  unfold eq_umin_contextual_commuted_before eq_umin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def ult_umin_contextual_combined := [llvmfunc|
  llvm.func @ult_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_ult_umin_contextual   : ult_umin_contextual_before  ⊑  ult_umin_contextual_combined := by
  unfold ult_umin_contextual_before ult_umin_contextual_combined
  simp_alive_peephole
  sorry
def ult_umin_contextual_commuted_combined := [llvmfunc|
  llvm.func @ult_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_ult_umin_contextual_commuted   : ult_umin_contextual_commuted_before  ⊑  ult_umin_contextual_commuted_combined := by
  unfold ult_umin_contextual_commuted_before ult_umin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def ule_umin_contextual_combined := [llvmfunc|
  llvm.func @ule_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
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

theorem inst_combine_ule_umin_contextual   : ule_umin_contextual_before  ⊑  ule_umin_contextual_combined := by
  unfold ule_umin_contextual_before ule_umin_contextual_combined
  simp_alive_peephole
  sorry
def ule_umin_contextual_commuted_combined := [llvmfunc|
  llvm.func @ule_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ult" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
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

theorem inst_combine_ule_umin_contextual_commuted   : ule_umin_contextual_commuted_before  ⊑  ule_umin_contextual_commuted_combined := by
  unfold ule_umin_contextual_commuted_before ule_umin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def ugt_umin_contextual_combined := [llvmfunc|
  llvm.func @ugt_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %arg1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %arg1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %arg1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %arg1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_ugt_umin_contextual   : ugt_umin_contextual_before  ⊑  ugt_umin_contextual_combined := by
  unfold ugt_umin_contextual_before ugt_umin_contextual_combined
  simp_alive_peephole
  sorry
def ugt_umin_contextual_commuted_combined := [llvmfunc|
  llvm.func @ugt_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %arg1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %arg1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %arg1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %arg1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_ugt_umin_contextual_commuted   : ugt_umin_contextual_commuted_before  ⊑  ugt_umin_contextual_commuted_combined := by
  unfold ugt_umin_contextual_commuted_before ugt_umin_contextual_commuted_combined
  simp_alive_peephole
  sorry
def uge_umin_contextual_combined := [llvmfunc|
  llvm.func @uge_umin_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %arg1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_uge_umin_contextual   : uge_umin_contextual_before  ⊑  uge_umin_contextual_combined := by
  unfold uge_umin_contextual_before uge_umin_contextual_combined
  simp_alive_peephole
  sorry
def uge_umin_contextual_commuted_combined := [llvmfunc|
  llvm.func @uge_umin_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.icmp "slt" %1, %arg2 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sle" %1, %arg2 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "sgt" %1, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sge" %1, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %arg1, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "ule" %1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "uge" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    %10 = llvm.icmp "eq" %1, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %1, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_uge_umin_contextual_commuted   : uge_umin_contextual_commuted_before  ⊑  uge_umin_contextual_commuted_combined := by
  unfold uge_umin_contextual_commuted_before uge_umin_contextual_commuted_combined
  simp_alive_peephole
  sorry

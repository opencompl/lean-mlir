import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  umax-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_umax1_before := [llvmfunc|
  llvm.func @eq_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_umax2_before := [llvmfunc|
  llvm.func @eq_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def eq_umax3_before := [llvmfunc|
  llvm.func @eq_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_umax4_before := [llvmfunc|
  llvm.func @eq_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ule_umax1_before := [llvmfunc|
  llvm.func @ule_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ule" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ule_umax2_before := [llvmfunc|
  llvm.func @ule_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ule" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ule_umax3_before := [llvmfunc|
  llvm.func @ule_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ule_umax4_before := [llvmfunc|
  llvm.func @ule_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_umax1_before := [llvmfunc|
  llvm.func @ne_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_umax2_before := [llvmfunc|
  llvm.func @ne_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ne_umax3_before := [llvmfunc|
  llvm.func @ne_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ne_umax4_before := [llvmfunc|
  llvm.func @ne_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ugt_umax1_before := [llvmfunc|
  llvm.func @ugt_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ugt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ugt_umax2_before := [llvmfunc|
  llvm.func @ugt_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ugt_umax3_before := [llvmfunc|
  llvm.func @ugt_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    llvm.return %4 : i1
  }]

def ugt_umax4_before := [llvmfunc|
  llvm.func @ugt_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %arg1, %1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    llvm.return %4 : i1
  }]

def eq_umax_contextual_before := [llvmfunc|
  llvm.func @eq_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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

def eq_umax_contextual_commuted_before := [llvmfunc|
  llvm.func @eq_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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

def ult_umax_contextual_before := [llvmfunc|
  llvm.func @ult_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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

def ult_umax_contextual_commuted_before := [llvmfunc|
  llvm.func @ult_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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

def ule_umax_contextual_before := [llvmfunc|
  llvm.func @ule_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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

def ule_umax_contextual_commuted_before := [llvmfunc|
  llvm.func @ule_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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

def ugt_umax_contextual_before := [llvmfunc|
  llvm.func @ugt_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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

def ugt_umax_contextual_commuted_before := [llvmfunc|
  llvm.func @ugt_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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

def uge_umax_contextual_before := [llvmfunc|
  llvm.func @uge_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "uge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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

def uge_umax_contextual_commuted_before := [llvmfunc|
  llvm.func @uge_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "uge" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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

def eq_umax1_combined := [llvmfunc|
  llvm.func @eq_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_umax1   : eq_umax1_before  ⊑  eq_umax1_combined := by
  unfold eq_umax1_before eq_umax1_combined
  simp_alive_peephole
  sorry
def eq_umax2_combined := [llvmfunc|
  llvm.func @eq_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_umax2   : eq_umax2_before  ⊑  eq_umax2_combined := by
  unfold eq_umax2_before eq_umax2_combined
  simp_alive_peephole
  sorry
def eq_umax3_combined := [llvmfunc|
  llvm.func @eq_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_umax3   : eq_umax3_before  ⊑  eq_umax3_combined := by
  unfold eq_umax3_before eq_umax3_combined
  simp_alive_peephole
  sorry
def eq_umax4_combined := [llvmfunc|
  llvm.func @eq_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_umax4   : eq_umax4_before  ⊑  eq_umax4_combined := by
  unfold eq_umax4_before eq_umax4_combined
  simp_alive_peephole
  sorry
def ule_umax1_combined := [llvmfunc|
  llvm.func @ule_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_umax1   : ule_umax1_before  ⊑  ule_umax1_combined := by
  unfold ule_umax1_before ule_umax1_combined
  simp_alive_peephole
  sorry
def ule_umax2_combined := [llvmfunc|
  llvm.func @ule_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_umax2   : ule_umax2_before  ⊑  ule_umax2_combined := by
  unfold ule_umax2_before ule_umax2_combined
  simp_alive_peephole
  sorry
def ule_umax3_combined := [llvmfunc|
  llvm.func @ule_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ule_umax3   : ule_umax3_before  ⊑  ule_umax3_combined := by
  unfold ule_umax3_before ule_umax3_combined
  simp_alive_peephole
  sorry
def ule_umax4_combined := [llvmfunc|
  llvm.func @ule_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ule_umax4   : ule_umax4_before  ⊑  ule_umax4_combined := by
  unfold ule_umax4_before ule_umax4_combined
  simp_alive_peephole
  sorry
def ne_umax1_combined := [llvmfunc|
  llvm.func @ne_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_umax1   : ne_umax1_before  ⊑  ne_umax1_combined := by
  unfold ne_umax1_before ne_umax1_combined
  simp_alive_peephole
  sorry
def ne_umax2_combined := [llvmfunc|
  llvm.func @ne_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_umax2   : ne_umax2_before  ⊑  ne_umax2_combined := by
  unfold ne_umax2_before ne_umax2_combined
  simp_alive_peephole
  sorry
def ne_umax3_combined := [llvmfunc|
  llvm.func @ne_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_umax3   : ne_umax3_before  ⊑  ne_umax3_combined := by
  unfold ne_umax3_before ne_umax3_combined
  simp_alive_peephole
  sorry
def ne_umax4_combined := [llvmfunc|
  llvm.func @ne_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_umax4   : ne_umax4_before  ⊑  ne_umax4_combined := by
  unfold ne_umax4_before ne_umax4_combined
  simp_alive_peephole
  sorry
def ugt_umax1_combined := [llvmfunc|
  llvm.func @ugt_umax1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_umax1   : ugt_umax1_before  ⊑  ugt_umax1_combined := by
  unfold ugt_umax1_before ugt_umax1_combined
  simp_alive_peephole
  sorry
def ugt_umax2_combined := [llvmfunc|
  llvm.func @ugt_umax2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_umax2   : ugt_umax2_before  ⊑  ugt_umax2_combined := by
  unfold ugt_umax2_before ugt_umax2_combined
  simp_alive_peephole
  sorry
def ugt_umax3_combined := [llvmfunc|
  llvm.func @ugt_umax3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ugt_umax3   : ugt_umax3_before  ⊑  ugt_umax3_combined := by
  unfold ugt_umax3_before ugt_umax3_combined
  simp_alive_peephole
  sorry
def ugt_umax4_combined := [llvmfunc|
  llvm.func @ugt_umax4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ugt_umax4   : ugt_umax4_before  ⊑  ugt_umax4_combined := by
  unfold ugt_umax4_before ugt_umax4_combined
  simp_alive_peephole
  sorry
def eq_umax_contextual_combined := [llvmfunc|
  llvm.func @eq_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    %8 = llvm.icmp "ule" %arg1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %10 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_umax_contextual   : eq_umax_contextual_before  ⊑  eq_umax_contextual_combined := by
  unfold eq_umax_contextual_before eq_umax_contextual_combined
  simp_alive_peephole
  sorry
def eq_umax_contextual_commuted_combined := [llvmfunc|
  llvm.func @eq_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    %8 = llvm.icmp "ule" %arg1, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %10 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_eq_umax_contextual_commuted   : eq_umax_contextual_commuted_before  ⊑  eq_umax_contextual_commuted_combined := by
  unfold eq_umax_contextual_commuted_before eq_umax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def ult_umax_contextual_combined := [llvmfunc|
  llvm.func @ult_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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

theorem inst_combine_ult_umax_contextual   : ult_umax_contextual_before  ⊑  ult_umax_contextual_combined := by
  unfold ult_umax_contextual_before ult_umax_contextual_combined
  simp_alive_peephole
  sorry
def ult_umax_contextual_commuted_combined := [llvmfunc|
  llvm.func @ult_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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

theorem inst_combine_ult_umax_contextual_commuted   : ult_umax_contextual_commuted_before  ⊑  ult_umax_contextual_commuted_combined := by
  unfold ult_umax_contextual_commuted_before ult_umax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def ule_umax_contextual_combined := [llvmfunc|
  llvm.func @ule_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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
    %7 = llvm.icmp "ule" %arg1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %arg1, %arg2 : i32
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

theorem inst_combine_ule_umax_contextual   : ule_umax_contextual_before  ⊑  ule_umax_contextual_combined := by
  unfold ule_umax_contextual_before ule_umax_contextual_combined
  simp_alive_peephole
  sorry
def ule_umax_contextual_commuted_combined := [llvmfunc|
  llvm.func @ule_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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
    %7 = llvm.icmp "ule" %arg1, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    %8 = llvm.icmp "ugt" %arg1, %arg2 : i32
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

theorem inst_combine_ule_umax_contextual_commuted   : ule_umax_contextual_commuted_before  ⊑  ule_umax_contextual_commuted_combined := by
  unfold ule_umax_contextual_commuted_before ule_umax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def ugt_umax_contextual_combined := [llvmfunc|
  llvm.func @ugt_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
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
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_ugt_umax_contextual   : ugt_umax_contextual_before  ⊑  ugt_umax_contextual_combined := by
  unfold ugt_umax_contextual_before ugt_umax_contextual_combined
  simp_alive_peephole
  sorry
def ugt_umax_contextual_commuted_combined := [llvmfunc|
  llvm.func @ugt_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
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
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_ugt_umax_contextual_commuted   : ugt_umax_contextual_commuted_before  ⊑  ugt_umax_contextual_commuted_combined := by
  unfold ugt_umax_contextual_commuted_before ugt_umax_contextual_commuted_combined
  simp_alive_peephole
  sorry
def uge_umax_contextual_combined := [llvmfunc|
  llvm.func @uge_umax_contextual(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    %8 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %10 = llvm.icmp "eq" %3, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %3, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_uge_umax_contextual   : uge_umax_contextual_before  ⊑  uge_umax_contextual_combined := by
  unfold uge_umax_contextual_before uge_umax_contextual_combined
  simp_alive_peephole
  sorry
def uge_umax_contextual_commuted_combined := [llvmfunc|
  llvm.func @uge_umax_contextual_commuted(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg0, %arg2 : i32
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "slt" %3, %arg2 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.icmp "sle" %3, %arg2 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.icmp "sgt" %3, %arg2 : i32
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.icmp "sge" %3, %arg2 : i32
    llvm.call @use(%7) : (i1) -> ()
    llvm.call @use(%0) : (i1) -> ()
    %8 = llvm.icmp "ule" %3, %arg2 : i32
    llvm.call @use(%8) : (i1) -> ()
    %9 = llvm.icmp "ugt" %3, %arg2 : i32
    llvm.call @use(%9) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    %10 = llvm.icmp "eq" %3, %arg2 : i32
    llvm.call @use(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %3, %arg2 : i32
    llvm.call @use(%11) : (i1) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_uge_umax_contextual_commuted   : uge_umax_contextual_commuted_before  ⊑  uge_umax_contextual_commuted_combined := by
  unfold uge_umax_contextual_commuted_before uge_umax_contextual_commuted_combined
  simp_alive_peephole
  sorry

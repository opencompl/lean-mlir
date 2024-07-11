import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-08-05-And
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %4 = llvm.sub %3, %0  : i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    %6 = llvm.sub %3, %2  : i8
    %7 = llvm.icmp "ugt" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    llvm.return
  }]

def f_logical_before := [llvmfunc|
  llvm.func @f_logical(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %5 = llvm.sub %4, %0  : i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    %7 = llvm.sub %4, %2  : i8
    %8 = llvm.icmp "ugt" %7, %1 : i8
    %9 = llvm.select %6, %8, %3 : i1, i1
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-9 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.mlir.constant(-13 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %4 = llvm.add %3, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %3, %2  : i8
    %7 = llvm.icmp "ult" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def f_logical_combined := [llvmfunc|
  llvm.func @f_logical(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-9 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.mlir.constant(-13 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %4 = llvm.add %3, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %3, %2  : i8
    %7 = llvm.icmp "ult" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_f_logical   : f_logical_before  ⊑  f_logical_combined := by
  unfold f_logical_before f_logical_combined
  simp_alive_peephole
  sorry

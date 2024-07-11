import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr2996
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_53_before := [llvmfunc|
  llvm.func @func_53(%arg0: i16 {llvm.signext}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i16
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.call @func_4(%4) vararg(!llvm.func<i32 (...)>) : (i32) -> i32
    llvm.return
  }]

def func_53_combined := [llvmfunc|
  llvm.func @func_53(%arg0: i16 {llvm.signext}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.call @func_4(%2) vararg(!llvm.func<i32 (...)>) : (i32) -> i32
    llvm.return
  }]

theorem inst_combine_func_53   : func_53_before  ⊑  func_53_combined := by
  unfold func_53_before func_53_combined
  simp_alive_peephole
  sorry

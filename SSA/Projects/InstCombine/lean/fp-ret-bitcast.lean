import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fp-ret-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bork_before := [llvmfunc|
  llvm.func @bork() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("whiteComponent\00") : !llvm.array<15 x i8>
    %2 = llvm.mlir.addressof @"\01L_OBJC_METH_VAR_NAME_112" : !llvm.ptr
    %3 = llvm.mlir.addressof @"\01L_OBJC_SELECTOR_REFERENCES_81" : !llvm.ptr
    %4 = llvm.mlir.addressof @objc_msgSend_fpret : !llvm.ptr
    %5 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %7, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    %8 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    %10 = llvm.call %4(%9, %8) : !llvm.ptr, (!llvm.ptr, !llvm.ptr) -> f32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def bork_combined := [llvmfunc|
  llvm.func @bork() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("whiteComponent\00") : !llvm.array<15 x i8>
    %2 = llvm.mlir.addressof @"\01L_OBJC_METH_VAR_NAME_112" : !llvm.ptr
    %3 = llvm.mlir.addressof @"\01L_OBJC_SELECTOR_REFERENCES_81" : !llvm.ptr
    %4 = llvm.mlir.addressof @objc_msgSend_fpret : !llvm.ptr
    %5 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %8 = llvm.call %4(%6, %7) : !llvm.ptr, (!llvm.ptr, !llvm.ptr) -> f32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_bork   : bork_before  ⊑  bork_combined := by
  unfold bork_before bork_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  intptr7
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def matching_phi_before := [llvmfunc|
  llvm.func @matching_phi(%arg0: i64, %arg1: !llvm.ptr, %arg2: i1) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %4 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %5 = llvm.icmp "eq" %arg2, %0 : i1
    %6 = llvm.add %arg0, %1  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %8 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8, %9 : !llvm.ptr, i64)
  ^bb2:  // pred: ^bb0
    llvm.store %3, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb3(%7, %6 : !llvm.ptr, i64)
  ^bb3(%10: !llvm.ptr, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.inttoptr %11 : i64 to !llvm.ptr
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %14 = llvm.fmul %13, %4  : f32
    llvm.store %14, %10 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.return
  }]

def no_matching_phi_before := [llvmfunc|
  llvm.func @no_matching_phi(%arg0: i64, %arg1: !llvm.ptr, %arg2: i1) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %4 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %5 = llvm.icmp "eq" %arg2, %0 : i1
    %6 = llvm.add %arg0, %1  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %8 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8, %6 : !llvm.ptr, i64)
  ^bb2:  // pred: ^bb0
    llvm.store %3, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb3(%7, %9 : !llvm.ptr, i64)
  ^bb3(%10: !llvm.ptr, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.inttoptr %11 : i64 to !llvm.ptr
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %14 = llvm.fmul %13, %4  : f32
    llvm.store %14, %10 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.return
  }]

def matching_phi_combined := [llvmfunc|
  llvm.func @matching_phi(%arg0: i64, %arg1: !llvm.ptr, %arg2: i1) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    llvm.cond_br %arg2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.br ^bb3(%4 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %5 = llvm.add %arg0, %1  : i64
    %6 = llvm.inttoptr %5 : i64 to !llvm.ptr
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb3(%6 : !llvm.ptr)
  ^bb3(%7: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %9 = llvm.fmul %8, %3  : f32
    llvm.store %9, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_matching_phi   : matching_phi_before  ⊑  matching_phi_combined := by
  unfold matching_phi_before matching_phi_combined
  simp_alive_peephole
  sorry
def no_matching_phi_combined := [llvmfunc|
  llvm.func @no_matching_phi(%arg0: i64, %arg1: !llvm.ptr, %arg2: i1) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.add %arg0, %0  : i64
    %5 = llvm.getelementptr inbounds %arg1[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.cond_br %arg2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.inttoptr %4 : i64 to !llvm.ptr
    llvm.br ^bb3(%5, %6 : !llvm.ptr, !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %7 = llvm.inttoptr %4 : i64 to !llvm.ptr
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb3(%7, %5 : !llvm.ptr, !llvm.ptr)
  ^bb3(%8: !llvm.ptr, %9: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.fmul %10, %3  : f32
    llvm.store %11, %8 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_no_matching_phi   : no_matching_phi_before  ⊑  no_matching_phi_combined := by
  unfold no_matching_phi_before no_matching_phi_combined
  simp_alive_peephole
  sorry

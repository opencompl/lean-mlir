import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  no-negzero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mysqrt_before := [llvmfunc|
  llvm.func @mysqrt(%arg0: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.bitcast %1 : i32 to i32
    llvm.store %arg0, %3 {alignment = 4 : i64} : f64, !llvm.ptr]

    %7 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %8 = llvm.call @fabs(%7) : (f64) -> f64
    %9 = llvm.call @sqrt(%8) : (f64) -> f64
    %10 = llvm.fadd %9, %2  : f64
    llvm.store %10, %5 {alignment = 8 : i64} : f64, !llvm.ptr]

    %11 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> f64]

    llvm.store %11, %4 {alignment = 8 : i64} : f64, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %12 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f64]

    llvm.return %12 : f64
  }]

def mysqrt_combined := [llvmfunc|
  llvm.func @mysqrt(%arg0: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %4 = llvm.call @sqrt(%3) : (f64) -> f64
    %5 = llvm.fadd %4, %1  : f64
    llvm.store %5, %2 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> f64
    llvm.return %6 : f64
  }]

theorem inst_combine_mysqrt   : mysqrt_before  ⊑  mysqrt_combined := by
  unfold mysqrt_before mysqrt_combined
  simp_alive_peephole
  sorry

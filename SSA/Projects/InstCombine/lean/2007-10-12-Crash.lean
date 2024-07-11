import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-10-12-Crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(512 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.icmp "slt" %1, %2 : i32
    llvm.cond_br %7, ^bb4, ^bb6
  ^bb1:  // pred: ^bb2
    %8 = llvm.getelementptr %6[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.Vec", (f64, f64, f64)>
    llvm.store %4, %8 {alignment = 8 : i64} : f64, !llvm.ptr]

    %9 = llvm.call @_Z9ray_traceRK3VecRK3RayRK5Scene(%5, %6, %5) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> f64
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb4
    %10 = llvm.icmp "slt" %1, %3 : i32
    llvm.cond_br %10, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %1 : i32
  ^bb4:  // pred: ^bb0
    %11 = llvm.icmp "slt" %1, %3 : i32
    llvm.cond_br %11, ^bb2, ^bb5
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i32
  ^bb6:  // pred: ^bb0
    llvm.return %1 : i32
  }]


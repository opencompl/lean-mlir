import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-02-13-FCmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z8tempCastj_before := [llvmfunc|
  llvm.func @_Z8tempCastj(%arg0: i32) -> i64 attributes {passthrough = ["ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %1 = llvm.mlir.constant("\0Ain_range input (should be 0): %f\0A\00") : !llvm.array<35 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %7 = llvm.call @printf(%0, %arg0) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    %8 = llvm.uitofp %arg0 : i32 to f64
    %9 = llvm.call @printf(%2, %8) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %10 = llvm.fcmp "oge" %8, %3 : f64
    llvm.cond_br %10, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %11 = llvm.fcmp "olt" %8, %4 : f64
    llvm.cond_br %11, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %12 = llvm.fadd %8, %6  : f64
    %13 = llvm.fptosi %12 : f64 to i64
    llvm.br ^bb5(%13 : i64)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb5(%5 : i64)
  ^bb5(%14: i64):  // 2 preds: ^bb2, ^bb4
    llvm.return %14 : i64
  }]

def _Z8tempCastj_combined := [llvmfunc|
  llvm.func @_Z8tempCastj(%arg0: i32) -> i64 attributes {passthrough = ["ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %1 = llvm.mlir.constant("\0Ain_range input (should be 0): %f\0A\00") : !llvm.array<35 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %7 = llvm.call @printf(%0, %arg0) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    %8 = llvm.uitofp %arg0 : i32 to f64
    %9 = llvm.call @printf(%2, %8) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %10 = llvm.icmp "eq" %arg0, %4 : i32
    llvm.cond_br %10, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %11 = llvm.fadd %8, %6  : f64
    %12 = llvm.fptosi %11 : f64 to i64
    llvm.br ^bb5(%12 : i64)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb5(%5 : i64)
  ^bb5(%13: i64):  // 2 preds: ^bb2, ^bb4
    llvm.return %13 : i64
  }]

theorem inst_combine__Z8tempCastj   : _Z8tempCastj_before  ⊑  _Z8tempCastj_combined := by
  unfold _Z8tempCastj_before _Z8tempCastj_combined
  simp_alive_peephole
  sorry

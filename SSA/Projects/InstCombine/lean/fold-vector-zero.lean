import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-vector-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-2222 : i64) : i64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %4 = llvm.mlir.undef : vector<2xi64>
    %5 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.constant(16 : i64) : i64
    %10 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i64)
  ^bb1(%11: i64, %12: i64):  // 2 preds: ^bb0, ^bb1
    %13 = llvm.add %11, %arg1  : i64
    %14 = llvm.inttoptr %13 : i64 to !llvm.ptr
    %15 = llvm.load %14 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf64>]

    %16 = llvm.bitcast %15 : vector<2xf64> to vector<2xi64>
    %17 = llvm.bitcast %3 : vector<2xf64> to vector<2xi64>
    %18 = llvm.insertelement %5, %4[%6 : i32] : vector<2xi64>
    %19 = llvm.insertelement %7, %4[%6 : i32] : vector<2xi64>
    %20 = llvm.insertelement %5, %18[%8 : i32] : vector<2xi64>
    %21 = llvm.insertelement %7, %19[%8 : i32] : vector<2xi64>
    %22 = llvm.and %16, %20  : vector<2xi64>
    %23 = llvm.and %17, %21  : vector<2xi64>
    %24 = llvm.or %22, %23  : vector<2xi64>
    %25 = llvm.bitcast %24 : vector<2xi64> to vector<2xf64>
    %26 = llvm.add %11, %arg0  : i64
    %27 = llvm.inttoptr %26 : i64 to !llvm.ptr
    llvm.store %25, %27 {alignment = 8 : i64} : vector<2xf64>, !llvm.ptr]

    %28 = llvm.add %9, %11  : i64
    %29 = llvm.add %10, %12  : i64
    %30 = llvm.icmp "slt" %29, %0 : i64
    %31 = llvm.zext %30 : i1 to i64
    %32 = llvm.icmp "ne" %31, %0 : i64
    llvm.cond_br %32, ^bb1(%28, %29 : i64, i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-2222 : i64) : i64
    %2 = llvm.mlir.constant(dense<9223372036854775807> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i64)
  ^bb1(%6: i64, %7: i64):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.add %6, %arg1  : i64
    %9 = llvm.inttoptr %8 : i64 to !llvm.ptr
    %10 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> vector<2xi64>
    %11 = llvm.and %10, %2  : vector<2xi64>
    %12 = llvm.add %6, %arg0  : i64
    %13 = llvm.inttoptr %12 : i64 to !llvm.ptr
    llvm.store %11, %13 {alignment = 8 : i64} : vector<2xi64>, !llvm.ptr
    %14 = llvm.add %6, %3  : i64
    %15 = llvm.add %7, %4  : i64
    %16 = llvm.icmp "sgt" %15, %5 : i64
    llvm.cond_br %16, ^bb2, ^bb1(%14, %15 : i64, i64)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry

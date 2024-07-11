import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-12-08-Phi-ICmp-Op-Fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def visible_before := [llvmfunc|
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x !llvm.struct<"struct.point", (i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.getelementptr %3[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg1, %7 {alignment = 4 : i64} : i64, !llvm.ptr]

    %8 = llvm.getelementptr %4[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg2, %8 {alignment = 4 : i64} : i64, !llvm.ptr]

    %9 = llvm.getelementptr %5[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    llvm.store %arg3, %9 {alignment = 4 : i64} : i64, !llvm.ptr]

    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.getelementptr %3[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %13 = llvm.getelementptr %4[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    %14 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %15 = llvm.getelementptr %5[%2, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(i64)>
    %16 = llvm.load %15 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %17 = llvm.call @determinant(%12, %14, %16) : (i64, i64, i64) -> i32
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %18 = llvm.icmp "slt" %17, %1 : i32
    %19 = llvm.zext %18 : i1 to i32
    llvm.br ^bb3(%19 : i32)
  ^bb2:  // pred: ^bb0
    %20 = llvm.icmp "sgt" %17, %1 : i32
    %21 = llvm.zext %20 : i1 to i32
    llvm.br ^bb3(%21 : i32)
  ^bb3(%22: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %22 : i32
  }]

def visible_combined := [llvmfunc|
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.call @determinant(%arg1, %arg2, %arg3) : (i64, i64, i64) -> i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.lshr %3, %1  : i32
    llvm.br ^bb3(%4 : i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.icmp "sgt" %3, %0 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.br ^bb3(%6 : i32)
  ^bb3(%7: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %7 : i32
  }]

theorem inst_combine_visible   : visible_before  ⊑  visible_combined := by
  unfold visible_before visible_combined
  simp_alive_peephole
  sorry

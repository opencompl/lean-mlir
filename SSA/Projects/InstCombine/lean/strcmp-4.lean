import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcmp-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strcmp_s3_x_s4_s3_before := [llvmfunc|
  llvm.func @fold_strcmp_s3_x_s4_s3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("123456789\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s9 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %6 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %7 = llvm.select %arg0, %5, %6 : i1, !llvm.ptr
    %8 = llvm.call @strcmp(%7, %5) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }]

def fold_strcmp_s3_x_s4_s3_combined := [llvmfunc|
  llvm.func @fold_strcmp_s3_x_s4_s3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("123456789\00") : !llvm.array<10 x i8>
    %3 = llvm.mlir.addressof @s9 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.getelementptr inbounds %3[%1, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %7 = llvm.select %arg0, %4, %6 : i1, !llvm.ptr
    %8 = llvm.call @strcmp(%7, %4) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }]

theorem inst_combine_fold_strcmp_s3_x_s4_s3   : fold_strcmp_s3_x_s4_s3_before  ⊑  fold_strcmp_s3_x_s4_s3_combined := by
  unfold fold_strcmp_s3_x_s4_s3_before fold_strcmp_s3_x_s4_s3_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  wcslen-6
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_af_before := [llvmfunc|
  llvm.func @fold_af() -> i64 {
    %0 = llvm.mlir.constant(dense<[1.231200e+00, 0.000000e+00]> : tensor<2xf32>) : !llvm.array<2 x f32>
    %1 = llvm.mlir.addressof @af : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def fold_aS_before := [llvmfunc|
  llvm.func @fold_aS() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.S", (i32)> 
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.S", (i32)> 
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.S", (i32)> 
    %9 = llvm.mlir.undef : !llvm.array<3 x struct<"struct.S", (i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %11 = llvm.insertvalue %5, %10[1] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %12 = llvm.insertvalue %2, %11[2] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %13 = llvm.mlir.addressof @aS : !llvm.ptr
    %14 = llvm.call @wcslen(%13) : (!llvm.ptr) -> i64
    llvm.return %14 : i64
  }]

def fold_af_combined := [llvmfunc|
  llvm.func @fold_af() -> i64 {
    %0 = llvm.mlir.constant(dense<[1.231200e+00, 0.000000e+00]> : tensor<2xf32>) : !llvm.array<2 x f32>
    %1 = llvm.mlir.addressof @af : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fold_af   : fold_af_before  ⊑  fold_af_combined := by
  unfold fold_af_before fold_af_combined
  simp_alive_peephole
  sorry
def fold_aS_combined := [llvmfunc|
  llvm.func @fold_aS() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.S", (i32)> 
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.S", (i32)> 
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<"struct.S", (i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.S", (i32)> 
    %9 = llvm.mlir.undef : !llvm.array<3 x struct<"struct.S", (i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %11 = llvm.insertvalue %5, %10[1] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %12 = llvm.insertvalue %2, %11[2] : !llvm.array<3 x struct<"struct.S", (i32)>> 
    %13 = llvm.mlir.addressof @aS : !llvm.ptr
    %14 = llvm.call @wcslen(%13) : (!llvm.ptr) -> i64
    llvm.return %14 : i64
  }]

theorem inst_combine_fold_aS   : fold_aS_before  ⊑  fold_aS_combined := by
  unfold fold_aS_before fold_aS_combined
  simp_alive_peephole
  sorry

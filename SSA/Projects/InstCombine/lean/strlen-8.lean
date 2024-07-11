import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-8
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_a5_4_i0_pI_before := [llvmfunc|
  llvm.func @fold_a5_4_i0_pI(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.getelementptr %11[%12, %12, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strlen(%13) : (!llvm.ptr) -> i64
    llvm.return %14 : i64
  }]

def fold_a5_4_i1_pI_before := [llvmfunc|
  llvm.func @fold_a5_4_i1_pI(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

def fold_a5_4_i2_pI_before := [llvmfunc|
  llvm.func @fold_a5_4_i2_pI(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

def fold_a5_4_i3_pI_to_0_before := [llvmfunc|
  llvm.func @fold_a5_4_i3_pI_to_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

def fold_a5_4_i4_pI_to_0_before := [llvmfunc|
  llvm.func @fold_a5_4_i4_pI_to_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

def fold_a5_4_i0_pI_combined := [llvmfunc|
  llvm.func @fold_a5_4_i0_pI(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.getelementptr %11[%12, %12, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strlen(%13) : (!llvm.ptr) -> i64
    llvm.return %14 : i64
  }]

theorem inst_combine_fold_a5_4_i0_pI   : fold_a5_4_i0_pI_before  ⊑  fold_a5_4_i0_pI_combined := by
  unfold fold_a5_4_i0_pI_before fold_a5_4_i0_pI_combined
  simp_alive_peephole
  sorry
def fold_a5_4_i1_pI_combined := [llvmfunc|
  llvm.func @fold_a5_4_i1_pI(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

theorem inst_combine_fold_a5_4_i1_pI   : fold_a5_4_i1_pI_before  ⊑  fold_a5_4_i1_pI_combined := by
  unfold fold_a5_4_i1_pI_before fold_a5_4_i1_pI_combined
  simp_alive_peephole
  sorry
def fold_a5_4_i2_pI_combined := [llvmfunc|
  llvm.func @fold_a5_4_i2_pI(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

theorem inst_combine_fold_a5_4_i2_pI   : fold_a5_4_i2_pI_before  ⊑  fold_a5_4_i2_pI_combined := by
  unfold fold_a5_4_i2_pI_before fold_a5_4_i2_pI_combined
  simp_alive_peephole
  sorry
def fold_a5_4_i3_pI_to_0_combined := [llvmfunc|
  llvm.func @fold_a5_4_i3_pI_to_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

theorem inst_combine_fold_a5_4_i3_pI_to_0   : fold_a5_4_i3_pI_to_0_before  ⊑  fold_a5_4_i3_pI_to_0_combined := by
  unfold fold_a5_4_i3_pI_to_0_before fold_a5_4_i3_pI_to_0_combined
  simp_alive_peephole
  sorry
def fold_a5_4_i4_pI_to_0_combined := [llvmfunc|
  llvm.func @fold_a5_4_i4_pI_to_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }]

theorem inst_combine_fold_a5_4_i4_pI_to_0   : fold_a5_4_i4_pI_to_0_before  ⊑  fold_a5_4_i4_pI_to_0_combined := by
  unfold fold_a5_4_i4_pI_to_0_before fold_a5_4_i4_pI_to_0_combined
  simp_alive_peephole
  sorry

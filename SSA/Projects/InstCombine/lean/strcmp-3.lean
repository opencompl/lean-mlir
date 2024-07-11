import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcmp-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strcmp_a5i0_a5i1_to_0_before := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_a5i1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }]

def call_strcmp_a5i0_a5iI_before := [llvmfunc|
  llvm.func @call_strcmp_a5i0_a5iI(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr %10[%11, %arg0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %13 = llvm.call @strcmp(%10, %12) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %13 : i32
  }]

def call_strcmp_a5iI_a5i0_before := [llvmfunc|
  llvm.func @call_strcmp_a5iI_a5i0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr %10[%11, %arg0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %13 = llvm.call @strcmp(%12, %10) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %13 : i32
  }]

def fold_strcmp_a5i0_a5i1_p1_to_0_before := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_a5i1_p1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }]

def call_strcmp_a5i0_a5i1_pI_before := [llvmfunc|
  llvm.func @call_strcmp_a5i0_a5i1_pI(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }]

def fold_strcmp_a5i0_p1_a5i1_to_0_before := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_p1_a5i1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %11, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strcmp(%13, %14) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %15 : i32
  }]

def fold_strcmp_a5i0_a5i2_to_0_before := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_a5i2_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }]

def fold_strcmp_a5i2_a5i0_to_m1_before := [llvmfunc|
  llvm.func @fold_strcmp_a5i2_a5i0_to_m1() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%13, %10) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }]

def fold_strcmp_a5i0_a5i1_to_0_combined := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_a5i1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strcmp_a5i0_a5i1_to_0   : fold_strcmp_a5i0_a5i1_to_0_before  ⊑  fold_strcmp_a5i0_a5i1_to_0_combined := by
  unfold fold_strcmp_a5i0_a5i1_to_0_before fold_strcmp_a5i0_a5i1_to_0_combined
  simp_alive_peephole
  sorry
def call_strcmp_a5i0_a5iI_combined := [llvmfunc|
  llvm.func @call_strcmp_a5i0_a5iI(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr %10[%11, %arg0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %13 = llvm.call @strcmp(%10, %12) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %13 : i32
  }]

theorem inst_combine_call_strcmp_a5i0_a5iI   : call_strcmp_a5i0_a5iI_before  ⊑  call_strcmp_a5i0_a5iI_combined := by
  unfold call_strcmp_a5i0_a5iI_before call_strcmp_a5i0_a5iI_combined
  simp_alive_peephole
  sorry
def call_strcmp_a5iI_a5i0_combined := [llvmfunc|
  llvm.func @call_strcmp_a5iI_a5i0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr %10[%11, %arg0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %13 = llvm.call @strcmp(%12, %10) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %13 : i32
  }]

theorem inst_combine_call_strcmp_a5iI_a5i0   : call_strcmp_a5iI_a5i0_before  ⊑  call_strcmp_a5iI_a5i0_combined := by
  unfold call_strcmp_a5iI_a5i0_before call_strcmp_a5iI_a5i0_combined
  simp_alive_peephole
  sorry
def fold_strcmp_a5i0_a5i1_p1_to_0_combined := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_a5i1_p1_to_0() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strcmp_a5i0_a5i1_p1_to_0   : fold_strcmp_a5i0_a5i1_p1_to_0_before  ⊑  fold_strcmp_a5i0_a5i1_p1_to_0_combined := by
  unfold fold_strcmp_a5i0_a5i1_p1_to_0_before fold_strcmp_a5i0_a5i1_p1_to_0_combined
  simp_alive_peephole
  sorry
def call_strcmp_a5i0_a5i1_pI_combined := [llvmfunc|
  llvm.func @call_strcmp_a5i0_a5i1_pI(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }]

theorem inst_combine_call_strcmp_a5i0_a5i1_pI   : call_strcmp_a5i0_a5i1_pI_before  ⊑  call_strcmp_a5i0_a5i1_pI_combined := by
  unfold call_strcmp_a5i0_a5i1_pI_before call_strcmp_a5i0_a5i1_pI_combined
  simp_alive_peephole
  sorry
def fold_strcmp_a5i0_p1_a5i1_to_0_combined := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_p1_a5i1_to_0() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strcmp_a5i0_p1_a5i1_to_0   : fold_strcmp_a5i0_p1_a5i1_to_0_before  ⊑  fold_strcmp_a5i0_p1_a5i1_to_0_combined := by
  unfold fold_strcmp_a5i0_p1_a5i1_to_0_before fold_strcmp_a5i0_p1_a5i1_to_0_combined
  simp_alive_peephole
  sorry
def fold_strcmp_a5i0_a5i2_to_0_combined := [llvmfunc|
  llvm.func @fold_strcmp_a5i0_a5i2_to_0() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strcmp_a5i0_a5i2_to_0   : fold_strcmp_a5i0_a5i2_to_0_before  ⊑  fold_strcmp_a5i0_a5i2_to_0_combined := by
  unfold fold_strcmp_a5i0_a5i2_to_0_before fold_strcmp_a5i0_a5i2_to_0_combined
  simp_alive_peephole
  sorry
def fold_strcmp_a5i2_a5i0_to_m1_combined := [llvmfunc|
  llvm.func @fold_strcmp_a5i2_a5i0_to_m1() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strcmp_a5i2_a5i0_to_m1   : fold_strcmp_a5i2_a5i0_to_m1_before  ⊑  fold_strcmp_a5i2_a5i0_to_m1_combined := by
  unfold fold_strcmp_a5i2_a5i0_to_m1_before fold_strcmp_a5i2_a5i0_to_m1_combined
  simp_alive_peephole
  sorry

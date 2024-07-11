import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  signbit-lshr-and-icmpeq-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def scalar_i8_signbit_lshr_and_eq_before := [llvmfunc|
  llvm.func @scalar_i8_signbit_lshr_and_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def scalar_i16_signbit_lshr_and_eq_before := [llvmfunc|
  llvm.func @scalar_i16_signbit_lshr_and_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.lshr %0, %arg1  : i16
    %3 = llvm.and %2, %arg0  : i16
    %4 = llvm.icmp "eq" %3, %1 : i16
    llvm.return %4 : i1
  }]

def scalar_i32_signbit_lshr_and_eq_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def scalar_i64_signbit_lshr_and_eq_before := [llvmfunc|
  llvm.func @scalar_i64_signbit_lshr_and_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.lshr %0, %arg1  : i64
    %3 = llvm.and %2, %arg0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    llvm.return %4 : i1
  }]

def scalar_i32_signbit_lshr_and_ne_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def vec_4xi32_signbit_lshr_and_eq_before := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.lshr %0, %arg1  : vector<4xi32>
    %4 = llvm.and %3, %arg0  : vector<4xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<4xi32>
    llvm.return %5 : vector<4xi1>
  }]

def vec_4xi32_signbit_lshr_and_eq_undef1_before := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq_undef1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(2147473648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.lshr %11, %arg1  : vector<4xi32>
    %15 = llvm.and %14, %arg0  : vector<4xi32>
    %16 = llvm.icmp "eq" %15, %13 : vector<4xi32>
    llvm.return %16 : vector<4xi1>
  }]

def vec_4xi32_signbit_lshr_and_eq_undef2_before := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq_undef2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[-2147483648, -2147483648, -2147483648, 2147473648]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.lshr %0, %arg1  : vector<4xi32>
    %13 = llvm.and %12, %arg0  : vector<4xi32>
    %14 = llvm.icmp "eq" %13, %11 : vector<4xi32>
    llvm.return %14 : vector<4xi1>
  }]

def vec_4xi32_signbit_lshr_and_eq_undef3_before := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq_undef3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(2147473648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %12, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %12, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.lshr %11, %arg1  : vector<4xi32>
    %23 = llvm.and %22, %arg0  : vector<4xi32>
    %24 = llvm.icmp "eq" %23, %21 : vector<4xi32>
    llvm.return %24 : vector<4xi1>
  }]

def scalar_i32_signbit_lshr_and_eq_extra_use_lshr_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_extra_use_lshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_signbit_lshr_and_eq_extra_use_and_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.mul %3, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.add %2, %arg2  : i32
    llvm.store %4, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_signbit_lshr_and_eq_X_is_constant1_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_X_is_constant1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(12345 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_signbit_lshr_and_eq_X_is_constant2_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_X_is_constant2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_signbit_lshr_and_slt_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def scalar_i32_signbit_lshr_and_eq_nonzero_before := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_nonzero(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def scalar_i8_signbit_lshr_and_eq_combined := [llvmfunc|
  llvm.func @scalar_i8_signbit_lshr_and_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i8_signbit_lshr_and_eq   : scalar_i8_signbit_lshr_and_eq_before  ⊑  scalar_i8_signbit_lshr_and_eq_combined := by
  unfold scalar_i8_signbit_lshr_and_eq_before scalar_i8_signbit_lshr_and_eq_combined
  simp_alive_peephole
  sorry
def scalar_i16_signbit_lshr_and_eq_combined := [llvmfunc|
  llvm.func @scalar_i16_signbit_lshr_and_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.lshr %0, %arg1  : i16
    %3 = llvm.and %2, %arg0  : i16
    %4 = llvm.icmp "eq" %3, %1 : i16
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i16_signbit_lshr_and_eq   : scalar_i16_signbit_lshr_and_eq_before  ⊑  scalar_i16_signbit_lshr_and_eq_combined := by
  unfold scalar_i16_signbit_lshr_and_eq_before scalar_i16_signbit_lshr_and_eq_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq   : scalar_i32_signbit_lshr_and_eq_before  ⊑  scalar_i32_signbit_lshr_and_eq_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_before scalar_i32_signbit_lshr_and_eq_combined
  simp_alive_peephole
  sorry
def scalar_i64_signbit_lshr_and_eq_combined := [llvmfunc|
  llvm.func @scalar_i64_signbit_lshr_and_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.lshr %0, %arg1  : i64
    %3 = llvm.and %2, %arg0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i64_signbit_lshr_and_eq   : scalar_i64_signbit_lshr_and_eq_before  ⊑  scalar_i64_signbit_lshr_and_eq_combined := by
  unfold scalar_i64_signbit_lshr_and_eq_before scalar_i64_signbit_lshr_and_eq_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_ne_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_ne   : scalar_i32_signbit_lshr_and_ne_before  ⊑  scalar_i32_signbit_lshr_and_ne_combined := by
  unfold scalar_i32_signbit_lshr_and_ne_before scalar_i32_signbit_lshr_and_ne_combined
  simp_alive_peephole
  sorry
def vec_4xi32_signbit_lshr_and_eq_combined := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.lshr %0, %arg1  : vector<4xi32>
    %4 = llvm.and %3, %arg0  : vector<4xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<4xi32>
    llvm.return %5 : vector<4xi1>
  }]

theorem inst_combine_vec_4xi32_signbit_lshr_and_eq   : vec_4xi32_signbit_lshr_and_eq_before  ⊑  vec_4xi32_signbit_lshr_and_eq_combined := by
  unfold vec_4xi32_signbit_lshr_and_eq_before vec_4xi32_signbit_lshr_and_eq_combined
  simp_alive_peephole
  sorry
def vec_4xi32_signbit_lshr_and_eq_undef1_combined := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq_undef1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(2147473648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.lshr %11, %arg1  : vector<4xi32>
    %15 = llvm.and %14, %arg0  : vector<4xi32>
    %16 = llvm.icmp "eq" %15, %13 : vector<4xi32>
    llvm.return %16 : vector<4xi1>
  }]

theorem inst_combine_vec_4xi32_signbit_lshr_and_eq_undef1   : vec_4xi32_signbit_lshr_and_eq_undef1_before  ⊑  vec_4xi32_signbit_lshr_and_eq_undef1_combined := by
  unfold vec_4xi32_signbit_lshr_and_eq_undef1_before vec_4xi32_signbit_lshr_and_eq_undef1_combined
  simp_alive_peephole
  sorry
def vec_4xi32_signbit_lshr_and_eq_undef2_combined := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq_undef2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[-2147483648, -2147483648, -2147483648, 2147473648]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.lshr %0, %arg1  : vector<4xi32>
    %13 = llvm.and %12, %arg0  : vector<4xi32>
    %14 = llvm.icmp "eq" %13, %11 : vector<4xi32>
    llvm.return %14 : vector<4xi1>
  }]

theorem inst_combine_vec_4xi32_signbit_lshr_and_eq_undef2   : vec_4xi32_signbit_lshr_and_eq_undef2_before  ⊑  vec_4xi32_signbit_lshr_and_eq_undef2_combined := by
  unfold vec_4xi32_signbit_lshr_and_eq_undef2_before vec_4xi32_signbit_lshr_and_eq_undef2_combined
  simp_alive_peephole
  sorry
def vec_4xi32_signbit_lshr_and_eq_undef3_combined := [llvmfunc|
  llvm.func @vec_4xi32_signbit_lshr_and_eq_undef3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(2147473648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %12, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %12, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.lshr %11, %arg1  : vector<4xi32>
    %23 = llvm.and %22, %arg0  : vector<4xi32>
    %24 = llvm.icmp "eq" %23, %21 : vector<4xi32>
    llvm.return %24 : vector<4xi1>
  }]

theorem inst_combine_vec_4xi32_signbit_lshr_and_eq_undef3   : vec_4xi32_signbit_lshr_and_eq_undef3_before  ⊑  vec_4xi32_signbit_lshr_and_eq_undef3_combined := by
  unfold vec_4xi32_signbit_lshr_and_eq_undef3_before vec_4xi32_signbit_lshr_and_eq_undef3_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_extra_use_lshr_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_extra_use_lshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq_extra_use_lshr   : scalar_i32_signbit_lshr_and_eq_extra_use_lshr_before  ⊑  scalar_i32_signbit_lshr_and_eq_extra_use_lshr_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_extra_use_lshr_before scalar_i32_signbit_lshr_and_eq_extra_use_lshr_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_extra_use_and_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.mul %3, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq_extra_use_and   : scalar_i32_signbit_lshr_and_eq_extra_use_and_before  ⊑  scalar_i32_signbit_lshr_and_eq_extra_use_and_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_extra_use_and_before scalar_i32_signbit_lshr_and_eq_extra_use_and_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.add %2, %arg2  : i32
    llvm.store %4, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and   : scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and_before  ⊑  scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and_before scalar_i32_signbit_lshr_and_eq_extra_use_lshr_and_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_X_is_constant1_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_X_is_constant1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(12345 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq_X_is_constant1   : scalar_i32_signbit_lshr_and_eq_X_is_constant1_before  ⊑  scalar_i32_signbit_lshr_and_eq_X_is_constant1_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_X_is_constant1_before scalar_i32_signbit_lshr_and_eq_X_is_constant1_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_X_is_constant2_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_X_is_constant2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq_X_is_constant2   : scalar_i32_signbit_lshr_and_eq_X_is_constant2_before  ⊑  scalar_i32_signbit_lshr_and_eq_X_is_constant2_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_X_is_constant2_before scalar_i32_signbit_lshr_and_eq_X_is_constant2_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_slt_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_slt   : scalar_i32_signbit_lshr_and_slt_before  ⊑  scalar_i32_signbit_lshr_and_slt_combined := by
  unfold scalar_i32_signbit_lshr_and_slt_before scalar_i32_signbit_lshr_and_slt_combined
  simp_alive_peephole
  sorry
def scalar_i32_signbit_lshr_and_eq_nonzero_combined := [llvmfunc|
  llvm.func @scalar_i32_signbit_lshr_and_eq_nonzero(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_scalar_i32_signbit_lshr_and_eq_nonzero   : scalar_i32_signbit_lshr_and_eq_nonzero_before  ⊑  scalar_i32_signbit_lshr_and_eq_nonzero_combined := by
  unfold scalar_i32_signbit_lshr_and_eq_nonzero_before scalar_i32_signbit_lshr_and_eq_nonzero_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shl-and-negC-icmpeq-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def scalar_i8_shl_and_negC_eq_before := [llvmfunc|
  llvm.func @scalar_i8_shl_and_negC_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %arg0, %arg1  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def scalar_i16_shl_and_negC_eq_before := [llvmfunc|
  llvm.func @scalar_i16_shl_and_negC_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.shl %arg0, %arg1  : i16
    %3 = llvm.and %2, %0  : i16
    %4 = llvm.icmp "eq" %3, %1 : i16
    llvm.return %4 : i1
  }]

def scalar_i32_shl_and_negC_eq_before := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-262144 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def scalar_i64_shl_and_negC_eq_before := [llvmfunc|
  llvm.func @scalar_i64_shl_and_negC_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-8589934592 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.shl %arg0, %arg1  : i64
    %3 = llvm.and %2, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    llvm.return %4 : i1
  }]

def scalar_i32_shl_and_negC_ne_before := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-262144 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def vec_4xi32_shl_and_negC_eq_before := [llvmfunc|
  llvm.func @vec_4xi32_shl_and_negC_eq(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %4 = llvm.and %3, %0  : vector<4xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<4xi32>
    llvm.return %5 : vector<4xi1>
  }]

def vec_shl_and_negC_eq_poison1_before := [llvmfunc|
  llvm.func @vec_shl_and_negC_eq_poison1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %13 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %14 = llvm.and %13, %10  : vector<4xi32>
    %15 = llvm.icmp "eq" %14, %12 : vector<4xi32>
    llvm.return %15 : vector<4xi1>
  }]

def vec_shl_and_negC_eq_poison2_before := [llvmfunc|
  llvm.func @vec_shl_and_negC_eq_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.poison : i32
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
    %12 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %13 = llvm.and %12, %0  : vector<4xi32>
    %14 = llvm.icmp "eq" %13, %11 : vector<4xi32>
    llvm.return %14 : vector<4xi1>
  }]

def vec_shl_and_negC_eq_poison3_before := [llvmfunc|
  llvm.func @vec_shl_and_negC_eq_poison3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %22 = llvm.and %21, %10  : vector<4xi32>
    %23 = llvm.icmp "eq" %22, %20 : vector<4xi32>
    llvm.return %23 : vector<4xi1>
  }]

def scalar_shl_and_negC_eq_extra_use_shl_before := [llvmfunc|
  llvm.func @scalar_shl_and_negC_eq_extra_use_shl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.xor %2, %arg2  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.and %2, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def scalar_shl_and_negC_eq_extra_use_and_before := [llvmfunc|
  llvm.func @scalar_shl_and_negC_eq_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.mul %3, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

def scalar_shl_and_negC_eq_extra_use_shl_and_before := [llvmfunc|
  llvm.func @scalar_shl_and_negC_eq_extra_use_shl_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.add %2, %arg2  : i32
    llvm.store %4, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_shl_and_negC_eq_X_is_constant1_before := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq_X_is_constant1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_shl_and_negC_eq_X_is_constant2_before := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq_X_is_constant2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def scalar_i32_shl_and_negC_slt_before := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def scalar_i32_shl_and_negC_eq_nonzero_before := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq_nonzero(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def scalar_i8_shl_and_negC_eq_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_and_negC_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %arg0, %arg1  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_i8_shl_and_negC_eq   : scalar_i8_shl_and_negC_eq_before  ⊑  scalar_i8_shl_and_negC_eq_combined := by
  unfold scalar_i8_shl_and_negC_eq_before scalar_i8_shl_and_negC_eq_combined
  simp_alive_peephole
  sorry
def scalar_i16_shl_and_negC_eq_combined := [llvmfunc|
  llvm.func @scalar_i16_shl_and_negC_eq(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.shl %arg0, %arg1  : i16
    %2 = llvm.icmp "ult" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_i16_shl_and_negC_eq   : scalar_i16_shl_and_negC_eq_before  ⊑  scalar_i16_shl_and_negC_eq_combined := by
  unfold scalar_i16_shl_and_negC_eq_before scalar_i16_shl_and_negC_eq_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_and_negC_eq_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(262144 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_i32_shl_and_negC_eq   : scalar_i32_shl_and_negC_eq_before  ⊑  scalar_i32_shl_and_negC_eq_combined := by
  unfold scalar_i32_shl_and_negC_eq_before scalar_i32_shl_and_negC_eq_combined
  simp_alive_peephole
  sorry
def scalar_i64_shl_and_negC_eq_combined := [llvmfunc|
  llvm.func @scalar_i64_shl_and_negC_eq(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(8589934592 : i64) : i64
    %1 = llvm.shl %arg0, %arg1  : i64
    %2 = llvm.icmp "ult" %1, %0 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_i64_shl_and_negC_eq   : scalar_i64_shl_and_negC_eq_before  ⊑  scalar_i64_shl_and_negC_eq_combined := by
  unfold scalar_i64_shl_and_negC_eq_before scalar_i64_shl_and_negC_eq_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_and_negC_ne_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(262143 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_i32_shl_and_negC_ne   : scalar_i32_shl_and_negC_ne_before  ⊑  scalar_i32_shl_and_negC_ne_combined := by
  unfold scalar_i32_shl_and_negC_ne_before scalar_i32_shl_and_negC_ne_combined
  simp_alive_peephole
  sorry
def vec_4xi32_shl_and_negC_eq_combined := [llvmfunc|
  llvm.func @vec_4xi32_shl_and_negC_eq(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_vec_4xi32_shl_and_negC_eq   : vec_4xi32_shl_and_negC_eq_before  ⊑  vec_4xi32_shl_and_negC_eq_combined := by
  unfold vec_4xi32_shl_and_negC_eq_before vec_4xi32_shl_and_negC_eq_combined
  simp_alive_peephole
  sorry
def vec_shl_and_negC_eq_poison1_combined := [llvmfunc|
  llvm.func @vec_shl_and_negC_eq_poison1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %13 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %14 = llvm.and %13, %10  : vector<4xi32>
    %15 = llvm.icmp "eq" %14, %12 : vector<4xi32>
    llvm.return %15 : vector<4xi1>
  }]

theorem inst_combine_vec_shl_and_negC_eq_poison1   : vec_shl_and_negC_eq_poison1_before  ⊑  vec_shl_and_negC_eq_poison1_combined := by
  unfold vec_shl_and_negC_eq_poison1_before vec_shl_and_negC_eq_poison1_combined
  simp_alive_peephole
  sorry
def vec_shl_and_negC_eq_poison2_combined := [llvmfunc|
  llvm.func @vec_shl_and_negC_eq_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.poison : i32
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
    %12 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %13 = llvm.and %12, %0  : vector<4xi32>
    %14 = llvm.icmp "eq" %13, %11 : vector<4xi32>
    llvm.return %14 : vector<4xi1>
  }]

theorem inst_combine_vec_shl_and_negC_eq_poison2   : vec_shl_and_negC_eq_poison2_before  ⊑  vec_shl_and_negC_eq_poison2_combined := by
  unfold vec_shl_and_negC_eq_poison2_before vec_shl_and_negC_eq_poison2_combined
  simp_alive_peephole
  sorry
def vec_shl_and_negC_eq_poison3_combined := [llvmfunc|
  llvm.func @vec_shl_and_negC_eq_poison3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %22 = llvm.and %21, %10  : vector<4xi32>
    %23 = llvm.icmp "eq" %22, %20 : vector<4xi32>
    llvm.return %23 : vector<4xi1>
  }]

theorem inst_combine_vec_shl_and_negC_eq_poison3   : vec_shl_and_negC_eq_poison3_before  ⊑  vec_shl_and_negC_eq_poison3_combined := by
  unfold vec_shl_and_negC_eq_poison3_before vec_shl_and_negC_eq_poison3_combined
  simp_alive_peephole
  sorry
def scalar_shl_and_negC_eq_extra_use_shl_combined := [llvmfunc|
  llvm.func @scalar_shl_and_negC_eq_extra_use_shl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.xor %1, %arg2  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_shl_and_negC_eq_extra_use_shl   : scalar_shl_and_negC_eq_extra_use_shl_before  ⊑  scalar_shl_and_negC_eq_extra_use_shl_combined := by
  unfold scalar_shl_and_negC_eq_extra_use_shl_before scalar_shl_and_negC_eq_extra_use_shl_combined
  simp_alive_peephole
  sorry
def scalar_shl_and_negC_eq_extra_use_and_combined := [llvmfunc|
  llvm.func @scalar_shl_and_negC_eq_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.mul %3, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_scalar_shl_and_negC_eq_extra_use_and   : scalar_shl_and_negC_eq_extra_use_and_before  ⊑  scalar_shl_and_negC_eq_extra_use_and_combined := by
  unfold scalar_shl_and_negC_eq_extra_use_and_before scalar_shl_and_negC_eq_extra_use_and_combined
  simp_alive_peephole
  sorry
def scalar_shl_and_negC_eq_extra_use_shl_and_combined := [llvmfunc|
  llvm.func @scalar_shl_and_negC_eq_extra_use_shl_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.add %2, %arg2  : i32
    llvm.store %4, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_scalar_shl_and_negC_eq_extra_use_shl_and   : scalar_shl_and_negC_eq_extra_use_shl_and_before  ⊑  scalar_shl_and_negC_eq_extra_use_shl_and_combined := by
  unfold scalar_shl_and_negC_eq_extra_use_shl_and_before scalar_shl_and_negC_eq_extra_use_shl_and_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_and_negC_eq_X_is_constant1_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq_X_is_constant1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i32_shl_and_negC_eq_X_is_constant1   : scalar_i32_shl_and_negC_eq_X_is_constant1_before  ⊑  scalar_i32_shl_and_negC_eq_X_is_constant1_combined := by
  unfold scalar_i32_shl_and_negC_eq_X_is_constant1_before scalar_i32_shl_and_negC_eq_X_is_constant1_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_and_negC_eq_X_is_constant2_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq_X_is_constant2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_scalar_i32_shl_and_negC_eq_X_is_constant2   : scalar_i32_shl_and_negC_eq_X_is_constant2_before  ⊑  scalar_i32_shl_and_negC_eq_X_is_constant2_combined := by
  unfold scalar_i32_shl_and_negC_eq_X_is_constant2_before scalar_i32_shl_and_negC_eq_X_is_constant2_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_and_negC_slt_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_scalar_i32_shl_and_negC_slt   : scalar_i32_shl_and_negC_slt_before  ⊑  scalar_i32_shl_and_negC_slt_combined := by
  unfold scalar_i32_shl_and_negC_slt_before scalar_i32_shl_and_negC_slt_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_and_negC_eq_nonzero_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_and_negC_eq_nonzero(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_scalar_i32_shl_and_negC_eq_nonzero   : scalar_i32_shl_and_negC_eq_nonzero_before  ⊑  scalar_i32_shl_and_negC_eq_nonzero_combined := by
  unfold scalar_i32_shl_and_negC_eq_nonzero_before scalar_i32_shl_and_negC_eq_nonzero_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shl-unsigned-cmp-const
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def scalar_i8_shl_ult_const_1_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_ult_const_2_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_ult_const_3_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i16_shl_ult_const_before := [llvmfunc|
  llvm.func @scalar_i16_shl_ult_const(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(1024 : i16) : i16
    %2 = llvm.shl %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

def scalar_i32_shl_ult_const_before := [llvmfunc|
  llvm.func @scalar_i32_shl_ult_const(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(131072 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def scalar_i64_shl_ult_const_before := [llvmfunc|
  llvm.func @scalar_i64_shl_ult_const(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(25 : i64) : i64
    %1 = llvm.mlir.constant(8589934592 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def scalar_i8_shl_uge_const_before := [llvmfunc|
  llvm.func @scalar_i8_shl_uge_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_ule_const_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ule_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_ugt_const_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ugt_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def vector_4xi32_shl_ult_const_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<11> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<131072> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<4xi32>
    llvm.return %3 : vector<4xi1>
  }]

def vector_4xi32_shl_ult_const_undef1_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const_undef1(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<131072> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.shl %arg0, %10  : vector<4xi32>
    %13 = llvm.icmp "ult" %12, %11 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

def vector_4xi32_shl_ult_const_undef2_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const_undef2(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<11> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(131072 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.shl %arg0, %0  : vector<4xi32>
    %13 = llvm.icmp "ult" %12, %11 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

def vector_4xi32_shl_ult_const_undef3_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const_undef3(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(131072 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.shl %arg0, %10  : vector<4xi32>
    %22 = llvm.icmp "ult" %21, %20 : vector<4xi32>
    llvm.return %22 : vector<4xi1>
  }]

def vector_4xi32_shl_uge_const_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_uge_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<11> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<131072> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.icmp "uge" %2, %1 : vector<4xi32>
    llvm.return %3 : vector<4xi1>
  }]

def vector_4xi32_shl_ule_const_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_ule_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<11> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<131071> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.icmp "ule" %2, %1 : vector<4xi32>
    llvm.return %3 : vector<4xi1>
  }]

def vector_4xi32_shl_ugt_const_before := [llvmfunc|
  llvm.func @vector_4xi32_shl_ugt_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<11> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<131071> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<4xi32>
    llvm.return %3 : vector<4xi1>
  }]

def scalar_i8_shl_ult_const_extra_use_shl_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_extra_use_shl(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_slt_const_before := [llvmfunc|
  llvm.func @scalar_i8_shl_slt_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_ugt_const_not_power_of_2_before := [llvmfunc|
  llvm.func @scalar_i8_shl_ugt_const_not_power_of_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(66 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def scalar_i8_shl_ult_const_1_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ult_const_1   : scalar_i8_shl_ult_const_1_before  ⊑  scalar_i8_shl_ult_const_1_combined := by
  unfold scalar_i8_shl_ult_const_1_before scalar_i8_shl_ult_const_1_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_ult_const_2_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ult_const_2   : scalar_i8_shl_ult_const_2_before  ⊑  scalar_i8_shl_ult_const_2_combined := by
  unfold scalar_i8_shl_ult_const_2_before scalar_i8_shl_ult_const_2_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_ult_const_3_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ult_const_3   : scalar_i8_shl_ult_const_3_before  ⊑  scalar_i8_shl_ult_const_3_combined := by
  unfold scalar_i8_shl_ult_const_3_before scalar_i8_shl_ult_const_3_combined
  simp_alive_peephole
  sorry
def scalar_i16_shl_ult_const_combined := [llvmfunc|
  llvm.func @scalar_i16_shl_ult_const(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(252 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "eq" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i16_shl_ult_const   : scalar_i16_shl_ult_const_before  ⊑  scalar_i16_shl_ult_const_combined := by
  unfold scalar_i16_shl_ult_const_before scalar_i16_shl_ult_const_combined
  simp_alive_peephole
  sorry
def scalar_i32_shl_ult_const_combined := [llvmfunc|
  llvm.func @scalar_i32_shl_ult_const(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2097088 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i32_shl_ult_const   : scalar_i32_shl_ult_const_before  ⊑  scalar_i32_shl_ult_const_combined := by
  unfold scalar_i32_shl_ult_const_before scalar_i32_shl_ult_const_combined
  simp_alive_peephole
  sorry
def scalar_i64_shl_ult_const_combined := [llvmfunc|
  llvm.func @scalar_i64_shl_ult_const(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(549755813632 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i64_shl_ult_const   : scalar_i64_shl_ult_const_before  ⊑  scalar_i64_shl_ult_const_combined := by
  unfold scalar_i64_shl_ult_const_before scalar_i64_shl_ult_const_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_uge_const_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_uge_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_uge_const   : scalar_i8_shl_uge_const_before  ⊑  scalar_i8_shl_uge_const_combined := by
  unfold scalar_i8_shl_uge_const_before scalar_i8_shl_uge_const_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_ule_const_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ule_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ule_const   : scalar_i8_shl_ule_const_before  ⊑  scalar_i8_shl_ule_const_combined := by
  unfold scalar_i8_shl_ule_const_before scalar_i8_shl_ule_const_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_ugt_const_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ugt_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ugt_const   : scalar_i8_shl_ugt_const_before  ⊑  scalar_i8_shl_ugt_const_combined := by
  unfold scalar_i8_shl_ugt_const_before scalar_i8_shl_ugt_const_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_ult_const_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<2097088> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_ult_const   : vector_4xi32_shl_ult_const_before  ⊑  vector_4xi32_shl_ult_const_combined := by
  unfold vector_4xi32_shl_ult_const_before vector_4xi32_shl_ult_const_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_ult_const_undef1_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const_undef1(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<131072> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.shl %arg0, %10  : vector<4xi32>
    %13 = llvm.icmp "ult" %12, %11 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_ult_const_undef1   : vector_4xi32_shl_ult_const_undef1_before  ⊑  vector_4xi32_shl_ult_const_undef1_combined := by
  unfold vector_4xi32_shl_ult_const_undef1_before vector_4xi32_shl_ult_const_undef1_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_ult_const_undef2_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const_undef2(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<11> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(131072 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.shl %arg0, %0  : vector<4xi32>
    %13 = llvm.icmp "ult" %12, %11 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_ult_const_undef2   : vector_4xi32_shl_ult_const_undef2_before  ⊑  vector_4xi32_shl_ult_const_undef2_combined := by
  unfold vector_4xi32_shl_ult_const_undef2_before vector_4xi32_shl_ult_const_undef2_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_ult_const_undef3_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_ult_const_undef3(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(131072 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.shl %arg0, %10  : vector<4xi32>
    %22 = llvm.icmp "ult" %21, %20 : vector<4xi32>
    llvm.return %22 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_ult_const_undef3   : vector_4xi32_shl_ult_const_undef3_before  ⊑  vector_4xi32_shl_ult_const_undef3_combined := by
  unfold vector_4xi32_shl_ult_const_undef3_before vector_4xi32_shl_ult_const_undef3_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_uge_const_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_uge_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<2097088> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_uge_const   : vector_4xi32_shl_uge_const_before  ⊑  vector_4xi32_shl_uge_const_combined := by
  unfold vector_4xi32_shl_uge_const_before vector_4xi32_shl_uge_const_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_ule_const_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_ule_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<2097088> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_ule_const   : vector_4xi32_shl_ule_const_before  ⊑  vector_4xi32_shl_ule_const_combined := by
  unfold vector_4xi32_shl_ule_const_before vector_4xi32_shl_ule_const_combined
  simp_alive_peephole
  sorry
def vector_4xi32_shl_ugt_const_combined := [llvmfunc|
  llvm.func @vector_4xi32_shl_ugt_const(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<2097088> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_vector_4xi32_shl_ugt_const   : vector_4xi32_shl_ugt_const_before  ⊑  vector_4xi32_shl_ugt_const_combined := by
  unfold vector_4xi32_shl_ugt_const_before vector_4xi32_shl_ugt_const_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_ult_const_extra_use_shl_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ult_const_extra_use_shl(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_scalar_i8_shl_ult_const_extra_use_shl   : scalar_i8_shl_ult_const_extra_use_shl_before  ⊑  scalar_i8_shl_ult_const_extra_use_shl_combined := by
  unfold scalar_i8_shl_ult_const_extra_use_shl_before scalar_i8_shl_ult_const_extra_use_shl_combined
  simp_alive_peephole
  sorry
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ult_const_extra_use_shl   : scalar_i8_shl_ult_const_extra_use_shl_before  ⊑  scalar_i8_shl_ult_const_extra_use_shl_combined := by
  unfold scalar_i8_shl_ult_const_extra_use_shl_before scalar_i8_shl_ult_const_extra_use_shl_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_slt_const_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_slt_const(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_slt_const   : scalar_i8_shl_slt_const_before  ⊑  scalar_i8_shl_slt_const_combined := by
  unfold scalar_i8_shl_slt_const_before scalar_i8_shl_slt_const_combined
  simp_alive_peephole
  sorry
def scalar_i8_shl_ugt_const_not_power_of_2_combined := [llvmfunc|
  llvm.func @scalar_i8_shl_ugt_const_not_power_of_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(66 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_scalar_i8_shl_ugt_const_not_power_of_2   : scalar_i8_shl_ugt_const_not_power_of_2_before  ⊑  scalar_i8_shl_ugt_const_not_power_of_2_combined := by
  unfold scalar_i8_shl_ugt_const_not_power_of_2_before scalar_i8_shl_ugt_const_not_power_of_2_combined
  simp_alive_peephole
  sorry

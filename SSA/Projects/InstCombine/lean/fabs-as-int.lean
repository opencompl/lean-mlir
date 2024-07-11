import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fabs-as-int
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fabs_as_int_f32_castback_noimplicitfloat_before := [llvmfunc|
  llvm.func @fabs_as_int_f32_castback_noimplicitfloat(%arg0: f32) -> f32 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

def fabs_as_int_v2f32_noimplicitfloat_before := [llvmfunc|
  llvm.func @fabs_as_int_v2f32_noimplicitfloat(%arg0: vector<2xf32>) -> vector<2xi32> attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fabs_as_int_f32_castback_before := [llvmfunc|
  llvm.func @fabs_as_int_f32_castback(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

def not_fabs_as_int_f32_castback_wrongconst_before := [llvmfunc|
  llvm.func @not_fabs_as_int_f32_castback_wrongconst(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

def fabs_as_int_f32_castback_multi_use_before := [llvmfunc|
  llvm.func @fabs_as_int_f32_castback_multi_use(%arg0: f32, %arg1: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

def fabs_as_int_f64_before := [llvmfunc|
  llvm.func @fabs_as_int_f64(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

def fabs_as_int_v2f64_before := [llvmfunc|
  llvm.func @fabs_as_int_v2f64(%arg0: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<9223372036854775807> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.bitcast %arg0 : vector<2xf64> to vector<2xi64>
    %2 = llvm.and %1, %0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def fabs_as_int_f64_swap_before := [llvmfunc|
  llvm.func @fabs_as_int_f64_swap(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.and %0, %1  : i64
    llvm.return %2 : i64
  }]

def fabs_as_int_f32_before := [llvmfunc|
  llvm.func @fabs_as_int_f32(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def fabs_as_int_v2f32_before := [llvmfunc|
  llvm.func @fabs_as_int_v2f32(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def not_fabs_as_int_v2f32_nonsplat_before := [llvmfunc|
  llvm.func @not_fabs_as_int_v2f32_nonsplat(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483647, 2147483646]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fabs_as_int_v3f32_poison_before := [llvmfunc|
  llvm.func @fabs_as_int_v3f32_poison(%arg0: vector<3xf32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.bitcast %arg0 : vector<3xf32> to vector<3xi32>
    %10 = llvm.and %9, %8  : vector<3xi32>
    llvm.return %10 : vector<3xi32>
  }]

def fabs_as_int_f64_not_bitcast_before := [llvmfunc|
  llvm.func @fabs_as_int_f64_not_bitcast(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.fptoui %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

def not_fabs_as_int_f32_bitcast_from_v2f16_before := [llvmfunc|
  llvm.func @not_fabs_as_int_f32_bitcast_from_v2f16(%arg0: vector<2xf16>) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xf16> to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

def not_fabs_as_int_f32_bitcast_from_v2i16_before := [llvmfunc|
  llvm.func @not_fabs_as_int_f32_bitcast_from_v2i16(%arg0: vector<2xi16>) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

def fabs_as_int_fp128_f64_mask_before := [llvmfunc|
  llvm.func @fabs_as_int_fp128_f64_mask(%arg0: f128) -> i128 {
    %0 = llvm.mlir.constant(170141183460469231731687303715884105727 : i128) : i128
    %1 = llvm.bitcast %arg0 : f128 to i128
    %2 = llvm.and %1, %0  : i128
    llvm.return %2 : i128
  }]

def fabs_as_int_fp128_f128_mask_before := [llvmfunc|
  llvm.func @fabs_as_int_fp128_f128_mask(%arg0: f128) -> i128 {
    %0 = llvm.mlir.constant(170141183460469231731687303715884105727 : i128) : i128
    %1 = llvm.bitcast %arg0 : f128 to i128
    %2 = llvm.and %1, %0  : i128
    llvm.return %2 : i128
  }]

def fabs_as_int_f16_before := [llvmfunc|
  llvm.func @fabs_as_int_f16(%arg0: f16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.bitcast %arg0 : f16 to i16
    %2 = llvm.and %1, %0  : i16
    llvm.return %2 : i16
  }]

def fabs_as_int_v2f16_before := [llvmfunc|
  llvm.func @fabs_as_int_v2f16(%arg0: vector<2xf16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<32767> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.bitcast %arg0 : vector<2xf16> to vector<2xi16>
    %2 = llvm.and %1, %0  : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def fabs_as_int_bf16_before := [llvmfunc|
  llvm.func @fabs_as_int_bf16(%arg0: bf16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.bitcast %arg0 : bf16 to i16
    %2 = llvm.and %1, %0  : i16
    llvm.return %2 : i16
  }]

def fabs_as_int_v2bf16_before := [llvmfunc|
  llvm.func @fabs_as_int_v2bf16(%arg0: vector<2xbf16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<32767> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.bitcast %arg0 : vector<2xbf16> to vector<2xi16>
    %2 = llvm.and %1, %0  : vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def fabs_as_int_x86_fp80_f64_mask_before := [llvmfunc|
  llvm.func @fabs_as_int_x86_fp80_f64_mask(%arg0: f80) -> i80 {
    %0 = llvm.mlir.constant(9223372036854775807 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    llvm.return %2 : i80
  }]

def fabs_as_int_ppc_fp128_f64_mask_before := [llvmfunc|
  llvm.func @fabs_as_int_ppc_fp128_f64_mask(%arg0: !llvm.ppc_fp128) -> i128 {
    %0 = llvm.mlir.constant(9223372036854775807 : i128) : i128
    %1 = llvm.bitcast %arg0 : !llvm.ppc_fp128 to i128
    %2 = llvm.and %1, %0  : i128
    llvm.return %2 : i128
  }]

def fabs_as_int_ppc_fp128_f128_mask_before := [llvmfunc|
  llvm.func @fabs_as_int_ppc_fp128_f128_mask(%arg0: !llvm.ppc_fp128) -> i128 {
    %0 = llvm.mlir.constant(170141183460469231731687303715884105727 : i128) : i128
    %1 = llvm.bitcast %arg0 : !llvm.ppc_fp128 to i128
    %2 = llvm.and %1, %0  : i128
    llvm.return %2 : i128
  }]

def fabs_as_int_f32_castback_noimplicitfloat_combined := [llvmfunc|
  llvm.func @fabs_as_int_f32_castback_noimplicitfloat(%arg0: f32) -> f32 attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fabs_as_int_f32_castback_noimplicitfloat   : fabs_as_int_f32_castback_noimplicitfloat_before  ⊑  fabs_as_int_f32_castback_noimplicitfloat_combined := by
  unfold fabs_as_int_f32_castback_noimplicitfloat_before fabs_as_int_f32_castback_noimplicitfloat_combined
  simp_alive_peephole
  sorry
def fabs_as_int_v2f32_noimplicitfloat_combined := [llvmfunc|
  llvm.func @fabs_as_int_v2f32_noimplicitfloat(%arg0: vector<2xf32>) -> vector<2xi32> attributes {passthrough = ["noimplicitfloat"]} {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_fabs_as_int_v2f32_noimplicitfloat   : fabs_as_int_v2f32_noimplicitfloat_before  ⊑  fabs_as_int_v2f32_noimplicitfloat_combined := by
  unfold fabs_as_int_v2f32_noimplicitfloat_before fabs_as_int_v2f32_noimplicitfloat_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f32_castback_combined := [llvmfunc|
  llvm.func @fabs_as_int_f32_castback(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_as_int_f32_castback   : fabs_as_int_f32_castback_before  ⊑  fabs_as_int_f32_castback_combined := by
  unfold fabs_as_int_f32_castback_before fabs_as_int_f32_castback_combined
  simp_alive_peephole
  sorry
def not_fabs_as_int_f32_castback_wrongconst_combined := [llvmfunc|
  llvm.func @not_fabs_as_int_f32_castback_wrongconst(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_not_fabs_as_int_f32_castback_wrongconst   : not_fabs_as_int_f32_castback_wrongconst_before  ⊑  not_fabs_as_int_f32_castback_wrongconst_combined := by
  unfold not_fabs_as_int_f32_castback_wrongconst_before not_fabs_as_int_f32_castback_wrongconst_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f32_castback_multi_use_combined := [llvmfunc|
  llvm.func @fabs_as_int_f32_castback_multi_use(%arg0: f32, %arg1: !llvm.ptr) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_as_int_f32_castback_multi_use   : fabs_as_int_f32_castback_multi_use_before  ⊑  fabs_as_int_f32_castback_multi_use_combined := by
  unfold fabs_as_int_f32_castback_multi_use_before fabs_as_int_f32_castback_multi_use_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f64_combined := [llvmfunc|
  llvm.func @fabs_as_int_f64(%arg0: f64) -> i64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_fabs_as_int_f64   : fabs_as_int_f64_before  ⊑  fabs_as_int_f64_combined := by
  unfold fabs_as_int_f64_before fabs_as_int_f64_combined
  simp_alive_peephole
  sorry
def fabs_as_int_v2f64_combined := [llvmfunc|
  llvm.func @fabs_as_int_v2f64(%arg0: vector<2xf64>) -> vector<2xi64> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf64>) -> vector<2xf64>
    %1 = llvm.bitcast %0 : vector<2xf64> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_fabs_as_int_v2f64   : fabs_as_int_v2f64_before  ⊑  fabs_as_int_v2f64_combined := by
  unfold fabs_as_int_v2f64_before fabs_as_int_v2f64_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f64_swap_combined := [llvmfunc|
  llvm.func @fabs_as_int_f64_swap(%arg0: f64) -> i64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_fabs_as_int_f64_swap   : fabs_as_int_f64_swap_before  ⊑  fabs_as_int_f64_swap_combined := by
  unfold fabs_as_int_f64_swap_before fabs_as_int_f64_swap_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f32_combined := [llvmfunc|
  llvm.func @fabs_as_int_f32(%arg0: f32) -> i32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fabs_as_int_f32   : fabs_as_int_f32_before  ⊑  fabs_as_int_f32_combined := by
  unfold fabs_as_int_f32_before fabs_as_int_f32_combined
  simp_alive_peephole
  sorry
def fabs_as_int_v2f32_combined := [llvmfunc|
  llvm.func @fabs_as_int_v2f32(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.bitcast %0 : vector<2xf32> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fabs_as_int_v2f32   : fabs_as_int_v2f32_before  ⊑  fabs_as_int_v2f32_combined := by
  unfold fabs_as_int_v2f32_before fabs_as_int_v2f32_combined
  simp_alive_peephole
  sorry
def not_fabs_as_int_v2f32_nonsplat_combined := [llvmfunc|
  llvm.func @not_fabs_as_int_v2f32_nonsplat(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2147483647, 2147483646]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_not_fabs_as_int_v2f32_nonsplat   : not_fabs_as_int_v2f32_nonsplat_before  ⊑  not_fabs_as_int_v2f32_nonsplat_combined := by
  unfold not_fabs_as_int_v2f32_nonsplat_before not_fabs_as_int_v2f32_nonsplat_combined
  simp_alive_peephole
  sorry
def fabs_as_int_v3f32_poison_combined := [llvmfunc|
  llvm.func @fabs_as_int_v3f32_poison(%arg0: vector<3xf32>) -> vector<3xi32> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<3xf32>) -> vector<3xf32>
    %1 = llvm.bitcast %0 : vector<3xf32> to vector<3xi32>
    llvm.return %1 : vector<3xi32>
  }]

theorem inst_combine_fabs_as_int_v3f32_poison   : fabs_as_int_v3f32_poison_before  ⊑  fabs_as_int_v3f32_poison_combined := by
  unfold fabs_as_int_v3f32_poison_before fabs_as_int_v3f32_poison_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f64_not_bitcast_combined := [llvmfunc|
  llvm.func @fabs_as_int_f64_not_bitcast(%arg0: f64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.fptoui %arg0 : f64 to i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_fabs_as_int_f64_not_bitcast   : fabs_as_int_f64_not_bitcast_before  ⊑  fabs_as_int_f64_not_bitcast_combined := by
  unfold fabs_as_int_f64_not_bitcast_before fabs_as_int_f64_not_bitcast_combined
  simp_alive_peephole
  sorry
def not_fabs_as_int_f32_bitcast_from_v2f16_combined := [llvmfunc|
  llvm.func @not_fabs_as_int_f32_bitcast_from_v2f16(%arg0: vector<2xf16>) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xf16> to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_not_fabs_as_int_f32_bitcast_from_v2f16   : not_fabs_as_int_f32_bitcast_from_v2f16_before  ⊑  not_fabs_as_int_f32_bitcast_from_v2f16_combined := by
  unfold not_fabs_as_int_f32_bitcast_from_v2f16_before not_fabs_as_int_f32_bitcast_from_v2f16_combined
  simp_alive_peephole
  sorry
def not_fabs_as_int_f32_bitcast_from_v2i16_combined := [llvmfunc|
  llvm.func @not_fabs_as_int_f32_bitcast_from_v2i16(%arg0: vector<2xi16>) -> f32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_not_fabs_as_int_f32_bitcast_from_v2i16   : not_fabs_as_int_f32_bitcast_from_v2i16_before  ⊑  not_fabs_as_int_f32_bitcast_from_v2i16_combined := by
  unfold not_fabs_as_int_f32_bitcast_from_v2i16_before not_fabs_as_int_f32_bitcast_from_v2i16_combined
  simp_alive_peephole
  sorry
def fabs_as_int_fp128_f64_mask_combined := [llvmfunc|
  llvm.func @fabs_as_int_fp128_f64_mask(%arg0: f128) -> i128 {
    %0 = llvm.intr.fabs(%arg0)  : (f128) -> f128
    %1 = llvm.bitcast %0 : f128 to i128
    llvm.return %1 : i128
  }]

theorem inst_combine_fabs_as_int_fp128_f64_mask   : fabs_as_int_fp128_f64_mask_before  ⊑  fabs_as_int_fp128_f64_mask_combined := by
  unfold fabs_as_int_fp128_f64_mask_before fabs_as_int_fp128_f64_mask_combined
  simp_alive_peephole
  sorry
def fabs_as_int_fp128_f128_mask_combined := [llvmfunc|
  llvm.func @fabs_as_int_fp128_f128_mask(%arg0: f128) -> i128 {
    %0 = llvm.intr.fabs(%arg0)  : (f128) -> f128
    %1 = llvm.bitcast %0 : f128 to i128
    llvm.return %1 : i128
  }]

theorem inst_combine_fabs_as_int_fp128_f128_mask   : fabs_as_int_fp128_f128_mask_before  ⊑  fabs_as_int_fp128_f128_mask_combined := by
  unfold fabs_as_int_fp128_f128_mask_before fabs_as_int_fp128_f128_mask_combined
  simp_alive_peephole
  sorry
def fabs_as_int_f16_combined := [llvmfunc|
  llvm.func @fabs_as_int_f16(%arg0: f16) -> i16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.bitcast %0 : f16 to i16
    llvm.return %1 : i16
  }]

theorem inst_combine_fabs_as_int_f16   : fabs_as_int_f16_before  ⊑  fabs_as_int_f16_combined := by
  unfold fabs_as_int_f16_before fabs_as_int_f16_combined
  simp_alive_peephole
  sorry
def fabs_as_int_v2f16_combined := [llvmfunc|
  llvm.func @fabs_as_int_v2f16(%arg0: vector<2xf16>) -> vector<2xi16> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %1 = llvm.bitcast %0 : vector<2xf16> to vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_fabs_as_int_v2f16   : fabs_as_int_v2f16_before  ⊑  fabs_as_int_v2f16_combined := by
  unfold fabs_as_int_v2f16_before fabs_as_int_v2f16_combined
  simp_alive_peephole
  sorry
def fabs_as_int_bf16_combined := [llvmfunc|
  llvm.func @fabs_as_int_bf16(%arg0: bf16) -> i16 {
    %0 = llvm.intr.fabs(%arg0)  : (bf16) -> bf16
    %1 = llvm.bitcast %0 : bf16 to i16
    llvm.return %1 : i16
  }]

theorem inst_combine_fabs_as_int_bf16   : fabs_as_int_bf16_before  ⊑  fabs_as_int_bf16_combined := by
  unfold fabs_as_int_bf16_before fabs_as_int_bf16_combined
  simp_alive_peephole
  sorry
def fabs_as_int_v2bf16_combined := [llvmfunc|
  llvm.func @fabs_as_int_v2bf16(%arg0: vector<2xbf16>) -> vector<2xi16> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xbf16>) -> vector<2xbf16>
    %1 = llvm.bitcast %0 : vector<2xbf16> to vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_fabs_as_int_v2bf16   : fabs_as_int_v2bf16_before  ⊑  fabs_as_int_v2bf16_combined := by
  unfold fabs_as_int_v2bf16_before fabs_as_int_v2bf16_combined
  simp_alive_peephole
  sorry
def fabs_as_int_x86_fp80_f64_mask_combined := [llvmfunc|
  llvm.func @fabs_as_int_x86_fp80_f64_mask(%arg0: f80) -> i80 {
    %0 = llvm.mlir.constant(9223372036854775807 : i80) : i80
    %1 = llvm.bitcast %arg0 : f80 to i80
    %2 = llvm.and %1, %0  : i80
    llvm.return %2 : i80
  }]

theorem inst_combine_fabs_as_int_x86_fp80_f64_mask   : fabs_as_int_x86_fp80_f64_mask_before  ⊑  fabs_as_int_x86_fp80_f64_mask_combined := by
  unfold fabs_as_int_x86_fp80_f64_mask_before fabs_as_int_x86_fp80_f64_mask_combined
  simp_alive_peephole
  sorry
def fabs_as_int_ppc_fp128_f64_mask_combined := [llvmfunc|
  llvm.func @fabs_as_int_ppc_fp128_f64_mask(%arg0: !llvm.ppc_fp128) -> i128 {
    %0 = llvm.mlir.constant(9223372036854775807 : i128) : i128
    %1 = llvm.bitcast %arg0 : !llvm.ppc_fp128 to i128
    %2 = llvm.and %1, %0  : i128
    llvm.return %2 : i128
  }]

theorem inst_combine_fabs_as_int_ppc_fp128_f64_mask   : fabs_as_int_ppc_fp128_f64_mask_before  ⊑  fabs_as_int_ppc_fp128_f64_mask_combined := by
  unfold fabs_as_int_ppc_fp128_f64_mask_before fabs_as_int_ppc_fp128_f64_mask_combined
  simp_alive_peephole
  sorry
def fabs_as_int_ppc_fp128_f128_mask_combined := [llvmfunc|
  llvm.func @fabs_as_int_ppc_fp128_f128_mask(%arg0: !llvm.ppc_fp128) -> i128 {
    %0 = llvm.mlir.constant(170141183460469231731687303715884105727 : i128) : i128
    %1 = llvm.bitcast %arg0 : !llvm.ppc_fp128 to i128
    %2 = llvm.and %1, %0  : i128
    llvm.return %2 : i128
  }]

theorem inst_combine_fabs_as_int_ppc_fp128_f128_mask   : fabs_as_int_ppc_fp128_f128_mask_before  ⊑  fabs_as_int_ppc_fp128_f128_mask_combined := by
  unfold fabs_as_int_ppc_fp128_f128_mask_before fabs_as_int_ppc_fp128_f128_mask_combined
  simp_alive_peephole
  sorry

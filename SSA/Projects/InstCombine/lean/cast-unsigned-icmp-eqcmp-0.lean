import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-unsigned-icmp-eqcmp-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def i32_cast_cmp_eq_int_0_uitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_eq_int_0_uitofp_float_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_float_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.uitofp %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.bitcast %2 : vector<2xf32> to vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def i32_cast_cmp_eq_int_0_uitofp_float_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_float_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf32>
    %10 = llvm.bitcast %9 : vector<3xf32> to vector<3xi32>
    %11 = llvm.icmp "eq" %10, %8 : vector<3xi32>
    llvm.return %11 : vector<3xi1>
  }]

def i32_cast_cmp_ne_int_0_uitofp_float_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.bitcast %1 : f32 to i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_uitofp_float_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_float_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.uitofp %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.bitcast %2 : vector<2xf32> to vector<2xi32>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def i32_cast_cmp_ne_int_0_uitofp_float_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_float_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf32>
    %10 = llvm.bitcast %9 : vector<3xf32> to vector<3xi32>
    %11 = llvm.icmp "ne" %10, %8 : vector<3xi32>
    llvm.return %11 : vector<3xi1>
  }]

def i32_cast_cmp_eq_int_0_uitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "eq" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_eq_int_0_uitofp_double_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_double_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.uitofp %arg0 : vector<2xi32> to vector<2xf64>
    %3 = llvm.bitcast %2 : vector<2xf64> to vector<2xi64>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def i32_cast_cmp_eq_int_0_uitofp_double_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_double_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<3xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi64>
    %9 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf64>
    %10 = llvm.bitcast %9 : vector<3xf64> to vector<3xi64>
    %11 = llvm.icmp "eq" %10, %8 : vector<3xi64>
    llvm.return %11 : vector<3xi1>
  }]

def i32_cast_cmp_ne_int_0_uitofp_double_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.bitcast %1 : f64 to i64
    %3 = llvm.icmp "ne" %2, %0 : i64
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_uitofp_double_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_double_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.uitofp %arg0 : vector<2xi32> to vector<2xf64>
    %3 = llvm.bitcast %2 : vector<2xf64> to vector<2xi64>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def i32_cast_cmp_ne_int_0_uitofp_double_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_double_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<3xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi64>
    %9 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf64>
    %10 = llvm.bitcast %9 : vector<3xf64> to vector<3xi64>
    %11 = llvm.icmp "ne" %10, %8 : vector<3xi64>
    llvm.return %11 : vector<3xi1>
  }]

def i32_cast_cmp_eq_int_0_uitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.uitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_eq_int_0_uitofp_half_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_half_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.uitofp %arg0 : vector<2xi32> to vector<2xf16>
    %3 = llvm.bitcast %2 : vector<2xf16> to vector<2xi16>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi16>
    llvm.return %4 : vector<2xi1>
  }]

def i32_cast_cmp_eq_int_0_uitofp_half_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_half_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf16>
    %10 = llvm.bitcast %9 : vector<3xf16> to vector<3xi16>
    %11 = llvm.icmp "eq" %10, %8 : vector<3xi16>
    llvm.return %11 : vector<3xi1>
  }]

def i32_cast_cmp_ne_int_0_uitofp_half_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.uitofp %arg0 : i32 to f16
    %2 = llvm.bitcast %1 : f16 to i16
    %3 = llvm.icmp "ne" %2, %0 : i16
    llvm.return %3 : i1
  }]

def i32_cast_cmp_ne_int_0_uitofp_half_vec_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_half_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.uitofp %arg0 : vector<2xi32> to vector<2xf16>
    %3 = llvm.bitcast %2 : vector<2xf16> to vector<2xi16>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi16>
    llvm.return %4 : vector<2xi1>
  }]

def i32_cast_cmp_ne_int_0_uitofp_half_vec_poison_before := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_half_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.uitofp %arg0 : vector<3xi32> to vector<3xf16>
    %10 = llvm.bitcast %9 : vector<3xf16> to vector<3xi16>
    %11 = llvm.icmp "ne" %10, %8 : vector<3xi16>
    llvm.return %11 : vector<3xi1>
  }]

def i32_cast_cmp_eq_int_0_uitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_float   : i32_cast_cmp_eq_int_0_uitofp_float_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_float_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_float_before i32_cast_cmp_eq_int_0_uitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_float_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_float_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_float_vec   : i32_cast_cmp_eq_int_0_uitofp_float_vec_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_float_vec_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_float_vec_before i32_cast_cmp_eq_int_0_uitofp_float_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_float_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_float_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_float_vec_poison   : i32_cast_cmp_eq_int_0_uitofp_float_vec_poison_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_float_vec_poison_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_float_vec_poison_before i32_cast_cmp_eq_int_0_uitofp_float_vec_poison_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_float_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_float(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_float   : i32_cast_cmp_ne_int_0_uitofp_float_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_float_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_float_before i32_cast_cmp_ne_int_0_uitofp_float_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_float_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_float_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_float_vec   : i32_cast_cmp_ne_int_0_uitofp_float_vec_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_float_vec_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_float_vec_before i32_cast_cmp_ne_int_0_uitofp_float_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_float_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_float_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_float_vec_poison   : i32_cast_cmp_ne_int_0_uitofp_float_vec_poison_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_float_vec_poison_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_float_vec_poison_before i32_cast_cmp_ne_int_0_uitofp_float_vec_poison_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_double   : i32_cast_cmp_eq_int_0_uitofp_double_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_double_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_double_before i32_cast_cmp_eq_int_0_uitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_double_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_double_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_double_vec   : i32_cast_cmp_eq_int_0_uitofp_double_vec_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_double_vec_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_double_vec_before i32_cast_cmp_eq_int_0_uitofp_double_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_double_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_double_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_double_vec_poison   : i32_cast_cmp_eq_int_0_uitofp_double_vec_poison_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_double_vec_poison_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_double_vec_poison_before i32_cast_cmp_eq_int_0_uitofp_double_vec_poison_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_double_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_double(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_double   : i32_cast_cmp_ne_int_0_uitofp_double_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_double_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_double_before i32_cast_cmp_ne_int_0_uitofp_double_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_double_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_double_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_double_vec   : i32_cast_cmp_ne_int_0_uitofp_double_vec_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_double_vec_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_double_vec_before i32_cast_cmp_ne_int_0_uitofp_double_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_double_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_double_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_double_vec_poison   : i32_cast_cmp_ne_int_0_uitofp_double_vec_poison_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_double_vec_poison_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_double_vec_poison_before i32_cast_cmp_ne_int_0_uitofp_double_vec_poison_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_half   : i32_cast_cmp_eq_int_0_uitofp_half_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_half_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_half_before i32_cast_cmp_eq_int_0_uitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_half_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_half_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_half_vec   : i32_cast_cmp_eq_int_0_uitofp_half_vec_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_half_vec_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_half_vec_before i32_cast_cmp_eq_int_0_uitofp_half_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_eq_int_0_uitofp_half_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_eq_int_0_uitofp_half_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_eq_int_0_uitofp_half_vec_poison   : i32_cast_cmp_eq_int_0_uitofp_half_vec_poison_before  ⊑  i32_cast_cmp_eq_int_0_uitofp_half_vec_poison_combined := by
  unfold i32_cast_cmp_eq_int_0_uitofp_half_vec_poison_before i32_cast_cmp_eq_int_0_uitofp_half_vec_poison_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_half_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_half(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_half   : i32_cast_cmp_ne_int_0_uitofp_half_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_half_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_half_before i32_cast_cmp_ne_int_0_uitofp_half_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_half_vec_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_half_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_half_vec   : i32_cast_cmp_ne_int_0_uitofp_half_vec_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_half_vec_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_half_vec_before i32_cast_cmp_ne_int_0_uitofp_half_vec_combined
  simp_alive_peephole
  sorry
def i32_cast_cmp_ne_int_0_uitofp_half_vec_poison_combined := [llvmfunc|
  llvm.func @i32_cast_cmp_ne_int_0_uitofp_half_vec_poison(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<3xi32>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_i32_cast_cmp_ne_int_0_uitofp_half_vec_poison   : i32_cast_cmp_ne_int_0_uitofp_half_vec_poison_before  ⊑  i32_cast_cmp_ne_int_0_uitofp_half_vec_poison_combined := by
  unfold i32_cast_cmp_ne_int_0_uitofp_half_vec_poison_before i32_cast_cmp_ne_int_0_uitofp_half_vec_poison_combined
  simp_alive_peephole
  sorry

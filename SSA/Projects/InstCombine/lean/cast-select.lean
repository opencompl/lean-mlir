import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zext_before := [llvmfunc|
  llvm.func @zext(%arg0: i32, %arg1: i32, %arg2: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.select %1, %0, %arg2 : i1, i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def zext_vec_before := [llvmfunc|
  llvm.func @zext_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def sext_before := [llvmfunc|
  llvm.func @sext(%arg0: i8, %arg1: i8, %arg2: i8) -> i64 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.select %1, %0, %arg2 : i1, i8
    %3 = llvm.sext %2 : i8 to i64
    llvm.return %3 : i64
  }]

def sext_vec_before := [llvmfunc|
  llvm.func @sext_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi8> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def trunc_before := [llvmfunc|
  llvm.func @trunc(%arg0: i32, %arg1: i32, %arg2: i32) -> i16 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.select %1, %0, %arg2 : i1, i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }]

def trunc_vec_before := [llvmfunc|
  llvm.func @trunc_vec(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi64>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi64>
    %3 = llvm.trunc %2 : vector<2xi64> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def fpext_before := [llvmfunc|
  llvm.func @fpext(%arg0: f32, %arg1: f32, %arg2: f32) -> f64 {
    %0 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    %2 = llvm.select %1, %0, %arg2 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def fpext_vec_before := [llvmfunc|
  llvm.func @fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : vector<2xf32>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fpext %2 : vector<2xf32> to vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

def fptrunc_before := [llvmfunc|
  llvm.func @fptrunc(%arg0: f64, %arg1: f64, %arg2: f64) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.select %1, %0, %arg2 : i1, f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def fptrunc_vec_before := [llvmfunc|
  llvm.func @fptrunc_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[-4.200000e+01, 1.200000e+01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "oge" %arg0, %arg1 : vector<2xf64>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def zext_combined := [llvmfunc|
  llvm.func @zext(%arg0: i32, %arg1: i32, %arg2: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.select %1, %0, %arg2 : i1, i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_zext   : zext_before  ⊑  zext_combined := by
  unfold zext_before zext_combined
  simp_alive_peephole
  sorry
def zext_vec_combined := [llvmfunc|
  llvm.func @zext_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_zext_vec   : zext_vec_before  ⊑  zext_vec_combined := by
  unfold zext_vec_before zext_vec_combined
  simp_alive_peephole
  sorry
def sext_combined := [llvmfunc|
  llvm.func @sext(%arg0: i8, %arg1: i8, %arg2: i8) -> i64 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.select %1, %0, %arg2 : i1, i8
    %3 = llvm.sext %2 : i8 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_sext   : sext_before  ⊑  sext_combined := by
  unfold sext_before sext_combined
  simp_alive_peephole
  sorry
def sext_vec_combined := [llvmfunc|
  llvm.func @sext_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi8> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_sext_vec   : sext_vec_before  ⊑  sext_vec_combined := by
  unfold sext_vec_before sext_vec_combined
  simp_alive_peephole
  sorry
def trunc_combined := [llvmfunc|
  llvm.func @trunc(%arg0: i32, %arg1: i32, %arg2: i32) -> i16 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.trunc %arg2 : i32 to i16
    %3 = llvm.select %1, %0, %2 : i1, i16
    llvm.return %3 : i16
  }]

theorem inst_combine_trunc   : trunc_before  ⊑  trunc_combined := by
  unfold trunc_before trunc_combined
  simp_alive_peephole
  sorry
def trunc_vec_combined := [llvmfunc|
  llvm.func @trunc_vec(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 7]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi64>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xi64>
    %3 = llvm.trunc %2 : vector<2xi64> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_trunc_vec   : trunc_vec_before  ⊑  trunc_vec_combined := by
  unfold trunc_vec_before trunc_vec_combined
  simp_alive_peephole
  sorry
def fpext_combined := [llvmfunc|
  llvm.func @fpext(%arg0: f32, %arg1: f32, %arg2: f32) -> f64 {
    %0 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    %2 = llvm.select %1, %0, %arg2 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fpext   : fpext_before  ⊑  fpext_combined := by
  unfold fpext_before fpext_combined
  simp_alive_peephole
  sorry
def fpext_vec_combined := [llvmfunc|
  llvm.func @fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : vector<2xf32>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fpext %2 : vector<2xf32> to vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_fpext_vec   : fpext_vec_before  ⊑  fpext_vec_combined := by
  unfold fpext_vec_before fpext_vec_combined
  simp_alive_peephole
  sorry
def fptrunc_combined := [llvmfunc|
  llvm.func @fptrunc(%arg0: f64, %arg1: f64, %arg2: f64) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.select %1, %0, %arg2 : i1, f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fptrunc   : fptrunc_before  ⊑  fptrunc_combined := by
  unfold fptrunc_before fptrunc_combined
  simp_alive_peephole
  sorry
def fptrunc_vec_combined := [llvmfunc|
  llvm.func @fptrunc_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[-4.200000e+01, 1.200000e+01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "oge" %arg0, %arg1 : vector<2xf64>
    %2 = llvm.select %1, %arg2, %0 : vector<2xi1>, vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_fptrunc_vec   : fptrunc_vec_before  ⊑  fptrunc_vec_combined := by
  unfold fptrunc_vec_before fptrunc_vec_combined
  simp_alive_peephole
  sorry

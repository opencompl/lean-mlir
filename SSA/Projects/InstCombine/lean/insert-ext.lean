import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insert-ext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fpext_fpext_before := [llvmfunc|
  llvm.func @fpext_fpext(%arg0: vector<2xf16>, %arg1: f16, %arg2: i32) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

def sext_sext_before := [llvmfunc|
  llvm.func @sext_sext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_zext_before := [llvmfunc|
  llvm.func @zext_zext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi12> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi12>
    %1 = llvm.zext %arg1 : i8 to i12
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi12>
    llvm.return %2 : vector<2xi12>
  }]

def fpext_fpext_types_before := [llvmfunc|
  llvm.func @fpext_fpext_types(%arg0: vector<2xf16>, %arg1: f32, %arg2: i32) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

def sext_sext_types_before := [llvmfunc|
  llvm.func @sext_sext_types(%arg0: vector<2xi16>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def sext_zext_before := [llvmfunc|
  llvm.func @sext_zext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi12> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi12>
    %1 = llvm.zext %arg1 : i8 to i12
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi12>
    llvm.return %2 : vector<2xi12>
  }]

def sext_sext_use1_before := [llvmfunc|
  llvm.func @sext_sext_use1(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @usevec(%0) : (vector<2xi32>) -> ()
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_zext_use2_before := [llvmfunc|
  llvm.func @zext_zext_use2(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_zext_use3_before := [llvmfunc|
  llvm.func @zext_zext_use3(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @usevec(%0) : (vector<2xi32>) -> ()
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fpext_fpext_combined := [llvmfunc|
  llvm.func @fpext_fpext(%arg0: vector<2xf16>, %arg1: f16, %arg2: i32) -> vector<2xf64> {
    %0 = llvm.insertelement %arg1, %arg0[%arg2 : i32] : vector<2xf16>
    %1 = llvm.fpext %0 : vector<2xf16> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fpext_fpext   : fpext_fpext_before  ⊑  fpext_fpext_combined := by
  unfold fpext_fpext_before fpext_fpext_combined
  simp_alive_peephole
  sorry
def sext_sext_combined := [llvmfunc|
  llvm.func @sext_sext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.insertelement %arg1, %arg0[%arg2 : i32] : vector<2xi8>
    %1 = llvm.sext %0 : vector<2xi8> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_sext_sext   : sext_sext_before  ⊑  sext_sext_combined := by
  unfold sext_sext_before sext_sext_combined
  simp_alive_peephole
  sorry
def zext_zext_combined := [llvmfunc|
  llvm.func @zext_zext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi12> {
    %0 = llvm.insertelement %arg1, %arg0[%arg2 : i32] : vector<2xi8>
    %1 = llvm.zext %0 : vector<2xi8> to vector<2xi12>
    llvm.return %1 : vector<2xi12>
  }]

theorem inst_combine_zext_zext   : zext_zext_before  ⊑  zext_zext_combined := by
  unfold zext_zext_before zext_zext_combined
  simp_alive_peephole
  sorry
def fpext_fpext_types_combined := [llvmfunc|
  llvm.func @fpext_fpext_types(%arg0: vector<2xf16>, %arg1: f32, %arg2: i32) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_fpext_fpext_types   : fpext_fpext_types_before  ⊑  fpext_fpext_types_combined := by
  unfold fpext_fpext_types_before fpext_fpext_types_combined
  simp_alive_peephole
  sorry
def sext_sext_types_combined := [llvmfunc|
  llvm.func @sext_sext_types(%arg0: vector<2xi16>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sext_sext_types   : sext_sext_types_before  ⊑  sext_sext_types_combined := by
  unfold sext_sext_types_before sext_sext_types_combined
  simp_alive_peephole
  sorry
def sext_zext_combined := [llvmfunc|
  llvm.func @sext_zext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi12> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi12>
    %1 = llvm.zext %arg1 : i8 to i12
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi12>
    llvm.return %2 : vector<2xi12>
  }]

theorem inst_combine_sext_zext   : sext_zext_before  ⊑  sext_zext_combined := by
  unfold sext_zext_before sext_zext_combined
  simp_alive_peephole
  sorry
def sext_sext_use1_combined := [llvmfunc|
  llvm.func @sext_sext_use1(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @usevec(%0) : (vector<2xi32>) -> ()
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sext_sext_use1   : sext_sext_use1_before  ⊑  sext_sext_use1_combined := by
  unfold sext_sext_use1_before sext_sext_use1_combined
  simp_alive_peephole
  sorry
def zext_zext_use2_combined := [llvmfunc|
  llvm.func @zext_zext_use2(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.insertelement %arg1, %arg0[%arg2 : i32] : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_zext_zext_use2   : zext_zext_use2_before  ⊑  zext_zext_use2_combined := by
  unfold zext_zext_use2_before zext_zext_use2_combined
  simp_alive_peephole
  sorry
def zext_zext_use3_combined := [llvmfunc|
  llvm.func @zext_zext_use3(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @usevec(%0) : (vector<2xi32>) -> ()
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_zext_zext_use3   : zext_zext_use3_before  ⊑  zext_zext_use3_combined := by
  unfold zext_zext_use3_before zext_zext_use3_combined
  simp_alive_peephole
  sorry

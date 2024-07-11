import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  type_pun
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def type_pun_zeroth_before := [llvmfunc|
  llvm.func @type_pun_zeroth(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def type_pun_first_before := [llvmfunc|
  llvm.func @type_pun_first(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 6, 7] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def type_pun_misaligned_before := [llvmfunc|
  llvm.func @type_pun_misaligned(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [6, 7, 8, 9] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def type_pun_pointer_before := [llvmfunc|
  llvm.func @type_pun_pointer(%arg0: vector<16xi8>) -> !llvm.ptr {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def type_pun_float_before := [llvmfunc|
  llvm.func @type_pun_float(%arg0: vector<16xi8>) -> f32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to f32
    llvm.return %2 : f32
  }]

def type_pun_double_before := [llvmfunc|
  llvm.func @type_pun_double(%arg0: vector<16xi8>) -> f64 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3, 4, 5, 6, 7] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<8xi8> to f64
    llvm.return %2 : f64
  }]

def type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<(f32, i32)> {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.mlir.undef : !llvm.struct<(f32, i32)>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to f32
    %4 = llvm.bitcast %2 : vector<4xi8> to i32
    %5 = llvm.insertvalue %3, %1[0] : !llvm.struct<(f32, i32)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(f32, i32)> 
    llvm.return %6 : !llvm.struct<(f32, i32)>
  }]

def type_pun_i32_ctrl_before := [llvmfunc|
  llvm.func @type_pun_i32_ctrl(%arg0: vector<16xi8>, %arg1: i1) -> i32 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<16xi8> 
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }]

def type_pun_unhandled_before := [llvmfunc|
  llvm.func @type_pun_unhandled(%arg0: vector<16xi8>) -> i40 {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 6, 7, 8] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<5xi8> to i40
    llvm.return %2 : i40
  }]

def type_pun_zeroth_combined := [llvmfunc|
  llvm.func @type_pun_zeroth(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_type_pun_zeroth   : type_pun_zeroth_before  ⊑  type_pun_zeroth_combined := by
  unfold type_pun_zeroth_before type_pun_zeroth_combined
  simp_alive_peephole
  sorry
def type_pun_first_combined := [llvmfunc|
  llvm.func @type_pun_first(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_type_pun_first   : type_pun_first_before  ⊑  type_pun_first_combined := by
  unfold type_pun_first_before type_pun_first_combined
  simp_alive_peephole
  sorry
def type_pun_misaligned_combined := [llvmfunc|
  llvm.func @type_pun_misaligned(%arg0: vector<16xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [6, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1] : vector<16xi8> 
    %3 = llvm.bitcast %2 : vector<16xi8> to vector<4xi32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<4xi32>
    llvm.return %4 : i32
  }]

theorem inst_combine_type_pun_misaligned   : type_pun_misaligned_before  ⊑  type_pun_misaligned_combined := by
  unfold type_pun_misaligned_before type_pun_misaligned_combined
  simp_alive_peephole
  sorry
def type_pun_pointer_combined := [llvmfunc|
  llvm.func @type_pun_pointer(%arg0: vector<16xi8>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_type_pun_pointer   : type_pun_pointer_before  ⊑  type_pun_pointer_combined := by
  unfold type_pun_pointer_before type_pun_pointer_combined
  simp_alive_peephole
  sorry
def type_pun_float_combined := [llvmfunc|
  llvm.func @type_pun_float(%arg0: vector<16xi8>) -> f32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xf32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xf32>
    llvm.return %2 : f32
  }]

theorem inst_combine_type_pun_float   : type_pun_float_before  ⊑  type_pun_float_combined := by
  unfold type_pun_float_before type_pun_float_combined
  simp_alive_peephole
  sorry
def type_pun_double_combined := [llvmfunc|
  llvm.func @type_pun_double(%arg0: vector<16xi8>) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<2xf64>
    %2 = llvm.extractelement %1[%0 : i64] : vector<2xf64>
    llvm.return %2 : f64
  }]

theorem inst_combine_type_pun_double   : type_pun_double_before  ⊑  type_pun_double_combined := by
  unfold type_pun_double_before type_pun_double_combined
  simp_alive_peephole
  sorry
def type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<(f32, i32)> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.undef : !llvm.struct<(f32, i32)>
    %2 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %3 = llvm.extractelement %2[%0 : i64] : vector<4xi32>
    %4 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xf32>
    %5 = llvm.extractelement %4[%0 : i64] : vector<4xf32>
    %6 = llvm.insertvalue %5, %1[0] : !llvm.struct<(f32, i32)> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.struct<(f32, i32)> 
    llvm.return %7 : !llvm.struct<(f32, i32)>
  }]

theorem inst_combine_type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<   : type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<_before  ⊑  type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<_combined := by
  unfold type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<_before type_pun_float_i32(%arg0: vector<16xi8>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def type_pun_i32_ctrl_combined := [llvmfunc|
  llvm.func @type_pun_i32_ctrl(%arg0: vector<16xi8>, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }]

theorem inst_combine_type_pun_i32_ctrl   : type_pun_i32_ctrl_before  ⊑  type_pun_i32_ctrl_combined := by
  unfold type_pun_i32_ctrl_before type_pun_i32_ctrl_combined
  simp_alive_peephole
  sorry
def type_pun_unhandled_combined := [llvmfunc|
  llvm.func @type_pun_unhandled(%arg0: vector<16xi8>) -> i40 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 6, 7, 8] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<5xi8> to i40
    llvm.return %2 : i40
  }]

theorem inst_combine_type_pun_unhandled   : type_pun_unhandled_before  ⊑  type_pun_unhandled_combined := by
  unfold type_pun_unhandled_before type_pun_unhandled_combined
  simp_alive_peephole
  sorry

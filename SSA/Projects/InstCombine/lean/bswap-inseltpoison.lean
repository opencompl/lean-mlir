import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bswap-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shuf_4bytes_before := [llvmfunc|
  llvm.func @shuf_4bytes(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def shuf_load_4bytes_before := [llvmfunc|
  llvm.func @shuf_load_4bytes(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>]

    %2 = llvm.shufflevector %1, %0 [3, 2, -1, 0] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }]

def shuf_bitcast_twice_4bytes_before := [llvmfunc|
  llvm.func @shuf_bitcast_twice_4bytes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [-1, 2, 1, 0] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }]

def shuf_4bytes_extra_use_before := [llvmfunc|
  llvm.func @shuf_4bytes_extra_use(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    llvm.call @use(%1) : (vector<4xi8>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def shuf_16bytes_before := [llvmfunc|
  llvm.func @shuf_16bytes(%arg0: vector<16xi8>) -> i128 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<16xi8> to i128
    llvm.return %2 : i128
  }]

def shuf_2bytes_widening_before := [llvmfunc|
  llvm.func @shuf_2bytes_widening(%arg0: vector<2xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, -1, -1] : vector<2xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def shuf_4bytes_combined := [llvmfunc|
  llvm.func @shuf_4bytes(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi8> to i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shuf_4bytes   : shuf_4bytes_before  ⊑  shuf_4bytes_combined := by
  unfold shuf_4bytes_before shuf_4bytes_combined
  simp_alive_peephole
  sorry
def shuf_load_4bytes_combined := [llvmfunc|
  llvm.func @shuf_load_4bytes(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shuf_load_4bytes   : shuf_load_4bytes_before  ⊑  shuf_load_4bytes_combined := by
  unfold shuf_load_4bytes_before shuf_load_4bytes_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_twice_4bytes_combined := [llvmfunc|
  llvm.func @shuf_bitcast_twice_4bytes(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shuf_bitcast_twice_4bytes   : shuf_bitcast_twice_4bytes_before  ⊑  shuf_bitcast_twice_4bytes_combined := by
  unfold shuf_bitcast_twice_4bytes_before shuf_bitcast_twice_4bytes_combined
  simp_alive_peephole
  sorry
def shuf_4bytes_extra_use_combined := [llvmfunc|
  llvm.func @shuf_4bytes_extra_use(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    llvm.call @use(%1) : (vector<4xi8>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shuf_4bytes_extra_use   : shuf_4bytes_extra_use_before  ⊑  shuf_4bytes_extra_use_combined := by
  unfold shuf_4bytes_extra_use_before shuf_4bytes_extra_use_combined
  simp_alive_peephole
  sorry
def shuf_16bytes_combined := [llvmfunc|
  llvm.func @shuf_16bytes(%arg0: vector<16xi8>) -> i128 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<16xi8> to i128
    llvm.return %2 : i128
  }]

theorem inst_combine_shuf_16bytes   : shuf_16bytes_before  ⊑  shuf_16bytes_combined := by
  unfold shuf_16bytes_before shuf_16bytes_combined
  simp_alive_peephole
  sorry
def shuf_2bytes_widening_combined := [llvmfunc|
  llvm.func @shuf_2bytes_widening(%arg0: vector<2xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, -1, -1] : vector<2xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shuf_2bytes_widening   : shuf_2bytes_widening_before  ⊑  shuf_2bytes_widening_combined := by
  unfold shuf_2bytes_widening_before shuf_2bytes_widening_combined
  simp_alive_peephole
  sorry

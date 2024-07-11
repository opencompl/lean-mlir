import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-not
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sub_not_before := [llvmfunc|
  llvm.func @sub_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

def sub_not_extra_use_before := [llvmfunc|
  llvm.func @sub_not_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def sub_not_vec_before := [llvmfunc|
  llvm.func @sub_not_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %8 = llvm.xor %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def dec_sub_before := [llvmfunc|
  llvm.func @dec_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.return %2 : i8
  }]

def dec_sub_extra_use_before := [llvmfunc|
  llvm.func @dec_sub_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def dec_sub_vec_before := [llvmfunc|
  llvm.func @dec_sub_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %8 = llvm.add %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def sub_inc_before := [llvmfunc|
  llvm.func @sub_inc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def sub_inc_extra_use_before := [llvmfunc|
  llvm.func @sub_inc_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def sub_inc_vec_before := [llvmfunc|
  llvm.func @sub_inc_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %6  : vector<2xi8>
    %8 = llvm.sub %arg1, %7  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def sub_dec_before := [llvmfunc|
  llvm.func @sub_dec(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def sub_dec_extra_use_before := [llvmfunc|
  llvm.func @sub_dec_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def sub_dec_vec_before := [llvmfunc|
  llvm.func @sub_dec_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %6  : vector<2xi8>
    %8 = llvm.sub %7, %arg1  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def sub_not_combined := [llvmfunc|
  llvm.func @sub_not(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_not   : sub_not_before  ⊑  sub_not_combined := by
  unfold sub_not_before sub_not_combined
  simp_alive_peephole
  sorry
def sub_not_extra_use_combined := [llvmfunc|
  llvm.func @sub_not_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_not_extra_use   : sub_not_extra_use_before  ⊑  sub_not_extra_use_combined := by
  unfold sub_not_extra_use_before sub_not_extra_use_combined
  simp_alive_peephole
  sorry
def sub_not_vec_combined := [llvmfunc|
  llvm.func @sub_not_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_sub_not_vec   : sub_not_vec_before  ⊑  sub_not_vec_combined := by
  unfold sub_not_vec_before sub_not_vec_combined
  simp_alive_peephole
  sorry
def dec_sub_combined := [llvmfunc|
  llvm.func @dec_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_dec_sub   : dec_sub_before  ⊑  dec_sub_combined := by
  unfold dec_sub_before dec_sub_combined
  simp_alive_peephole
  sorry
def dec_sub_extra_use_combined := [llvmfunc|
  llvm.func @dec_sub_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_dec_sub_extra_use   : dec_sub_extra_use_before  ⊑  dec_sub_extra_use_combined := by
  unfold dec_sub_extra_use_before dec_sub_extra_use_combined
  simp_alive_peephole
  sorry
def dec_sub_vec_combined := [llvmfunc|
  llvm.func @dec_sub_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg1, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_dec_sub_vec   : dec_sub_vec_before  ⊑  dec_sub_vec_combined := by
  unfold dec_sub_vec_before dec_sub_vec_combined
  simp_alive_peephole
  sorry
def sub_inc_combined := [llvmfunc|
  llvm.func @sub_inc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_inc   : sub_inc_before  ⊑  sub_inc_combined := by
  unfold sub_inc_before sub_inc_combined
  simp_alive_peephole
  sorry
def sub_inc_extra_use_combined := [llvmfunc|
  llvm.func @sub_inc_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_inc_extra_use   : sub_inc_extra_use_before  ⊑  sub_inc_extra_use_combined := by
  unfold sub_inc_extra_use_before sub_inc_extra_use_combined
  simp_alive_peephole
  sorry
def sub_inc_vec_combined := [llvmfunc|
  llvm.func @sub_inc_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_sub_inc_vec   : sub_inc_vec_before  ⊑  sub_inc_vec_combined := by
  unfold sub_inc_vec_before sub_inc_vec_combined
  simp_alive_peephole
  sorry
def sub_dec_combined := [llvmfunc|
  llvm.func @sub_dec(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_dec   : sub_dec_before  ⊑  sub_dec_combined := by
  unfold sub_dec_before sub_dec_combined
  simp_alive_peephole
  sorry
def sub_dec_extra_use_combined := [llvmfunc|
  llvm.func @sub_dec_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.call @use(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_dec_extra_use   : sub_dec_extra_use_before  ⊑  sub_dec_extra_use_combined := by
  unfold sub_dec_extra_use_before sub_dec_extra_use_combined
  simp_alive_peephole
  sorry
def sub_dec_vec_combined := [llvmfunc|
  llvm.func @sub_dec_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg1, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_sub_dec_vec   : sub_dec_vec_before  ⊑  sub_dec_vec_combined := by
  unfold sub_dec_vec_before sub_dec_vec_combined
  simp_alive_peephole
  sorry

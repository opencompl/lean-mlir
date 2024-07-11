import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr53357
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def src_before := [llvmfunc|
  llvm.func @src(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def src_vec_before := [llvmfunc|
  llvm.func @src_vec(%arg0: vector<2xi32> {llvm.noundef}, %arg1: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg1, %arg0  : vector<2xi32>
    %2 = llvm.or %arg1, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.add %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def src_vec_poison_before := [llvmfunc|
  llvm.func @src_vec_poison(%arg0: vector<2xi32> {llvm.noundef}, %arg1: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.and %arg1, %arg0  : vector<2xi32>
    %8 = llvm.or %arg1, %arg0  : vector<2xi32>
    %9 = llvm.xor %8, %6  : vector<2xi32>
    %10 = llvm.add %7, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def src2_before := [llvmfunc|
  llvm.func @src2(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def src3_before := [llvmfunc|
  llvm.func @src3(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.add %1, %4  : i32
    llvm.return %5 : i32
  }]

def src4_before := [llvmfunc|
  llvm.func @src4(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def src5_before := [llvmfunc|
  llvm.func @src5(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def src6_before := [llvmfunc|
  llvm.func @src6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg2, %arg3  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def src_combined := [llvmfunc|
  llvm.func @src(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_src   : src_before  ⊑  src_combined := by
  unfold src_before src_combined
  simp_alive_peephole
  sorry
def src_vec_combined := [llvmfunc|
  llvm.func @src_vec(%arg0: vector<2xi32> {llvm.noundef}, %arg1: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg1, %arg0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_src_vec   : src_vec_before  ⊑  src_vec_combined := by
  unfold src_vec_before src_vec_combined
  simp_alive_peephole
  sorry
def src_vec_poison_combined := [llvmfunc|
  llvm.func @src_vec_poison(%arg0: vector<2xi32> {llvm.noundef}, %arg1: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg1, %arg0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_src_vec_poison   : src_vec_poison_before  ⊑  src_vec_poison_combined := by
  unfold src_vec_poison_before src_vec_poison_combined
  simp_alive_peephole
  sorry
def src2_combined := [llvmfunc|
  llvm.func @src2(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_src2   : src2_before  ⊑  src2_combined := by
  unfold src2_before src2_combined
  simp_alive_peephole
  sorry
def src3_combined := [llvmfunc|
  llvm.func @src3(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_src3   : src3_before  ⊑  src3_combined := by
  unfold src3_before src3_combined
  simp_alive_peephole
  sorry
def src4_combined := [llvmfunc|
  llvm.func @src4(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_src4   : src4_before  ⊑  src4_combined := by
  unfold src4_before src4_combined
  simp_alive_peephole
  sorry
def src5_combined := [llvmfunc|
  llvm.func @src5(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_src5   : src5_before  ⊑  src5_combined := by
  unfold src5_before src5_combined
  simp_alive_peephole
  sorry
def src6_combined := [llvmfunc|
  llvm.func @src6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg2, %arg3  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_src6   : src6_before  ⊑  src6_combined := by
  unfold src6_before src6_combined
  simp_alive_peephole
  sorry

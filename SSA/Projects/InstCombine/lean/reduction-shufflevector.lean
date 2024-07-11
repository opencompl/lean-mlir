import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  reduction-shufflevector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def reduce_add_before := [llvmfunc|
  llvm.func @reduce_add(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.add"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_or_before := [llvmfunc|
  llvm.func @reduce_or(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %0, %arg0 [7, 6, 5, 4] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.or"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_and_before := [llvmfunc|
  llvm.func @reduce_and(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 2, 1, 3] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.and"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_xor_before := [llvmfunc|
  llvm.func @reduce_xor(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %0, %arg0 [5, 6, 7, 4] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.xor"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_umax_before := [llvmfunc|
  llvm.func @reduce_umax(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 1, 3, 0] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.umax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_umin_before := [llvmfunc|
  llvm.func @reduce_umin(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 3, 0, 1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.umin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_smax_before := [llvmfunc|
  llvm.func @reduce_smax(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.smax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_smin_before := [llvmfunc|
  llvm.func @reduce_smin(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 3, 1, 2] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.smin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_fmax_before := [llvmfunc|
  llvm.func @reduce_fmax(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmax(%1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<4xf32>) -> f32]

    llvm.return %2 : f32
  }]

def reduce_fmin_before := [llvmfunc|
  llvm.func @reduce_fmin(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [0, 3, 1, 2] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

def reduce_fadd_before := [llvmfunc|
  llvm.func @reduce_fadd(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.shufflevector %arg1, %arg1 [0, 3, 1, 2] : vector<4xf32> 
    %1 = "llvm.intr.vector.reduce.fadd"(%arg0, %0) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<4xf32>) -> f32]

    llvm.return %1 : f32
  }]

def reduce_fmul_before := [llvmfunc|
  llvm.func @reduce_fmul(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.shufflevector %arg1, %1 [0, 3, 1, 2] : vector<4xf32> 
    %3 = "llvm.intr.vector.reduce.fmul"(%arg0, %2) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<4xf32>) -> f32]

    llvm.return %3 : f32
  }]

def reduce_add_failed_before := [llvmfunc|
  llvm.func @reduce_add_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg0 [0, 1, 2, 4] : vector<4xi32> 
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }]

def reduce_or_failed_before := [llvmfunc|
  llvm.func @reduce_or_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [3, 2, 1, 4] : vector<4xi32> 
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<4xi32>) -> i32
    llvm.return %3 : i32
  }]

def reduce_and_failed_before := [llvmfunc|
  llvm.func @reduce_and_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 2, 1, 0] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.and"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_xor_failed_before := [llvmfunc|
  llvm.func @reduce_xor_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 2, 3, -1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.xor"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_umax_failed_before := [llvmfunc|
  llvm.func @reduce_umax_failed(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg1 [2, 1, 3, 0] : vector<2xi32> 
    %1 = "llvm.intr.vector.reduce.umax"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }]

def reduce_umin_failed_before := [llvmfunc|
  llvm.func @reduce_umin_failed(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 3, 0, 1] : vector<2xi32> 
    %2 = "llvm.intr.vector.reduce.umin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_smax_failed_before := [llvmfunc|
  llvm.func @reduce_smax_failed(%arg0: vector<8xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<8xi32> 
    %2 = "llvm.intr.vector.reduce.smax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

def reduce_smin_failed_before := [llvmfunc|
  llvm.func @reduce_smin_failed(%arg0: vector<8xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg0 [0, 3, 1, 2] : vector<8xi32> 
    %1 = "llvm.intr.vector.reduce.smin"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }]

def reduce_fmax_failed_before := [llvmfunc|
  llvm.func @reduce_fmax_failed(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [2, 2, 3, 1] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

def reduce_fmin_failed_before := [llvmfunc|
  llvm.func @reduce_fmin_failed(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [-1, 3, 1, 2] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

def reduce_fadd_failed_before := [llvmfunc|
  llvm.func @reduce_fadd_failed(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 3, 1, 2] : vector<4xf32> 
    %2 = "llvm.intr.vector.reduce.fadd"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    llvm.return %2 : f32
  }]

def reduce_fmul_failed_before := [llvmfunc|
  llvm.func @reduce_fmul_failed(%arg0: f32, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 3, 1, 2] : vector<2xf32> 
    %2 = "llvm.intr.vector.reduce.fmul"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    llvm.return %2 : f32
  }]

def reduce_add_combined := [llvmfunc|
  llvm.func @reduce_add(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.add"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_add   : reduce_add_before  ⊑  reduce_add_combined := by
  unfold reduce_add_before reduce_add_combined
  simp_alive_peephole
  sorry
def reduce_or_combined := [llvmfunc|
  llvm.func @reduce_or(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.or"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_or   : reduce_or_before  ⊑  reduce_or_combined := by
  unfold reduce_or_before reduce_or_combined
  simp_alive_peephole
  sorry
def reduce_and_combined := [llvmfunc|
  llvm.func @reduce_and(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.and"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_and   : reduce_and_before  ⊑  reduce_and_combined := by
  unfold reduce_and_before reduce_and_combined
  simp_alive_peephole
  sorry
def reduce_xor_combined := [llvmfunc|
  llvm.func @reduce_xor(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.xor"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_xor   : reduce_xor_before  ⊑  reduce_xor_combined := by
  unfold reduce_xor_before reduce_xor_combined
  simp_alive_peephole
  sorry
def reduce_umax_combined := [llvmfunc|
  llvm.func @reduce_umax(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.umax"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_umax   : reduce_umax_before  ⊑  reduce_umax_combined := by
  unfold reduce_umax_before reduce_umax_combined
  simp_alive_peephole
  sorry
def reduce_umin_combined := [llvmfunc|
  llvm.func @reduce_umin(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.umin"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_umin   : reduce_umin_before  ⊑  reduce_umin_combined := by
  unfold reduce_umin_before reduce_umin_combined
  simp_alive_peephole
  sorry
def reduce_smax_combined := [llvmfunc|
  llvm.func @reduce_smax(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.smax"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_smax   : reduce_smax_before  ⊑  reduce_smax_combined := by
  unfold reduce_smax_before reduce_smax_combined
  simp_alive_peephole
  sorry
def reduce_smin_combined := [llvmfunc|
  llvm.func @reduce_smin(%arg0: vector<4xi32>) -> i32 {
    %0 = "llvm.intr.vector.reduce.smin"(%arg0) : (vector<4xi32>) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_reduce_smin   : reduce_smin_before  ⊑  reduce_smin_combined := by
  unfold reduce_smin_before reduce_smin_combined
  simp_alive_peephole
  sorry
def reduce_fmax_combined := [llvmfunc|
  llvm.func @reduce_fmax(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.intr.vector.reduce.fmax(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<4xf32>) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_reduce_fmax   : reduce_fmax_before  ⊑  reduce_fmax_combined := by
  unfold reduce_fmax_before reduce_fmax_combined
  simp_alive_peephole
  sorry
def reduce_fmin_combined := [llvmfunc|
  llvm.func @reduce_fmin(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.intr.vector.reduce.fmin(%arg0)  : (vector<4xf32>) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_reduce_fmin   : reduce_fmin_before  ⊑  reduce_fmin_combined := by
  unfold reduce_fmin_before reduce_fmin_combined
  simp_alive_peephole
  sorry
def reduce_fadd_combined := [llvmfunc|
  llvm.func @reduce_fadd(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = "llvm.intr.vector.reduce.fadd"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<4xf32>) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_reduce_fadd   : reduce_fadd_before  ⊑  reduce_fadd_combined := by
  unfold reduce_fadd_before reduce_fadd_combined
  simp_alive_peephole
  sorry
def reduce_fmul_combined := [llvmfunc|
  llvm.func @reduce_fmul(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = "llvm.intr.vector.reduce.fmul"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<4xf32>) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_reduce_fmul   : reduce_fmul_before  ⊑  reduce_fmul_combined := by
  unfold reduce_fmul_before reduce_fmul_combined
  simp_alive_peephole
  sorry
def reduce_add_failed_combined := [llvmfunc|
  llvm.func @reduce_add_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 0] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.add"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reduce_add_failed   : reduce_add_failed_before  ⊑  reduce_add_failed_combined := by
  unfold reduce_add_failed_before reduce_add_failed_combined
  simp_alive_peephole
  sorry
def reduce_or_failed_combined := [llvmfunc|
  llvm.func @reduce_or_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shufflevector %arg0, %10 [3, 2, 1, 4] : vector<4xi32> 
    %12 = "llvm.intr.vector.reduce.or"(%11) : (vector<4xi32>) -> i32
    llvm.return %12 : i32
  }]

theorem inst_combine_reduce_or_failed   : reduce_or_failed_before  ⊑  reduce_or_failed_combined := by
  unfold reduce_or_failed_before reduce_or_failed_combined
  simp_alive_peephole
  sorry
def reduce_and_failed_combined := [llvmfunc|
  llvm.func @reduce_and_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 2, 1, 0] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.and"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reduce_and_failed   : reduce_and_failed_before  ⊑  reduce_and_failed_combined := by
  unfold reduce_and_failed_before reduce_and_failed_combined
  simp_alive_peephole
  sorry
def reduce_xor_failed_combined := [llvmfunc|
  llvm.func @reduce_xor_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 2, 3, -1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.xor"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reduce_xor_failed   : reduce_xor_failed_before  ⊑  reduce_xor_failed_combined := by
  unfold reduce_xor_failed_before reduce_xor_failed_combined
  simp_alive_peephole
  sorry
def reduce_umax_failed_combined := [llvmfunc|
  llvm.func @reduce_umax_failed(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg1 [2, 1, 3, 0] : vector<2xi32> 
    %1 = "llvm.intr.vector.reduce.umax"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_reduce_umax_failed   : reduce_umax_failed_before  ⊑  reduce_umax_failed_combined := by
  unfold reduce_umax_failed_before reduce_umax_failed_combined
  simp_alive_peephole
  sorry
def reduce_umin_failed_combined := [llvmfunc|
  llvm.func @reduce_umin_failed(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [-1, -1, 0, 1] : vector<2xi32> 
    %2 = "llvm.intr.vector.reduce.umin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reduce_umin_failed   : reduce_umin_failed_before  ⊑  reduce_umin_failed_combined := by
  unfold reduce_umin_failed_before reduce_umin_failed_combined
  simp_alive_peephole
  sorry
def reduce_smax_failed_combined := [llvmfunc|
  llvm.func @reduce_smax_failed(%arg0: vector<8xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<8xi32> 
    %2 = "llvm.intr.vector.reduce.smax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reduce_smax_failed   : reduce_smax_failed_before  ⊑  reduce_smax_failed_combined := by
  unfold reduce_smax_failed_before reduce_smax_failed_combined
  simp_alive_peephole
  sorry
def reduce_smin_failed_combined := [llvmfunc|
  llvm.func @reduce_smin_failed(%arg0: vector<8xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 3, 1, 2] : vector<8xi32> 
    %2 = "llvm.intr.vector.reduce.smin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_reduce_smin_failed   : reduce_smin_failed_before  ⊑  reduce_smin_failed_combined := by
  unfold reduce_smin_failed_before reduce_smin_failed_combined
  simp_alive_peephole
  sorry
def reduce_fmax_failed_combined := [llvmfunc|
  llvm.func @reduce_fmax_failed(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [2, 2, 3, 1] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_reduce_fmax_failed   : reduce_fmax_failed_before  ⊑  reduce_fmax_failed_combined := by
  unfold reduce_fmax_failed_before reduce_fmax_failed_combined
  simp_alive_peephole
  sorry
def reduce_fmin_failed_combined := [llvmfunc|
  llvm.func @reduce_fmin_failed(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [-1, 3, 1, 2] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_reduce_fmin_failed   : reduce_fmin_failed_before  ⊑  reduce_fmin_failed_combined := by
  unfold reduce_fmin_failed_before reduce_fmin_failed_combined
  simp_alive_peephole
  sorry
def reduce_fadd_failed_combined := [llvmfunc|
  llvm.func @reduce_fadd_failed(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 3, 1, 2] : vector<4xf32> 
    %2 = "llvm.intr.vector.reduce.fadd"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_reduce_fadd_failed   : reduce_fadd_failed_before  ⊑  reduce_fadd_failed_combined := by
  unfold reduce_fadd_failed_before reduce_fadd_failed_combined
  simp_alive_peephole
  sorry
def reduce_fmul_failed_combined := [llvmfunc|
  llvm.func @reduce_fmul_failed(%arg0: f32, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, -1, 1, -1] : vector<2xf32> 
    %2 = "llvm.intr.vector.reduce.fmul"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_reduce_fmul_failed   : reduce_fmul_failed_before  ⊑  reduce_fmul_failed_combined := by
  unfold reduce_fmul_failed_before reduce_fmul_failed_combined
  simp_alive_peephole
  sorry

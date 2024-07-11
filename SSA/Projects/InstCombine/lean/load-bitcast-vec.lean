import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-bitcast-vec
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def matching_scalar_before := [llvmfunc|
  llvm.func @matching_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32]

    llvm.return %0 : f32
  }]

def nonmatching_scalar_before := [llvmfunc|
  llvm.func @nonmatching_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i32]

    llvm.return %0 : i32
  }]

def larger_scalar_before := [llvmfunc|
  llvm.func @larger_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i64 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i64]

    llvm.return %0 : i64
  }]

def smaller_scalar_before := [llvmfunc|
  llvm.func @smaller_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i8]

    llvm.return %0 : i8
  }]

def smaller_scalar_less_aligned_before := [llvmfunc|
  llvm.func @smaller_scalar_less_aligned(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i8]

    llvm.return %0 : i8
  }]

def matching_scalar_small_deref_before := [llvmfunc|
  llvm.func @matching_scalar_small_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 15 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32]

    llvm.return %0 : f32
  }]

def matching_scalar_smallest_deref_before := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32]

    llvm.return %0 : f32
  }]

def matching_scalar_smallest_deref_or_null_before := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref_or_null(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32]

    llvm.return %0 : f32
  }]

def matching_scalar_smallest_deref_addrspace_before := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref_addrspace(%arg0: !llvm.ptr<4> {llvm.dereferenceable = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr<4> -> f32]

    llvm.return %0 : f32
  }]

def matching_scalar_smallest_deref_or_null_addrspace_before := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref_or_null_addrspace(%arg0: !llvm.ptr<4> {llvm.dereferenceable_or_null = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr<4> -> f32]

    llvm.return %0 : f32
  }]

def matching_scalar_volatile_before := [llvmfunc|
  llvm.func @matching_scalar_volatile(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load volatile %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32]

    llvm.return %0 : f32
  }]

def nonvector_before := [llvmfunc|
  llvm.func @nonvector(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32]

    llvm.return %0 : f32
  }]

def matching_scalar_combined := [llvmfunc|
  llvm.func @matching_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar   : matching_scalar_before  ⊑  matching_scalar_combined := by
  unfold matching_scalar_before matching_scalar_combined
  simp_alive_peephole
  sorry
def nonmatching_scalar_combined := [llvmfunc|
  llvm.func @nonmatching_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_nonmatching_scalar   : nonmatching_scalar_before  ⊑  nonmatching_scalar_combined := by
  unfold nonmatching_scalar_before nonmatching_scalar_combined
  simp_alive_peephole
  sorry
def larger_scalar_combined := [llvmfunc|
  llvm.func @larger_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i64 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_larger_scalar   : larger_scalar_before  ⊑  larger_scalar_combined := by
  unfold larger_scalar_before larger_scalar_combined
  simp_alive_peephole
  sorry
def smaller_scalar_combined := [llvmfunc|
  llvm.func @smaller_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smaller_scalar   : smaller_scalar_before  ⊑  smaller_scalar_combined := by
  unfold smaller_scalar_before smaller_scalar_combined
  simp_alive_peephole
  sorry
def smaller_scalar_less_aligned_combined := [llvmfunc|
  llvm.func @smaller_scalar_less_aligned(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_smaller_scalar_less_aligned   : smaller_scalar_less_aligned_before  ⊑  smaller_scalar_less_aligned_combined := by
  unfold smaller_scalar_less_aligned_before smaller_scalar_less_aligned_combined
  simp_alive_peephole
  sorry
def matching_scalar_small_deref_combined := [llvmfunc|
  llvm.func @matching_scalar_small_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 15 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar_small_deref   : matching_scalar_small_deref_before  ⊑  matching_scalar_small_deref_combined := by
  unfold matching_scalar_small_deref_before matching_scalar_small_deref_combined
  simp_alive_peephole
  sorry
def matching_scalar_smallest_deref_combined := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar_smallest_deref   : matching_scalar_smallest_deref_before  ⊑  matching_scalar_smallest_deref_combined := by
  unfold matching_scalar_smallest_deref_before matching_scalar_smallest_deref_combined
  simp_alive_peephole
  sorry
def matching_scalar_smallest_deref_or_null_combined := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref_or_null(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar_smallest_deref_or_null   : matching_scalar_smallest_deref_or_null_before  ⊑  matching_scalar_smallest_deref_or_null_combined := by
  unfold matching_scalar_smallest_deref_or_null_before matching_scalar_smallest_deref_or_null_combined
  simp_alive_peephole
  sorry
def matching_scalar_smallest_deref_addrspace_combined := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref_addrspace(%arg0: !llvm.ptr<4> {llvm.dereferenceable = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr<4> -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar_smallest_deref_addrspace   : matching_scalar_smallest_deref_addrspace_before  ⊑  matching_scalar_smallest_deref_addrspace_combined := by
  unfold matching_scalar_smallest_deref_addrspace_before matching_scalar_smallest_deref_addrspace_combined
  simp_alive_peephole
  sorry
def matching_scalar_smallest_deref_or_null_addrspace_combined := [llvmfunc|
  llvm.func @matching_scalar_smallest_deref_or_null_addrspace(%arg0: !llvm.ptr<4> {llvm.dereferenceable_or_null = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr<4> -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar_smallest_deref_or_null_addrspace   : matching_scalar_smallest_deref_or_null_addrspace_before  ⊑  matching_scalar_smallest_deref_or_null_addrspace_combined := by
  unfold matching_scalar_smallest_deref_or_null_addrspace_before matching_scalar_smallest_deref_or_null_addrspace_combined
  simp_alive_peephole
  sorry
def matching_scalar_volatile_combined := [llvmfunc|
  llvm.func @matching_scalar_volatile(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load volatile %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_matching_scalar_volatile   : matching_scalar_volatile_before  ⊑  matching_scalar_volatile_combined := by
  unfold matching_scalar_volatile_before matching_scalar_volatile_combined
  simp_alive_peephole
  sorry
def nonvector_combined := [llvmfunc|
  llvm.func @nonvector(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_nonvector   : nonvector_before  ⊑  nonvector_combined := by
  unfold nonvector_before nonvector_combined
  simp_alive_peephole
  sorry

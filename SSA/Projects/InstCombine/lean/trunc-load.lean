import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-load
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def truncload_no_deref_before := [llvmfunc|
  llvm.func @truncload_no_deref(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def truncload_small_deref_before := [llvmfunc|
  llvm.func @truncload_small_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 7 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def truncload_deref_before := [llvmfunc|
  llvm.func @truncload_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def truncload_align_before := [llvmfunc|
  llvm.func @truncload_align(%arg0: !llvm.ptr {llvm.dereferenceable = 14 : i64}) -> i16 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i32]

    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

def truncload_extra_use_before := [llvmfunc|
  llvm.func @truncload_extra_use(%arg0: !llvm.ptr {llvm.dereferenceable = 100 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i64]

    llvm.call @use(%0) : (i64) -> ()
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def truncload_type_before := [llvmfunc|
  llvm.func @truncload_type(%arg0: !llvm.ptr {llvm.dereferenceable = 9 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i64]

    %1 = llvm.trunc %0 : i64 to i8
    llvm.return %1 : i8
  }]

def truncload_volatile_before := [llvmfunc|
  llvm.func @truncload_volatile(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def truncload_address_space_before := [llvmfunc|
  llvm.func @truncload_address_space(%arg0: !llvm.ptr<1> {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr<1> -> i64]

    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def truncload_no_deref_combined := [llvmfunc|
  llvm.func @truncload_no_deref(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_truncload_no_deref   : truncload_no_deref_before  ⊑  truncload_no_deref_combined := by
  unfold truncload_no_deref_before truncload_no_deref_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_truncload_no_deref   : truncload_no_deref_before  ⊑  truncload_no_deref_combined := by
  unfold truncload_no_deref_before truncload_no_deref_combined
  simp_alive_peephole
  sorry
def truncload_small_deref_combined := [llvmfunc|
  llvm.func @truncload_small_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 7 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_truncload_small_deref   : truncload_small_deref_before  ⊑  truncload_small_deref_combined := by
  unfold truncload_small_deref_before truncload_small_deref_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_truncload_small_deref   : truncload_small_deref_before  ⊑  truncload_small_deref_combined := by
  unfold truncload_small_deref_before truncload_small_deref_combined
  simp_alive_peephole
  sorry
def truncload_deref_combined := [llvmfunc|
  llvm.func @truncload_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_truncload_deref   : truncload_deref_before  ⊑  truncload_deref_combined := by
  unfold truncload_deref_before truncload_deref_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_truncload_deref   : truncload_deref_before  ⊑  truncload_deref_combined := by
  unfold truncload_deref_before truncload_deref_combined
  simp_alive_peephole
  sorry
def truncload_align_combined := [llvmfunc|
  llvm.func @truncload_align(%arg0: !llvm.ptr {llvm.dereferenceable = 14 : i64}) -> i16 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i32]

theorem inst_combine_truncload_align   : truncload_align_before  ⊑  truncload_align_combined := by
  unfold truncload_align_before truncload_align_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

theorem inst_combine_truncload_align   : truncload_align_before  ⊑  truncload_align_combined := by
  unfold truncload_align_before truncload_align_combined
  simp_alive_peephole
  sorry
def truncload_extra_use_combined := [llvmfunc|
  llvm.func @truncload_extra_use(%arg0: !llvm.ptr {llvm.dereferenceable = 100 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i64]

theorem inst_combine_truncload_extra_use   : truncload_extra_use_before  ⊑  truncload_extra_use_combined := by
  unfold truncload_extra_use_before truncload_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (i64) -> ()
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_truncload_extra_use   : truncload_extra_use_before  ⊑  truncload_extra_use_combined := by
  unfold truncload_extra_use_before truncload_extra_use_combined
  simp_alive_peephole
  sorry
def truncload_type_combined := [llvmfunc|
  llvm.func @truncload_type(%arg0: !llvm.ptr {llvm.dereferenceable = 9 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i64]

theorem inst_combine_truncload_type   : truncload_type_before  ⊑  truncload_type_combined := by
  unfold truncload_type_before truncload_type_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i64 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_truncload_type   : truncload_type_before  ⊑  truncload_type_combined := by
  unfold truncload_type_before truncload_type_combined
  simp_alive_peephole
  sorry
def truncload_volatile_combined := [llvmfunc|
  llvm.func @truncload_volatile(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_truncload_volatile   : truncload_volatile_before  ⊑  truncload_volatile_combined := by
  unfold truncload_volatile_before truncload_volatile_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_truncload_volatile   : truncload_volatile_before  ⊑  truncload_volatile_combined := by
  unfold truncload_volatile_before truncload_volatile_combined
  simp_alive_peephole
  sorry
def truncload_address_space_combined := [llvmfunc|
  llvm.func @truncload_address_space(%arg0: !llvm.ptr<1> {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr<1> -> i64]

theorem inst_combine_truncload_address_space   : truncload_address_space_before  ⊑  truncload_address_space_combined := by
  unfold truncload_address_space_before truncload_address_space_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_truncload_address_space   : truncload_address_space_before  ⊑  truncload_address_space_combined := by
  unfold truncload_address_space_before truncload_address_space_combined
  simp_alive_peephole
  sorry

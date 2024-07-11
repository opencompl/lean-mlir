import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-int2ptr-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.br ^bb3(%3 : !llvm.ptr)
  ^bb3(%4: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    llvm.return %5 : i64
  }]

def func_single_operand_before := [llvmfunc|
  llvm.func @func_single_operand(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }]

def func_pointer_different_types_before := [llvmfunc|
  llvm.func @func_pointer_different_types(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }]

def func_integer_type_too_small_before := [llvmfunc|
  llvm.func @func_integer_type_too_small(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }]

def func_phi_not_use_in_ptr2int_before := [llvmfunc|
  llvm.func @func_phi_not_use_in_ptr2int(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> !llvm.ptr {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : !llvm.ptr
  }]

def func_ptr_different_addrspace_before := [llvmfunc|
  llvm.func @func_ptr_different_addrspace(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.br ^bb2(%1 : !llvm.ptr)
  ^bb2(%2: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    llvm.return %3 : i64
  }]

def func_combined := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%0: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
def func_single_operand_combined := [llvmfunc|
  llvm.func @func_single_operand(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%0: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_func_single_operand   : func_single_operand_before  ⊑  func_single_operand_combined := by
  unfold func_single_operand_before func_single_operand_combined
  simp_alive_peephole
  sorry
def func_pointer_different_types_combined := [llvmfunc|
  llvm.func @func_pointer_different_types(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg0 : !llvm.ptr)
  ^bb2(%0: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_func_pointer_different_types   : func_pointer_different_types_before  ⊑  func_pointer_different_types_combined := by
  unfold func_pointer_different_types_before func_pointer_different_types_combined
  simp_alive_peephole
  sorry
def func_integer_type_too_small_combined := [llvmfunc|
  llvm.func @func_integer_type_too_small(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.br ^bb2(%3 : !llvm.ptr)
  ^bb2(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_func_integer_type_too_small   : func_integer_type_too_small_before  ⊑  func_integer_type_too_small_combined := by
  unfold func_integer_type_too_small_before func_integer_type_too_small_combined
  simp_alive_peephole
  sorry
def func_phi_not_use_in_ptr2int_combined := [llvmfunc|
  llvm.func @func_phi_not_use_in_ptr2int(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i1) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    llvm.br ^bb2(%3 : !llvm.ptr)
  ^bb2(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_func_phi_not_use_in_ptr2int   : func_phi_not_use_in_ptr2int_before  ⊑  func_phi_not_use_in_ptr2int_combined := by
  unfold func_phi_not_use_in_ptr2int_before func_phi_not_use_in_ptr2int_combined
  simp_alive_peephole
  sorry
def func_ptr_different_addrspace_combined := [llvmfunc|
  llvm.func @func_ptr_different_addrspace(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr, %arg2: i1) -> i64 {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    llvm.br ^bb2(%2 : !llvm.ptr)
  ^bb2(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_func_ptr_different_addrspace   : func_ptr_different_addrspace_before  ⊑  func_ptr_different_addrspace_combined := by
  unfold func_ptr_different_addrspace_before func_ptr_different_addrspace_combined
  simp_alive_peephole
  sorry

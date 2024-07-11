import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcpy_chk-64
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @__strcpy_chk(%2, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @func2(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

def func_no_null_opt_before := [llvmfunc|
  llvm.func @func_no_null_opt(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "null_pointer_is_valid", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @__strcpy_chk(%2, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @func2(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

def func_combined := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @__strcpy_chk(%2, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @func2(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
def func_no_null_opt_combined := [llvmfunc|
  llvm.func @func_no_null_opt(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind", "null_pointer_is_valid", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @__strcpy_chk(%2, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @func2(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_func_no_null_opt   : func_no_null_opt_before  ⊑  func_no_null_opt_combined := by
  unfold func_no_null_opt_before func_no_null_opt_combined
  simp_alive_peephole
  sorry

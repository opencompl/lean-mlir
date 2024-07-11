import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen_chk
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def unknown_str_known_object_size_before := [llvmfunc|
  llvm.func @unknown_str_known_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def known_str_known_object_size_before := [llvmfunc|
  llvm.func @known_str_known_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

def known_str_too_small_object_size_before := [llvmfunc|
  llvm.func @known_str_too_small_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

def known_str_no_nul_before := [llvmfunc|
  llvm.func @known_str_no_nul(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hello_no_nul : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

def unknown_str_unknown_object_size_before := [llvmfunc|
  llvm.func @unknown_str_unknown_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def unknown_str_known_object_size_combined := [llvmfunc|
  llvm.func @unknown_str_known_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_unknown_str_known_object_size   : unknown_str_known_object_size_before  ⊑  unknown_str_known_object_size_combined := by
  unfold unknown_str_known_object_size_before unknown_str_known_object_size_combined
  simp_alive_peephole
  sorry
def known_str_known_object_size_combined := [llvmfunc|
  llvm.func @known_str_known_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_known_str_known_object_size   : known_str_known_object_size_before  ⊑  known_str_known_object_size_combined := by
  unfold known_str_known_object_size_before known_str_known_object_size_combined
  simp_alive_peephole
  sorry
def known_str_too_small_object_size_combined := [llvmfunc|
  llvm.func @known_str_too_small_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_known_str_too_small_object_size   : known_str_too_small_object_size_before  ⊑  known_str_too_small_object_size_combined := by
  unfold known_str_too_small_object_size_before known_str_too_small_object_size_combined
  simp_alive_peephole
  sorry
def known_str_no_nul_combined := [llvmfunc|
  llvm.func @known_str_no_nul(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hello_no_nul : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @__strlen_chk(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_known_str_no_nul   : known_str_no_nul_before  ⊑  known_str_no_nul_combined := by
  unfold known_str_no_nul_before known_str_no_nul_combined
  simp_alive_peephole
  sorry
def unknown_str_unknown_object_size_combined := [llvmfunc|
  llvm.func @unknown_str_unknown_object_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_unknown_str_unknown_object_size   : unknown_str_unknown_object_size_before  ⊑  unknown_str_unknown_object_size_combined := by
  unfold unknown_str_unknown_object_size_before unknown_str_unknown_object_size_combined
  simp_alive_peephole
  sorry

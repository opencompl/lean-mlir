import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncpy-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fill_with_zeros_before := [llvmfunc|
  llvm.func @fill_with_zeros(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def fill_with_zeros2_before := [llvmfunc|
  llvm.func @fill_with_zeros2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abc") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @str2 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def fill_with_zeros3_before := [llvmfunc|
  llvm.func @fill_with_zeros3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def fill_with_zeros4_before := [llvmfunc|
  llvm.func @fill_with_zeros4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(128 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def no_simplify_before := [llvmfunc|
  llvm.func @no_simplify(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(129 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def fill_with_zeros_combined := [llvmfunc|
  llvm.func @fill_with_zeros(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(97 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_fill_with_zeros   : fill_with_zeros_before  ⊑  fill_with_zeros_combined := by
  unfold fill_with_zeros_before fill_with_zeros_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fill_with_zeros   : fill_with_zeros_before  ⊑  fill_with_zeros_combined := by
  unfold fill_with_zeros_before fill_with_zeros_combined
  simp_alive_peephole
  sorry
def fill_with_zeros2_combined := [llvmfunc|
  llvm.func @fill_with_zeros2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(6513249 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_fill_with_zeros2   : fill_with_zeros2_before  ⊑  fill_with_zeros2_combined := by
  unfold fill_with_zeros2_before fill_with_zeros2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fill_with_zeros2   : fill_with_zeros2_before  ⊑  fill_with_zeros2_combined := by
  unfold fill_with_zeros2_before fill_with_zeros2_combined
  simp_alive_peephole
  sorry
def fill_with_zeros3_combined := [llvmfunc|
  llvm.func @fill_with_zeros3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1684234849 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_fill_with_zeros3   : fill_with_zeros3_before  ⊑  fill_with_zeros3_combined := by
  unfold fill_with_zeros3_before fill_with_zeros3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fill_with_zeros3   : fill_with_zeros3_before  ⊑  fill_with_zeros3_combined := by
  unfold fill_with_zeros3_before fill_with_zeros3_combined
  simp_alive_peephole
  sorry
def fill_with_zeros4_combined := [llvmfunc|
  llvm.func @fill_with_zeros4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00") : !llvm.array<129 x i8>
    %1 = llvm.mlir.addressof @str.2 : !llvm.ptr
    %2 = llvm.mlir.constant(128 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_fill_with_zeros4   : fill_with_zeros4_before  ⊑  fill_with_zeros4_combined := by
  unfold fill_with_zeros4_before fill_with_zeros4_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fill_with_zeros4   : fill_with_zeros4_before  ⊑  fill_with_zeros4_combined := by
  unfold fill_with_zeros4_before fill_with_zeros4_combined
  simp_alive_peephole
  sorry
def no_simplify_combined := [llvmfunc|
  llvm.func @no_simplify(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcd") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @str3 : !llvm.ptr
    %2 = llvm.mlir.constant(129 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_no_simplify   : no_simplify_before  ⊑  no_simplify_combined := by
  unfold no_simplify_before no_simplify_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  lifetime-sanitizer
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def asan_before := [llvmfunc|
  llvm.func @asan() attributes {passthrough = ["sanitize_address"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def hwasan_before := [llvmfunc|
  llvm.func @hwasan() attributes {passthrough = ["sanitize_hwaddress"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def msan_before := [llvmfunc|
  llvm.func @msan() attributes {passthrough = ["sanitize_memory"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def no_asan_before := [llvmfunc|
  llvm.func @no_asan() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def asan_combined := [llvmfunc|
  llvm.func @asan() attributes {passthrough = ["sanitize_address"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_asan   : asan_before  ⊑  asan_combined := by
  unfold asan_before asan_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_asan   : asan_before  ⊑  asan_combined := by
  unfold asan_before asan_combined
  simp_alive_peephole
  sorry
def hwasan_combined := [llvmfunc|
  llvm.func @hwasan() attributes {passthrough = ["sanitize_hwaddress"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_hwasan   : hwasan_before  ⊑  hwasan_combined := by
  unfold hwasan_before hwasan_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_hwasan   : hwasan_before  ⊑  hwasan_combined := by
  unfold hwasan_before hwasan_combined
  simp_alive_peephole
  sorry
def msan_combined := [llvmfunc|
  llvm.func @msan() attributes {passthrough = ["sanitize_memory"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_msan   : msan_before  ⊑  msan_combined := by
  unfold msan_before msan_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_msan   : msan_before  ⊑  msan_combined := by
  unfold msan_before msan_combined
  simp_alive_peephole
  sorry
def no_asan_combined := [llvmfunc|
  llvm.func @no_asan() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_no_asan   : no_asan_before  ⊑  no_asan_combined := by
  unfold no_asan_before no_asan_combined
  simp_alive_peephole
  sorry
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_no_asan   : no_asan_before  ⊑  no_asan_combined := by
  unfold no_asan_before no_asan_combined
  simp_alive_peephole
  sorry

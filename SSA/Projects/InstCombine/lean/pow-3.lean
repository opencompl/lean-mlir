import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sqrt_libcall_before := [llvmfunc|
  llvm.func @sqrt_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def sqrt_intrinsic_before := [llvmfunc|
  llvm.func @sqrt_intrinsic(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def shrink_libcall_before := [llvmfunc|
  llvm.func @shrink_libcall(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def shrink_intrinsic_before := [llvmfunc|
  llvm.func @shrink_intrinsic(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def sqrt_libcall_combined := [llvmfunc|
  llvm.func @sqrt_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_libcall   : sqrt_libcall_before  ⊑  sqrt_libcall_combined := by
  unfold sqrt_libcall_before sqrt_libcall_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %3 = llvm.intr.fabs(%2)  : (f64) -> f64
    %4 = llvm.fcmp "oeq" %arg0, %0 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }]

theorem inst_combine_sqrt_intrinsic   : sqrt_intrinsic_before  ⊑  sqrt_intrinsic_combined := by
  unfold sqrt_intrinsic_before sqrt_intrinsic_combined
  simp_alive_peephole
  sorry
def shrink_libcall_combined := [llvmfunc|
  llvm.func @shrink_libcall(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_shrink_libcall   : shrink_libcall_before  ⊑  shrink_libcall_combined := by
  unfold shrink_libcall_before shrink_libcall_combined
  simp_alive_peephole
  sorry
def shrink_intrinsic_combined := [llvmfunc|
  llvm.func @shrink_intrinsic(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_shrink_intrinsic   : shrink_intrinsic_before  ⊑  shrink_intrinsic_combined := by
  unfold shrink_intrinsic_before shrink_intrinsic_combined
  simp_alive_peephole
  sorry

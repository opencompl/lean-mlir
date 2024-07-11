import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sqrt-nofast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mysqrt_before := [llvmfunc|
  llvm.func @mysqrt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %1 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %arg1, %2 {alignment = 4 : i64} : f32, !llvm.ptr]

    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %5 = llvm.fmul %3, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %6 = llvm.intr.sqrt(%5)  : (f32) -> f32
    llvm.return %6 : f32
  }]

def fake_sqrt_before := [llvmfunc|
  llvm.func @fake_sqrt(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def mysqrt_combined := [llvmfunc|
  llvm.func @mysqrt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_mysqrt   : mysqrt_before  ⊑  mysqrt_combined := by
  unfold mysqrt_before mysqrt_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_mysqrt   : mysqrt_before  ⊑  mysqrt_combined := by
  unfold mysqrt_before mysqrt_combined
  simp_alive_peephole
  sorry
def fake_sqrt_combined := [llvmfunc|
  llvm.func @fake_sqrt(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_fake_sqrt   : fake_sqrt_before  ⊑  fake_sqrt_combined := by
  unfold fake_sqrt_before fake_sqrt_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_fake_sqrt   : fake_sqrt_before  ⊑  fake_sqrt_combined := by
  unfold fake_sqrt_before fake_sqrt_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fake_sqrt   : fake_sqrt_before  ⊑  fake_sqrt_combined := by
  unfold fake_sqrt_before fake_sqrt_combined
  simp_alive_peephole
  sorry

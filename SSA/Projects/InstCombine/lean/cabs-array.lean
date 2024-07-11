import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cabs-array
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def std_cabs_before := [llvmfunc|
  llvm.func @std_cabs(%arg0: !llvm.array<2 x f64>) -> f64 {
    %0 = llvm.call @cabs(%arg0) : (!llvm.array<2 x f64>) -> f64
    llvm.return %0 : f64
  }]

def std_cabsf_before := [llvmfunc|
  llvm.func @std_cabsf(%arg0: !llvm.array<2 x f32>) -> f32 {
    %0 = llvm.call @cabsf(%arg0) : (!llvm.array<2 x f32>) -> f32
    llvm.return %0 : f32
  }]

def std_cabsl_before := [llvmfunc|
  llvm.func @std_cabsl(%arg0: !llvm.array<2 x f128>) -> f128 {
    %0 = llvm.call @cabsl(%arg0) : (!llvm.array<2 x f128>) -> f128
    llvm.return %0 : f128
  }]

def fast_cabs_before := [llvmfunc|
  llvm.func @fast_cabs(%arg0: !llvm.array<2 x f64>) -> f64 {
    %0 = llvm.call @cabs(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (!llvm.array<2 x f64>) -> f64]

    llvm.return %0 : f64
  }]

def fast_cabsf_before := [llvmfunc|
  llvm.func @fast_cabsf(%arg0: !llvm.array<2 x f32>) -> f32 {
    %0 = llvm.call @cabsf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (!llvm.array<2 x f32>) -> f32]

    llvm.return %0 : f32
  }]

def fast_cabsl_before := [llvmfunc|
  llvm.func @fast_cabsl(%arg0: !llvm.array<2 x f128>) -> f128 {
    %0 = llvm.call @cabsl(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (!llvm.array<2 x f128>) -> f128]

    llvm.return %0 : f128
  }]

def std_cabs_combined := [llvmfunc|
  llvm.func @std_cabs(%arg0: !llvm.array<2 x f64>) -> f64 {
    %0 = llvm.call @cabs(%arg0) : (!llvm.array<2 x f64>) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_std_cabs   : std_cabs_before  ⊑  std_cabs_combined := by
  unfold std_cabs_before std_cabs_combined
  simp_alive_peephole
  sorry
def std_cabsf_combined := [llvmfunc|
  llvm.func @std_cabsf(%arg0: !llvm.array<2 x f32>) -> f32 {
    %0 = llvm.call @cabsf(%arg0) : (!llvm.array<2 x f32>) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_std_cabsf   : std_cabsf_before  ⊑  std_cabsf_combined := by
  unfold std_cabsf_before std_cabsf_combined
  simp_alive_peephole
  sorry
def std_cabsl_combined := [llvmfunc|
  llvm.func @std_cabsl(%arg0: !llvm.array<2 x f128>) -> f128 {
    %0 = llvm.call @cabsl(%arg0) : (!llvm.array<2 x f128>) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_std_cabsl   : std_cabsl_before  ⊑  std_cabsl_combined := by
  unfold std_cabsl_before std_cabsl_combined
  simp_alive_peephole
  sorry
def fast_cabs_combined := [llvmfunc|
  llvm.func @fast_cabs(%arg0: !llvm.array<2 x f64>) -> f64 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.array<2 x f64> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.array<2 x f64> 
    %2 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %5 = llvm.intr.sqrt(%4)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %5 : f64
  }]

theorem inst_combine_fast_cabs   : fast_cabs_before  ⊑  fast_cabs_combined := by
  unfold fast_cabs_before fast_cabs_combined
  simp_alive_peephole
  sorry
def fast_cabsf_combined := [llvmfunc|
  llvm.func @fast_cabsf(%arg0: !llvm.array<2 x f32>) -> f32 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.array<2 x f32> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.array<2 x f32> 
    %2 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.intr.sqrt(%4)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %5 : f32
  }]

theorem inst_combine_fast_cabsf   : fast_cabsf_before  ⊑  fast_cabsf_combined := by
  unfold fast_cabsf_before fast_cabsf_combined
  simp_alive_peephole
  sorry
def fast_cabsl_combined := [llvmfunc|
  llvm.func @fast_cabsl(%arg0: !llvm.array<2 x f128>) -> f128 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.array<2 x f128> 
    %1 = llvm.extractvalue %arg0[1] : !llvm.array<2 x f128> 
    %2 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f128
    %3 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f128
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f128
    %5 = llvm.intr.sqrt(%4)  {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128
    llvm.return %5 : f128
  }]

theorem inst_combine_fast_cabsl   : fast_cabsl_before  ⊑  fast_cabsl_combined := by
  unfold fast_cabsl_before fast_cabsl_combined
  simp_alive_peephole
  sorry

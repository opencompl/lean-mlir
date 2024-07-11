import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fcmp-special
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def oeq_self_before := [llvmfunc|
  llvm.func @oeq_self(%arg0: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg0 : f64
    llvm.return %0 : i1
  }]

def une_self_before := [llvmfunc|
  llvm.func @une_self(%arg0: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg0 : f64
    llvm.return %0 : i1
  }]

def ord_zero_before := [llvmfunc|
  llvm.func @ord_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

def ord_nonzero_before := [llvmfunc|
  llvm.func @ord_nonzero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ord" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

def ord_self_before := [llvmfunc|
  llvm.func @ord_self(%arg0: f32) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg0 : f32
    llvm.return %0 : i1
  }]

def uno_zero_before := [llvmfunc|
  llvm.func @uno_zero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

def uno_nonzero_before := [llvmfunc|
  llvm.func @uno_nonzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

def uno_self_before := [llvmfunc|
  llvm.func @uno_self(%arg0: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg0 : f64
    llvm.return %0 : i1
  }]

def ord_zero_vec_before := [llvmfunc|
  llvm.func @ord_zero_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def ord_nonzero_vec_before := [llvmfunc|
  llvm.func @ord_nonzero_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 5.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ord" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

def ord_self_vec_before := [llvmfunc|
  llvm.func @ord_self_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.fcmp "ord" %arg0, %arg0 : vector<2xf64>
    llvm.return %0 : vector<2xi1>
  }]

def uno_zero_vec_before := [llvmfunc|
  llvm.func @uno_zero_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def uno_nonzero_vec_before := [llvmfunc|
  llvm.func @uno_nonzero_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 5.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "uno" %arg0, %0 : vector<2xf64>
    llvm.return %1 : vector<2xi1>
  }]

def uno_self_vec_before := [llvmfunc|
  llvm.func @uno_self_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg0, %arg0 : vector<2xf32>
    llvm.return %0 : vector<2xi1>
  }]

def uno_vec_with_nan_before := [llvmfunc|
  llvm.func @uno_vec_with_nan(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 0x7FF00000FFFFFFFF]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "uno" %arg0, %0 : vector<2xf64>
    llvm.return %1 : vector<2xi1>
  }]

def uno_vec_with_poison_before := [llvmfunc|
  llvm.func @uno_vec_with_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "uno" %arg0, %6 : vector<2xf64>
    llvm.return %7 : vector<2xi1>
  }]

def ord_vec_with_poison_before := [llvmfunc|
  llvm.func @ord_vec_with_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "ord" %arg0, %6 : vector<2xf64>
    llvm.return %7 : vector<2xi1>
  }]

def nnan_ops_to_fcmp_ord_before := [llvmfunc|
  llvm.func @nnan_ops_to_fcmp_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %1 = llvm.fdiv %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = llvm.fcmp "ord" %0, %1 : f32
    llvm.return %2 : i1
  }]

def nnan_ops_to_fcmp_uno_before := [llvmfunc|
  llvm.func @nnan_ops_to_fcmp_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %1 = llvm.fdiv %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }]

def negative_zero_oeq_before := [llvmfunc|
  llvm.func @negative_zero_oeq(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

def negative_zero_oge_before := [llvmfunc|
  llvm.func @negative_zero_oge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    llvm.return %1 : i1
  }]

def negative_zero_uge_before := [llvmfunc|
  llvm.func @negative_zero_uge(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %1 : i1
  }]

def negative_zero_olt_vec_before := [llvmfunc|
  llvm.func @negative_zero_olt_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<2xf32>]

    llvm.return %1 : vector<2xi1>
  }]

def negative_zero_une_vec_poison_before := [llvmfunc|
  llvm.func @negative_zero_une_vec_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "une" %arg0, %6 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>]

    llvm.return %7 : vector<2xi1>
  }]

def negative_zero_ule_vec_mixed_before := [llvmfunc|
  llvm.func @negative_zero_ule_vec_mixed(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ule" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

def oeq_self_combined := [llvmfunc|
  llvm.func @oeq_self(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ord" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

theorem inst_combine_oeq_self   : oeq_self_before  ⊑  oeq_self_combined := by
  unfold oeq_self_before oeq_self_combined
  simp_alive_peephole
  sorry
def une_self_combined := [llvmfunc|
  llvm.func @une_self(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

theorem inst_combine_une_self   : une_self_before  ⊑  une_self_combined := by
  unfold une_self_before une_self_combined
  simp_alive_peephole
  sorry
def ord_zero_combined := [llvmfunc|
  llvm.func @ord_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_ord_zero   : ord_zero_before  ⊑  ord_zero_combined := by
  unfold ord_zero_before ord_zero_combined
  simp_alive_peephole
  sorry
def ord_nonzero_combined := [llvmfunc|
  llvm.func @ord_nonzero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ord" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

theorem inst_combine_ord_nonzero   : ord_nonzero_before  ⊑  ord_nonzero_combined := by
  unfold ord_nonzero_before ord_nonzero_combined
  simp_alive_peephole
  sorry
def ord_self_combined := [llvmfunc|
  llvm.func @ord_self(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_ord_self   : ord_self_before  ⊑  ord_self_combined := by
  unfold ord_self_before ord_self_combined
  simp_alive_peephole
  sorry
def uno_zero_combined := [llvmfunc|
  llvm.func @uno_zero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

theorem inst_combine_uno_zero   : uno_zero_before  ⊑  uno_zero_combined := by
  unfold uno_zero_before uno_zero_combined
  simp_alive_peephole
  sorry
def uno_nonzero_combined := [llvmfunc|
  llvm.func @uno_nonzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_uno_nonzero   : uno_nonzero_before  ⊑  uno_nonzero_combined := by
  unfold uno_nonzero_before uno_nonzero_combined
  simp_alive_peephole
  sorry
def uno_self_combined := [llvmfunc|
  llvm.func @uno_self(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 : f64
    llvm.return %1 : i1
  }]

theorem inst_combine_uno_self   : uno_self_before  ⊑  uno_self_combined := by
  unfold uno_self_before uno_self_combined
  simp_alive_peephole
  sorry
def ord_zero_vec_combined := [llvmfunc|
  llvm.func @ord_zero_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ord_zero_vec   : ord_zero_vec_before  ⊑  ord_zero_vec_combined := by
  unfold ord_zero_vec_before ord_zero_vec_combined
  simp_alive_peephole
  sorry
def ord_nonzero_vec_combined := [llvmfunc|
  llvm.func @ord_nonzero_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ord_nonzero_vec   : ord_nonzero_vec_before  ⊑  ord_nonzero_vec_combined := by
  unfold ord_nonzero_vec_before ord_nonzero_vec_combined
  simp_alive_peephole
  sorry
def ord_self_vec_combined := [llvmfunc|
  llvm.func @ord_self_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ord_self_vec   : ord_self_vec_before  ⊑  ord_self_vec_combined := by
  unfold ord_self_vec_before ord_self_vec_combined
  simp_alive_peephole
  sorry
def uno_zero_vec_combined := [llvmfunc|
  llvm.func @uno_zero_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_uno_zero_vec   : uno_zero_vec_before  ⊑  uno_zero_vec_combined := by
  unfold uno_zero_vec_before uno_zero_vec_combined
  simp_alive_peephole
  sorry
def uno_nonzero_vec_combined := [llvmfunc|
  llvm.func @uno_nonzero_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_uno_nonzero_vec   : uno_nonzero_vec_before  ⊑  uno_nonzero_vec_combined := by
  unfold uno_nonzero_vec_before uno_nonzero_vec_combined
  simp_alive_peephole
  sorry
def uno_self_vec_combined := [llvmfunc|
  llvm.func @uno_self_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_uno_self_vec   : uno_self_vec_before  ⊑  uno_self_vec_combined := by
  unfold uno_self_vec_before uno_self_vec_combined
  simp_alive_peephole
  sorry
def uno_vec_with_nan_combined := [llvmfunc|
  llvm.func @uno_vec_with_nan(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 0x7FF00000FFFFFFFF]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "uno" %arg0, %0 : vector<2xf64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_uno_vec_with_nan   : uno_vec_with_nan_before  ⊑  uno_vec_with_nan_combined := by
  unfold uno_vec_with_nan_before uno_vec_with_nan_combined
  simp_alive_peephole
  sorry
def uno_vec_with_poison_combined := [llvmfunc|
  llvm.func @uno_vec_with_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_uno_vec_with_poison   : uno_vec_with_poison_before  ⊑  uno_vec_with_poison_combined := by
  unfold uno_vec_with_poison_before uno_vec_with_poison_combined
  simp_alive_peephole
  sorry
def ord_vec_with_poison_combined := [llvmfunc|
  llvm.func @ord_vec_with_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "ord" %arg0, %6 : vector<2xf64>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_ord_vec_with_poison   : ord_vec_with_poison_before  ⊑  ord_vec_with_poison_combined := by
  unfold ord_vec_with_poison_before ord_vec_with_poison_combined
  simp_alive_peephole
  sorry
def nnan_ops_to_fcmp_ord_combined := [llvmfunc|
  llvm.func @nnan_ops_to_fcmp_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nnan_ops_to_fcmp_ord   : nnan_ops_to_fcmp_ord_before  ⊑  nnan_ops_to_fcmp_ord_combined := by
  unfold nnan_ops_to_fcmp_ord_before nnan_ops_to_fcmp_ord_combined
  simp_alive_peephole
  sorry
def nnan_ops_to_fcmp_uno_combined := [llvmfunc|
  llvm.func @nnan_ops_to_fcmp_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nnan_ops_to_fcmp_uno   : nnan_ops_to_fcmp_uno_before  ⊑  nnan_ops_to_fcmp_uno_combined := by
  unfold nnan_ops_to_fcmp_uno_before nnan_ops_to_fcmp_uno_combined
  simp_alive_peephole
  sorry
def negative_zero_oeq_combined := [llvmfunc|
  llvm.func @negative_zero_oeq(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_zero_oeq   : negative_zero_oeq_before  ⊑  negative_zero_oeq_combined := by
  unfold negative_zero_oeq_before negative_zero_oeq_combined
  simp_alive_peephole
  sorry
def negative_zero_oge_combined := [llvmfunc|
  llvm.func @negative_zero_oge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_negative_zero_oge   : negative_zero_oge_before  ⊑  negative_zero_oge_combined := by
  unfold negative_zero_oge_before negative_zero_oge_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_zero_oge   : negative_zero_oge_before  ⊑  negative_zero_oge_combined := by
  unfold negative_zero_oge_before negative_zero_oge_combined
  simp_alive_peephole
  sorry
def negative_zero_uge_combined := [llvmfunc|
  llvm.func @negative_zero_uge(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_negative_zero_uge   : negative_zero_uge_before  ⊑  negative_zero_uge_combined := by
  unfold negative_zero_uge_before negative_zero_uge_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_zero_uge   : negative_zero_uge_before  ⊑  negative_zero_uge_combined := by
  unfold negative_zero_uge_before negative_zero_uge_combined
  simp_alive_peephole
  sorry
def negative_zero_olt_vec_combined := [llvmfunc|
  llvm.func @negative_zero_olt_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "olt" %arg0, %1 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<2xf32>]

theorem inst_combine_negative_zero_olt_vec   : negative_zero_olt_vec_before  ⊑  negative_zero_olt_vec_combined := by
  unfold negative_zero_olt_vec_before negative_zero_olt_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_negative_zero_olt_vec   : negative_zero_olt_vec_before  ⊑  negative_zero_olt_vec_combined := by
  unfold negative_zero_olt_vec_before negative_zero_olt_vec_combined
  simp_alive_peephole
  sorry
def negative_zero_une_vec_poison_combined := [llvmfunc|
  llvm.func @negative_zero_une_vec_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "une" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>]

theorem inst_combine_negative_zero_une_vec_poison   : negative_zero_une_vec_poison_before  ⊑  negative_zero_une_vec_poison_combined := by
  unfold negative_zero_une_vec_poison_before negative_zero_une_vec_poison_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_negative_zero_une_vec_poison   : negative_zero_une_vec_poison_before  ⊑  negative_zero_une_vec_poison_combined := by
  unfold negative_zero_une_vec_poison_before negative_zero_une_vec_poison_combined
  simp_alive_peephole
  sorry
def negative_zero_ule_vec_mixed_combined := [llvmfunc|
  llvm.func @negative_zero_ule_vec_mixed(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ule" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_negative_zero_ule_vec_mixed   : negative_zero_ule_vec_mixed_before  ⊑  negative_zero_ule_vec_mixed_combined := by
  unfold negative_zero_ule_vec_mixed_before negative_zero_ule_vec_mixed_combined
  simp_alive_peephole
  sorry

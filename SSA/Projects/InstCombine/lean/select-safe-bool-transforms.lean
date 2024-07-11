import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-safe-bool-transforms
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def land_land_left1_before := [llvmfunc|
  llvm.func @land_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def land_land_left2_before := [llvmfunc|
  llvm.func @land_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def land_band_left1_before := [llvmfunc|
  llvm.func @land_band_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def land_band_left2_before := [llvmfunc|
  llvm.func @land_band_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def land_lor_left1_before := [llvmfunc|
  llvm.func @land_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %2, %1, %arg0 : i1, i1
    llvm.return %3 : i1
  }]

def land_lor_left2_before := [llvmfunc|
  llvm.func @land_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %2, %1, %arg0 : i1, i1
    llvm.return %3 : i1
  }]

def land_bor_left1_before := [llvmfunc|
  llvm.func @land_bor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def land_bor_left2_before := [llvmfunc|
  llvm.func @land_bor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def band_land_left1_before := [llvmfunc|
  llvm.func @band_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def band_land_left2_before := [llvmfunc|
  llvm.func @band_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def band_lor_left1_before := [llvmfunc|
  llvm.func @band_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def band_lor_left2_before := [llvmfunc|
  llvm.func @band_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def lor_land_left1_before := [llvmfunc|
  llvm.func @lor_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    llvm.return %3 : i1
  }]

def lor_land_left2_before := [llvmfunc|
  llvm.func @lor_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    llvm.return %3 : i1
  }]

def lor_band_left1_before := [llvmfunc|
  llvm.func @lor_band_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def lor_band_left2_before := [llvmfunc|
  llvm.func @lor_band_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def lor_lor_left1_before := [llvmfunc|
  llvm.func @lor_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def lor_lor_left2_before := [llvmfunc|
  llvm.func @lor_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def lor_bor_left1_before := [llvmfunc|
  llvm.func @lor_bor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def lor_bor_left2_before := [llvmfunc|
  llvm.func @lor_bor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

def bor_land_left1_before := [llvmfunc|
  llvm.func @bor_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def bor_land_left2_before := [llvmfunc|
  llvm.func @bor_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }]

def bor_lor_left1_before := [llvmfunc|
  llvm.func @bor_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def bor_lor_left2_before := [llvmfunc|
  llvm.func @bor_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    llvm.return %2 : i1
  }]

def land_land_right1_before := [llvmfunc|
  llvm.func @land_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

def land_land_right2_before := [llvmfunc|
  llvm.func @land_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

def land_band_right1_before := [llvmfunc|
  llvm.func @land_band_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def land_band_right2_before := [llvmfunc|
  llvm.func @land_band_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def land_lor_right1_before := [llvmfunc|
  llvm.func @land_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

def land_lor_right2_before := [llvmfunc|
  llvm.func @land_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

def land_lor_right1_vec_before := [llvmfunc|
  llvm.func @land_lor_right1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def land_lor_right2_vec_before := [llvmfunc|
  llvm.func @land_lor_right2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.select %arg1, %arg0, %1 : vector<2xi1>, vector<2xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def land_bor_right1_before := [llvmfunc|
  llvm.func @land_bor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def land_bor_right2_before := [llvmfunc|
  llvm.func @land_bor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def band_land_right1_before := [llvmfunc|
  llvm.func @band_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

def band_land_right2_before := [llvmfunc|
  llvm.func @band_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

def band_lor_right1_before := [llvmfunc|
  llvm.func @band_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def band_lor_right2_before := [llvmfunc|
  llvm.func @band_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def lor_land_right1_before := [llvmfunc|
  llvm.func @lor_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

def lor_land_right2_before := [llvmfunc|
  llvm.func @lor_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

def lor_band_right1_before := [llvmfunc|
  llvm.func @lor_band_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def lor_band_right2_before := [llvmfunc|
  llvm.func @lor_band_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.and %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def lor_lor_right1_before := [llvmfunc|
  llvm.func @lor_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def lor_lor_right2_before := [llvmfunc|
  llvm.func @lor_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def lor_bor_right1_before := [llvmfunc|
  llvm.func @lor_bor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def lor_bor_right2_before := [llvmfunc|
  llvm.func @lor_bor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.or %arg0, %1  : i1
    llvm.return %2 : i1
  }]

def bor_land_right1_before := [llvmfunc|
  llvm.func @bor_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

def bor_land_right2_before := [llvmfunc|
  llvm.func @bor_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

def bor_lor_right1_before := [llvmfunc|
  llvm.func @bor_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def bor_lor_right2_before := [llvmfunc|
  llvm.func @bor_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

def PR50500_trueval_before := [llvmfunc|
  llvm.func @PR50500_trueval(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi1> 
    %2 = llvm.select %arg0, %1, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def PR50500_falseval_before := [llvmfunc|
  llvm.func @PR50500_falseval(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi1> 
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

def land_land_left1_combined := [llvmfunc|
  llvm.func @land_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_land_left1   : land_land_left1_before  ⊑  land_land_left1_combined := by
  unfold land_land_left1_before land_land_left1_combined
  simp_alive_peephole
  sorry
def land_land_left2_combined := [llvmfunc|
  llvm.func @land_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_land_left2   : land_land_left2_before  ⊑  land_land_left2_combined := by
  unfold land_land_left2_before land_land_left2_combined
  simp_alive_peephole
  sorry
def land_band_left1_combined := [llvmfunc|
  llvm.func @land_band_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_band_left1   : land_band_left1_before  ⊑  land_band_left1_combined := by
  unfold land_band_left1_before land_band_left1_combined
  simp_alive_peephole
  sorry
def land_band_left2_combined := [llvmfunc|
  llvm.func @land_band_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_band_left2   : land_band_left2_before  ⊑  land_band_left2_combined := by
  unfold land_band_left2_before land_band_left2_combined
  simp_alive_peephole
  sorry
def land_lor_left1_combined := [llvmfunc|
  llvm.func @land_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_lor_left1   : land_lor_left1_before  ⊑  land_lor_left1_combined := by
  unfold land_lor_left1_before land_lor_left1_combined
  simp_alive_peephole
  sorry
def land_lor_left2_combined := [llvmfunc|
  llvm.func @land_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_lor_left2   : land_lor_left2_before  ⊑  land_lor_left2_combined := by
  unfold land_lor_left2_before land_lor_left2_combined
  simp_alive_peephole
  sorry
def land_bor_left1_combined := [llvmfunc|
  llvm.func @land_bor_left1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_bor_left1   : land_bor_left1_before  ⊑  land_bor_left1_combined := by
  unfold land_bor_left1_before land_bor_left1_combined
  simp_alive_peephole
  sorry
def land_bor_left2_combined := [llvmfunc|
  llvm.func @land_bor_left2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_bor_left2   : land_bor_left2_before  ⊑  land_bor_left2_combined := by
  unfold land_bor_left2_before land_bor_left2_combined
  simp_alive_peephole
  sorry
def band_land_left1_combined := [llvmfunc|
  llvm.func @band_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_band_land_left1   : band_land_left1_before  ⊑  band_land_left1_combined := by
  unfold band_land_left1_before band_land_left1_combined
  simp_alive_peephole
  sorry
def band_land_left2_combined := [llvmfunc|
  llvm.func @band_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_band_land_left2   : band_land_left2_before  ⊑  band_land_left2_combined := by
  unfold band_land_left2_before band_land_left2_combined
  simp_alive_peephole
  sorry
def band_lor_left1_combined := [llvmfunc|
  llvm.func @band_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_band_lor_left1   : band_lor_left1_before  ⊑  band_lor_left1_combined := by
  unfold band_lor_left1_before band_lor_left1_combined
  simp_alive_peephole
  sorry
def band_lor_left2_combined := [llvmfunc|
  llvm.func @band_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_band_lor_left2   : band_lor_left2_before  ⊑  band_lor_left2_combined := by
  unfold band_lor_left2_before band_lor_left2_combined
  simp_alive_peephole
  sorry
def lor_land_left1_combined := [llvmfunc|
  llvm.func @lor_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_land_left1   : lor_land_left1_before  ⊑  lor_land_left1_combined := by
  unfold lor_land_left1_before lor_land_left1_combined
  simp_alive_peephole
  sorry
def lor_land_left2_combined := [llvmfunc|
  llvm.func @lor_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_land_left2   : lor_land_left2_before  ⊑  lor_land_left2_combined := by
  unfold lor_land_left2_before lor_land_left2_combined
  simp_alive_peephole
  sorry
def lor_band_left1_combined := [llvmfunc|
  llvm.func @lor_band_left1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_band_left1   : lor_band_left1_before  ⊑  lor_band_left1_combined := by
  unfold lor_band_left1_before lor_band_left1_combined
  simp_alive_peephole
  sorry
def lor_band_left2_combined := [llvmfunc|
  llvm.func @lor_band_left2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_band_left2   : lor_band_left2_before  ⊑  lor_band_left2_combined := by
  unfold lor_band_left2_before lor_band_left2_combined
  simp_alive_peephole
  sorry
def lor_lor_left1_combined := [llvmfunc|
  llvm.func @lor_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_lor_left1   : lor_lor_left1_before  ⊑  lor_lor_left1_combined := by
  unfold lor_lor_left1_before lor_lor_left1_combined
  simp_alive_peephole
  sorry
def lor_lor_left2_combined := [llvmfunc|
  llvm.func @lor_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_lor_left2   : lor_lor_left2_before  ⊑  lor_lor_left2_combined := by
  unfold lor_lor_left2_before lor_lor_left2_combined
  simp_alive_peephole
  sorry
def lor_bor_left1_combined := [llvmfunc|
  llvm.func @lor_bor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_bor_left1   : lor_bor_left1_before  ⊑  lor_bor_left1_combined := by
  unfold lor_bor_left1_before lor_bor_left1_combined
  simp_alive_peephole
  sorry
def lor_bor_left2_combined := [llvmfunc|
  llvm.func @lor_bor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_bor_left2   : lor_bor_left2_before  ⊑  lor_bor_left2_combined := by
  unfold lor_bor_left2_before lor_bor_left2_combined
  simp_alive_peephole
  sorry
def bor_land_left1_combined := [llvmfunc|
  llvm.func @bor_land_left1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_bor_land_left1   : bor_land_left1_before  ⊑  bor_land_left1_combined := by
  unfold bor_land_left1_before bor_land_left1_combined
  simp_alive_peephole
  sorry
def bor_land_left2_combined := [llvmfunc|
  llvm.func @bor_land_left2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_bor_land_left2   : bor_land_left2_before  ⊑  bor_land_left2_combined := by
  unfold bor_land_left2_before bor_land_left2_combined
  simp_alive_peephole
  sorry
def bor_lor_left1_combined := [llvmfunc|
  llvm.func @bor_lor_left1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_bor_lor_left1   : bor_lor_left1_before  ⊑  bor_lor_left1_combined := by
  unfold bor_lor_left1_before bor_lor_left1_combined
  simp_alive_peephole
  sorry
def bor_lor_left2_combined := [llvmfunc|
  llvm.func @bor_lor_left2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_bor_lor_left2   : bor_lor_left2_before  ⊑  bor_lor_left2_combined := by
  unfold bor_lor_left2_before bor_lor_left2_combined
  simp_alive_peephole
  sorry
def land_land_right1_combined := [llvmfunc|
  llvm.func @land_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_land_right1   : land_land_right1_before  ⊑  land_land_right1_combined := by
  unfold land_land_right1_before land_land_right1_combined
  simp_alive_peephole
  sorry
def land_land_right2_combined := [llvmfunc|
  llvm.func @land_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_land_right2   : land_land_right2_before  ⊑  land_land_right2_combined := by
  unfold land_land_right2_before land_land_right2_combined
  simp_alive_peephole
  sorry
def land_band_right1_combined := [llvmfunc|
  llvm.func @land_band_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_band_right1   : land_band_right1_before  ⊑  land_band_right1_combined := by
  unfold land_band_right1_before land_band_right1_combined
  simp_alive_peephole
  sorry
def land_band_right2_combined := [llvmfunc|
  llvm.func @land_band_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_land_band_right2   : land_band_right2_before  ⊑  land_band_right2_combined := by
  unfold land_band_right2_before land_band_right2_combined
  simp_alive_peephole
  sorry
def land_lor_right1_combined := [llvmfunc|
  llvm.func @land_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_lor_right1   : land_lor_right1_before  ⊑  land_lor_right1_combined := by
  unfold land_lor_right1_before land_lor_right1_combined
  simp_alive_peephole
  sorry
def land_lor_right2_combined := [llvmfunc|
  llvm.func @land_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_lor_right2   : land_lor_right2_before  ⊑  land_lor_right2_combined := by
  unfold land_lor_right2_before land_lor_right2_combined
  simp_alive_peephole
  sorry
def land_lor_right1_vec_combined := [llvmfunc|
  llvm.func @land_lor_right1_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_land_lor_right1_vec   : land_lor_right1_vec_before  ⊑  land_lor_right1_vec_combined := by
  unfold land_lor_right1_vec_before land_lor_right1_vec_combined
  simp_alive_peephole
  sorry
def land_lor_right2_vec_combined := [llvmfunc|
  llvm.func @land_lor_right2_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_land_lor_right2_vec   : land_lor_right2_vec_before  ⊑  land_lor_right2_vec_combined := by
  unfold land_lor_right2_vec_before land_lor_right2_vec_combined
  simp_alive_peephole
  sorry
def land_bor_right1_combined := [llvmfunc|
  llvm.func @land_bor_right1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_bor_right1   : land_bor_right1_before  ⊑  land_bor_right1_combined := by
  unfold land_bor_right1_before land_bor_right1_combined
  simp_alive_peephole
  sorry
def land_bor_right2_combined := [llvmfunc|
  llvm.func @land_bor_right2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_land_bor_right2   : land_bor_right2_before  ⊑  land_bor_right2_combined := by
  unfold land_bor_right2_before land_bor_right2_combined
  simp_alive_peephole
  sorry
def band_land_right1_combined := [llvmfunc|
  llvm.func @band_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_band_land_right1   : band_land_right1_before  ⊑  band_land_right1_combined := by
  unfold band_land_right1_before band_land_right1_combined
  simp_alive_peephole
  sorry
def band_land_right2_combined := [llvmfunc|
  llvm.func @band_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_band_land_right2   : band_land_right2_before  ⊑  band_land_right2_combined := by
  unfold band_land_right2_before band_land_right2_combined
  simp_alive_peephole
  sorry
def band_lor_right1_combined := [llvmfunc|
  llvm.func @band_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_band_lor_right1   : band_lor_right1_before  ⊑  band_lor_right1_combined := by
  unfold band_lor_right1_before band_lor_right1_combined
  simp_alive_peephole
  sorry
def band_lor_right2_combined := [llvmfunc|
  llvm.func @band_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_band_lor_right2   : band_lor_right2_before  ⊑  band_lor_right2_combined := by
  unfold band_lor_right2_before band_lor_right2_combined
  simp_alive_peephole
  sorry
def lor_land_right1_combined := [llvmfunc|
  llvm.func @lor_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_land_right1   : lor_land_right1_before  ⊑  lor_land_right1_combined := by
  unfold lor_land_right1_before lor_land_right1_combined
  simp_alive_peephole
  sorry
def lor_land_right2_combined := [llvmfunc|
  llvm.func @lor_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_land_right2   : lor_land_right2_before  ⊑  lor_land_right2_combined := by
  unfold lor_land_right2_before lor_land_right2_combined
  simp_alive_peephole
  sorry
def lor_band_right1_combined := [llvmfunc|
  llvm.func @lor_band_right1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_band_right1   : lor_band_right1_before  ⊑  lor_band_right1_combined := by
  unfold lor_band_right1_before lor_band_right1_combined
  simp_alive_peephole
  sorry
def lor_band_right2_combined := [llvmfunc|
  llvm.func @lor_band_right2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_lor_band_right2   : lor_band_right2_before  ⊑  lor_band_right2_combined := by
  unfold lor_band_right2_before lor_band_right2_combined
  simp_alive_peephole
  sorry
def lor_lor_right1_combined := [llvmfunc|
  llvm.func @lor_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_lor_right1   : lor_lor_right1_before  ⊑  lor_lor_right1_combined := by
  unfold lor_lor_right1_before lor_lor_right1_combined
  simp_alive_peephole
  sorry
def lor_lor_right2_combined := [llvmfunc|
  llvm.func @lor_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_lor_right2   : lor_lor_right2_before  ⊑  lor_lor_right2_combined := by
  unfold lor_lor_right2_before lor_lor_right2_combined
  simp_alive_peephole
  sorry
def lor_bor_right1_combined := [llvmfunc|
  llvm.func @lor_bor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_bor_right1   : lor_bor_right1_before  ⊑  lor_bor_right1_combined := by
  unfold lor_bor_right1_before lor_bor_right1_combined
  simp_alive_peephole
  sorry
def lor_bor_right2_combined := [llvmfunc|
  llvm.func @lor_bor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_lor_bor_right2   : lor_bor_right2_before  ⊑  lor_bor_right2_combined := by
  unfold lor_bor_right2_before lor_bor_right2_combined
  simp_alive_peephole
  sorry
def bor_land_right1_combined := [llvmfunc|
  llvm.func @bor_land_right1(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_bor_land_right1   : bor_land_right1_before  ⊑  bor_land_right1_combined := by
  unfold bor_land_right1_before bor_land_right1_combined
  simp_alive_peephole
  sorry
def bor_land_right2_combined := [llvmfunc|
  llvm.func @bor_land_right2(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_bor_land_right2   : bor_land_right2_before  ⊑  bor_land_right2_combined := by
  unfold bor_land_right2_before bor_land_right2_combined
  simp_alive_peephole
  sorry
def bor_lor_right1_combined := [llvmfunc|
  llvm.func @bor_lor_right1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_bor_lor_right1   : bor_lor_right1_before  ⊑  bor_lor_right1_combined := by
  unfold bor_lor_right1_before bor_lor_right1_combined
  simp_alive_peephole
  sorry
def bor_lor_right2_combined := [llvmfunc|
  llvm.func @bor_lor_right2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.return %1 : i1
  }]

theorem inst_combine_bor_lor_right2   : bor_lor_right2_before  ⊑  bor_lor_right2_combined := by
  unfold bor_lor_right2_before bor_lor_right2_combined
  simp_alive_peephole
  sorry
def PR50500_trueval_combined := [llvmfunc|
  llvm.func @PR50500_trueval(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi1> 
    %2 = llvm.select %arg0, %1, %arg1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_PR50500_trueval   : PR50500_trueval_before  ⊑  PR50500_trueval_combined := by
  unfold PR50500_trueval_before PR50500_trueval_combined
  simp_alive_peephole
  sorry
def PR50500_falseval_combined := [llvmfunc|
  llvm.func @PR50500_falseval(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi1> 
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_PR50500_falseval   : PR50500_falseval_before  ⊑  PR50500_falseval_combined := by
  unfold PR50500_falseval_before PR50500_falseval_combined
  simp_alive_peephole
  sorry

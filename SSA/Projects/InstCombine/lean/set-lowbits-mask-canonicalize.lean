import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  set-lowbits-mask-canonicalize
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_add_before := [llvmfunc|
  llvm.func @shl_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def shl_add_nsw_before := [llvmfunc|
  llvm.func @shl_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_add_nuw_before := [llvmfunc|
  llvm.func @shl_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_add_nsw_nuw_before := [llvmfunc|
  llvm.func @shl_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_before := [llvmfunc|
  llvm.func @shl_nsw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_nsw_before := [llvmfunc|
  llvm.func @shl_nsw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_nuw_before := [llvmfunc|
  llvm.func @shl_nsw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_nsw_nuw_before := [llvmfunc|
  llvm.func @shl_nsw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_nuw_add_before := [llvmfunc|
  llvm.func @shl_nuw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def shl_nuw_add_nsw_before := [llvmfunc|
  llvm.func @shl_nuw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nuw_add_nuw_before := [llvmfunc|
  llvm.func @shl_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_nuw_add_nsw_nuw_before := [llvmfunc|
  llvm.func @shl_nuw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_nuw_add_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_nuw_add_nsw_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_nuw_add_nuw_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_nuw_add_nsw_nuw_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

def shl_add_vec_before := [llvmfunc|
  llvm.func @shl_add_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg0  : vector<2xi32>
    %3 = llvm.add %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def shl_add_vec_poison0_before := [llvmfunc|
  llvm.func @shl_add_vec_poison0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %8, %arg0  : vector<3xi32>
    %11 = llvm.add %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def shl_add_vec_poison1_before := [llvmfunc|
  llvm.func @shl_add_vec_poison1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %0, %arg0  : vector<3xi32>
    %11 = llvm.add %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }]

def shl_add_vec_poison2_before := [llvmfunc|
  llvm.func @shl_add_vec_poison2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %8, %arg0  : vector<3xi32>
    %18 = llvm.add %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }]

def bad_oneuse0_before := [llvmfunc|
  llvm.func @bad_oneuse0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def bad_shl_before := [llvmfunc|
  llvm.func @bad_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def bad_add0_before := [llvmfunc|
  llvm.func @bad_add0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def bad_add1_before := [llvmfunc|
  llvm.func @bad_add1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def bad_add2_before := [llvmfunc|
  llvm.func @bad_add2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

def shl_add_combined := [llvmfunc|
  llvm.func @shl_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add   : shl_add_before  ⊑  shl_add_combined := by
  unfold shl_add_before shl_add_combined
  simp_alive_peephole
  sorry
def shl_add_nsw_combined := [llvmfunc|
  llvm.func @shl_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add_nsw   : shl_add_nsw_before  ⊑  shl_add_nsw_combined := by
  unfold shl_add_nsw_before shl_add_nsw_combined
  simp_alive_peephole
  sorry
def shl_add_nuw_combined := [llvmfunc|
  llvm.func @shl_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_add_nuw   : shl_add_nuw_before  ⊑  shl_add_nuw_combined := by
  unfold shl_add_nuw_before shl_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_add_nsw_nuw_combined := [llvmfunc|
  llvm.func @shl_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_add_nsw_nuw   : shl_add_nsw_nuw_before  ⊑  shl_add_nsw_nuw_combined := by
  unfold shl_add_nsw_nuw_before shl_add_nsw_nuw_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_combined := [llvmfunc|
  llvm.func @shl_nsw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_nsw_add   : shl_nsw_add_before  ⊑  shl_nsw_add_combined := by
  unfold shl_nsw_add_before shl_nsw_add_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_nsw_combined := [llvmfunc|
  llvm.func @shl_nsw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_nsw_add_nsw   : shl_nsw_add_nsw_before  ⊑  shl_nsw_add_nsw_combined := by
  unfold shl_nsw_add_nsw_before shl_nsw_add_nsw_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_nuw_combined := [llvmfunc|
  llvm.func @shl_nsw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_nsw_add_nuw   : shl_nsw_add_nuw_before  ⊑  shl_nsw_add_nuw_combined := by
  unfold shl_nsw_add_nuw_before shl_nsw_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_nsw_nuw_combined := [llvmfunc|
  llvm.func @shl_nsw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_nsw_add_nsw_nuw   : shl_nsw_add_nsw_nuw_before  ⊑  shl_nsw_add_nsw_nuw_combined := by
  unfold shl_nsw_add_nsw_nuw_before shl_nsw_add_nsw_nuw_combined
  simp_alive_peephole
  sorry
def shl_nuw_add_combined := [llvmfunc|
  llvm.func @shl_nuw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_nuw_add   : shl_nuw_add_before  ⊑  shl_nuw_add_combined := by
  unfold shl_nuw_add_before shl_nuw_add_combined
  simp_alive_peephole
  sorry
def shl_nuw_add_nsw_combined := [llvmfunc|
  llvm.func @shl_nuw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_nuw_add_nsw   : shl_nuw_add_nsw_before  ⊑  shl_nuw_add_nsw_combined := by
  unfold shl_nuw_add_nsw_before shl_nuw_add_nsw_combined
  simp_alive_peephole
  sorry
def shl_nuw_add_nuw_combined := [llvmfunc|
  llvm.func @shl_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_nuw_add_nuw   : shl_nuw_add_nuw_before  ⊑  shl_nuw_add_nuw_combined := by
  unfold shl_nuw_add_nuw_before shl_nuw_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_nuw_add_nsw_nuw_combined := [llvmfunc|
  llvm.func @shl_nuw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_nuw_add_nsw_nuw   : shl_nuw_add_nsw_nuw_before  ⊑  shl_nuw_add_nsw_nuw_combined := by
  unfold shl_nuw_add_nsw_nuw_before shl_nuw_add_nsw_nuw_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_add_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_nsw_nuw_add   : shl_nsw_nuw_add_before  ⊑  shl_nsw_nuw_add_combined := by
  unfold shl_nsw_nuw_add_before shl_nsw_nuw_add_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_add_nsw_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_nsw_nuw_add_nsw   : shl_nsw_nuw_add_nsw_before  ⊑  shl_nsw_nuw_add_nsw_combined := by
  unfold shl_nsw_nuw_add_nsw_before shl_nsw_nuw_add_nsw_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_add_nuw_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_nsw_nuw_add_nuw   : shl_nsw_nuw_add_nuw_before  ⊑  shl_nsw_nuw_add_nuw_combined := by
  unfold shl_nsw_nuw_add_nuw_before shl_nsw_nuw_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_add_nsw_nuw_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_shl_nsw_nuw_add_nsw_nuw   : shl_nsw_nuw_add_nsw_nuw_before  ⊑  shl_nsw_nuw_add_nsw_nuw_combined := by
  unfold shl_nsw_nuw_add_nsw_nuw_before shl_nsw_nuw_add_nsw_nuw_combined
  simp_alive_peephole
  sorry
def shl_add_vec_combined := [llvmfunc|
  llvm.func @shl_add_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_shl_add_vec   : shl_add_vec_before  ⊑  shl_add_vec_combined := by
  unfold shl_add_vec_before shl_add_vec_combined
  simp_alive_peephole
  sorry
def shl_add_vec_poison0_combined := [llvmfunc|
  llvm.func @shl_add_vec_poison0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<3xi32>
    %2 = llvm.xor %1, %0  : vector<3xi32>
    llvm.return %2 : vector<3xi32>
  }]

theorem inst_combine_shl_add_vec_poison0   : shl_add_vec_poison0_before  ⊑  shl_add_vec_poison0_combined := by
  unfold shl_add_vec_poison0_before shl_add_vec_poison0_combined
  simp_alive_peephole
  sorry
def shl_add_vec_poison1_combined := [llvmfunc|
  llvm.func @shl_add_vec_poison1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<3xi32>
    %2 = llvm.xor %1, %0  : vector<3xi32>
    llvm.return %2 : vector<3xi32>
  }]

theorem inst_combine_shl_add_vec_poison1   : shl_add_vec_poison1_before  ⊑  shl_add_vec_poison1_combined := by
  unfold shl_add_vec_poison1_before shl_add_vec_poison1_combined
  simp_alive_peephole
  sorry
def shl_add_vec_poison2_combined := [llvmfunc|
  llvm.func @shl_add_vec_poison2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<3xi32>
    %2 = llvm.xor %1, %0  : vector<3xi32>
    llvm.return %2 : vector<3xi32>
  }]

theorem inst_combine_shl_add_vec_poison2   : shl_add_vec_poison2_before  ⊑  shl_add_vec_poison2_combined := by
  unfold shl_add_vec_poison2_before shl_add_vec_poison2_combined
  simp_alive_peephole
  sorry
def bad_oneuse0_combined := [llvmfunc|
  llvm.func @bad_oneuse0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bad_oneuse0   : bad_oneuse0_before  ⊑  bad_oneuse0_combined := by
  unfold bad_oneuse0_before bad_oneuse0_combined
  simp_alive_peephole
  sorry
def bad_shl_combined := [llvmfunc|
  llvm.func @bad_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_bad_shl   : bad_shl_before  ⊑  bad_shl_combined := by
  unfold bad_shl_before bad_shl_combined
  simp_alive_peephole
  sorry
def bad_add0_combined := [llvmfunc|
  llvm.func @bad_add0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_bad_add0   : bad_add0_before  ⊑  bad_add0_combined := by
  unfold bad_add0_before bad_add0_combined
  simp_alive_peephole
  sorry
def bad_add1_combined := [llvmfunc|
  llvm.func @bad_add1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %2 = llvm.add %1, %0 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_bad_add1   : bad_add1_before  ⊑  bad_add1_combined := by
  unfold bad_add1_before bad_add1_combined
  simp_alive_peephole
  sorry
def bad_add2_combined := [llvmfunc|
  llvm.func @bad_add2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bad_add2   : bad_add2_before  ⊑  bad_add2_combined := by
  unfold bad_add2_before bad_add2_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-of-displaced-shifts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_or_before := [llvmfunc|
  llvm.func @shl_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def lshr_or_before := [llvmfunc|
  llvm.func @lshr_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def ashr_or_before := [llvmfunc|
  llvm.func @ashr_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.ashr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.ashr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_xor_before := [llvmfunc|
  llvm.func @shl_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.xor %3, %5  : i8
    llvm.return %6 : i8
  }]

def lshr_xor_before := [llvmfunc|
  llvm.func @lshr_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.xor %3, %5  : i8
    llvm.return %6 : i8
  }]

def ashr_xor_before := [llvmfunc|
  llvm.func @ashr_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-64 : i8) : i8
    %3 = llvm.ashr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.ashr %2, %4  : i8
    %6 = llvm.xor %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_and_before := [llvmfunc|
  llvm.func @shl_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }]

def lshr_and_before := [llvmfunc|
  llvm.func @lshr_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(48 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }]

def ashr_and_before := [llvmfunc|
  llvm.func @ashr_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.ashr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.ashr %2, %4  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_add_before := [llvmfunc|
  llvm.func @shl_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.add %3, %5  : i8
    llvm.return %6 : i8
  }]

def lshr_add_fail_before := [llvmfunc|
  llvm.func @lshr_add_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.add %3, %5  : i8
    llvm.return %6 : i8
  }]

def ashr_add_fail_before := [llvmfunc|
  llvm.func @ashr_add_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.ashr %0, %3  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_or_commuted_before := [llvmfunc|
  llvm.func @shl_or_commuted(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %5, %3  : i8
    llvm.return %6 : i8
  }]

def shl_or_splat_before := [llvmfunc|
  llvm.func @shl_or_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def shl_or_non_splat_before := [llvmfunc|
  llvm.func @shl_or_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[3, 7]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def shl_or_poison_in_add_before := [llvmfunc|
  llvm.func @shl_or_poison_in_add(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.shl %0, %arg0  : vector<2xi8>
    %10 = llvm.add %arg0, %7  : vector<2xi8>
    %11 = llvm.shl %8, %10  : vector<2xi8>
    %12 = llvm.or %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }]

def shl_or_poison_in_shift1_before := [llvmfunc|
  llvm.func @shl_or_poison_in_shift1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.shl %6, %arg0  : vector<2xi8>
    %10 = llvm.add %arg0, %7  : vector<2xi8>
    %11 = llvm.shl %8, %10  : vector<2xi8>
    %12 = llvm.or %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }]

def shl_or_poison_in_shift2_before := [llvmfunc|
  llvm.func @shl_or_poison_in_shift2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.constant(3 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.shl %0, %arg0  : vector<2xi8>
    %10 = llvm.add %arg0, %1  : vector<2xi8>
    %11 = llvm.shl %8, %10  : vector<2xi8>
    %12 = llvm.or %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }]

def shl_or_multiuse_before := [llvmfunc|
  llvm.func @shl_or_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    llvm.call @use(%3) : (i8) -> ()
    llvm.call @use(%4) : (i8) -> ()
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def mismatched_shifts_before := [llvmfunc|
  llvm.func @mismatched_shifts(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def mismatched_ops_before := [llvmfunc|
  llvm.func @mismatched_ops(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def add_out_of_range_before := [llvmfunc|
  llvm.func @add_out_of_range(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_or_non_splat_out_of_range_before := [llvmfunc|
  llvm.func @shl_or_non_splat_out_of_range(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 32]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[3, 7]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def shl_or_with_or_disjoint_instead_of_add_before := [llvmfunc|
  llvm.func @shl_or_with_or_disjoint_instead_of_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_or_with_or_instead_of_add_before := [llvmfunc|
  llvm.func @shl_or_with_or_instead_of_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_or_combined := [llvmfunc|
  llvm.func @shl_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shl_or   : shl_or_before  ⊑  shl_or_combined := by
  unfold shl_or_before shl_or_combined
  simp_alive_peephole
  sorry
def lshr_or_combined := [llvmfunc|
  llvm.func @lshr_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_lshr_or   : lshr_or_before  ⊑  lshr_or_combined := by
  unfold lshr_or_before lshr_or_combined
  simp_alive_peephole
  sorry
def ashr_or_combined := [llvmfunc|
  llvm.func @ashr_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_ashr_or   : ashr_or_before  ⊑  ashr_or_combined := by
  unfold ashr_or_before ashr_or_combined
  simp_alive_peephole
  sorry
def shl_xor_combined := [llvmfunc|
  llvm.func @shl_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shl_xor   : shl_xor_before  ⊑  shl_xor_combined := by
  unfold shl_xor_before shl_xor_combined
  simp_alive_peephole
  sorry
def lshr_xor_combined := [llvmfunc|
  llvm.func @lshr_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_lshr_xor   : lshr_xor_before  ⊑  lshr_xor_combined := by
  unfold lshr_xor_before lshr_xor_combined
  simp_alive_peephole
  sorry
def ashr_xor_combined := [llvmfunc|
  llvm.func @ashr_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(96 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_ashr_xor   : ashr_xor_before  ⊑  ashr_xor_combined := by
  unfold ashr_xor_before ashr_xor_combined
  simp_alive_peephole
  sorry
def shl_and_combined := [llvmfunc|
  llvm.func @shl_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shl_and   : shl_and_before  ⊑  shl_and_combined := by
  unfold shl_and_before shl_and_combined
  simp_alive_peephole
  sorry
def lshr_and_combined := [llvmfunc|
  llvm.func @lshr_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_lshr_and   : lshr_and_before  ⊑  lshr_and_combined := by
  unfold lshr_and_before lshr_and_combined
  simp_alive_peephole
  sorry
def ashr_and_combined := [llvmfunc|
  llvm.func @ashr_and(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_ashr_and   : ashr_and_before  ⊑  ashr_and_combined := by
  unfold ashr_and_before ashr_and_combined
  simp_alive_peephole
  sorry
def shl_add_combined := [llvmfunc|
  llvm.func @shl_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shl_add   : shl_add_before  ⊑  shl_add_combined := by
  unfold shl_add_before shl_add_combined
  simp_alive_peephole
  sorry
def lshr_add_fail_combined := [llvmfunc|
  llvm.func @lshr_add_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.lshr %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.add %3, %5 overflow<nsw, nuw>  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_lshr_add_fail   : lshr_add_fail_before  ⊑  lshr_add_fail_combined := by
  unfold lshr_add_fail_before lshr_add_fail_combined
  simp_alive_peephole
  sorry
def ashr_add_fail_combined := [llvmfunc|
  llvm.func @ashr_add_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.ashr %0, %3  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_ashr_add_fail   : ashr_add_fail_before  ⊑  ashr_add_fail_combined := by
  unfold ashr_add_fail_before ashr_add_fail_combined
  simp_alive_peephole
  sorry
def shl_or_commuted_combined := [llvmfunc|
  llvm.func @shl_or_commuted(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shl_or_commuted   : shl_or_commuted_before  ⊑  shl_or_commuted_combined := by
  unfold shl_or_commuted_before shl_or_commuted_combined
  simp_alive_peephole
  sorry
def shl_or_splat_combined := [llvmfunc|
  llvm.func @shl_or_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<22> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_shl_or_splat   : shl_or_splat_before  ⊑  shl_or_splat_combined := by
  unfold shl_or_splat_before shl_or_splat_combined
  simp_alive_peephole
  sorry
def shl_or_non_splat_combined := [llvmfunc|
  llvm.func @shl_or_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[22, 60]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_shl_or_non_splat   : shl_or_non_splat_before  ⊑  shl_or_non_splat_combined := by
  unfold shl_or_non_splat_before shl_or_non_splat_combined
  simp_alive_peephole
  sorry
def shl_or_poison_in_add_combined := [llvmfunc|
  llvm.func @shl_or_poison_in_add(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(22 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg0  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_shl_or_poison_in_add   : shl_or_poison_in_add_before  ⊑  shl_or_poison_in_add_combined := by
  unfold shl_or_poison_in_add_before shl_or_poison_in_add_combined
  simp_alive_peephole
  sorry
def shl_or_poison_in_shift1_combined := [llvmfunc|
  llvm.func @shl_or_poison_in_shift1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(22 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg0  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_shl_or_poison_in_shift1   : shl_or_poison_in_shift1_before  ⊑  shl_or_poison_in_shift1_combined := by
  unfold shl_or_poison_in_shift1_before shl_or_poison_in_shift1_combined
  simp_alive_peephole
  sorry
def shl_or_poison_in_shift2_combined := [llvmfunc|
  llvm.func @shl_or_poison_in_shift2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(22 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg0  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_shl_or_poison_in_shift2   : shl_or_poison_in_shift2_before  ⊑  shl_or_poison_in_shift2_combined := by
  unfold shl_or_poison_in_shift2_before shl_or_poison_in_shift2_combined
  simp_alive_peephole
  sorry
def shl_or_multiuse_combined := [llvmfunc|
  llvm.func @shl_or_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.constant(22 : i8) : i8
    %4 = llvm.shl %0, %arg0  : i8
    %5 = llvm.add %arg0, %1  : i8
    %6 = llvm.shl %2, %5  : i8
    llvm.call @use(%4) : (i8) -> ()
    llvm.call @use(%5) : (i8) -> ()
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.shl %3, %arg0  : i8
    llvm.return %7 : i8
  }]

theorem inst_combine_shl_or_multiuse   : shl_or_multiuse_before  ⊑  shl_or_multiuse_combined := by
  unfold shl_or_multiuse_before shl_or_multiuse_combined
  simp_alive_peephole
  sorry
def mismatched_shifts_combined := [llvmfunc|
  llvm.func @mismatched_shifts(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.lshr %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_mismatched_shifts   : mismatched_shifts_before  ⊑  mismatched_shifts_combined := by
  unfold mismatched_shifts_before mismatched_shifts_combined
  simp_alive_peephole
  sorry
def mismatched_ops_combined := [llvmfunc|
  llvm.func @mismatched_ops(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_mismatched_ops   : mismatched_ops_before  ⊑  mismatched_ops_combined := by
  unfold mismatched_ops_before mismatched_ops_combined
  simp_alive_peephole
  sorry
def add_out_of_range_combined := [llvmfunc|
  llvm.func @add_out_of_range(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_add_out_of_range   : add_out_of_range_before  ⊑  add_out_of_range_combined := by
  unfold add_out_of_range_before add_out_of_range_combined
  simp_alive_peephole
  sorry
def shl_or_non_splat_out_of_range_combined := [llvmfunc|
  llvm.func @shl_or_non_splat_out_of_range(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 32]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[3, 7]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg0  : vector<2xi8>
    %4 = llvm.add %arg0, %1  : vector<2xi8>
    %5 = llvm.shl %2, %4  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_shl_or_non_splat_out_of_range   : shl_or_non_splat_out_of_range_before  ⊑  shl_or_non_splat_out_of_range_combined := by
  unfold shl_or_non_splat_out_of_range_before shl_or_non_splat_out_of_range_combined
  simp_alive_peephole
  sorry
def shl_or_with_or_disjoint_instead_of_add_combined := [llvmfunc|
  llvm.func @shl_or_with_or_disjoint_instead_of_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(22 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shl_or_with_or_disjoint_instead_of_add   : shl_or_with_or_disjoint_instead_of_add_before  ⊑  shl_or_with_or_disjoint_instead_of_add_combined := by
  unfold shl_or_with_or_disjoint_instead_of_add_before shl_or_with_or_disjoint_instead_of_add_combined
  simp_alive_peephole
  sorry
def shl_or_with_or_instead_of_add_combined := [llvmfunc|
  llvm.func @shl_or_with_or_instead_of_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.shl %2, %4  : i8
    %6 = llvm.or %3, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_shl_or_with_or_instead_of_add   : shl_or_with_or_instead_of_add_before  ⊑  shl_or_with_or_instead_of_add_combined := by
  unfold shl_or_with_or_instead_of_add_before shl_or_with_or_instead_of_add_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bit_floor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bit_floor_32_before := [llvmfunc|
  llvm.func @bit_floor_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.shl %1, %6  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.return %8 : i32
  }]

def bit_floor_64_before := [llvmfunc|
  llvm.func @bit_floor_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(64 : i64) : i64
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i64) -> i64]

    %6 = llvm.sub %2, %5  : i64
    %7 = llvm.shl %1, %6  : i64
    %8 = llvm.select %3, %0, %7 : i1, i64
    llvm.return %8 : i64
  }]

def bit_floor_commuted_operands_before := [llvmfunc|
  llvm.func @bit_floor_commuted_operands(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.shl %1, %6  : i32
    %8 = llvm.select %3, %7, %0 : i1, i32
    llvm.return %8 : i32
  }]

def bit_floor_lshr_used_twice_before := [llvmfunc|
  llvm.func @bit_floor_lshr_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.shl %1, %6  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %4, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %8 : i32
  }]

def bit_floor_ctlz_used_twice_before := [llvmfunc|
  llvm.func @bit_floor_ctlz_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.shl %1, %6  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %8 : i32
  }]

def bit_floor_sub_used_twice_before := [llvmfunc|
  llvm.func @bit_floor_sub_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.shl %1, %6  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %8 : i32
  }]

def bit_floor_shl_used_twice_before := [llvmfunc|
  llvm.func @bit_floor_shl_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.shl %1, %6  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %8 : i32
  }]

def bit_floor_v4i32_before := [llvmfunc|
  llvm.func @bit_floor_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<32> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.icmp "eq" %arg0, %1 : vector<4xi32>
    %5 = llvm.lshr %arg0, %2  : vector<4xi32>
    %6 = "llvm.intr.ctlz"(%5) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    %7 = llvm.sub %3, %6  : vector<4xi32>
    %8 = llvm.shl %2, %7  : vector<4xi32>
    %9 = llvm.select %4, %1, %8 : vector<4xi1>, vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }]

def bit_floor_32_combined := [llvmfunc|
  llvm.func @bit_floor_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_floor_32   : bit_floor_32_before  ⊑  bit_floor_32_combined := by
  unfold bit_floor_32_before bit_floor_32_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %1, %6 overflow<nuw>  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_floor_32   : bit_floor_32_before  ⊑  bit_floor_32_combined := by
  unfold bit_floor_32_before bit_floor_32_combined
  simp_alive_peephole
  sorry
def bit_floor_64_combined := [llvmfunc|
  llvm.func @bit_floor_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(64 : i64) : i64
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i64) -> i64]

theorem inst_combine_bit_floor_64   : bit_floor_64_before  ⊑  bit_floor_64_combined := by
  unfold bit_floor_64_before bit_floor_64_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i64
    %7 = llvm.shl %1, %6 overflow<nuw>  : i64
    %8 = llvm.select %3, %0, %7 : i1, i64
    llvm.return %8 : i64
  }]

theorem inst_combine_bit_floor_64   : bit_floor_64_before  ⊑  bit_floor_64_combined := by
  unfold bit_floor_64_before bit_floor_64_combined
  simp_alive_peephole
  sorry
def bit_floor_commuted_operands_combined := [llvmfunc|
  llvm.func @bit_floor_commuted_operands(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_floor_commuted_operands   : bit_floor_commuted_operands_before  ⊑  bit_floor_commuted_operands_combined := by
  unfold bit_floor_commuted_operands_before bit_floor_commuted_operands_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %1, %6 overflow<nuw>  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_floor_commuted_operands   : bit_floor_commuted_operands_before  ⊑  bit_floor_commuted_operands_combined := by
  unfold bit_floor_commuted_operands_before bit_floor_commuted_operands_combined
  simp_alive_peephole
  sorry
def bit_floor_lshr_used_twice_combined := [llvmfunc|
  llvm.func @bit_floor_lshr_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_floor_lshr_used_twice   : bit_floor_lshr_used_twice_before  ⊑  bit_floor_lshr_used_twice_combined := by
  unfold bit_floor_lshr_used_twice_before bit_floor_lshr_used_twice_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %1, %6 overflow<nuw>  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %4, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bit_floor_lshr_used_twice   : bit_floor_lshr_used_twice_before  ⊑  bit_floor_lshr_used_twice_combined := by
  unfold bit_floor_lshr_used_twice_before bit_floor_lshr_used_twice_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_floor_lshr_used_twice   : bit_floor_lshr_used_twice_before  ⊑  bit_floor_lshr_used_twice_combined := by
  unfold bit_floor_lshr_used_twice_before bit_floor_lshr_used_twice_combined
  simp_alive_peephole
  sorry
def bit_floor_ctlz_used_twice_combined := [llvmfunc|
  llvm.func @bit_floor_ctlz_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_floor_ctlz_used_twice   : bit_floor_ctlz_used_twice_before  ⊑  bit_floor_ctlz_used_twice_combined := by
  unfold bit_floor_ctlz_used_twice_before bit_floor_ctlz_used_twice_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %1, %6 overflow<nuw>  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bit_floor_ctlz_used_twice   : bit_floor_ctlz_used_twice_before  ⊑  bit_floor_ctlz_used_twice_combined := by
  unfold bit_floor_ctlz_used_twice_before bit_floor_ctlz_used_twice_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_floor_ctlz_used_twice   : bit_floor_ctlz_used_twice_before  ⊑  bit_floor_ctlz_used_twice_combined := by
  unfold bit_floor_ctlz_used_twice_before bit_floor_ctlz_used_twice_combined
  simp_alive_peephole
  sorry
def bit_floor_sub_used_twice_combined := [llvmfunc|
  llvm.func @bit_floor_sub_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_floor_sub_used_twice   : bit_floor_sub_used_twice_before  ⊑  bit_floor_sub_used_twice_combined := by
  unfold bit_floor_sub_used_twice_before bit_floor_sub_used_twice_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %1, %6 overflow<nuw>  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bit_floor_sub_used_twice   : bit_floor_sub_used_twice_before  ⊑  bit_floor_sub_used_twice_combined := by
  unfold bit_floor_sub_used_twice_before bit_floor_sub_used_twice_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_floor_sub_used_twice   : bit_floor_sub_used_twice_before  ⊑  bit_floor_sub_used_twice_combined := by
  unfold bit_floor_sub_used_twice_before bit_floor_sub_used_twice_combined
  simp_alive_peephole
  sorry
def bit_floor_shl_used_twice_combined := [llvmfunc|
  llvm.func @bit_floor_shl_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_floor_shl_used_twice   : bit_floor_shl_used_twice_before  ⊑  bit_floor_shl_used_twice_combined := by
  unfold bit_floor_shl_used_twice_before bit_floor_shl_used_twice_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %2, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %1, %6 overflow<nuw>  : i32
    %8 = llvm.select %3, %0, %7 : i1, i32
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bit_floor_shl_used_twice   : bit_floor_shl_used_twice_before  ⊑  bit_floor_shl_used_twice_combined := by
  unfold bit_floor_shl_used_twice_before bit_floor_shl_used_twice_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_floor_shl_used_twice   : bit_floor_shl_used_twice_before  ⊑  bit_floor_shl_used_twice_combined := by
  unfold bit_floor_shl_used_twice_before bit_floor_shl_used_twice_combined
  simp_alive_peephole
  sorry
def bit_floor_v4i32_combined := [llvmfunc|
  llvm.func @bit_floor_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<32> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.icmp "eq" %arg0, %1 : vector<4xi32>
    %5 = llvm.lshr %arg0, %2  : vector<4xi32>
    %6 = "llvm.intr.ctlz"(%5) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_bit_floor_v4i32   : bit_floor_v4i32_before  ⊑  bit_floor_v4i32_combined := by
  unfold bit_floor_v4i32_before bit_floor_v4i32_combined
  simp_alive_peephole
  sorry
    %7 = llvm.sub %3, %6 overflow<nsw, nuw>  : vector<4xi32>
    %8 = llvm.shl %2, %7 overflow<nuw>  : vector<4xi32>
    %9 = llvm.select %4, %1, %8 : vector<4xi1>, vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }]

theorem inst_combine_bit_floor_v4i32   : bit_floor_v4i32_before  ⊑  bit_floor_v4i32_combined := by
  unfold bit_floor_v4i32_before bit_floor_v4i32_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strnlen-5
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strnlen_ax_0_eqz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_0_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def fold_strnlen_ax_0_gtz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_0_gtz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def fold_strnlen_ax_1_eqz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    llvm.return %4 : i1
  }]

def fold_strnlen_ax_1_lt1_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_lt1() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def fold_strnlen_ax_1_neqz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_neqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    llvm.return %4 : i1
  }]

def fold_strnlen_ax_1_gtz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_gtz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "ugt" %3, %2 : i64
    llvm.return %4 : i1
  }]

def fold_strnlen_ax_9_eqz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_9_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    llvm.return %4 : i1
  }]

def call_strnlen_ax_n_eqz_before := [llvmfunc|
  llvm.func @call_strnlen_ax_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %arg0) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def fold_strnlen_ax_nz_eqz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_nz_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.call @strnlen(%1, %3) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    llvm.return %5 : i1
  }]

def fold_strnlen_ax_nz_gtz_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_nz_gtz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.call @strnlen(%1, %3) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "ugt" %4, %2 : i64
    llvm.return %5 : i1
  }]

def fold_strnlen_a5_pi_nz_eqz_before := [llvmfunc|
  llvm.func @fold_strnlen_a5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.or %arg1, %0  : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    llvm.return %6 : i1
  }]

def fold_strnlen_s5_pi_nz_eqz_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.or %arg1, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    %7 = llvm.icmp "eq" %6, %3 : i64
    llvm.return %7 : i1
  }]

def call_strnlen_s5_pi_n_eqz_before := [llvmfunc|
  llvm.func @call_strnlen_s5_pi_n_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    llvm.return %5 : i1
  }]

def fold_strnlen_ax_0_eqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_0_eqz() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_strnlen_ax_0_eqz   : fold_strnlen_ax_0_eqz_before  ⊑  fold_strnlen_ax_0_eqz_combined := by
  unfold fold_strnlen_ax_0_eqz_before fold_strnlen_ax_0_eqz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_0_gtz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_0_gtz() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_strnlen_ax_0_gtz   : fold_strnlen_ax_0_gtz_before  ⊑  fold_strnlen_ax_0_gtz_combined := by
  unfold fold_strnlen_ax_0_gtz_before fold_strnlen_ax_0_gtz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_1_eqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_1_eqz   : fold_strnlen_ax_1_eqz_before  ⊑  fold_strnlen_ax_1_eqz_combined := by
  unfold fold_strnlen_ax_1_eqz_before fold_strnlen_ax_1_eqz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_1_lt1_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_lt1() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_1_lt1   : fold_strnlen_ax_1_lt1_before  ⊑  fold_strnlen_ax_1_lt1_combined := by
  unfold fold_strnlen_ax_1_lt1_before fold_strnlen_ax_1_lt1_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_1_neqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_neqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_1_neqz   : fold_strnlen_ax_1_neqz_before  ⊑  fold_strnlen_ax_1_neqz_combined := by
  unfold fold_strnlen_ax_1_neqz_before fold_strnlen_ax_1_neqz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_1_gtz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_1_gtz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_1_gtz   : fold_strnlen_ax_1_gtz_before  ⊑  fold_strnlen_ax_1_gtz_combined := by
  unfold fold_strnlen_ax_1_gtz_before fold_strnlen_ax_1_gtz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_9_eqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_9_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_9_eqz   : fold_strnlen_ax_9_eqz_before  ⊑  fold_strnlen_ax_9_eqz_combined := by
  unfold fold_strnlen_ax_9_eqz_before fold_strnlen_ax_9_eqz_combined
  simp_alive_peephole
  sorry
def call_strnlen_ax_n_eqz_combined := [llvmfunc|
  llvm.func @call_strnlen_ax_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %arg0) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_call_strnlen_ax_n_eqz   : call_strnlen_ax_n_eqz_before  ⊑  call_strnlen_ax_n_eqz_combined := by
  unfold call_strnlen_ax_n_eqz_before call_strnlen_ax_n_eqz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_nz_eqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_nz_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_nz_eqz   : fold_strnlen_ax_nz_eqz_before  ⊑  fold_strnlen_ax_nz_eqz_combined := by
  unfold fold_strnlen_ax_nz_eqz_before fold_strnlen_ax_nz_eqz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_nz_gtz_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_nz_gtz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_strnlen_ax_nz_gtz   : fold_strnlen_ax_nz_gtz_before  ⊑  fold_strnlen_ax_nz_gtz_combined := by
  unfold fold_strnlen_ax_nz_gtz_before fold_strnlen_ax_nz_gtz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_a5_pi_nz_eqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_a5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.addressof @a5 : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.getelementptr inbounds %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_fold_strnlen_a5_pi_nz_eqz   : fold_strnlen_a5_pi_nz_eqz_before  ⊑  fold_strnlen_a5_pi_nz_eqz_combined := by
  unfold fold_strnlen_a5_pi_nz_eqz_before fold_strnlen_a5_pi_nz_eqz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_pi_nz_eqz_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_fold_strnlen_s5_pi_nz_eqz   : fold_strnlen_s5_pi_nz_eqz_before  ⊑  fold_strnlen_s5_pi_nz_eqz_combined := by
  unfold fold_strnlen_s5_pi_nz_eqz_before fold_strnlen_s5_pi_nz_eqz_combined
  simp_alive_peephole
  sorry
def call_strnlen_s5_pi_n_eqz_combined := [llvmfunc|
  llvm.func @call_strnlen_s5_pi_n_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    llvm.return %5 : i1
  }]

theorem inst_combine_call_strnlen_s5_pi_n_eqz   : call_strnlen_s5_pi_n_eqz_before  ⊑  call_strnlen_s5_pi_n_eqz_combined := by
  unfold call_strnlen_s5_pi_n_eqz_before call_strnlen_s5_pi_n_eqz_combined
  simp_alive_peephole
  sorry

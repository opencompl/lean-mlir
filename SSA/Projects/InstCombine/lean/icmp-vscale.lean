import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-vscale
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ugt_vscale64_x_32() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ugt_vscale64_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(1024 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    llvm.return %4 : i1
  }]

def ugt_vscale64_x_31() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ugt_vscale64_x_31() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(1024 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    llvm.return %4 : i1
  }]

def ugt_vscale16_x_32() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ugt_vscale16_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(5 : i16) : i16
    %1 = llvm.mlir.constant(1024 : i16) : i16
    %2 = "llvm.intr.vscale"() : () -> i16
    %3 = llvm.shl %2, %0  : i16
    %4 = llvm.icmp "ugt" %3, %1 : i16
    llvm.return %4 : i1
  }]

def ult_vscale16() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ult_vscale16() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(1024 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ult" %0, %1 : i16
    llvm.return %2 : i1
  }]

def ule_vscale64() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ule_vscale64() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.icmp "ule" %0, %1 : i64
    llvm.return %2 : i1
  }]

def ueq_vscale64_range4_4() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ueq_vscale64_range4_4() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }]

def ne_vscale64_x_32() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @ne_vscale64_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(39488 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.icmp "ne" %3, %1 : i64
    llvm.return %4 : i1
  }]

def vscale_ule_max() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ule_max() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ule" %1, %0 : i16
    llvm.return %2 : i1
  }]

def vscale_ult_max() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ult_max() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ult" %1, %0 : i16
    llvm.return %2 : i1
  }]

def vscale_uge_min() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_uge_min() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "uge" %1, %0 : i16
    llvm.return %2 : i1
  }]

def vscale_ugt_min() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ugt_min() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ugt" %1, %0 : i16
    llvm.return %2 : i1
  }]

def vscale_uge_no_max() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_uge_no_max() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def vscale_ugt_no_max() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ugt_no_max() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def vscale_uge_max_overflow() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_uge_max_overflow() -> i1 vscale_range(4, 256) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def vscale_ugt_max_overflow() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ugt_max_overflow() -> i1 vscale_range(4, 256) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def vscale_eq_min_overflow() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_eq_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def vscale_ult_min_overflow() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ult_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def vscale_ugt_min_overflow() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ugt_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ugt_vscale64_x_32() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ugt_vscale64_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_vscale64_x_32() -> i1 vscale_range   : ugt_vscale64_x_32() -> i1 vscale_range_before  ⊑  ugt_vscale64_x_32() -> i1 vscale_range_combined := by
  unfold ugt_vscale64_x_32() -> i1 vscale_range_before ugt_vscale64_x_32() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def ugt_vscale64_x_31() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ugt_vscale64_x_31() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_vscale64_x_31() -> i1 vscale_range   : ugt_vscale64_x_31() -> i1 vscale_range_before  ⊑  ugt_vscale64_x_31() -> i1 vscale_range_combined := by
  unfold ugt_vscale64_x_31() -> i1 vscale_range_before ugt_vscale64_x_31() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def ugt_vscale16_x_32() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ugt_vscale16_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_vscale16_x_32() -> i1 vscale_range   : ugt_vscale16_x_32() -> i1 vscale_range_before  ⊑  ugt_vscale16_x_32() -> i1 vscale_range_combined := by
  unfold ugt_vscale16_x_32() -> i1 vscale_range_before ugt_vscale16_x_32() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def ult_vscale16() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ult_vscale16() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_vscale16() -> i1 vscale_range   : ult_vscale16() -> i1 vscale_range_before  ⊑  ult_vscale16() -> i1 vscale_range_combined := by
  unfold ult_vscale16() -> i1 vscale_range_before ult_vscale16() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def ule_vscale64() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ule_vscale64() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_vscale64() -> i1 vscale_range   : ule_vscale64() -> i1 vscale_range_before  ⊑  ule_vscale64() -> i1 vscale_range_combined := by
  unfold ule_vscale64() -> i1 vscale_range_before ule_vscale64() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def ueq_vscale64_range4_4() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ueq_vscale64_range4_4() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ueq_vscale64_range4_4() -> i1 vscale_range   : ueq_vscale64_range4_4() -> i1 vscale_range_before  ⊑  ueq_vscale64_range4_4() -> i1 vscale_range_combined := by
  unfold ueq_vscale64_range4_4() -> i1 vscale_range_before ueq_vscale64_range4_4() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def ne_vscale64_x_32() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @ne_vscale64_x_32() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_vscale64_x_32() -> i1 vscale_range   : ne_vscale64_x_32() -> i1 vscale_range_before  ⊑  ne_vscale64_x_32() -> i1 vscale_range_combined := by
  unfold ne_vscale64_x_32() -> i1 vscale_range_before ne_vscale64_x_32() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ule_max() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ule_max() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_ule_max() -> i1 vscale_range   : vscale_ule_max() -> i1 vscale_range_before  ⊑  vscale_ule_max() -> i1 vscale_range_combined := by
  unfold vscale_ule_max() -> i1 vscale_range_before vscale_ule_max() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ult_max() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ult_max() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ult" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_vscale_ult_max() -> i1 vscale_range   : vscale_ult_max() -> i1 vscale_range_before  ⊑  vscale_ult_max() -> i1 vscale_range_combined := by
  unfold vscale_ult_max() -> i1 vscale_range_before vscale_ult_max() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_uge_min() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_uge_min() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_uge_min() -> i1 vscale_range   : vscale_uge_min() -> i1 vscale_range_before  ⊑  vscale_uge_min() -> i1 vscale_range_combined := by
  unfold vscale_uge_min() -> i1 vscale_range_before vscale_uge_min() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ugt_min() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ugt_min() -> i1 vscale_range(4, 8) {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = "llvm.intr.vscale"() : () -> i16
    %2 = llvm.icmp "ugt" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_vscale_ugt_min() -> i1 vscale_range   : vscale_ugt_min() -> i1 vscale_range_before  ⊑  vscale_ugt_min() -> i1 vscale_range_combined := by
  unfold vscale_ugt_min() -> i1 vscale_range_before vscale_ugt_min() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_uge_no_max() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_uge_no_max() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_uge_no_max() -> i1 vscale_range   : vscale_uge_no_max() -> i1 vscale_range_before  ⊑  vscale_uge_no_max() -> i1 vscale_range_combined := by
  unfold vscale_uge_no_max() -> i1 vscale_range_before vscale_uge_no_max() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ugt_no_max() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ugt_no_max() -> i1 vscale_range(4, 4) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_ugt_no_max() -> i1 vscale_range   : vscale_ugt_no_max() -> i1 vscale_range_before  ⊑  vscale_ugt_no_max() -> i1 vscale_range_combined := by
  unfold vscale_ugt_no_max() -> i1 vscale_range_before vscale_ugt_no_max() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_uge_max_overflow() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_uge_max_overflow() -> i1 vscale_range(4, 256) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_uge_max_overflow() -> i1 vscale_range   : vscale_uge_max_overflow() -> i1 vscale_range_before  ⊑  vscale_uge_max_overflow() -> i1 vscale_range_combined := by
  unfold vscale_uge_max_overflow() -> i1 vscale_range_before vscale_uge_max_overflow() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ugt_max_overflow() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ugt_max_overflow() -> i1 vscale_range(4, 256) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.vscale"() : () -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_vscale_ugt_max_overflow() -> i1 vscale_range   : vscale_ugt_max_overflow() -> i1 vscale_range_before  ⊑  vscale_ugt_max_overflow() -> i1 vscale_range_combined := by
  unfold vscale_ugt_max_overflow() -> i1 vscale_range_before vscale_ugt_max_overflow() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_eq_min_overflow() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_eq_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_eq_min_overflow() -> i1 vscale_range   : vscale_eq_min_overflow() -> i1 vscale_range_before  ⊑  vscale_eq_min_overflow() -> i1 vscale_range_combined := by
  unfold vscale_eq_min_overflow() -> i1 vscale_range_before vscale_eq_min_overflow() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ult_min_overflow() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ult_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_ult_min_overflow() -> i1 vscale_range   : vscale_ult_min_overflow() -> i1 vscale_range_before  ⊑  vscale_ult_min_overflow() -> i1 vscale_range_combined := by
  unfold vscale_ult_min_overflow() -> i1 vscale_range_before vscale_ult_min_overflow() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ugt_min_overflow() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ugt_min_overflow() -> i1 vscale_range(256, 512) {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_vscale_ugt_min_overflow() -> i1 vscale_range   : vscale_ugt_min_overflow() -> i1 vscale_range_before  ⊑  vscale_ugt_min_overflow() -> i1 vscale_range_combined := by
  unfold vscale_ugt_min_overflow() -> i1 vscale_range_before vscale_ugt_min_overflow() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry

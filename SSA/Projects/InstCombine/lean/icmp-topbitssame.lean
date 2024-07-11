import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-topbitssame
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def testi16i8_before := [llvmfunc|
  llvm.func @testi16i8(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

def testi16i8_com_before := [llvmfunc|
  llvm.func @testi16i8_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %3, %5 : i8
    llvm.return %6 : i1
  }]

def testi16i8_ne_before := [llvmfunc|
  llvm.func @testi16i8_ne(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "ne" %5, %3 : i8
    llvm.return %6 : i1
  }]

def testi16i8_ne_com_before := [llvmfunc|
  llvm.func @testi16i8_ne_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "ne" %3, %5 : i8
    llvm.return %6 : i1
  }]

def testi64i32_before := [llvmfunc|
  llvm.func @testi64i32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    llvm.return %6 : i1
  }]

def testi64i32_ne_before := [llvmfunc|
  llvm.func @testi64i32_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "ne" %5, %3 : i32
    llvm.return %6 : i1
  }]

def testi32i8_before := [llvmfunc|
  llvm.func @testi32i8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

def wrongimm1_before := [llvmfunc|
  llvm.func @wrongimm1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

def wrongimm2_before := [llvmfunc|
  llvm.func @wrongimm2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

def slt_before := [llvmfunc|
  llvm.func @slt(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "slt" %5, %3 : i32
    llvm.return %6 : i1
  }]

def extrause_a_before := [llvmfunc|
  llvm.func @extrause_a(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.return %6 : i1
  }]

def extrause_l_before := [llvmfunc|
  llvm.func @extrause_l(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }]

def extrause_la_before := [llvmfunc|
  llvm.func @extrause_la(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }]

def testi16i8_combined := [llvmfunc|
  llvm.func @testi16i8(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.add %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_testi16i8   : testi16i8_before  ⊑  testi16i8_combined := by
  unfold testi16i8_before testi16i8_combined
  simp_alive_peephole
  sorry
def testi16i8_com_combined := [llvmfunc|
  llvm.func @testi16i8_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(128 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.add %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_testi16i8_com   : testi16i8_com_before  ⊑  testi16i8_com_combined := by
  unfold testi16i8_com_before testi16i8_com_combined
  simp_alive_peephole
  sorry
def testi16i8_ne_combined := [llvmfunc|
  llvm.func @testi16i8_ne(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.add %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_testi16i8_ne   : testi16i8_ne_before  ⊑  testi16i8_ne_combined := by
  unfold testi16i8_ne_before testi16i8_ne_combined
  simp_alive_peephole
  sorry
def testi16i8_ne_com_combined := [llvmfunc|
  llvm.func @testi16i8_ne_com(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-128 : i16) : i16
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.add %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_testi16i8_ne_com   : testi16i8_ne_com_before  ⊑  testi16i8_ne_com_combined := by
  unfold testi16i8_ne_com_before testi16i8_ne_com_combined
  simp_alive_peephole
  sorry
def testi64i32_combined := [llvmfunc|
  llvm.func @testi64i32(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_testi64i32   : testi64i32_before  ⊑  testi64i32_combined := by
  unfold testi64i32_before testi64i32_combined
  simp_alive_peephole
  sorry
def testi64i32_ne_combined := [llvmfunc|
  llvm.func @testi64i32_ne(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(-4294967296 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_testi64i32_ne   : testi64i32_ne_before  ⊑  testi64i32_ne_combined := by
  unfold testi64i32_ne_before testi64i32_ne_combined
  simp_alive_peephole
  sorry
def testi32i8_combined := [llvmfunc|
  llvm.func @testi32i8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_testi32i8   : testi32i8_before  ⊑  testi32i8_combined := by
  unfold testi32i8_before testi32i8_combined
  simp_alive_peephole
  sorry
def wrongimm1_combined := [llvmfunc|
  llvm.func @wrongimm1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_wrongimm1   : wrongimm1_before  ⊑  wrongimm1_combined := by
  unfold wrongimm1_before wrongimm1_combined
  simp_alive_peephole
  sorry
def wrongimm2_combined := [llvmfunc|
  llvm.func @wrongimm2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_wrongimm2   : wrongimm2_before  ⊑  wrongimm2_combined := by
  unfold wrongimm2_before wrongimm2_combined
  simp_alive_peephole
  sorry
def slt_combined := [llvmfunc|
  llvm.func @slt(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.trunc %arg0 : i64 to i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.icmp "slt" %5, %3 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_slt   : slt_before  ⊑  slt_combined := by
  unfold slt_before slt_combined
  simp_alive_peephole
  sorry
def extrause_a_combined := [llvmfunc|
  llvm.func @extrause_a(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.ashr %3, %0  : i8
    %5 = llvm.add %arg0, %1  : i16
    %6 = llvm.icmp "ult" %5, %2 : i16
    llvm.call @use(%4) : (i8) -> ()
    llvm.return %6 : i1
  }]

theorem inst_combine_extrause_a   : extrause_a_before  ⊑  extrause_a_combined := by
  unfold extrause_a_before extrause_a_combined
  simp_alive_peephole
  sorry
def extrause_l_combined := [llvmfunc|
  llvm.func @extrause_l(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.lshr %arg0, %0  : i16
    %4 = llvm.trunc %3 : i16 to i8
    %5 = llvm.add %arg0, %1  : i16
    %6 = llvm.icmp "ult" %5, %2 : i16
    llvm.call @use(%4) : (i8) -> ()
    llvm.return %6 : i1
  }]

theorem inst_combine_extrause_l   : extrause_l_before  ⊑  extrause_l_combined := by
  unfold extrause_l_before extrause_l_combined
  simp_alive_peephole
  sorry
def extrause_la_combined := [llvmfunc|
  llvm.func @extrause_la(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    %4 = llvm.trunc %arg0 : i16 to i8
    %5 = llvm.ashr %4, %1  : i8
    %6 = llvm.icmp "eq" %5, %3 : i8
    llvm.call @use(%5) : (i8) -> ()
    llvm.call @use(%3) : (i8) -> ()
    llvm.return %6 : i1
  }]

theorem inst_combine_extrause_la   : extrause_la_before  ⊑  extrause_la_combined := by
  unfold extrause_la_before extrause_la_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  signext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sextinreg_before := [llvmfunc|
  llvm.func @sextinreg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(32768 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def sextinreg_extra_use_before := [llvmfunc|
  llvm.func @sextinreg_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(32768 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def sextinreg_splat_before := [llvmfunc|
  llvm.func @sextinreg_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-32768> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<32768> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def sextinreg_alt_before := [llvmfunc|
  llvm.func @sextinreg_alt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(32768 : i32) : i32
    %2 = llvm.mlir.constant(-32768 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def sextinreg_alt_splat_before := [llvmfunc|
  llvm.func @sextinreg_alt_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32768> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-32768> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def sext_before := [llvmfunc|
  llvm.func @sext(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def sext_extra_use_before := [llvmfunc|
  llvm.func @sext_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.xor %2, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def sext_splat_before := [llvmfunc|
  llvm.func @sext_splat(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32768> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-32768> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.add %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def sextinreg2_before := [llvmfunc|
  llvm.func @sextinreg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(-128 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def sextinreg2_splat_before := [llvmfunc|
  llvm.func @sextinreg2_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-128> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }]

def test6_splat_vec_before := [llvmfunc|
  llvm.func @test6_splat_vec(%arg0: vector<2xi12>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<20> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi12> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def ashr_before := [llvmfunc|
  llvm.func @ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(67108864 : i32) : i32
    %2 = llvm.mlir.constant(-67108864 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def ashr_splat_before := [llvmfunc|
  llvm.func @ashr_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<67108864> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-67108864> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def sextinreg_combined := [llvmfunc|
  llvm.func @sextinreg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sextinreg   : sextinreg_before  ⊑  sextinreg_combined := by
  unfold sextinreg_before sextinreg_combined
  simp_alive_peephole
  sorry
def sextinreg_extra_use_combined := [llvmfunc|
  llvm.func @sextinreg_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(32768 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_sextinreg_extra_use   : sextinreg_extra_use_before  ⊑  sextinreg_extra_use_combined := by
  unfold sextinreg_extra_use_before sextinreg_extra_use_combined
  simp_alive_peephole
  sorry
def sextinreg_splat_combined := [llvmfunc|
  llvm.func @sextinreg_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sextinreg_splat   : sextinreg_splat_before  ⊑  sextinreg_splat_combined := by
  unfold sextinreg_splat_before sextinreg_splat_combined
  simp_alive_peephole
  sorry
def sextinreg_alt_combined := [llvmfunc|
  llvm.func @sextinreg_alt(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sextinreg_alt   : sextinreg_alt_before  ⊑  sextinreg_alt_combined := by
  unfold sextinreg_alt_before sextinreg_alt_combined
  simp_alive_peephole
  sorry
def sextinreg_alt_splat_combined := [llvmfunc|
  llvm.func @sextinreg_alt_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sextinreg_alt_splat   : sextinreg_alt_splat_before  ⊑  sextinreg_alt_splat_combined := by
  unfold sextinreg_alt_splat_before sextinreg_alt_splat_combined
  simp_alive_peephole
  sorry
def sext_combined := [llvmfunc|
  llvm.func @sext(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sext   : sext_before  ⊑  sext_combined := by
  unfold sext_before sext_combined
  simp_alive_peephole
  sorry
def sext_extra_use_combined := [llvmfunc|
  llvm.func @sext_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.zext %1 : i16 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.sext %arg0 : i16 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sext_extra_use   : sext_extra_use_before  ⊑  sext_extra_use_combined := by
  unfold sext_extra_use_before sext_extra_use_combined
  simp_alive_peephole
  sorry
def sext_splat_combined := [llvmfunc|
  llvm.func @sext_splat(%arg0: vector<2xi16>) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_sext_splat   : sext_splat_before  ⊑  sext_splat_combined := by
  unfold sext_splat_before sext_splat_combined
  simp_alive_peephole
  sorry
def sextinreg2_combined := [llvmfunc|
  llvm.func @sextinreg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sextinreg2   : sextinreg2_before  ⊑  sextinreg2_combined := by
  unfold sextinreg2_before sextinreg2_combined
  simp_alive_peephole
  sorry
def sextinreg2_splat_combined := [llvmfunc|
  llvm.func @sextinreg2_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sextinreg2_splat   : sextinreg2_splat_before  ⊑  sextinreg2_splat_combined := by
  unfold sextinreg2_splat_before sextinreg2_splat_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_splat_vec_combined := [llvmfunc|
  llvm.func @test6_splat_vec(%arg0: vector<2xi12>) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi12> to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_test6_splat_vec   : test6_splat_vec_before  ⊑  test6_splat_vec_combined := by
  unfold test6_splat_vec_before test6_splat_vec_combined
  simp_alive_peephole
  sorry
def ashr_combined := [llvmfunc|
  llvm.func @ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr   : ashr_before  ⊑  ashr_combined := by
  unfold ashr_before ashr_combined
  simp_alive_peephole
  sorry
def ashr_splat_combined := [llvmfunc|
  llvm.func @ashr_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_ashr_splat   : ashr_splat_before  ⊑  ashr_splat_combined := by
  unfold ashr_splat_before ashr_splat_combined
  simp_alive_peephole
  sorry

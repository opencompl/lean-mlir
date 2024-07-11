import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-narrow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zext_add_before := [llvmfunc|
  llvm.func @zext_add(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(44 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.add %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

def zext_sub_before := [llvmfunc|
  llvm.func @zext_sub(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(-5 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.sub %0, %1  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

def zext_mul_before := [llvmfunc|
  llvm.func @zext_mul(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.mul %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

def zext_lshr_before := [llvmfunc|
  llvm.func @zext_lshr(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

def zext_ashr_before := [llvmfunc|
  llvm.func @zext_ashr(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.ashr %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

def zext_shl_before := [llvmfunc|
  llvm.func @zext_shl(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

def zext_add_vec_before := [llvmfunc|
  llvm.func @zext_add_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[44, 42]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.add %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_sub_vec_before := [llvmfunc|
  llvm.func @zext_sub_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[-5, -4]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.sub %0, %1  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_mul_vec_before := [llvmfunc|
  llvm.func @zext_mul_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[3, -2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.mul %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_lshr_vec_before := [llvmfunc|
  llvm.func @zext_lshr_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_ashr_vec_before := [llvmfunc|
  llvm.func @zext_ashr_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.ashr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_shl_vec_before := [llvmfunc|
  llvm.func @zext_shl_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_lshr_vec_overshift_before := [llvmfunc|
  llvm.func @zext_lshr_vec_overshift(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 8]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_lshr_vec_undef_before := [llvmfunc|
  llvm.func @zext_lshr_vec_undef(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_shl_vec_overshift_before := [llvmfunc|
  llvm.func @zext_shl_vec_overshift(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[8, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_shl_vec_undef_before := [llvmfunc|
  llvm.func @zext_shl_vec_undef(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def zext_add_combined := [llvmfunc|
  llvm.func @zext_add(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(44 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zext_add   : zext_add_before  ⊑  zext_add_combined := by
  unfold zext_add_before zext_add_combined
  simp_alive_peephole
  sorry
def zext_sub_combined := [llvmfunc|
  llvm.func @zext_sub(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zext_sub   : zext_sub_before  ⊑  zext_sub_combined := by
  unfold zext_sub_before zext_sub_combined
  simp_alive_peephole
  sorry
def zext_mul_combined := [llvmfunc|
  llvm.func @zext_mul(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zext_mul   : zext_mul_before  ⊑  zext_mul_combined := by
  unfold zext_mul_before zext_mul_combined
  simp_alive_peephole
  sorry
def zext_lshr_combined := [llvmfunc|
  llvm.func @zext_lshr(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zext_lshr   : zext_lshr_before  ⊑  zext_lshr_combined := by
  unfold zext_lshr_before zext_lshr_combined
  simp_alive_peephole
  sorry
def zext_ashr_combined := [llvmfunc|
  llvm.func @zext_ashr(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zext_ashr   : zext_ashr_before  ⊑  zext_ashr_combined := by
  unfold zext_ashr_before zext_ashr_combined
  simp_alive_peephole
  sorry
def zext_shl_combined := [llvmfunc|
  llvm.func @zext_shl(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_zext_shl   : zext_shl_before  ⊑  zext_shl_combined := by
  unfold zext_shl_before zext_shl_combined
  simp_alive_peephole
  sorry
def zext_add_vec_combined := [llvmfunc|
  llvm.func @zext_add_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[44, 42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_add_vec   : zext_add_vec_before  ⊑  zext_add_vec_combined := by
  unfold zext_add_vec_before zext_add_vec_combined
  simp_alive_peephole
  sorry
def zext_sub_vec_combined := [llvmfunc|
  llvm.func @zext_sub_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[-5, -4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_sub_vec   : zext_sub_vec_before  ⊑  zext_sub_vec_combined := by
  unfold zext_sub_vec_before zext_sub_vec_combined
  simp_alive_peephole
  sorry
def zext_mul_vec_combined := [llvmfunc|
  llvm.func @zext_mul_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[3, -2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_mul_vec   : zext_mul_vec_before  ⊑  zext_mul_vec_combined := by
  unfold zext_mul_vec_before zext_mul_vec_combined
  simp_alive_peephole
  sorry
def zext_lshr_vec_combined := [llvmfunc|
  llvm.func @zext_lshr_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_lshr_vec   : zext_lshr_vec_before  ⊑  zext_lshr_vec_combined := by
  unfold zext_lshr_vec_before zext_lshr_vec_combined
  simp_alive_peephole
  sorry
def zext_ashr_vec_combined := [llvmfunc|
  llvm.func @zext_ashr_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_ashr_vec   : zext_ashr_vec_before  ⊑  zext_ashr_vec_combined := by
  unfold zext_ashr_vec_before zext_ashr_vec_combined
  simp_alive_peephole
  sorry
def zext_shl_vec_combined := [llvmfunc|
  llvm.func @zext_shl_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_shl_vec   : zext_shl_vec_before  ⊑  zext_shl_vec_combined := by
  unfold zext_shl_vec_before zext_shl_vec_combined
  simp_alive_peephole
  sorry
def zext_lshr_vec_overshift_combined := [llvmfunc|
  llvm.func @zext_lshr_vec_overshift(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 8]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_lshr_vec_overshift   : zext_lshr_vec_overshift_before  ⊑  zext_lshr_vec_overshift_combined := by
  unfold zext_lshr_vec_overshift_before zext_lshr_vec_overshift_combined
  simp_alive_peephole
  sorry
def zext_lshr_vec_undef_combined := [llvmfunc|
  llvm.func @zext_lshr_vec_undef(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_zext_lshr_vec_undef   : zext_lshr_vec_undef_before  ⊑  zext_lshr_vec_undef_combined := by
  unfold zext_lshr_vec_undef_before zext_lshr_vec_undef_combined
  simp_alive_peephole
  sorry
def zext_shl_vec_overshift_combined := [llvmfunc|
  llvm.func @zext_shl_vec_overshift(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[8, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_zext_shl_vec_overshift   : zext_shl_vec_overshift_before  ⊑  zext_shl_vec_overshift_combined := by
  unfold zext_shl_vec_overshift_before zext_shl_vec_overshift_combined
  simp_alive_peephole
  sorry
def zext_shl_vec_undef_combined := [llvmfunc|
  llvm.func @zext_shl_vec_undef(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_zext_shl_vec_undef   : zext_shl_vec_undef_before  ⊑  zext_shl_vec_undef_combined := by
  unfold zext_shl_vec_undef_before zext_shl_vec_undef_combined
  simp_alive_peephole
  sorry

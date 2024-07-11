import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  udivrem-change-width
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def udiv_i8_before := [llvmfunc|
  llvm.func @udiv_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def udiv_i8_vec_before := [llvmfunc|
  llvm.func @udiv_i8_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.udiv %0, %1  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def urem_i8_before := [llvmfunc|
  llvm.func @urem_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def urem_i8_vec_before := [llvmfunc|
  llvm.func @urem_i8_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.urem %0, %1  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def udiv_i32_before := [llvmfunc|
  llvm.func @udiv_i32(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_i32_vec_before := [llvmfunc|
  llvm.func @udiv_i32_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.udiv %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def udiv_i32_multiuse_before := [llvmfunc|
  llvm.func @udiv_i32_multiuse(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    %3 = llvm.add %0, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.return %4 : i32
  }]

def udiv_illegal_type_before := [llvmfunc|
  llvm.func @udiv_illegal_type(%arg0: i9, %arg1: i9) -> i32 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.zext %arg1 : i9 to i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def urem_i32_before := [llvmfunc|
  llvm.func @urem_i32(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    llvm.return %2 : i32
  }]

def urem_i32_vec_before := [llvmfunc|
  llvm.func @urem_i32_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.urem %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def urem_i32_multiuse_before := [llvmfunc|
  llvm.func @urem_i32_multiuse(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    %3 = llvm.add %0, %1  : i32
    %4 = llvm.mul %2, %3  : i32
    llvm.return %4 : i32
  }]

def urem_illegal_type_before := [llvmfunc|
  llvm.func @urem_illegal_type(%arg0: i9, %arg1: i9) -> i32 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.zext %arg1 : i9 to i32
    %2 = llvm.urem %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_i32_c_before := [llvmfunc|
  llvm.func @udiv_i32_c(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }]

def udiv_i32_c_vec_before := [llvmfunc|
  llvm.func @udiv_i32_c_vec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.udiv %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def udiv_i32_c_multiuse_before := [llvmfunc|
  llvm.func @udiv_i32_c_multiuse(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %1, %0  : i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

def udiv_illegal_type_c_before := [llvmfunc|
  llvm.func @udiv_illegal_type_c(%arg0: i9) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i9 to i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }]

def urem_i32_c_before := [llvmfunc|
  llvm.func @urem_i32_c(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }]

def urem_i32_c_vec_before := [llvmfunc|
  llvm.func @urem_i32_c_vec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.urem %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def urem_i32_c_multiuse_before := [llvmfunc|
  llvm.func @urem_i32_c_multiuse(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %1, %0  : i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

def urem_illegal_type_c_before := [llvmfunc|
  llvm.func @urem_illegal_type_c(%arg0: i9) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i9 to i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }]

def udiv_c_i32_before := [llvmfunc|
  llvm.func @udiv_c_i32(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    llvm.return %2 : i32
  }]

def urem_c_i32_before := [llvmfunc|
  llvm.func @urem_c_i32(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    llvm.return %2 : i32
  }]

def udiv_constexpr_before := [llvmfunc|
  llvm.func @udiv_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.udiv %2, %3  : i32
    llvm.return %4 : i32
  }]

def udiv_const_constexpr_before := [llvmfunc|
  llvm.func @udiv_const_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g1 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.udiv %2, %3  : i32
    llvm.return %4 : i32
  }]

def urem_const_constexpr_before := [llvmfunc|
  llvm.func @urem_const_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g2 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }]

def udiv_constexpr_const_before := [llvmfunc|
  llvm.func @udiv_constexpr_const(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g3 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.udiv %3, %2  : i32
    llvm.return %4 : i32
  }]

def urem_constexpr_const_before := [llvmfunc|
  llvm.func @urem_constexpr_const(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g4 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.zext %1 : i8 to i32
    %4 = llvm.urem %3, %2  : i32
    llvm.return %4 : i32
  }]

def udiv_i8_combined := [llvmfunc|
  llvm.func @udiv_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_udiv_i8   : udiv_i8_before  ⊑  udiv_i8_combined := by
  unfold udiv_i8_before udiv_i8_combined
  simp_alive_peephole
  sorry
def udiv_i8_vec_combined := [llvmfunc|
  llvm.func @udiv_i8_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.udiv %arg0, %arg1  : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_udiv_i8_vec   : udiv_i8_vec_before  ⊑  udiv_i8_vec_combined := by
  unfold udiv_i8_vec_before udiv_i8_vec_combined
  simp_alive_peephole
  sorry
def urem_i8_combined := [llvmfunc|
  llvm.func @urem_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.urem %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_urem_i8   : urem_i8_before  ⊑  urem_i8_combined := by
  unfold urem_i8_before urem_i8_combined
  simp_alive_peephole
  sorry
def urem_i8_vec_combined := [llvmfunc|
  llvm.func @urem_i8_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.urem %arg0, %arg1  : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_urem_i8_vec   : urem_i8_vec_before  ⊑  urem_i8_vec_combined := by
  unfold urem_i8_vec_before urem_i8_vec_combined
  simp_alive_peephole
  sorry
def udiv_i32_combined := [llvmfunc|
  llvm.func @udiv_i32(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_udiv_i32   : udiv_i32_before  ⊑  udiv_i32_combined := by
  unfold udiv_i32_before udiv_i32_combined
  simp_alive_peephole
  sorry
def udiv_i32_vec_combined := [llvmfunc|
  llvm.func @udiv_i32_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.udiv %arg0, %arg1  : vector<2xi8>
    %1 = llvm.zext %0 : vector<2xi8> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_udiv_i32_vec   : udiv_i32_vec_before  ⊑  udiv_i32_vec_combined := by
  unfold udiv_i32_vec_before udiv_i32_vec_combined
  simp_alive_peephole
  sorry
def udiv_i32_multiuse_combined := [llvmfunc|
  llvm.func @udiv_i32_multiuse(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.udiv %0, %1  : i32
    %3 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_udiv_i32_multiuse   : udiv_i32_multiuse_before  ⊑  udiv_i32_multiuse_combined := by
  unfold udiv_i32_multiuse_before udiv_i32_multiuse_combined
  simp_alive_peephole
  sorry
def udiv_illegal_type_combined := [llvmfunc|
  llvm.func @udiv_illegal_type(%arg0: i9, %arg1: i9) -> i32 {
    %0 = llvm.udiv %arg0, %arg1  : i9
    %1 = llvm.zext %0 : i9 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_udiv_illegal_type   : udiv_illegal_type_before  ⊑  udiv_illegal_type_combined := by
  unfold udiv_illegal_type_before udiv_illegal_type_combined
  simp_alive_peephole
  sorry
def urem_i32_combined := [llvmfunc|
  llvm.func @urem_i32(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.urem %arg0, %arg1  : i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_urem_i32   : urem_i32_before  ⊑  urem_i32_combined := by
  unfold urem_i32_before urem_i32_combined
  simp_alive_peephole
  sorry
def urem_i32_vec_combined := [llvmfunc|
  llvm.func @urem_i32_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.urem %arg0, %arg1  : vector<2xi8>
    %1 = llvm.zext %0 : vector<2xi8> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_urem_i32_vec   : urem_i32_vec_before  ⊑  urem_i32_vec_combined := by
  unfold urem_i32_vec_before urem_i32_vec_combined
  simp_alive_peephole
  sorry
def urem_i32_multiuse_combined := [llvmfunc|
  llvm.func @urem_i32_multiuse(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.urem %0, %1  : i32
    %3 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_urem_i32_multiuse   : urem_i32_multiuse_before  ⊑  urem_i32_multiuse_combined := by
  unfold urem_i32_multiuse_before urem_i32_multiuse_combined
  simp_alive_peephole
  sorry
def urem_illegal_type_combined := [llvmfunc|
  llvm.func @urem_illegal_type(%arg0: i9, %arg1: i9) -> i32 {
    %0 = llvm.urem %arg0, %arg1  : i9
    %1 = llvm.zext %0 : i9 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_urem_illegal_type   : urem_illegal_type_before  ⊑  urem_illegal_type_combined := by
  unfold urem_illegal_type_before urem_illegal_type_combined
  simp_alive_peephole
  sorry
def udiv_i32_c_combined := [llvmfunc|
  llvm.func @udiv_i32_c(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.udiv %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_i32_c   : udiv_i32_c_before  ⊑  udiv_i32_c_combined := by
  unfold udiv_i32_c_before udiv_i32_c_combined
  simp_alive_peephole
  sorry
def udiv_i32_c_vec_combined := [llvmfunc|
  llvm.func @udiv_i32_c_vec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 17]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.udiv %arg0, %0  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_udiv_i32_c_vec   : udiv_i32_c_vec_before  ⊑  udiv_i32_c_vec_combined := by
  unfold udiv_i32_c_vec_before udiv_i32_c_vec_combined
  simp_alive_peephole
  sorry
def udiv_i32_c_multiuse_combined := [llvmfunc|
  llvm.func @udiv_i32_c_multiuse(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.udiv %1, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_udiv_i32_c_multiuse   : udiv_i32_c_multiuse_before  ⊑  udiv_i32_c_multiuse_combined := by
  unfold udiv_i32_c_multiuse_before udiv_i32_c_multiuse_combined
  simp_alive_peephole
  sorry
def udiv_illegal_type_c_combined := [llvmfunc|
  llvm.func @udiv_illegal_type_c(%arg0: i9) -> i32 {
    %0 = llvm.mlir.constant(10 : i9) : i9
    %1 = llvm.udiv %arg0, %0  : i9
    %2 = llvm.zext %1 : i9 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_illegal_type_c   : udiv_illegal_type_c_before  ⊑  udiv_illegal_type_c_combined := by
  unfold udiv_illegal_type_c_before udiv_illegal_type_c_combined
  simp_alive_peephole
  sorry
def urem_i32_c_combined := [llvmfunc|
  llvm.func @urem_i32_c(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.urem %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_urem_i32_c   : urem_i32_c_before  ⊑  urem_i32_c_combined := by
  unfold urem_i32_c_before urem_i32_c_combined
  simp_alive_peephole
  sorry
def urem_i32_c_vec_combined := [llvmfunc|
  llvm.func @urem_i32_c_vec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 17]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.urem %arg0, %0  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_urem_i32_c_vec   : urem_i32_c_vec_before  ⊑  urem_i32_c_vec_combined := by
  unfold urem_i32_c_vec_before urem_i32_c_vec_combined
  simp_alive_peephole
  sorry
def urem_i32_c_multiuse_combined := [llvmfunc|
  llvm.func @urem_i32_c_multiuse(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.urem %1, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_urem_i32_c_multiuse   : urem_i32_c_multiuse_before  ⊑  urem_i32_c_multiuse_combined := by
  unfold urem_i32_c_multiuse_before urem_i32_c_multiuse_combined
  simp_alive_peephole
  sorry
def urem_illegal_type_c_combined := [llvmfunc|
  llvm.func @urem_illegal_type_c(%arg0: i9) -> i32 {
    %0 = llvm.mlir.constant(10 : i9) : i9
    %1 = llvm.urem %arg0, %0  : i9
    %2 = llvm.zext %1 : i9 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_urem_illegal_type_c   : urem_illegal_type_c_before  ⊑  urem_illegal_type_c_combined := by
  unfold urem_illegal_type_c_before urem_illegal_type_c_combined
  simp_alive_peephole
  sorry
def udiv_c_i32_combined := [llvmfunc|
  llvm.func @udiv_c_i32(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_udiv_c_i32   : udiv_c_i32_before  ⊑  udiv_c_i32_combined := by
  unfold udiv_c_i32_before udiv_c_i32_combined
  simp_alive_peephole
  sorry
def urem_c_i32_combined := [llvmfunc|
  llvm.func @urem_c_i32(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.urem %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_urem_c_i32   : urem_c_i32_before  ⊑  urem_c_i32_combined := by
  unfold urem_c_i32_before urem_c_i32_combined
  simp_alive_peephole
  sorry
def udiv_constexpr_combined := [llvmfunc|
  llvm.func @udiv_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.udiv %arg0, %1  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_udiv_constexpr   : udiv_constexpr_before  ⊑  udiv_constexpr_combined := by
  unfold udiv_constexpr_before udiv_constexpr_combined
  simp_alive_peephole
  sorry
def udiv_const_constexpr_combined := [llvmfunc|
  llvm.func @udiv_const_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.addressof @g1 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.udiv %0, %2  : i8
    %4 = llvm.zext %3 : i8 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_udiv_const_constexpr   : udiv_const_constexpr_before  ⊑  udiv_const_constexpr_combined := by
  unfold udiv_const_constexpr_before udiv_const_constexpr_combined
  simp_alive_peephole
  sorry
def urem_const_constexpr_combined := [llvmfunc|
  llvm.func @urem_const_constexpr(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.addressof @g2 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i8
    %3 = llvm.urem %0, %2  : i8
    %4 = llvm.zext %3 : i8 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_urem_const_constexpr   : urem_const_constexpr_before  ⊑  urem_const_constexpr_combined := by
  unfold urem_const_constexpr_before urem_const_constexpr_combined
  simp_alive_peephole
  sorry
def udiv_constexpr_const_combined := [llvmfunc|
  llvm.func @udiv_constexpr_const(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g3 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.udiv %1, %2  : i8
    %4 = llvm.zext %3 : i8 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_udiv_constexpr_const   : udiv_constexpr_const_before  ⊑  udiv_constexpr_const_combined := by
  unfold udiv_constexpr_const_before udiv_constexpr_const_combined
  simp_alive_peephole
  sorry
def urem_constexpr_const_combined := [llvmfunc|
  llvm.func @urem_constexpr_const(%arg0: i8) -> i32 {
    %0 = llvm.mlir.addressof @g4 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.urem %1, %2  : i8
    %4 = llvm.zext %3 : i8 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_urem_constexpr_const   : urem_constexpr_const_before  ⊑  urem_constexpr_const_combined := by
  unfold urem_constexpr_const_before urem_constexpr_const_combined
  simp_alive_peephole
  sorry

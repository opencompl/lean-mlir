import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-binop-ext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def narrow_sext_and_before := [llvmfunc|
  llvm.func @narrow_sext_and(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.and %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_zext_and_before := [llvmfunc|
  llvm.func @narrow_zext_and(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.and %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_sext_or_before := [llvmfunc|
  llvm.func @narrow_sext_or(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.or %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_zext_or_before := [llvmfunc|
  llvm.func @narrow_zext_or(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.or %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_sext_xor_before := [llvmfunc|
  llvm.func @narrow_sext_xor(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.xor %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_zext_xor_before := [llvmfunc|
  llvm.func @narrow_zext_xor(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.xor %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_sext_add_before := [llvmfunc|
  llvm.func @narrow_sext_add(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.add %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_zext_add_before := [llvmfunc|
  llvm.func @narrow_zext_add(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.add %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_sext_sub_before := [llvmfunc|
  llvm.func @narrow_sext_sub(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_zext_sub_before := [llvmfunc|
  llvm.func @narrow_zext_sub(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_sext_mul_before := [llvmfunc|
  llvm.func @narrow_sext_mul(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_zext_mul_before := [llvmfunc|
  llvm.func @narrow_zext_mul(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def narrow_sext_and_commute_before := [llvmfunc|
  llvm.func @narrow_sext_and_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_and_commute_before := [llvmfunc|
  llvm.func @narrow_zext_and_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_sext_or_commute_before := [llvmfunc|
  llvm.func @narrow_sext_or_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_or_commute_before := [llvmfunc|
  llvm.func @narrow_zext_or_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_sext_xor_commute_before := [llvmfunc|
  llvm.func @narrow_sext_xor_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_xor_commute_before := [llvmfunc|
  llvm.func @narrow_zext_xor_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.xor %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_sext_add_commute_before := [llvmfunc|
  llvm.func @narrow_sext_add_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.add %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_add_commute_before := [llvmfunc|
  llvm.func @narrow_zext_add_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.add %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_sext_sub_commute_before := [llvmfunc|
  llvm.func @narrow_sext_sub_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.sub %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_sub_commute_before := [llvmfunc|
  llvm.func @narrow_zext_sub_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.sub %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_sext_mul_commute_before := [llvmfunc|
  llvm.func @narrow_sext_mul_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.mul %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_mul_commute_before := [llvmfunc|
  llvm.func @narrow_zext_mul_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.mul %1, %2  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def narrow_zext_ashr_keep_trunc_before := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.sext %arg1 : i8 to i32
    %3 = llvm.add %1, %2 overflow<nsw>  : i32
    %4 = llvm.ashr %3, %0  : i32
    %5 = llvm.trunc %4 : i32 to i8
    llvm.return %5 : i8
  }]

def narrow_zext_ashr_keep_trunc2_before := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc2(%arg0: i9, %arg1: i9) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sext %arg0 : i9 to i64
    %2 = llvm.sext %arg1 : i9 to i64
    %3 = llvm.add %1, %2 overflow<nsw>  : i64
    %4 = llvm.ashr %3, %0  : i64
    %5 = llvm.trunc %4 : i64 to i8
    llvm.return %5 : i8
  }]

def narrow_zext_ashr_keep_trunc3_before := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc3(%arg0: i8, %arg1: i8) -> i7 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sext %arg0 : i8 to i64
    %2 = llvm.sext %arg1 : i8 to i64
    %3 = llvm.add %1, %2 overflow<nsw>  : i64
    %4 = llvm.ashr %3, %0  : i64
    %5 = llvm.trunc %4 : i64 to i7
    llvm.return %5 : i7
  }]

def narrow_zext_ashr_keep_trunc_vector_before := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc_vector(%arg0: vector<8xi8>, %arg1: vector<8xi8>) -> vector<8xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.sext %arg0 : vector<8xi8> to vector<8xi32>
    %2 = llvm.sext %arg1 : vector<8xi8> to vector<8xi32>
    %3 = llvm.add %1, %2 overflow<nsw>  : vector<8xi32>
    %4 = llvm.ashr %3, %0  : vector<8xi32>
    %5 = llvm.trunc %4 : vector<8xi32> to vector<8xi8>
    llvm.return %5 : vector<8xi8>
  }]

def dont_narrow_zext_ashr_keep_trunc_before := [llvmfunc|
  llvm.func @dont_narrow_zext_ashr_keep_trunc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.sext %arg1 : i8 to i16
    %3 = llvm.add %1, %2 overflow<nsw>  : i16
    %4 = llvm.ashr %3, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    llvm.return %5 : i8
  }]

def narrow_sext_and_combined := [llvmfunc|
  llvm.func @narrow_sext_and(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.and %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_sext_and   : narrow_sext_and_before  ⊑  narrow_sext_and_combined := by
  unfold narrow_sext_and_before narrow_sext_and_combined
  simp_alive_peephole
  sorry
def narrow_zext_and_combined := [llvmfunc|
  llvm.func @narrow_zext_and(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.and %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_zext_and   : narrow_zext_and_before  ⊑  narrow_zext_and_combined := by
  unfold narrow_zext_and_before narrow_zext_and_combined
  simp_alive_peephole
  sorry
def narrow_sext_or_combined := [llvmfunc|
  llvm.func @narrow_sext_or(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.or %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_sext_or   : narrow_sext_or_before  ⊑  narrow_sext_or_combined := by
  unfold narrow_sext_or_before narrow_sext_or_combined
  simp_alive_peephole
  sorry
def narrow_zext_or_combined := [llvmfunc|
  llvm.func @narrow_zext_or(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.or %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_zext_or   : narrow_zext_or_before  ⊑  narrow_zext_or_combined := by
  unfold narrow_zext_or_before narrow_zext_or_combined
  simp_alive_peephole
  sorry
def narrow_sext_xor_combined := [llvmfunc|
  llvm.func @narrow_sext_xor(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.xor %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_sext_xor   : narrow_sext_xor_before  ⊑  narrow_sext_xor_combined := by
  unfold narrow_sext_xor_before narrow_sext_xor_combined
  simp_alive_peephole
  sorry
def narrow_zext_xor_combined := [llvmfunc|
  llvm.func @narrow_zext_xor(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.xor %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_zext_xor   : narrow_zext_xor_before  ⊑  narrow_zext_xor_combined := by
  unfold narrow_zext_xor_before narrow_zext_xor_combined
  simp_alive_peephole
  sorry
def narrow_sext_add_combined := [llvmfunc|
  llvm.func @narrow_sext_add(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.add %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_sext_add   : narrow_sext_add_before  ⊑  narrow_sext_add_combined := by
  unfold narrow_sext_add_before narrow_sext_add_combined
  simp_alive_peephole
  sorry
def narrow_zext_add_combined := [llvmfunc|
  llvm.func @narrow_zext_add(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.add %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_zext_add   : narrow_zext_add_before  ⊑  narrow_zext_add_combined := by
  unfold narrow_zext_add_before narrow_zext_add_combined
  simp_alive_peephole
  sorry
def narrow_sext_sub_combined := [llvmfunc|
  llvm.func @narrow_sext_sub(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.sub %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_sext_sub   : narrow_sext_sub_before  ⊑  narrow_sext_sub_combined := by
  unfold narrow_sext_sub_before narrow_sext_sub_combined
  simp_alive_peephole
  sorry
def narrow_zext_sub_combined := [llvmfunc|
  llvm.func @narrow_zext_sub(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.sub %arg0, %0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_zext_sub   : narrow_zext_sub_before  ⊑  narrow_zext_sub_combined := by
  unfold narrow_zext_sub_before narrow_zext_sub_combined
  simp_alive_peephole
  sorry
def narrow_sext_mul_combined := [llvmfunc|
  llvm.func @narrow_sext_mul(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.mul %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_sext_mul   : narrow_sext_mul_before  ⊑  narrow_sext_mul_combined := by
  unfold narrow_sext_mul_before narrow_sext_mul_combined
  simp_alive_peephole
  sorry
def narrow_zext_mul_combined := [llvmfunc|
  llvm.func @narrow_zext_mul(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.mul %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_narrow_zext_mul   : narrow_zext_mul_before  ⊑  narrow_zext_mul_combined := by
  unfold narrow_zext_mul_before narrow_zext_mul_combined
  simp_alive_peephole
  sorry
def narrow_sext_and_commute_combined := [llvmfunc|
  llvm.func @narrow_sext_and_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.and %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_sext_and_commute   : narrow_sext_and_commute_before  ⊑  narrow_sext_and_commute_combined := by
  unfold narrow_sext_and_commute_before narrow_sext_and_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_and_commute_combined := [llvmfunc|
  llvm.func @narrow_zext_and_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.and %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_zext_and_commute   : narrow_zext_and_commute_before  ⊑  narrow_zext_and_commute_combined := by
  unfold narrow_zext_and_commute_before narrow_zext_and_commute_combined
  simp_alive_peephole
  sorry
def narrow_sext_or_commute_combined := [llvmfunc|
  llvm.func @narrow_sext_or_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.or %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_sext_or_commute   : narrow_sext_or_commute_before  ⊑  narrow_sext_or_commute_combined := by
  unfold narrow_sext_or_commute_before narrow_sext_or_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_or_commute_combined := [llvmfunc|
  llvm.func @narrow_zext_or_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.or %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_zext_or_commute   : narrow_zext_or_commute_before  ⊑  narrow_zext_or_commute_combined := by
  unfold narrow_zext_or_commute_before narrow_zext_or_commute_combined
  simp_alive_peephole
  sorry
def narrow_sext_xor_commute_combined := [llvmfunc|
  llvm.func @narrow_sext_xor_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.xor %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_sext_xor_commute   : narrow_sext_xor_commute_before  ⊑  narrow_sext_xor_commute_combined := by
  unfold narrow_sext_xor_commute_before narrow_sext_xor_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_xor_commute_combined := [llvmfunc|
  llvm.func @narrow_zext_xor_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.xor %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_zext_xor_commute   : narrow_zext_xor_commute_before  ⊑  narrow_zext_xor_commute_combined := by
  unfold narrow_zext_xor_commute_before narrow_zext_xor_commute_combined
  simp_alive_peephole
  sorry
def narrow_sext_add_commute_combined := [llvmfunc|
  llvm.func @narrow_sext_add_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.add %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_sext_add_commute   : narrow_sext_add_commute_before  ⊑  narrow_sext_add_commute_combined := by
  unfold narrow_sext_add_commute_before narrow_sext_add_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_add_commute_combined := [llvmfunc|
  llvm.func @narrow_zext_add_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.add %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_zext_add_commute   : narrow_zext_add_commute_before  ⊑  narrow_zext_add_commute_combined := by
  unfold narrow_zext_add_commute_before narrow_zext_add_commute_combined
  simp_alive_peephole
  sorry
def narrow_sext_sub_commute_combined := [llvmfunc|
  llvm.func @narrow_sext_sub_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.sub %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_sext_sub_commute   : narrow_sext_sub_commute_before  ⊑  narrow_sext_sub_commute_combined := by
  unfold narrow_sext_sub_commute_before narrow_sext_sub_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_sub_commute_combined := [llvmfunc|
  llvm.func @narrow_zext_sub_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.sub %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_zext_sub_commute   : narrow_zext_sub_commute_before  ⊑  narrow_zext_sub_commute_combined := by
  unfold narrow_zext_sub_commute_before narrow_zext_sub_commute_combined
  simp_alive_peephole
  sorry
def narrow_sext_mul_commute_combined := [llvmfunc|
  llvm.func @narrow_sext_mul_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.mul %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_sext_mul_commute   : narrow_sext_mul_commute_before  ⊑  narrow_sext_mul_commute_combined := by
  unfold narrow_sext_mul_commute_before narrow_sext_mul_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_mul_commute_combined := [llvmfunc|
  llvm.func @narrow_zext_mul_commute(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[7, -17]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg1, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    %3 = llvm.mul %2, %arg0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_narrow_zext_mul_commute   : narrow_zext_mul_commute_before  ⊑  narrow_zext_mul_commute_combined := by
  unfold narrow_zext_mul_commute_before narrow_zext_mul_commute_combined
  simp_alive_peephole
  sorry
def narrow_zext_ashr_keep_trunc_combined := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.sext %arg1 : i8 to i16
    %3 = llvm.add %1, %2 overflow<nsw>  : i16
    %4 = llvm.lshr %3, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    llvm.return %5 : i8
  }]

theorem inst_combine_narrow_zext_ashr_keep_trunc   : narrow_zext_ashr_keep_trunc_before  ⊑  narrow_zext_ashr_keep_trunc_combined := by
  unfold narrow_zext_ashr_keep_trunc_before narrow_zext_ashr_keep_trunc_combined
  simp_alive_peephole
  sorry
def narrow_zext_ashr_keep_trunc2_combined := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc2(%arg0: i9, %arg1: i9) -> i8 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.zext %arg0 : i9 to i16
    %2 = llvm.zext %arg1 : i9 to i16
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i16
    %4 = llvm.lshr %3, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    llvm.return %5 : i8
  }]

theorem inst_combine_narrow_zext_ashr_keep_trunc2   : narrow_zext_ashr_keep_trunc2_before  ⊑  narrow_zext_ashr_keep_trunc2_combined := by
  unfold narrow_zext_ashr_keep_trunc2_before narrow_zext_ashr_keep_trunc2_combined
  simp_alive_peephole
  sorry
def narrow_zext_ashr_keep_trunc3_combined := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc3(%arg0: i8, %arg1: i8) -> i7 {
    %0 = llvm.mlir.constant(1 : i14) : i14
    %1 = llvm.zext %arg0 : i8 to i14
    %2 = llvm.zext %arg1 : i8 to i14
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i14
    %4 = llvm.lshr %3, %0  : i14
    %5 = llvm.trunc %4 : i14 to i7
    llvm.return %5 : i7
  }]

theorem inst_combine_narrow_zext_ashr_keep_trunc3   : narrow_zext_ashr_keep_trunc3_before  ⊑  narrow_zext_ashr_keep_trunc3_combined := by
  unfold narrow_zext_ashr_keep_trunc3_before narrow_zext_ashr_keep_trunc3_combined
  simp_alive_peephole
  sorry
def narrow_zext_ashr_keep_trunc_vector_combined := [llvmfunc|
  llvm.func @narrow_zext_ashr_keep_trunc_vector(%arg0: vector<8xi8>, %arg1: vector<8xi8>) -> vector<8xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.sext %arg0 : vector<8xi8> to vector<8xi32>
    %2 = llvm.sext %arg1 : vector<8xi8> to vector<8xi32>
    %3 = llvm.add %1, %2 overflow<nsw>  : vector<8xi32>
    %4 = llvm.lshr %3, %0  : vector<8xi32>
    %5 = llvm.trunc %4 : vector<8xi32> to vector<8xi8>
    llvm.return %5 : vector<8xi8>
  }]

theorem inst_combine_narrow_zext_ashr_keep_trunc_vector   : narrow_zext_ashr_keep_trunc_vector_before  ⊑  narrow_zext_ashr_keep_trunc_vector_combined := by
  unfold narrow_zext_ashr_keep_trunc_vector_before narrow_zext_ashr_keep_trunc_vector_combined
  simp_alive_peephole
  sorry
def dont_narrow_zext_ashr_keep_trunc_combined := [llvmfunc|
  llvm.func @dont_narrow_zext_ashr_keep_trunc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.sext %arg1 : i8 to i16
    %3 = llvm.add %1, %2 overflow<nsw>  : i16
    %4 = llvm.lshr %3, %0  : i16
    %5 = llvm.trunc %4 : i16 to i8
    llvm.return %5 : i8
  }]

theorem inst_combine_dont_narrow_zext_ashr_keep_trunc   : dont_narrow_zext_ashr_keep_trunc_before  ⊑  dont_narrow_zext_ashr_keep_trunc_combined := by
  unfold dont_narrow_zext_ashr_keep_trunc_before dont_narrow_zext_ashr_keep_trunc_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-xor-signbit
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def slt_to_ult_before := [llvmfunc|
  llvm.func @slt_to_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "slt" %1, %2 : i8
    llvm.return %3 : i1
  }]

def slt_to_ult_splat_before := [llvmfunc|
  llvm.func @slt_to_ult_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def ult_to_slt_before := [llvmfunc|
  llvm.func @ult_to_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    llvm.return %3 : i1
  }]

def ult_to_slt_splat_before := [llvmfunc|
  llvm.func @ult_to_slt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def slt_to_ugt_before := [llvmfunc|
  llvm.func @slt_to_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "slt" %1, %2 : i8
    llvm.return %3 : i1
  }]

def slt_to_ugt_splat_before := [llvmfunc|
  llvm.func @slt_to_ugt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def ult_to_sgt_before := [llvmfunc|
  llvm.func @ult_to_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    llvm.return %3 : i1
  }]

def ult_to_sgt_splat_before := [llvmfunc|
  llvm.func @ult_to_sgt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def sge_to_ugt_before := [llvmfunc|
  llvm.func @sge_to_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sge_to_ugt_splat_before := [llvmfunc|
  llvm.func @sge_to_ugt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def uge_to_sgt_before := [llvmfunc|
  llvm.func @uge_to_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def uge_to_sgt_splat_before := [llvmfunc|
  llvm.func @uge_to_sgt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def sge_to_ult_before := [llvmfunc|
  llvm.func @sge_to_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sge_to_ult_splat_before := [llvmfunc|
  llvm.func @sge_to_ult_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def uge_to_slt_before := [llvmfunc|
  llvm.func @uge_to_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def uge_to_slt_splat_before := [llvmfunc|
  llvm.func @uge_to_slt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def sgt_to_ugt_bitcasted_splat_before := [llvmfunc|
  llvm.func @sgt_to_ugt_bitcasted_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(dense<-2139062144> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.bitcast %1 : vector<2xi32> to vector<8xi8>
    %4 = llvm.bitcast %2 : vector<2xi32> to vector<8xi8>
    %5 = llvm.icmp "sgt" %3, %4 : vector<8xi8>
    llvm.return %5 : vector<8xi1>
  }]

def negative_simplify_splat_before := [llvmfunc|
  llvm.func @negative_simplify_splat(%arg0: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, -128, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.or %arg0, %0  : vector<4xi8>
    %4 = llvm.bitcast %3 : vector<4xi8> to vector<2xi16>
    %5 = llvm.icmp "sgt" %4, %2 : vector<2xi16>
    llvm.return %5 : vector<2xi1>
  }]

def slt_zero_eq_i1_before := [llvmfunc|
  llvm.func @slt_zero_eq_i1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_eq_i1_fail_before := [llvmfunc|
  llvm.func @slt_zero_eq_i1_fail(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_eq_ne_0_before := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %3, %4 : i32
    llvm.return %5 : i1
  }]

def slt_zero_ne_ne_0_before := [llvmfunc|
  llvm.func @slt_zero_ne_ne_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "ne" %3, %4 : i32
    llvm.return %5 : i1
  }]

def slt_zero_eq_ne_0_vec_before := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0_vec(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<4xi32>
    %4 = llvm.zext %3 : vector<4xi1> to vector<4xi32>
    %5 = llvm.lshr %arg0, %2  : vector<4xi32>
    %6 = llvm.icmp "eq" %4, %5 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }]

def slt_zero_ne_ne_b_before := [llvmfunc|
  llvm.func @slt_zero_ne_ne_b(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.icmp "ne" %2, %3 : i32
    llvm.return %4 : i1
  }]

def slt_zero_eq_ne_0_fail1_before := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0_fail1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %3, %4 : i32
    llvm.return %5 : i1
  }]

def slt_zero_eq_ne_0_fail2_before := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0_fail2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %3, %4 : i32
    llvm.return %5 : i1
  }]

def slt_to_ult_combined := [llvmfunc|
  llvm.func @slt_to_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_to_ult   : slt_to_ult_before  ⊑  slt_to_ult_combined := by
  unfold slt_to_ult_before slt_to_ult_combined
  simp_alive_peephole
  sorry
def slt_to_ult_splat_combined := [llvmfunc|
  llvm.func @slt_to_ult_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_slt_to_ult_splat   : slt_to_ult_splat_before  ⊑  slt_to_ult_splat_combined := by
  unfold slt_to_ult_splat_before slt_to_ult_splat_combined
  simp_alive_peephole
  sorry
def ult_to_slt_combined := [llvmfunc|
  llvm.func @ult_to_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_to_slt   : ult_to_slt_before  ⊑  ult_to_slt_combined := by
  unfold ult_to_slt_before ult_to_slt_combined
  simp_alive_peephole
  sorry
def ult_to_slt_splat_combined := [llvmfunc|
  llvm.func @ult_to_slt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_ult_to_slt_splat   : ult_to_slt_splat_before  ⊑  ult_to_slt_splat_combined := by
  unfold ult_to_slt_splat_before ult_to_slt_splat_combined
  simp_alive_peephole
  sorry
def slt_to_ugt_combined := [llvmfunc|
  llvm.func @slt_to_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_to_ugt   : slt_to_ugt_before  ⊑  slt_to_ugt_combined := by
  unfold slt_to_ugt_before slt_to_ugt_combined
  simp_alive_peephole
  sorry
def slt_to_ugt_splat_combined := [llvmfunc|
  llvm.func @slt_to_ugt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_slt_to_ugt_splat   : slt_to_ugt_splat_before  ⊑  slt_to_ugt_splat_combined := by
  unfold slt_to_ugt_splat_before slt_to_ugt_splat_combined
  simp_alive_peephole
  sorry
def ult_to_sgt_combined := [llvmfunc|
  llvm.func @ult_to_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_to_sgt   : ult_to_sgt_before  ⊑  ult_to_sgt_combined := by
  unfold ult_to_sgt_before ult_to_sgt_combined
  simp_alive_peephole
  sorry
def ult_to_sgt_splat_combined := [llvmfunc|
  llvm.func @ult_to_sgt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_ult_to_sgt_splat   : ult_to_sgt_splat_before  ⊑  ult_to_sgt_splat_combined := by
  unfold ult_to_sgt_splat_before ult_to_sgt_splat_combined
  simp_alive_peephole
  sorry
def sge_to_ugt_combined := [llvmfunc|
  llvm.func @sge_to_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-114 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_to_ugt   : sge_to_ugt_before  ⊑  sge_to_ugt_combined := by
  unfold sge_to_ugt_before sge_to_ugt_combined
  simp_alive_peephole
  sorry
def sge_to_ugt_splat_combined := [llvmfunc|
  llvm.func @sge_to_ugt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-114> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sge_to_ugt_splat   : sge_to_ugt_splat_before  ⊑  sge_to_ugt_splat_combined := by
  unfold sge_to_ugt_splat_before sge_to_ugt_splat_combined
  simp_alive_peephole
  sorry
def uge_to_sgt_combined := [llvmfunc|
  llvm.func @uge_to_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-114 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_to_sgt   : uge_to_sgt_before  ⊑  uge_to_sgt_combined := by
  unfold uge_to_sgt_before uge_to_sgt_combined
  simp_alive_peephole
  sorry
def uge_to_sgt_splat_combined := [llvmfunc|
  llvm.func @uge_to_sgt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-114> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_uge_to_sgt_splat   : uge_to_sgt_splat_before  ⊑  uge_to_sgt_splat_combined := by
  unfold uge_to_sgt_splat_before uge_to_sgt_splat_combined
  simp_alive_peephole
  sorry
def sge_to_ult_combined := [llvmfunc|
  llvm.func @sge_to_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(113 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_to_ult   : sge_to_ult_before  ⊑  sge_to_ult_combined := by
  unfold sge_to_ult_before sge_to_ult_combined
  simp_alive_peephole
  sorry
def sge_to_ult_splat_combined := [llvmfunc|
  llvm.func @sge_to_ult_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<113> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sge_to_ult_splat   : sge_to_ult_splat_before  ⊑  sge_to_ult_splat_combined := by
  unfold sge_to_ult_splat_before sge_to_ult_splat_combined
  simp_alive_peephole
  sorry
def uge_to_slt_combined := [llvmfunc|
  llvm.func @uge_to_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(113 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_to_slt   : uge_to_slt_before  ⊑  uge_to_slt_combined := by
  unfold uge_to_slt_before uge_to_slt_combined
  simp_alive_peephole
  sorry
def uge_to_slt_splat_combined := [llvmfunc|
  llvm.func @uge_to_slt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<113> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_uge_to_slt_splat   : uge_to_slt_splat_before  ⊑  uge_to_slt_splat_combined := by
  unfold uge_to_slt_splat_before uge_to_slt_splat_combined
  simp_alive_peephole
  sorry
def sgt_to_ugt_bitcasted_splat_combined := [llvmfunc|
  llvm.func @sgt_to_ugt_bitcasted_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<8xi1> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<8xi8>
    %1 = llvm.bitcast %arg1 : vector<2xi32> to vector<8xi8>
    %2 = llvm.icmp "ugt" %0, %1 : vector<8xi8>
    llvm.return %2 : vector<8xi1>
  }]

theorem inst_combine_sgt_to_ugt_bitcasted_splat   : sgt_to_ugt_bitcasted_splat_before  ⊑  sgt_to_ugt_bitcasted_splat_combined := by
  unfold sgt_to_ugt_bitcasted_splat_before sgt_to_ugt_bitcasted_splat_combined
  simp_alive_peephole
  sorry
def negative_simplify_splat_combined := [llvmfunc|
  llvm.func @negative_simplify_splat(%arg0: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_negative_simplify_splat   : negative_simplify_splat_before  ⊑  negative_simplify_splat_combined := by
  unfold negative_simplify_splat_before negative_simplify_splat_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_i1_combined := [llvmfunc|
  llvm.func @slt_zero_eq_i1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.xor %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_slt_zero_eq_i1   : slt_zero_eq_i1_before  ⊑  slt_zero_eq_i1_combined := by
  unfold slt_zero_eq_i1_before slt_zero_eq_i1_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_i1_fail_combined := [llvmfunc|
  llvm.func @slt_zero_eq_i1_fail(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_zero_eq_i1_fail   : slt_zero_eq_i1_fail_before  ⊑  slt_zero_eq_i1_fail_combined := by
  unfold slt_zero_eq_i1_fail_before slt_zero_eq_i1_fail_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_ne_0_combined := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_zero_eq_ne_0   : slt_zero_eq_ne_0_before  ⊑  slt_zero_eq_ne_0_combined := by
  unfold slt_zero_eq_ne_0_before slt_zero_eq_ne_0_combined
  simp_alive_peephole
  sorry
def slt_zero_ne_ne_0_combined := [llvmfunc|
  llvm.func @slt_zero_ne_ne_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_zero_ne_ne_0   : slt_zero_ne_ne_0_before  ⊑  slt_zero_ne_ne_0_combined := by
  unfold slt_zero_ne_ne_0_before slt_zero_ne_ne_0_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_ne_0_vec_combined := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0_vec(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<4xi32>
    llvm.return %1 : vector<4xi1>
  }]

theorem inst_combine_slt_zero_eq_ne_0_vec   : slt_zero_eq_ne_0_vec_before  ⊑  slt_zero_eq_ne_0_vec_combined := by
  unfold slt_zero_eq_ne_0_vec_before slt_zero_eq_ne_0_vec_combined
  simp_alive_peephole
  sorry
def slt_zero_ne_ne_b_combined := [llvmfunc|
  llvm.func @slt_zero_ne_ne_b(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_zero_ne_ne_b   : slt_zero_ne_ne_b_before  ⊑  slt_zero_ne_ne_b_combined := by
  unfold slt_zero_ne_ne_b_before slt_zero_ne_ne_b_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_ne_0_fail1_combined := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0_fail1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_slt_zero_eq_ne_0_fail1   : slt_zero_eq_ne_0_fail1_before  ⊑  slt_zero_eq_ne_0_fail1_combined := by
  unfold slt_zero_eq_ne_0_fail1_before slt_zero_eq_ne_0_fail1_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_ne_0_fail2_combined := [llvmfunc|
  llvm.func @slt_zero_eq_ne_0_fail2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_slt_zero_eq_ne_0_fail2   : slt_zero_eq_ne_0_fail2_before  ⊑  slt_zero_eq_ne_0_fail2_combined := by
  unfold slt_zero_eq_ne_0_fail2_before slt_zero_eq_ne_0_fail2_combined
  simp_alive_peephole
  sorry

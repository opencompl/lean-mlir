import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  get-lowbitmask-upto-and-including-bit
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.shl %0, %arg0  : i16
    %3 = llvm.add %2, %1  : i16
    %4 = llvm.or %3, %2  : i16
    llvm.return %4 : i16
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def t3_vec_poison0_before := [llvmfunc|
  llvm.func @t3_vec_poison0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %8, %arg0  : vector<3xi8>
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.or %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def t4_vec_poison1_before := [llvmfunc|
  llvm.func @t4_vec_poison1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %0, %arg0  : vector<3xi8>
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.or %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def t5_vec_poison2_before := [llvmfunc|
  llvm.func @t5_vec_poison2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(-1 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.shl %8, %arg0  : vector<3xi8>
    %18 = llvm.add %17, %16  : vector<3xi8>
    %19 = llvm.or %18, %17  : vector<3xi8>
    llvm.return %19 : vector<3xi8>
  }]

def t6_extrause0_before := [llvmfunc|
  llvm.func @t6_extrause0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def t7_extrause1_before := [llvmfunc|
  llvm.func @t7_extrause1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def t8_extrause2_before := [llvmfunc|
  llvm.func @t8_extrause2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

def t9_nocse_before := [llvmfunc|
  llvm.func @t9_nocse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t10_nocse_extrause0_before := [llvmfunc|
  llvm.func @t10_nocse_extrause0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t11_nocse_extrause1_before := [llvmfunc|
  llvm.func @t11_nocse_extrause1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t12_nocse_extrause2_before := [llvmfunc|
  llvm.func @t12_nocse_extrause2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t13_nocse_extrause3_before := [llvmfunc|
  llvm.func @t13_nocse_extrause3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t14_nocse_extrause4_before := [llvmfunc|
  llvm.func @t14_nocse_extrause4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t15_nocse_extrause5_before := [llvmfunc|
  llvm.func @t15_nocse_extrause5(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t16_nocse_extrause6_before := [llvmfunc|
  llvm.func @t16_nocse_extrause6(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t17_nocse_mismatching_x_before := [llvmfunc|
  llvm.func @t17_nocse_mismatching_x(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg1  : i8
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.lshr %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i16
    %3 = llvm.lshr %1, %2  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %0, %arg0  : vector<2xi8>
    %3 = llvm.lshr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def t3_vec_poison0_combined := [llvmfunc|
  llvm.func @t3_vec_poison0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sub %0, %arg0  : vector<3xi8>
    %3 = llvm.lshr %1, %2  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_t3_vec_poison0   : t3_vec_poison0_before  ⊑  t3_vec_poison0_combined := by
  unfold t3_vec_poison0_before t3_vec_poison0_combined
  simp_alive_peephole
  sorry
def t4_vec_poison1_combined := [llvmfunc|
  llvm.func @t4_vec_poison1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sub %0, %arg0  : vector<3xi8>
    %3 = llvm.lshr %1, %2  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_t4_vec_poison1   : t4_vec_poison1_before  ⊑  t4_vec_poison1_combined := by
  unfold t4_vec_poison1_before t4_vec_poison1_combined
  simp_alive_peephole
  sorry
def t5_vec_poison2_combined := [llvmfunc|
  llvm.func @t5_vec_poison2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.sub %0, %arg0  : vector<3xi8>
    %3 = llvm.lshr %1, %2  : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_t5_vec_poison2   : t5_vec_poison2_before  ⊑  t5_vec_poison2_combined := by
  unfold t5_vec_poison2_before t5_vec_poison2_combined
  simp_alive_peephole
  sorry
def t6_extrause0_combined := [llvmfunc|
  llvm.func @t6_extrause0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %arg0  : i8
    %5 = llvm.lshr %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t6_extrause0   : t6_extrause0_before  ⊑  t6_extrause0_combined := by
  unfold t6_extrause0_before t6_extrause0_combined
  simp_alive_peephole
  sorry
def t7_extrause1_combined := [llvmfunc|
  llvm.func @t7_extrause1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t7_extrause1   : t7_extrause1_before  ⊑  t7_extrause1_combined := by
  unfold t7_extrause1_before t7_extrause1_combined
  simp_alive_peephole
  sorry
def t8_extrause2_combined := [llvmfunc|
  llvm.func @t8_extrause2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t8_extrause2   : t8_extrause2_before  ⊑  t8_extrause2_combined := by
  unfold t8_extrause2_before t8_extrause2_combined
  simp_alive_peephole
  sorry
def t9_nocse_combined := [llvmfunc|
  llvm.func @t9_nocse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %3 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t9_nocse   : t9_nocse_before  ⊑  t9_nocse_combined := by
  unfold t9_nocse_before t9_nocse_combined
  simp_alive_peephole
  sorry
def t10_nocse_extrause0_combined := [llvmfunc|
  llvm.func @t10_nocse_extrause0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %arg0  : i8
    %5 = llvm.lshr %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t10_nocse_extrause0   : t10_nocse_extrause0_before  ⊑  t10_nocse_extrause0_combined := by
  unfold t10_nocse_extrause0_before t10_nocse_extrause0_combined
  simp_alive_peephole
  sorry
def t11_nocse_extrause1_combined := [llvmfunc|
  llvm.func @t11_nocse_extrause1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t11_nocse_extrause1   : t11_nocse_extrause1_before  ⊑  t11_nocse_extrause1_combined := by
  unfold t11_nocse_extrause1_before t11_nocse_extrause1_combined
  simp_alive_peephole
  sorry
def t12_nocse_extrause2_combined := [llvmfunc|
  llvm.func @t12_nocse_extrause2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %3 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t12_nocse_extrause2   : t12_nocse_extrause2_before  ⊑  t12_nocse_extrause2_combined := by
  unfold t12_nocse_extrause2_before t12_nocse_extrause2_combined
  simp_alive_peephole
  sorry
def t13_nocse_extrause3_combined := [llvmfunc|
  llvm.func @t13_nocse_extrause3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sub %1, %arg0  : i8
    %6 = llvm.lshr %2, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_t13_nocse_extrause3   : t13_nocse_extrause3_before  ⊑  t13_nocse_extrause3_combined := by
  unfold t13_nocse_extrause3_before t13_nocse_extrause3_combined
  simp_alive_peephole
  sorry
def t14_nocse_extrause4_combined := [llvmfunc|
  llvm.func @t14_nocse_extrause4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %3, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sub %2, %arg0  : i8
    %6 = llvm.lshr %1, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_t14_nocse_extrause4   : t14_nocse_extrause4_before  ⊑  t14_nocse_extrause4_combined := by
  unfold t14_nocse_extrause4_before t14_nocse_extrause4_combined
  simp_alive_peephole
  sorry
def t15_nocse_extrause5_combined := [llvmfunc|
  llvm.func @t15_nocse_extrause5(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t15_nocse_extrause5   : t15_nocse_extrause5_before  ⊑  t15_nocse_extrause5_combined := by
  unfold t15_nocse_extrause5_before t15_nocse_extrause5_combined
  simp_alive_peephole
  sorry
def t16_nocse_extrause6_combined := [llvmfunc|
  llvm.func @t16_nocse_extrause6(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %2, %1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.or %4, %3  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t16_nocse_extrause6   : t16_nocse_extrause6_before  ⊑  t16_nocse_extrause6_combined := by
  unfold t16_nocse_extrause6_before t16_nocse_extrause6_combined
  simp_alive_peephole
  sorry
def t17_nocse_mismatching_x_combined := [llvmfunc|
  llvm.func @t17_nocse_mismatching_x(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %3 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t17_nocse_mismatching_x   : t17_nocse_mismatching_x_before  ⊑  t17_nocse_mismatching_x_combined := by
  unfold t17_nocse_mismatching_x_before t17_nocse_mismatching_x_combined
  simp_alive_peephole
  sorry

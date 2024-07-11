import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  masked-merge-and-of-ors
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p_before := [llvmfunc|
  llvm.func @p(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def p_splatvec_before := [llvmfunc|
  llvm.func @p_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg2, %0  : vector<2xi32>
    %2 = llvm.or %1, %arg0  : vector<2xi32>
    %3 = llvm.or %arg1, %arg2  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_vec_undef_before := [llvmfunc|
  llvm.func @p_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.xor %arg2, %8  : vector<3xi32>
    %10 = llvm.or %9, %arg0  : vector<3xi32>
    %11 = llvm.or %arg1, %arg2  : vector<3xi32>
    %12 = llvm.and %10, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

def p_constmask_before := [llvmfunc|
  llvm.func @p_constmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def p_constmask_splatvec_before := [llvmfunc|
  llvm.func @p_constmask_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.or %arg1, %1  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_constmask_vec_before := [llvmfunc|
  llvm.func @p_constmask_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65280, 16776960]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.or %arg1, %1  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_constmask_vec_undef_before := [llvmfunc|
  llvm.func @p_constmask_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(65280 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.or %arg0, %8  : vector<3xi32>
    %18 = llvm.or %arg1, %16  : vector<3xi32>
    %19 = llvm.and %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }]

def p_commutative0_before := [llvmfunc|
  llvm.func @p_commutative0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def p_commutative1_before := [llvmfunc|
  llvm.func @p_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

def p_commutative2_before := [llvmfunc|
  llvm.func @p_commutative2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def p_commutative3_before := [llvmfunc|
  llvm.func @p_commutative3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

def p_commutative4_before := [llvmfunc|
  llvm.func @p_commutative4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def p_commutative5_before := [llvmfunc|
  llvm.func @p_commutative5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def p_commutative6_before := [llvmfunc|
  llvm.func @p_commutative6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def p_constmask_commutative_before := [llvmfunc|
  llvm.func @p_constmask_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

def n0_oneuse_of_neg_is_ok_0_before := [llvmfunc|
  llvm.func @n0_oneuse_of_neg_is_ok_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_oneuse_1_before := [llvmfunc|
  llvm.func @n0_oneuse_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_oneuse_2_before := [llvmfunc|
  llvm.func @n0_oneuse_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_oneuse_3_before := [llvmfunc|
  llvm.func @n0_oneuse_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_oneuse_4_before := [llvmfunc|
  llvm.func @n0_oneuse_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_oneuse_5_before := [llvmfunc|
  llvm.func @n0_oneuse_5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_oneuse_6_before := [llvmfunc|
  llvm.func @n0_oneuse_6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_constmask_oneuse_0_before := [llvmfunc|
  llvm.func @n0_constmask_oneuse_0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_constmask_oneuse_1_before := [llvmfunc|
  llvm.func @n0_constmask_oneuse_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_constmask_oneuse_2_before := [llvmfunc|
  llvm.func @n0_constmask_oneuse_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n1_badxor_before := [llvmfunc|
  llvm.func @n1_badxor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def n2_badmask_before := [llvmfunc|
  llvm.func @n2_badmask(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg3, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg2, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def n3_constmask_badmask_set_before := [llvmfunc|
  llvm.func @n3_constmask_badmask_set(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65281 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def n3_constmask_badmask_unset_before := [llvmfunc|
  llvm.func @n3_constmask_badmask_unset(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65024 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def n3_constmask_samemask_before := [llvmfunc|
  llvm.func @n3_constmask_samemask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

def p_combined := [llvmfunc|
  llvm.func @p(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p   : p_before  ⊑  p_combined := by
  unfold p_before p_combined
  simp_alive_peephole
  sorry
def p_splatvec_combined := [llvmfunc|
  llvm.func @p_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg2, %0  : vector<2xi32>
    %2 = llvm.or %1, %arg0  : vector<2xi32>
    %3 = llvm.or %arg1, %arg2  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_splatvec   : p_splatvec_before  ⊑  p_splatvec_combined := by
  unfold p_splatvec_before p_splatvec_combined
  simp_alive_peephole
  sorry
def p_vec_undef_combined := [llvmfunc|
  llvm.func @p_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.xor %arg2, %8  : vector<3xi32>
    %10 = llvm.or %9, %arg0  : vector<3xi32>
    %11 = llvm.or %arg1, %arg2  : vector<3xi32>
    %12 = llvm.and %10, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

theorem inst_combine_p_vec_undef   : p_vec_undef_before  ⊑  p_vec_undef_combined := by
  unfold p_vec_undef_before p_vec_undef_combined
  simp_alive_peephole
  sorry
def p_constmask_combined := [llvmfunc|
  llvm.func @p_constmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_constmask   : p_constmask_before  ⊑  p_constmask_combined := by
  unfold p_constmask_before p_constmask_combined
  simp_alive_peephole
  sorry
def p_constmask_splatvec_combined := [llvmfunc|
  llvm.func @p_constmask_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.or %arg1, %1  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_constmask_splatvec   : p_constmask_splatvec_before  ⊑  p_constmask_splatvec_combined := by
  unfold p_constmask_splatvec_before p_constmask_splatvec_combined
  simp_alive_peephole
  sorry
def p_constmask_vec_combined := [llvmfunc|
  llvm.func @p_constmask_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65280, 16776960]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.or %arg1, %1  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_constmask_vec   : p_constmask_vec_before  ⊑  p_constmask_vec_combined := by
  unfold p_constmask_vec_before p_constmask_vec_combined
  simp_alive_peephole
  sorry
def p_constmask_vec_undef_combined := [llvmfunc|
  llvm.func @p_constmask_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(65280 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.or %arg0, %8  : vector<3xi32>
    %18 = llvm.or %arg1, %16  : vector<3xi32>
    %19 = llvm.and %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }]

theorem inst_combine_p_constmask_vec_undef   : p_constmask_vec_undef_before  ⊑  p_constmask_vec_undef_combined := by
  unfold p_constmask_vec_undef_before p_constmask_vec_undef_combined
  simp_alive_peephole
  sorry
def p_commutative0_combined := [llvmfunc|
  llvm.func @p_commutative0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_commutative0   : p_commutative0_before  ⊑  p_commutative0_combined := by
  unfold p_commutative0_before p_commutative0_combined
  simp_alive_peephole
  sorry
def p_commutative1_combined := [llvmfunc|
  llvm.func @p_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %1, %arg1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative1   : p_commutative1_before  ⊑  p_commutative1_combined := by
  unfold p_commutative1_before p_commutative1_combined
  simp_alive_peephole
  sorry
def p_commutative2_combined := [llvmfunc|
  llvm.func @p_commutative2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_commutative2   : p_commutative2_before  ⊑  p_commutative2_combined := by
  unfold p_commutative2_before p_commutative2_combined
  simp_alive_peephole
  sorry
def p_commutative3_combined := [llvmfunc|
  llvm.func @p_commutative3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %1, %arg1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative3   : p_commutative3_before  ⊑  p_commutative3_combined := by
  unfold p_commutative3_before p_commutative3_combined
  simp_alive_peephole
  sorry
def p_commutative4_combined := [llvmfunc|
  llvm.func @p_commutative4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_commutative4   : p_commutative4_before  ⊑  p_commutative4_combined := by
  unfold p_commutative4_before p_commutative4_combined
  simp_alive_peephole
  sorry
def p_commutative5_combined := [llvmfunc|
  llvm.func @p_commutative5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %1, %arg1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative5   : p_commutative5_before  ⊑  p_commutative5_combined := by
  unfold p_commutative5_before p_commutative5_combined
  simp_alive_peephole
  sorry
def p_commutative6_combined := [llvmfunc|
  llvm.func @p_commutative6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.or %1, %arg1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative6   : p_commutative6_before  ⊑  p_commutative6_combined := by
  unfold p_commutative6_before p_commutative6_combined
  simp_alive_peephole
  sorry
def p_constmask_commutative_combined := [llvmfunc|
  llvm.func @p_constmask_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_constmask_commutative   : p_constmask_commutative_before  ⊑  p_constmask_commutative_combined := by
  unfold p_constmask_commutative_before p_constmask_commutative_combined
  simp_alive_peephole
  sorry
def n0_oneuse_of_neg_is_ok_0_combined := [llvmfunc|
  llvm.func @n0_oneuse_of_neg_is_ok_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_of_neg_is_ok_0   : n0_oneuse_of_neg_is_ok_0_before  ⊑  n0_oneuse_of_neg_is_ok_0_combined := by
  unfold n0_oneuse_of_neg_is_ok_0_before n0_oneuse_of_neg_is_ok_0_combined
  simp_alive_peephole
  sorry
def n0_oneuse_1_combined := [llvmfunc|
  llvm.func @n0_oneuse_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_1   : n0_oneuse_1_before  ⊑  n0_oneuse_1_combined := by
  unfold n0_oneuse_1_before n0_oneuse_1_combined
  simp_alive_peephole
  sorry
def n0_oneuse_2_combined := [llvmfunc|
  llvm.func @n0_oneuse_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_2   : n0_oneuse_2_before  ⊑  n0_oneuse_2_combined := by
  unfold n0_oneuse_2_before n0_oneuse_2_combined
  simp_alive_peephole
  sorry
def n0_oneuse_3_combined := [llvmfunc|
  llvm.func @n0_oneuse_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_3   : n0_oneuse_3_before  ⊑  n0_oneuse_3_combined := by
  unfold n0_oneuse_3_before n0_oneuse_3_combined
  simp_alive_peephole
  sorry
def n0_oneuse_4_combined := [llvmfunc|
  llvm.func @n0_oneuse_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_4   : n0_oneuse_4_before  ⊑  n0_oneuse_4_combined := by
  unfold n0_oneuse_4_before n0_oneuse_4_combined
  simp_alive_peephole
  sorry
def n0_oneuse_5_combined := [llvmfunc|
  llvm.func @n0_oneuse_5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_5   : n0_oneuse_5_before  ⊑  n0_oneuse_5_combined := by
  unfold n0_oneuse_5_before n0_oneuse_5_combined
  simp_alive_peephole
  sorry
def n0_oneuse_6_combined := [llvmfunc|
  llvm.func @n0_oneuse_6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse_6   : n0_oneuse_6_before  ⊑  n0_oneuse_6_combined := by
  unfold n0_oneuse_6_before n0_oneuse_6_combined
  simp_alive_peephole
  sorry
def n0_constmask_oneuse_0_combined := [llvmfunc|
  llvm.func @n0_constmask_oneuse_0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_constmask_oneuse_0   : n0_constmask_oneuse_0_before  ⊑  n0_constmask_oneuse_0_combined := by
  unfold n0_constmask_oneuse_0_before n0_constmask_oneuse_0_combined
  simp_alive_peephole
  sorry
def n0_constmask_oneuse_1_combined := [llvmfunc|
  llvm.func @n0_constmask_oneuse_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_constmask_oneuse_1   : n0_constmask_oneuse_1_before  ⊑  n0_constmask_oneuse_1_combined := by
  unfold n0_constmask_oneuse_1_before n0_constmask_oneuse_1_combined
  simp_alive_peephole
  sorry
def n0_constmask_oneuse_2_combined := [llvmfunc|
  llvm.func @n0_constmask_oneuse_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65280 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_constmask_oneuse_2   : n0_constmask_oneuse_2_before  ⊑  n0_constmask_oneuse_2_combined := by
  unfold n0_constmask_oneuse_2_before n0_constmask_oneuse_2_combined
  simp_alive_peephole
  sorry
def n1_badxor_combined := [llvmfunc|
  llvm.func @n1_badxor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg1, %arg2  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n1_badxor   : n1_badxor_before  ⊑  n1_badxor_combined := by
  unfold n1_badxor_before n1_badxor_combined
  simp_alive_peephole
  sorry
def n2_badmask_combined := [llvmfunc|
  llvm.func @n2_badmask(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg3, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.or %arg2, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n2_badmask   : n2_badmask_before  ⊑  n2_badmask_combined := by
  unfold n2_badmask_before n2_badmask_combined
  simp_alive_peephole
  sorry
def n3_constmask_badmask_set_combined := [llvmfunc|
  llvm.func @n3_constmask_badmask_set(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65281 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n3_constmask_badmask_set   : n3_constmask_badmask_set_before  ⊑  n3_constmask_badmask_set_combined := by
  unfold n3_constmask_badmask_set_before n3_constmask_badmask_set_combined
  simp_alive_peephole
  sorry
def n3_constmask_badmask_unset_combined := [llvmfunc|
  llvm.func @n3_constmask_badmask_unset(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.mlir.constant(65024 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n3_constmask_badmask_unset   : n3_constmask_badmask_unset_before  ⊑  n3_constmask_badmask_unset_combined := by
  unfold n3_constmask_badmask_unset_before n3_constmask_badmask_unset_combined
  simp_alive_peephole
  sorry
def n3_constmask_samemask_combined := [llvmfunc|
  llvm.func @n3_constmask_samemask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-65281 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_n3_constmask_samemask   : n3_constmask_samemask_before  ⊑  n3_constmask_samemask_combined := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_combined
  simp_alive_peephole
  sorry

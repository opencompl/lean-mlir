import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  masked-merge-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p_before := [llvmfunc|
  llvm.func @p(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def p_splatvec_before := [llvmfunc|
  llvm.func @p_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %arg2  : vector<2xi32>
    %2 = llvm.xor %arg2, %0  : vector<2xi32>
    %3 = llvm.and %2, %arg1  : vector<2xi32>
    %4 = llvm.add %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_vec_undef_before := [llvmfunc|
  llvm.func @p_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32> {llvm.noundef}) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %arg2  : vector<3xi32>
    %10 = llvm.xor %arg2, %8  : vector<3xi32>
    %11 = llvm.and %10, %arg1  : vector<3xi32>
    %12 = llvm.add %9, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

def p_vec_poison_before := [llvmfunc|
  llvm.func @p_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32> {llvm.noundef}) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %arg2  : vector<3xi32>
    %10 = llvm.xor %arg2, %8  : vector<3xi32>
    %11 = llvm.and %10, %arg1  : vector<3xi32>
    %12 = llvm.add %9, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

def p_constmask_before := [llvmfunc|
  llvm.func @p_constmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def p_constmask_splatvec_before := [llvmfunc|
  llvm.func @p_constmask_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_constmask_vec_before := [llvmfunc|
  llvm.func @p_constmask_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65280, 16776960]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_constmask_vec_undef_before := [llvmfunc|
  llvm.func @p_constmask_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-65281 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.and %arg1, %16  : vector<3xi32>
    %19 = llvm.add %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }]

def p_constmask2_before := [llvmfunc|
  llvm.func @p_constmask2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(61440 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def p_constmask2_splatvec_before := [llvmfunc|
  llvm.func @p_constmask2_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<61440> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_constmask2_vec_before := [llvmfunc|
  llvm.func @p_constmask2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[61440, 16711680]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def p_constmask2_vec_undef_before := [llvmfunc|
  llvm.func @p_constmask2_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(61440 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-65281 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.and %arg1, %16  : vector<3xi32>
    %19 = llvm.add %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }]

def p_commutative0_before := [llvmfunc|
  llvm.func @p_commutative0(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def p_commutative1_before := [llvmfunc|
  llvm.func @p_commutative1(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }]

def p_commutative2_before := [llvmfunc|
  llvm.func @p_commutative2(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def p_commutative3_before := [llvmfunc|
  llvm.func @p_commutative3(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }]

def p_commutative4_before := [llvmfunc|
  llvm.func @p_commutative4(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def p_commutative5_before := [llvmfunc|
  llvm.func @p_commutative5(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def p_commutative6_before := [llvmfunc|
  llvm.func @p_commutative6(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.add %4, %2  : i32
    llvm.return %5 : i32
  }]

def p_constmask_commutative_before := [llvmfunc|
  llvm.func @p_constmask_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def n0_oneuse_before := [llvmfunc|
  llvm.func @n0_oneuse(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n0_constmask_oneuse_before := [llvmfunc|
  llvm.func @n0_constmask_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def n1_badxor_before := [llvmfunc|
  llvm.func @n1_badxor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def n2_badmask_before := [llvmfunc|
  llvm.func @n2_badmask(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg3, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def n3_constmask_badmask_before := [llvmfunc|
  llvm.func @n3_constmask_badmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65280 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def n3_constmask_samemask_before := [llvmfunc|
  llvm.func @n3_constmask_samemask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }]

def p_combined := [llvmfunc|
  llvm.func @p(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p   : p_before  ⊑  p_combined := by
  unfold p_before p_combined
  simp_alive_peephole
  sorry
def p_splatvec_combined := [llvmfunc|
  llvm.func @p_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32> {llvm.noundef}) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %arg2  : vector<2xi32>
    %2 = llvm.xor %arg2, %0  : vector<2xi32>
    %3 = llvm.and %2, %arg1  : vector<2xi32>
    %4 = llvm.or %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_splatvec   : p_splatvec_before  ⊑  p_splatvec_combined := by
  unfold p_splatvec_before p_splatvec_combined
  simp_alive_peephole
  sorry
def p_vec_undef_combined := [llvmfunc|
  llvm.func @p_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32> {llvm.noundef}) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %arg2  : vector<3xi32>
    %10 = llvm.xor %arg2, %8  : vector<3xi32>
    %11 = llvm.and %10, %arg1  : vector<3xi32>
    %12 = llvm.or %9, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

theorem inst_combine_p_vec_undef   : p_vec_undef_before  ⊑  p_vec_undef_combined := by
  unfold p_vec_undef_before p_vec_undef_combined
  simp_alive_peephole
  sorry
def p_vec_poison_combined := [llvmfunc|
  llvm.func @p_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32> {llvm.noundef}) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.and %arg0, %arg2  : vector<3xi32>
    %10 = llvm.xor %arg2, %8  : vector<3xi32>
    %11 = llvm.and %10, %arg1  : vector<3xi32>
    %12 = llvm.or %9, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

theorem inst_combine_p_vec_poison   : p_vec_poison_before  ⊑  p_vec_poison_combined := by
  unfold p_vec_poison_before p_vec_poison_combined
  simp_alive_peephole
  sorry
def p_constmask_combined := [llvmfunc|
  llvm.func @p_constmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_constmask   : p_constmask_before  ⊑  p_constmask_combined := by
  unfold p_constmask_before p_constmask_combined
  simp_alive_peephole
  sorry
def p_constmask_splatvec_combined := [llvmfunc|
  llvm.func @p_constmask_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_constmask_splatvec   : p_constmask_splatvec_before  ⊑  p_constmask_splatvec_combined := by
  unfold p_constmask_splatvec_before p_constmask_splatvec_combined
  simp_alive_peephole
  sorry
def p_constmask_vec_combined := [llvmfunc|
  llvm.func @p_constmask_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65280, 16776960]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_constmask_vec   : p_constmask_vec_before  ⊑  p_constmask_vec_combined := by
  unfold p_constmask_vec_before p_constmask_vec_combined
  simp_alive_peephole
  sorry
def p_constmask_vec_undef_combined := [llvmfunc|
  llvm.func @p_constmask_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-65281 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.and %arg1, %16  : vector<3xi32>
    %19 = llvm.add %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }]

theorem inst_combine_p_constmask_vec_undef   : p_constmask_vec_undef_before  ⊑  p_constmask_vec_undef_combined := by
  unfold p_constmask_vec_undef_before p_constmask_vec_undef_combined
  simp_alive_peephole
  sorry
def p_constmask2_combined := [llvmfunc|
  llvm.func @p_constmask2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(61440 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_constmask2   : p_constmask2_before  ⊑  p_constmask2_combined := by
  unfold p_constmask2_before p_constmask2_combined
  simp_alive_peephole
  sorry
def p_constmask2_splatvec_combined := [llvmfunc|
  llvm.func @p_constmask2_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<61440> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-65281> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_constmask2_splatvec   : p_constmask2_splatvec_before  ⊑  p_constmask2_splatvec_combined := by
  unfold p_constmask2_splatvec_before p_constmask2_splatvec_combined
  simp_alive_peephole
  sorry
def p_constmask2_vec_combined := [llvmfunc|
  llvm.func @p_constmask2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[61440, 16711680]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-65281, -16776961]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.and %arg1, %1  : vector<2xi32>
    %4 = llvm.add %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_p_constmask2_vec   : p_constmask2_vec_before  ⊑  p_constmask2_vec_combined := by
  unfold p_constmask2_vec_before p_constmask2_vec_combined
  simp_alive_peephole
  sorry
def p_constmask2_vec_undef_combined := [llvmfunc|
  llvm.func @p_constmask2_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(61440 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-65281 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.and %arg1, %16  : vector<3xi32>
    %19 = llvm.add %17, %18  : vector<3xi32>
    llvm.return %19 : vector<3xi32>
  }]

theorem inst_combine_p_constmask2_vec_undef   : p_constmask2_vec_undef_before  ⊑  p_constmask2_vec_undef_combined := by
  unfold p_constmask2_vec_undef_before p_constmask2_vec_undef_combined
  simp_alive_peephole
  sorry
def p_commutative0_combined := [llvmfunc|
  llvm.func @p_commutative0(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_commutative0   : p_commutative0_before  ⊑  p_commutative0_combined := by
  unfold p_commutative0_before p_commutative0_combined
  simp_alive_peephole
  sorry
def p_commutative1_combined := [llvmfunc|
  llvm.func @p_commutative1(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative1   : p_commutative1_before  ⊑  p_commutative1_combined := by
  unfold p_commutative1_before p_commutative1_combined
  simp_alive_peephole
  sorry
def p_commutative2_combined := [llvmfunc|
  llvm.func @p_commutative2(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_commutative2   : p_commutative2_before  ⊑  p_commutative2_combined := by
  unfold p_commutative2_before p_commutative2_combined
  simp_alive_peephole
  sorry
def p_commutative3_combined := [llvmfunc|
  llvm.func @p_commutative3(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative3   : p_commutative3_before  ⊑  p_commutative3_combined := by
  unfold p_commutative3_before p_commutative3_combined
  simp_alive_peephole
  sorry
def p_commutative4_combined := [llvmfunc|
  llvm.func @p_commutative4(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_commutative4   : p_commutative4_before  ⊑  p_commutative4_combined := by
  unfold p_commutative4_before p_commutative4_combined
  simp_alive_peephole
  sorry
def p_commutative5_combined := [llvmfunc|
  llvm.func @p_commutative5(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative5   : p_commutative5_before  ⊑  p_commutative5_combined := by
  unfold p_commutative5_before p_commutative5_combined
  simp_alive_peephole
  sorry
def p_commutative6_combined := [llvmfunc|
  llvm.func @p_commutative6(%arg0: i32, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %arg1, %0  : i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_p_commutative6   : p_commutative6_before  ⊑  p_commutative6_combined := by
  unfold p_commutative6_before p_commutative6_combined
  simp_alive_peephole
  sorry
def p_constmask_commutative_combined := [llvmfunc|
  llvm.func @p_constmask_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_p_constmask_commutative   : p_constmask_commutative_before  ⊑  p_constmask_commutative_combined := by
  unfold p_constmask_commutative_before p_constmask_commutative_combined
  simp_alive_peephole
  sorry
def n0_oneuse_combined := [llvmfunc|
  llvm.func @n0_oneuse(%arg0: i32, %arg1: i32, %arg2: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_oneuse   : n0_oneuse_before  ⊑  n0_oneuse_combined := by
  unfold n0_oneuse_before n0_oneuse_combined
  simp_alive_peephole
  sorry
def n0_constmask_oneuse_combined := [llvmfunc|
  llvm.func @n0_constmask_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65281 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_n0_constmask_oneuse   : n0_constmask_oneuse_before  ⊑  n0_constmask_oneuse_combined := by
  unfold n0_constmask_oneuse_before n0_constmask_oneuse_combined
  simp_alive_peephole
  sorry
def n1_badxor_combined := [llvmfunc|
  llvm.func @n1_badxor(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n1_badxor   : n1_badxor_before  ⊑  n1_badxor_combined := by
  unfold n1_badxor_before n1_badxor_combined
  simp_alive_peephole
  sorry
def n2_badmask_combined := [llvmfunc|
  llvm.func @n2_badmask(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg2, %arg0  : i32
    %2 = llvm.xor %arg3, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n2_badmask   : n2_badmask_before  ⊑  n2_badmask_combined := by
  unfold n2_badmask_before n2_badmask_combined
  simp_alive_peephole
  sorry
def n3_constmask_badmask_combined := [llvmfunc|
  llvm.func @n3_constmask_badmask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(-65280 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n3_constmask_badmask   : n3_constmask_badmask_before  ⊑  n3_constmask_badmask_combined := by
  unfold n3_constmask_badmask_before n3_constmask_badmask_combined
  simp_alive_peephole
  sorry
def n3_constmask_samemask_combined := [llvmfunc|
  llvm.func @n3_constmask_samemask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n3_constmask_samemask   : n3_constmask_samemask_before  ⊑  n3_constmask_samemask_combined := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_combined
  simp_alive_peephole
  sorry

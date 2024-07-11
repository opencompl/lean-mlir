import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-amount-reassociation
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def t2_vec_nonsplat_before := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32, 30]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def t3_vec_nonsplat_poison0_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<-2> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.sub %8, %arg1  : vector<3xi32>
    %11 = llvm.lshr %arg0, %10  : vector<3xi32>
    %12 = llvm.add %arg1, %9  : vector<3xi32>
    %13 = llvm.lshr %11, %12  : vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }]

def t4_vec_nonsplat_poison1_before := [llvmfunc|
  llvm.func @t4_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.sub %0, %arg1  : vector<3xi32>
    %11 = llvm.lshr %arg0, %10  : vector<3xi32>
    %12 = llvm.add %arg1, %9  : vector<3xi32>
    %13 = llvm.lshr %11, %12  : vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }]

def t5_vec_nonsplat_poison1_before := [llvmfunc|
  llvm.func @t5_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-2 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.sub %8, %arg1  : vector<3xi32>
    %18 = llvm.lshr %arg0, %17  : vector<3xi32>
    %19 = llvm.add %arg1, %16  : vector<3xi32>
    %20 = llvm.lshr %18, %19  : vector<3xi32>
    llvm.return %20 : vector<3xi32>
  }]

def t6_shl_before := [llvmfunc|
  llvm.func @t6_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2 overflow<nuw>  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }]

def t7_ashr_before := [llvmfunc|
  llvm.func @t7_ashr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

def t8_lshr_exact_flag_preservation_before := [llvmfunc|
  llvm.func @t8_lshr_exact_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

def t9_ashr_exact_flag_preservation_before := [llvmfunc|
  llvm.func @t9_ashr_exact_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

def t10_shl_nuw_flag_preservation_before := [llvmfunc|
  llvm.func @t10_shl_nuw_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2 overflow<nuw>  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw, nuw>  : i32
    llvm.return %5 : i32
  }]

def t11_shl_nsw_flag_preservation_before := [llvmfunc|
  llvm.func @t11_shl_nsw_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2 overflow<nsw>  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw, nuw>  : i32
    llvm.return %5 : i32
  }]

def constantexpr_before := [llvmfunc|
  llvm.func @constantexpr() -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : i64
    %5 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %7 = llvm.add %2, %3  : i64
    %8 = llvm.shl %7, %3  : i64
    %9 = llvm.ashr %8, %6  : i64
    %10 = llvm.and %4, %9  : i64
    llvm.return %10 : i64
  }]

def n12_before := [llvmfunc|
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

def t13_vec_before := [llvmfunc|
  llvm.func @t13_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32, 30]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, 2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def n13_before := [llvmfunc|
  llvm.func @n13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

def n14_before := [llvmfunc|
  llvm.func @n14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

def n15_before := [llvmfunc|
  llvm.func @n15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

def n16_before := [llvmfunc|
  llvm.func @n16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

def n17_before := [llvmfunc|
  llvm.func @n17(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

def n18_before := [llvmfunc|
  llvm.func @n18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

def n19_before := [llvmfunc|
  llvm.func @n19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

def n20_before := [llvmfunc|
  llvm.func @n20(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

def pr44802_before := [llvmfunc|
  llvm.func @pr44802(%arg0: i3) -> i3 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.sub %0, %arg0  : i3
    %2 = llvm.icmp "ne" %arg0, %0 : i3
    %3 = llvm.zext %2 : i1 to i3
    %4 = llvm.lshr %1, %3  : i3
    %5 = llvm.lshr %4, %3  : i3
    llvm.return %5 : i3
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_t2_vec_nonsplat   : t2_vec_nonsplat_before  ⊑  t2_vec_nonsplat_combined := by
  unfold t2_vec_nonsplat_before t2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.lshr %arg0, %8  : vector<3xi32>
    llvm.return %9 : vector<3xi32>
  }]

theorem inst_combine_t3_vec_nonsplat_poison0   : t3_vec_nonsplat_poison0_before  ⊑  t3_vec_nonsplat_poison0_combined := by
  unfold t3_vec_nonsplat_poison0_before t3_vec_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def t4_vec_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @t4_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.lshr %arg0, %8  : vector<3xi32>
    llvm.return %9 : vector<3xi32>
  }]

theorem inst_combine_t4_vec_nonsplat_poison1   : t4_vec_nonsplat_poison1_before  ⊑  t4_vec_nonsplat_poison1_combined := by
  unfold t4_vec_nonsplat_poison1_before t4_vec_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def t5_vec_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @t5_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.lshr %arg0, %8  : vector<3xi32>
    llvm.return %9 : vector<3xi32>
  }]

theorem inst_combine_t5_vec_nonsplat_poison1   : t5_vec_nonsplat_poison1_before  ⊑  t5_vec_nonsplat_poison1_combined := by
  unfold t5_vec_nonsplat_poison1_before t5_vec_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def t6_shl_combined := [llvmfunc|
  llvm.func @t6_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t6_shl   : t6_shl_before  ⊑  t6_shl_combined := by
  unfold t6_shl_before t6_shl_combined
  simp_alive_peephole
  sorry
def t7_ashr_combined := [llvmfunc|
  llvm.func @t7_ashr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t7_ashr   : t7_ashr_before  ⊑  t7_ashr_combined := by
  unfold t7_ashr_before t7_ashr_combined
  simp_alive_peephole
  sorry
def t8_lshr_exact_flag_preservation_combined := [llvmfunc|
  llvm.func @t8_lshr_exact_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t8_lshr_exact_flag_preservation   : t8_lshr_exact_flag_preservation_before  ⊑  t8_lshr_exact_flag_preservation_combined := by
  unfold t8_lshr_exact_flag_preservation_before t8_lshr_exact_flag_preservation_combined
  simp_alive_peephole
  sorry
def t9_ashr_exact_flag_preservation_combined := [llvmfunc|
  llvm.func @t9_ashr_exact_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t9_ashr_exact_flag_preservation   : t9_ashr_exact_flag_preservation_before  ⊑  t9_ashr_exact_flag_preservation_combined := by
  unfold t9_ashr_exact_flag_preservation_before t9_ashr_exact_flag_preservation_combined
  simp_alive_peephole
  sorry
def t10_shl_nuw_flag_preservation_combined := [llvmfunc|
  llvm.func @t10_shl_nuw_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t10_shl_nuw_flag_preservation   : t10_shl_nuw_flag_preservation_before  ⊑  t10_shl_nuw_flag_preservation_combined := by
  unfold t10_shl_nuw_flag_preservation_before t10_shl_nuw_flag_preservation_combined
  simp_alive_peephole
  sorry
def t11_shl_nsw_flag_preservation_combined := [llvmfunc|
  llvm.func @t11_shl_nsw_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_t11_shl_nsw_flag_preservation   : t11_shl_nsw_flag_preservation_before  ⊑  t11_shl_nsw_flag_preservation_combined := by
  unfold t11_shl_nsw_flag_preservation_before t11_shl_nsw_flag_preservation_combined
  simp_alive_peephole
  sorry
def constantexpr_combined := [llvmfunc|
  llvm.func @constantexpr() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_constantexpr   : constantexpr_before  ⊑  constantexpr_combined := by
  unfold constantexpr_before constantexpr_combined
  simp_alive_peephole
  sorry
def n12_combined := [llvmfunc|
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n12   : n12_before  ⊑  n12_combined := by
  unfold n12_before n12_combined
  simp_alive_peephole
  sorry
def t13_vec_combined := [llvmfunc|
  llvm.func @t13_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32, 30]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, 2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_t13_vec   : t13_vec_before  ⊑  t13_vec_combined := by
  unfold t13_vec_before t13_vec_combined
  simp_alive_peephole
  sorry
def n13_combined := [llvmfunc|
  llvm.func @n13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n13   : n13_before  ⊑  n13_combined := by
  unfold n13_before n13_combined
  simp_alive_peephole
  sorry
def n14_combined := [llvmfunc|
  llvm.func @n14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n14   : n14_before  ⊑  n14_combined := by
  unfold n14_before n14_combined
  simp_alive_peephole
  sorry
def n15_combined := [llvmfunc|
  llvm.func @n15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n15   : n15_before  ⊑  n15_combined := by
  unfold n15_before n15_combined
  simp_alive_peephole
  sorry
def n16_combined := [llvmfunc|
  llvm.func @n16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n16   : n16_before  ⊑  n16_combined := by
  unfold n16_before n16_combined
  simp_alive_peephole
  sorry
def n17_combined := [llvmfunc|
  llvm.func @n17(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n17   : n17_before  ⊑  n17_combined := by
  unfold n17_before n17_combined
  simp_alive_peephole
  sorry
def n18_combined := [llvmfunc|
  llvm.func @n18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n18   : n18_before  ⊑  n18_combined := by
  unfold n18_before n18_combined
  simp_alive_peephole
  sorry
def n19_combined := [llvmfunc|
  llvm.func @n19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n19   : n19_before  ⊑  n19_combined := by
  unfold n19_before n19_combined
  simp_alive_peephole
  sorry
def n20_combined := [llvmfunc|
  llvm.func @n20(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n20   : n20_before  ⊑  n20_combined := by
  unfold n20_before n20_combined
  simp_alive_peephole
  sorry
def pr44802_combined := [llvmfunc|
  llvm.func @pr44802(%arg0: i3) -> i3 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.sub %0, %arg0  : i3
    %2 = llvm.icmp "ne" %arg0, %0 : i3
    %3 = llvm.zext %2 : i1 to i3
    %4 = llvm.lshr %1, %3  : i3
    %5 = llvm.lshr %4, %3  : i3
    llvm.return %5 : i3
  }]

theorem inst_combine_pr44802   : pr44802_before  ⊑  pr44802_combined := by
  unfold pr44802_before pr44802_combined
  simp_alive_peephole
  sorry

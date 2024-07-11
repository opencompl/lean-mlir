import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shl-demand
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def src_srem_shl_demand_max_signbit_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_min_signbit_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_min_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_max_mask_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_max_signbit_mask_hit_first_demand_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_signbit_mask_hit_first_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(29 : i32) : i32
    %2 = llvm.mlir.constant(-1073741824 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_min_signbit_mask_hit_last_demand_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_min_signbit_mask_hit_last_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(536870912 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1073741822 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_eliminate_signbit_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_eliminate_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_max_mask_hit_demand_before := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_mask_hit_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_mask_vector_before := [llvmfunc|
  llvm.func @src_srem_shl_mask_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<29> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.shl %3, %1  : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def src_srem_shl_mask_vector_nonconstant_before := [llvmfunc|
  llvm.func @src_srem_shl_mask_vector_nonconstant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %2, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def sext_shl_trunc_same_size_before := [llvmfunc|
  llvm.func @sext_shl_trunc_same_size(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

def sext_shl_trunc_smaller_before := [llvmfunc|
  llvm.func @sext_shl_trunc_smaller(%arg0: i16, %arg1: i32) -> i5 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i5
    llvm.return %2 : i5
  }]

def sext_shl_trunc_larger_before := [llvmfunc|
  llvm.func @sext_shl_trunc_larger(%arg0: i16, %arg1: i32) -> i17 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i17
    llvm.return %2 : i17
  }]

def sext_shl_mask_before := [llvmfunc|
  llvm.func @sext_shl_mask(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.shl %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def sext_shl_mask_higher_before := [llvmfunc|
  llvm.func @sext_shl_mask_higher(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.shl %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def set_shl_mask_before := [llvmfunc|
  llvm.func @set_shl_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(196609 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def must_drop_poison_before := [llvmfunc|
  llvm.func @must_drop_poison(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.shl %1, %arg1 overflow<nsw, nuw>  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def f_t15_t01_t09_before := [llvmfunc|
  llvm.func @f_t15_t01_t09(%arg0: i40) -> i32 {
    %0 = llvm.mlir.constant(31 : i40) : i40
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i40
    %4 = llvm.trunc %3 : i40 to i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.ashr %5, %1  : i32
    %7 = llvm.shl %6, %2  : i32
    llvm.return %5 : i32
  }]

def src_srem_shl_demand_max_signbit_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_max_signbit   : src_srem_shl_demand_max_signbit_before  ⊑  src_srem_shl_demand_max_signbit_combined := by
  unfold src_srem_shl_demand_max_signbit_before src_srem_shl_demand_max_signbit_combined
  simp_alive_peephole
  sorry
def src_srem_shl_demand_min_signbit_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_min_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_min_signbit   : src_srem_shl_demand_min_signbit_before  ⊑  src_srem_shl_demand_min_signbit_combined := by
  unfold src_srem_shl_demand_min_signbit_before src_srem_shl_demand_min_signbit_combined
  simp_alive_peephole
  sorry
def src_srem_shl_demand_max_mask_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_max_mask   : src_srem_shl_demand_max_mask_before  ⊑  src_srem_shl_demand_max_mask_combined := by
  unfold src_srem_shl_demand_max_mask_before src_srem_shl_demand_max_mask_combined
  simp_alive_peephole
  sorry
def src_srem_shl_demand_max_signbit_mask_hit_first_demand_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_signbit_mask_hit_first_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(29 : i32) : i32
    %2 = llvm.mlir.constant(-1073741824 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_max_signbit_mask_hit_first_demand   : src_srem_shl_demand_max_signbit_mask_hit_first_demand_before  ⊑  src_srem_shl_demand_max_signbit_mask_hit_first_demand_combined := by
  unfold src_srem_shl_demand_max_signbit_mask_hit_first_demand_before src_srem_shl_demand_max_signbit_mask_hit_first_demand_combined
  simp_alive_peephole
  sorry
def src_srem_shl_demand_min_signbit_mask_hit_last_demand_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_min_signbit_mask_hit_last_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(536870912 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1073741822 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_min_signbit_mask_hit_last_demand   : src_srem_shl_demand_min_signbit_mask_hit_last_demand_before  ⊑  src_srem_shl_demand_min_signbit_mask_hit_last_demand_combined := by
  unfold src_srem_shl_demand_min_signbit_mask_hit_last_demand_before src_srem_shl_demand_min_signbit_mask_hit_last_demand_combined
  simp_alive_peephole
  sorry
def src_srem_shl_demand_eliminate_signbit_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_eliminate_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_eliminate_signbit   : src_srem_shl_demand_eliminate_signbit_before  ⊑  src_srem_shl_demand_eliminate_signbit_combined := by
  unfold src_srem_shl_demand_eliminate_signbit_before src_srem_shl_demand_eliminate_signbit_combined
  simp_alive_peephole
  sorry
def src_srem_shl_demand_max_mask_hit_demand_combined := [llvmfunc|
  llvm.func @src_srem_shl_demand_max_mask_hit_demand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src_srem_shl_demand_max_mask_hit_demand   : src_srem_shl_demand_max_mask_hit_demand_before  ⊑  src_srem_shl_demand_max_mask_hit_demand_combined := by
  unfold src_srem_shl_demand_max_mask_hit_demand_before src_srem_shl_demand_max_mask_hit_demand_combined
  simp_alive_peephole
  sorry
def src_srem_shl_mask_vector_combined := [llvmfunc|
  llvm.func @src_srem_shl_mask_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<29> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.shl %3, %1 overflow<nsw>  : vector<2xi32>
    %5 = llvm.and %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_src_srem_shl_mask_vector   : src_srem_shl_mask_vector_before  ⊑  src_srem_shl_mask_vector_combined := by
  unfold src_srem_shl_mask_vector_before src_srem_shl_mask_vector_combined
  simp_alive_peephole
  sorry
def src_srem_shl_mask_vector_nonconstant_combined := [llvmfunc|
  llvm.func @src_srem_shl_mask_vector_nonconstant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1073741824> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %2, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_src_srem_shl_mask_vector_nonconstant   : src_srem_shl_mask_vector_nonconstant_before  ⊑  src_srem_shl_mask_vector_nonconstant_combined := by
  unfold src_srem_shl_mask_vector_nonconstant_before src_srem_shl_mask_vector_nonconstant_combined
  simp_alive_peephole
  sorry
def sext_shl_trunc_same_size_combined := [llvmfunc|
  llvm.func @sext_shl_trunc_same_size(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_sext_shl_trunc_same_size   : sext_shl_trunc_same_size_before  ⊑  sext_shl_trunc_same_size_combined := by
  unfold sext_shl_trunc_same_size_before sext_shl_trunc_same_size_combined
  simp_alive_peephole
  sorry
def sext_shl_trunc_smaller_combined := [llvmfunc|
  llvm.func @sext_shl_trunc_smaller(%arg0: i16, %arg1: i32) -> i5 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i5
    llvm.return %2 : i5
  }]

theorem inst_combine_sext_shl_trunc_smaller   : sext_shl_trunc_smaller_before  ⊑  sext_shl_trunc_smaller_combined := by
  unfold sext_shl_trunc_smaller_before sext_shl_trunc_smaller_combined
  simp_alive_peephole
  sorry
def sext_shl_trunc_larger_combined := [llvmfunc|
  llvm.func @sext_shl_trunc_larger(%arg0: i16, %arg1: i32) -> i17 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i17
    llvm.return %2 : i17
  }]

theorem inst_combine_sext_shl_trunc_larger   : sext_shl_trunc_larger_before  ⊑  sext_shl_trunc_larger_combined := by
  unfold sext_shl_trunc_larger_before sext_shl_trunc_larger_combined
  simp_alive_peephole
  sorry
def sext_shl_mask_combined := [llvmfunc|
  llvm.func @sext_shl_mask(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sext_shl_mask   : sext_shl_mask_before  ⊑  sext_shl_mask_combined := by
  unfold sext_shl_mask_before sext_shl_mask_combined
  simp_alive_peephole
  sorry
def sext_shl_mask_higher_combined := [llvmfunc|
  llvm.func @sext_shl_mask_higher(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.shl %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sext_shl_mask_higher   : sext_shl_mask_higher_before  ⊑  sext_shl_mask_higher_combined := by
  unfold sext_shl_mask_higher_before sext_shl_mask_higher_combined
  simp_alive_peephole
  sorry
def set_shl_mask_combined := [llvmfunc|
  llvm.func @set_shl_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_set_shl_mask   : set_shl_mask_before  ⊑  set_shl_mask_combined := by
  unfold set_shl_mask_before set_shl_mask_combined
  simp_alive_peephole
  sorry
def must_drop_poison_combined := [llvmfunc|
  llvm.func @must_drop_poison(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_must_drop_poison   : must_drop_poison_before  ⊑  must_drop_poison_combined := by
  unfold must_drop_poison_before must_drop_poison_combined
  simp_alive_peephole
  sorry
def f_t15_t01_t09_combined := [llvmfunc|
  llvm.func @f_t15_t01_t09(%arg0: i40) -> i32 {
    %0 = llvm.mlir.constant(15 : i40) : i40
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i40
    %3 = llvm.trunc %2 : i40 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_f_t15_t01_t09   : f_t15_t01_t09_before  ⊑  f_t15_t01_t09_combined := by
  unfold f_t15_t01_t09_before f_t15_t01_t09_combined
  simp_alive_peephole
  sorry

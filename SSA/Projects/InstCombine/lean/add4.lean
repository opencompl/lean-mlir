import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def match_unsigned_before := [llvmfunc|
  llvm.func @match_unsigned(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.urem %arg0, %0  : i64
    %3 = llvm.udiv %arg0, %0  : i64
    %4 = llvm.urem %3, %1  : i64
    %5 = llvm.mul %4, %0  : i64
    %6 = llvm.add %2, %5  : i64
    llvm.return %6 : i64
  }]

def match_unsigned_vector_before := [llvmfunc|
  llvm.func @match_unsigned_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<299> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.urem %arg0, %0  : vector<2xi64>
    %3 = llvm.udiv %arg0, %0  : vector<2xi64>
    %4 = llvm.urem %3, %1  : vector<2xi64>
    %5 = llvm.mul %4, %0  : vector<2xi64>
    %6 = llvm.add %2, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def match_andAsRem_lshrAsDiv_shlAsMul_before := [llvmfunc|
  llvm.func @match_andAsRem_lshrAsDiv_shlAsMul(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.urem %4, %2  : i64
    %6 = llvm.shl %5, %1  : i64
    %7 = llvm.add %3, %6  : i64
    llvm.return %7 : i64
  }]

def match_signed_before := [llvmfunc|
  llvm.func @match_signed(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.mlir.constant(19136 : i64) : i64
    %3 = llvm.mlir.constant(9 : i64) : i64
    %4 = llvm.srem %arg0, %0  : i64
    %5 = llvm.sdiv %arg0, %0  : i64
    %6 = llvm.srem %5, %1  : i64
    %7 = llvm.sdiv %arg0, %2  : i64
    %8 = llvm.srem %7, %3  : i64
    %9 = llvm.mul %6, %0  : i64
    %10 = llvm.add %4, %9  : i64
    %11 = llvm.mul %8, %2  : i64
    %12 = llvm.add %10, %11  : i64
    llvm.return %12 : i64
  }]

def match_signed_vector_before := [llvmfunc|
  llvm.func @match_signed_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<299> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<19136> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<9> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.srem %arg0, %0  : vector<2xi64>
    %5 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %6 = llvm.srem %5, %1  : vector<2xi64>
    %7 = llvm.sdiv %arg0, %2  : vector<2xi64>
    %8 = llvm.srem %7, %3  : vector<2xi64>
    %9 = llvm.mul %6, %0  : vector<2xi64>
    %10 = llvm.add %4, %9  : vector<2xi64>
    %11 = llvm.mul %8, %2  : vector<2xi64>
    %12 = llvm.add %10, %11  : vector<2xi64>
    llvm.return %12 : vector<2xi64>
  }]

def not_match_inconsistent_signs_before := [llvmfunc|
  llvm.func @not_match_inconsistent_signs(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.urem %arg0, %0  : i64
    %3 = llvm.sdiv %arg0, %0  : i64
    %4 = llvm.urem %3, %1  : i64
    %5 = llvm.mul %4, %0  : i64
    %6 = llvm.add %2, %5  : i64
    llvm.return %6 : i64
  }]

def not_match_inconsistent_values_before := [llvmfunc|
  llvm.func @not_match_inconsistent_values(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(29 : i64) : i64
    %2 = llvm.mlir.constant(64 : i64) : i64
    %3 = llvm.urem %arg0, %0  : i64
    %4 = llvm.udiv %arg0, %1  : i64
    %5 = llvm.urem %4, %2  : i64
    %6 = llvm.mul %5, %0  : i64
    %7 = llvm.add %3, %6  : i64
    llvm.return %7 : i64
  }]

def not_match_overflow_before := [llvmfunc|
  llvm.func @not_match_overflow(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(299 : i32) : i32
    %1 = llvm.mlir.constant(147483647 : i32) : i32
    %2 = llvm.urem %arg0, %0  : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.urem %3, %1  : i32
    %5 = llvm.mul %4, %0  : i32
    %6 = llvm.add %2, %5  : i32
    llvm.return %6 : i32
  }]

def fold_add_udiv_urem_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def fold_add_sdiv_srem_before := [llvmfunc|
  llvm.func @fold_add_sdiv_srem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.srem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def fold_add_udiv_urem_to_mul_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_to_mul(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %arg0, %0  : i32
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }]

def fold_add_udiv_urem_to_mul_multiuse_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_to_mul_multiuse(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %arg0, %0  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }]

def fold_add_udiv_urem_commuted_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_commuted(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }]

def fold_add_udiv_urem_or_disjoint_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_or_disjoint(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

def fold_add_udiv_urem_without_noundef_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_without_noundef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def fold_add_udiv_urem_multiuse_mul_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_multiuse_mul(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def fold_add_udiv_srem_before := [llvmfunc|
  llvm.func @fold_add_udiv_srem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.srem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def fold_add_udiv_urem_non_constant_before := [llvmfunc|
  llvm.func @fold_add_udiv_urem_non_constant(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.urem %arg0, %arg1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def match_unsigned_combined := [llvmfunc|
  llvm.func @match_unsigned(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(19136 : i64) : i64
    %1 = llvm.urem %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_match_unsigned   : match_unsigned_before  ⊑  match_unsigned_combined := by
  unfold match_unsigned_before match_unsigned_combined
  simp_alive_peephole
  sorry
def match_unsigned_vector_combined := [llvmfunc|
  llvm.func @match_unsigned_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<19136> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.urem %arg0, %0  : vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_match_unsigned_vector   : match_unsigned_vector_before  ⊑  match_unsigned_vector_combined := by
  unfold match_unsigned_vector_before match_unsigned_vector_combined
  simp_alive_peephole
  sorry
def match_andAsRem_lshrAsDiv_shlAsMul_combined := [llvmfunc|
  llvm.func @match_andAsRem_lshrAsDiv_shlAsMul(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(576 : i64) : i64
    %1 = llvm.urem %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_match_andAsRem_lshrAsDiv_shlAsMul   : match_andAsRem_lshrAsDiv_shlAsMul_before  ⊑  match_andAsRem_lshrAsDiv_shlAsMul_combined := by
  unfold match_andAsRem_lshrAsDiv_shlAsMul_before match_andAsRem_lshrAsDiv_shlAsMul_combined
  simp_alive_peephole
  sorry
def match_signed_combined := [llvmfunc|
  llvm.func @match_signed(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(172224 : i64) : i64
    %1 = llvm.srem %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_match_signed   : match_signed_before  ⊑  match_signed_combined := by
  unfold match_signed_before match_signed_combined
  simp_alive_peephole
  sorry
def match_signed_vector_combined := [llvmfunc|
  llvm.func @match_signed_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<172224> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.srem %arg0, %0  : vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_match_signed_vector   : match_signed_vector_before  ⊑  match_signed_vector_combined := by
  unfold match_signed_vector_before match_signed_vector_combined
  simp_alive_peephole
  sorry
def not_match_inconsistent_signs_combined := [llvmfunc|
  llvm.func @not_match_inconsistent_signs(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.urem %arg0, %0  : i64
    %3 = llvm.sdiv %arg0, %0  : i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.mul %4, %0 overflow<nsw, nuw>  : i64
    %6 = llvm.add %2, %5 overflow<nsw, nuw>  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_not_match_inconsistent_signs   : not_match_inconsistent_signs_before  ⊑  not_match_inconsistent_signs_combined := by
  unfold not_match_inconsistent_signs_before not_match_inconsistent_signs_combined
  simp_alive_peephole
  sorry
def not_match_inconsistent_values_combined := [llvmfunc|
  llvm.func @not_match_inconsistent_values(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(299 : i64) : i64
    %1 = llvm.mlir.constant(29 : i64) : i64
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.urem %arg0, %0  : i64
    %4 = llvm.udiv %arg0, %1  : i64
    %5 = llvm.and %4, %2  : i64
    %6 = llvm.mul %5, %0 overflow<nsw, nuw>  : i64
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i64
    llvm.return %7 : i64
  }]

theorem inst_combine_not_match_inconsistent_values   : not_match_inconsistent_values_before  ⊑  not_match_inconsistent_values_combined := by
  unfold not_match_inconsistent_values_before not_match_inconsistent_values_combined
  simp_alive_peephole
  sorry
def not_match_overflow_combined := [llvmfunc|
  llvm.func @not_match_overflow(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(299 : i32) : i32
    %1 = llvm.freeze %arg0 : i32
    %2 = llvm.urem %1, %0  : i32
    %3 = llvm.urem %1, %0  : i32
    %4 = llvm.sub %1, %3 overflow<nuw>  : i32
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_not_match_overflow   : not_match_overflow_before  ⊑  not_match_overflow_combined := by
  unfold not_match_overflow_before not_match_overflow_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_udiv_urem   : fold_add_udiv_urem_before  ⊑  fold_add_udiv_urem_combined := by
  unfold fold_add_udiv_urem_before fold_add_udiv_urem_combined
  simp_alive_peephole
  sorry
def fold_add_sdiv_srem_combined := [llvmfunc|
  llvm.func @fold_add_sdiv_srem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.srem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_sdiv_srem   : fold_add_sdiv_srem_before  ⊑  fold_add_sdiv_srem_combined := by
  unfold fold_add_sdiv_srem_before fold_add_sdiv_srem_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_to_mul_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_to_mul(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %arg0, %0  : i32
    %6 = llvm.mul %5, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_to_mul   : fold_add_udiv_urem_to_mul_before  ⊑  fold_add_udiv_urem_to_mul_combined := by
  unfold fold_add_udiv_urem_to_mul_before fold_add_udiv_urem_to_mul_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_to_mul_multiuse_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_to_mul_multiuse(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.udiv %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %arg0, %0  : i32
    llvm.call @use(%5) : (i32) -> ()
    %6 = llvm.mul %5, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_to_mul_multiuse   : fold_add_udiv_urem_to_mul_multiuse_before  ⊑  fold_add_udiv_urem_to_mul_multiuse_combined := by
  unfold fold_add_udiv_urem_to_mul_multiuse_before fold_add_udiv_urem_to_mul_multiuse_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_commuted_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_commuted(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_commuted   : fold_add_udiv_urem_commuted_before  ⊑  fold_add_udiv_urem_commuted_combined := by
  unfold fold_add_udiv_urem_commuted_before fold_add_udiv_urem_commuted_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_or_disjoint_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_or_disjoint(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_or_disjoint   : fold_add_udiv_urem_or_disjoint_before  ⊑  fold_add_udiv_urem_or_disjoint_combined := by
  unfold fold_add_udiv_urem_or_disjoint_before fold_add_udiv_urem_or_disjoint_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_without_noundef_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_without_noundef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_without_noundef   : fold_add_udiv_urem_without_noundef_before  ⊑  fold_add_udiv_urem_without_noundef_combined := by
  unfold fold_add_udiv_urem_without_noundef_before fold_add_udiv_urem_without_noundef_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_multiuse_mul_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_multiuse_mul(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.urem %arg0, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_multiuse_mul   : fold_add_udiv_urem_multiuse_mul_before  ⊑  fold_add_udiv_urem_multiuse_mul_combined := by
  unfold fold_add_udiv_urem_multiuse_mul_before fold_add_udiv_urem_multiuse_mul_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_srem_combined := [llvmfunc|
  llvm.func @fold_add_udiv_srem(%arg0: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.udiv %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.srem %arg0, %0  : i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_add_udiv_srem   : fold_add_udiv_srem_before  ⊑  fold_add_udiv_srem_combined := by
  unfold fold_add_udiv_srem_before fold_add_udiv_srem_combined
  simp_alive_peephole
  sorry
def fold_add_udiv_urem_non_constant_combined := [llvmfunc|
  llvm.func @fold_add_udiv_urem_non_constant(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.urem %arg0, %arg1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_fold_add_udiv_urem_non_constant   : fold_add_udiv_urem_non_constant_before  ⊑  fold_add_udiv_urem_non_constant_combined := by
  unfold fold_add_udiv_urem_non_constant_before fold_add_udiv_urem_non_constant_combined
  simp_alive_peephole
  sorry

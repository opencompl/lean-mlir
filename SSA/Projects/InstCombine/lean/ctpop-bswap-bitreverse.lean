import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ctpop-bswap-bitreverse
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ctpop_bitreverse_before := [llvmfunc|
  llvm.func @ctpop_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

def ctpop_bitreverse_vec_before := [llvmfunc|
  llvm.func @ctpop_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.intr.ctpop(%0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

def ctpop_bswap_before := [llvmfunc|
  llvm.func @ctpop_bswap(%arg0: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.ctpop(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

def ctpop_bswap_vec_before := [llvmfunc|
  llvm.func @ctpop_bswap_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.intr.ctpop(%0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

def ctpop_bitreverse_combined := [llvmfunc|
  llvm.func @ctpop_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctpop_bitreverse   : ctpop_bitreverse_before  ⊑  ctpop_bitreverse_combined := by
  unfold ctpop_bitreverse_before ctpop_bitreverse_combined
  simp_alive_peephole
  sorry
def ctpop_bitreverse_vec_combined := [llvmfunc|
  llvm.func @ctpop_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.ctpop(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_ctpop_bitreverse_vec   : ctpop_bitreverse_vec_before  ⊑  ctpop_bitreverse_vec_combined := by
  unfold ctpop_bitreverse_vec_before ctpop_bitreverse_vec_combined
  simp_alive_peephole
  sorry
def ctpop_bswap_combined := [llvmfunc|
  llvm.func @ctpop_bswap(%arg0: i32) -> i32 {
    %0 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctpop_bswap   : ctpop_bswap_before  ⊑  ctpop_bswap_combined := by
  unfold ctpop_bswap_before ctpop_bswap_combined
  simp_alive_peephole
  sorry
def ctpop_bswap_vec_combined := [llvmfunc|
  llvm.func @ctpop_bswap_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.ctpop(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_ctpop_bswap_vec   : ctpop_bswap_vec_before  ⊑  ctpop_bswap_vec_combined := by
  unfold ctpop_bswap_vec_before ctpop_bswap_vec_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-concat-binop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_before := [llvmfunc|
  llvm.func @add(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.and %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def sub_before := [llvmfunc|
  llvm.func @sub(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.sub %0, %1 overflow<nsw>  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def mul_before := [llvmfunc|
  llvm.func @mul(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.mul %0, %1 overflow<nuw>  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def and_before := [llvmfunc|
  llvm.func @and(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.and %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def or_before := [llvmfunc|
  llvm.func @or(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, 2, 3] : vector<2xi8> 
    %2 = llvm.or %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def xor_before := [llvmfunc|
  llvm.func @xor(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.xor %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def shl_before := [llvmfunc|
  llvm.func @shl(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, -1, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.shl %0, %1 overflow<nuw>  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def lshr_before := [llvmfunc|
  llvm.func @lshr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, -1, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, -1, 3] : vector<2xi8> 
    %2 = llvm.lshr %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def ashr_before := [llvmfunc|
  llvm.func @ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.call @use(%0) : (vector<4xi8>) -> ()
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.ashr %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def sdiv_before := [llvmfunc|
  llvm.func @sdiv(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, -1, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.sdiv %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def srem_before := [llvmfunc|
  llvm.func @srem(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.srem %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def udiv_before := [llvmfunc|
  llvm.func @udiv(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.udiv %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def urem_before := [llvmfunc|
  llvm.func @urem(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [-1, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.urem %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def fadd_before := [llvmfunc|
  llvm.func @fadd(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xf32> 
    %2 = llvm.fadd %0, %1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def fsub_before := [llvmfunc|
  llvm.func @fsub(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, -1, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xf32> 
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    llvm.return %2 : vector<4xf32>
  }]

def fmul_before := [llvmfunc|
  llvm.func @fmul(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, -1, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [-1, 1, -1, 3] : vector<2xf32> 
    llvm.call @use2(%1) : (vector<4xf32>) -> ()
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<4xf32>]

    llvm.return %2 : vector<4xf32>
  }]

def fdiv_before := [llvmfunc|
  llvm.func @fdiv(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xf32> 
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<4xf32>]

    llvm.return %2 : vector<4xf32>
  }]

def frem_before := [llvmfunc|
  llvm.func @frem(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, 2, 3] : vector<2xf32> 
    %2 = llvm.frem %0, %1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def PR33026_before := [llvmfunc|
  llvm.func @PR33026(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>, %arg3: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi32> 
    %2 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi32> 
    %3 = llvm.and %1, %2  : vector<8xi32>
    %4 = llvm.shufflevector %3, %0 [0, 1, 2, 3] : vector<8xi32> 
    %5 = llvm.shufflevector %3, %0 [4, 5, 6, 7] : vector<8xi32> 
    %6 = llvm.sub %4, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def add_combined := [llvmfunc|
  llvm.func @add(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.and %arg0, %arg2  : vector<2xi8>
    %1 = llvm.and %arg1, %arg3  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_add   : add_before  ⊑  add_combined := by
  unfold add_before add_combined
  simp_alive_peephole
  sorry
def sub_combined := [llvmfunc|
  llvm.func @sub(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.sub %arg0, %arg2 overflow<nsw>  : vector<2xi8>
    %1 = llvm.sub %arg1, %arg3 overflow<nsw>  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_sub   : sub_before  ⊑  sub_combined := by
  unfold sub_before sub_combined
  simp_alive_peephole
  sorry
def mul_combined := [llvmfunc|
  llvm.func @mul(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.mul %arg0, %arg2 overflow<nuw>  : vector<2xi8>
    %1 = llvm.mul %arg1, %arg3 overflow<nuw>  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_mul   : mul_before  ⊑  mul_combined := by
  unfold mul_before mul_combined
  simp_alive_peephole
  sorry
def and_combined := [llvmfunc|
  llvm.func @and(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.and %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_and   : and_before  ⊑  and_combined := by
  unfold and_before and_combined
  simp_alive_peephole
  sorry
def or_combined := [llvmfunc|
  llvm.func @or(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, 2, 3] : vector<2xi8> 
    %2 = llvm.or %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_or   : or_before  ⊑  or_combined := by
  unfold or_before or_combined
  simp_alive_peephole
  sorry
def xor_combined := [llvmfunc|
  llvm.func @xor(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.xor %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_xor   : xor_before  ⊑  xor_combined := by
  unfold xor_before xor_combined
  simp_alive_peephole
  sorry
def shl_combined := [llvmfunc|
  llvm.func @shl(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shl %arg0, %arg2 overflow<nuw>  : vector<2xi8>
    %1 = llvm.shl %arg1, %arg3 overflow<nuw>  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, -1, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_shl   : shl_before  ⊑  shl_combined := by
  unfold shl_before shl_combined
  simp_alive_peephole
  sorry
def lshr_combined := [llvmfunc|
  llvm.func @lshr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.lshr %arg0, %arg2  : vector<2xi8>
    %1 = llvm.lshr %arg1, %arg3  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, -1, -1, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_lshr   : lshr_before  ⊑  lshr_combined := by
  unfold lshr_before lshr_combined
  simp_alive_peephole
  sorry
def ashr_combined := [llvmfunc|
  llvm.func @ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.call @use(%0) : (vector<4xi8>) -> ()
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.ashr %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_ashr   : ashr_before  ⊑  ashr_combined := by
  unfold ashr_before ashr_combined
  simp_alive_peephole
  sorry
def sdiv_combined := [llvmfunc|
  llvm.func @sdiv(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.sdiv %arg0, %arg2  : vector<2xi8>
    %1 = llvm.sdiv %arg1, %arg3  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, -1, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_sdiv   : sdiv_before  ⊑  sdiv_combined := by
  unfold sdiv_before sdiv_combined
  simp_alive_peephole
  sorry
def srem_combined := [llvmfunc|
  llvm.func @srem(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.srem %arg0, %arg2  : vector<2xi8>
    %1 = llvm.srem %arg1, %arg3  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_srem   : srem_before  ⊑  srem_combined := by
  unfold srem_before srem_combined
  simp_alive_peephole
  sorry
def udiv_combined := [llvmfunc|
  llvm.func @udiv(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.udiv %arg0, %arg2  : vector<2xi8>
    %1 = llvm.udiv %arg1, %arg3  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_udiv   : udiv_before  ⊑  udiv_combined := by
  unfold udiv_before udiv_combined
  simp_alive_peephole
  sorry
def urem_combined := [llvmfunc|
  llvm.func @urem(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.urem %arg0, %arg2  : vector<2xi8>
    %1 = llvm.urem %arg1, %arg3  : vector<2xi8>
    %2 = llvm.shufflevector %0, %1 [-1, 1, 2, 3] : vector<2xi8> 
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_urem   : urem_before  ⊑  urem_combined := by
  unfold urem_before urem_combined
  simp_alive_peephole
  sorry
def fadd_combined := [llvmfunc|
  llvm.func @fadd(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg0, %arg2  : vector<2xf32>
    %1 = llvm.fadd %arg1, %arg3  : vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_fadd   : fadd_before  ⊑  fadd_combined := by
  unfold fadd_before fadd_combined
  simp_alive_peephole
  sorry
def fsub_combined := [llvmfunc|
  llvm.func @fsub(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.fsub %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %1 = llvm.fsub %arg1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [0, 1, -1, 3] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_fsub   : fsub_before  ⊑  fsub_combined := by
  unfold fsub_before fsub_combined
  simp_alive_peephole
  sorry
def fmul_combined := [llvmfunc|
  llvm.func @fmul(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, -1, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [-1, 1, -1, 3] : vector<2xf32> 
    llvm.call @use2(%1) : (vector<4xf32>) -> ()
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_fmul   : fmul_before  ⊑  fmul_combined := by
  unfold fmul_before fmul_combined
  simp_alive_peephole
  sorry
def fdiv_combined := [llvmfunc|
  llvm.func @fdiv(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<2xf32>
    %1 = llvm.fdiv %arg1, %arg3  {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [0, 1, 2, 3] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_fdiv   : fdiv_before  ⊑  fdiv_combined := by
  unfold fdiv_before fdiv_combined
  simp_alive_peephole
  sorry
def frem_combined := [llvmfunc|
  llvm.func @frem(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.frem %arg0, %arg2  : vector<2xf32>
    %1 = llvm.frem %arg1, %arg3  : vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [0, -1, 2, 3] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_frem   : frem_before  ⊑  frem_combined := by
  unfold frem_before frem_combined
  simp_alive_peephole
  sorry
def PR33026_combined := [llvmfunc|
  llvm.func @PR33026(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>, %arg3: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.and %arg0, %arg2  : vector<4xi32>
    %1 = llvm.and %arg1, %arg3  : vector<4xi32>
    %2 = llvm.sub %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_PR33026   : PR33026_before  ⊑  PR33026_combined := by
  unfold PR33026_before PR33026_combined
  simp_alive_peephole
  sorry

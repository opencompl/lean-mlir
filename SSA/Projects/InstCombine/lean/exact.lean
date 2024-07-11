import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  exact
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sdiv1_before := [llvmfunc|
  llvm.func @sdiv1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def sdiv2_before := [llvmfunc|
  llvm.func @sdiv2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def sdiv2_vec_before := [llvmfunc|
  llvm.func @sdiv2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def sdiv3_before := [llvmfunc|
  llvm.func @sdiv3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }]

def sdiv4_before := [llvmfunc|
  llvm.func @sdiv4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }]

def sdiv5_before := [llvmfunc|
  llvm.func @sdiv5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    llvm.return %3 : i32
  }]

def sdiv6_before := [llvmfunc|
  llvm.func @sdiv6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    llvm.return %3 : i32
  }]

def udiv1_before := [llvmfunc|
  llvm.func @udiv1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.udiv %arg0, %arg1  : i32
    %1 = llvm.mul %0, %arg1  : i32
    llvm.return %1 : i32
  }]

def udiv2_before := [llvmfunc|
  llvm.func @udiv2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.udiv %arg0, %1  : i32
    llvm.return %2 : i32
  }]

def ashr1_before := [llvmfunc|
  llvm.func @ashr1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.ashr %2, %1  : i64
    llvm.return %3 : i64
  }]

def ashr1_vec_before := [llvmfunc|
  llvm.func @ashr1_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def ashr_icmp1_before := [llvmfunc|
  llvm.func @ashr_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def ashr_icmp2_before := [llvmfunc|
  llvm.func @ashr_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def ashr_icmp2_vec_before := [llvmfunc|
  llvm.func @ashr_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def pr9998_before := [llvmfunc|
  llvm.func @pr9998(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(7297771788697658747 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    llvm.return %5 : i1
  }]

def pr9998vec_before := [llvmfunc|
  llvm.func @pr9998vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7297771788697658747> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    %5 = llvm.icmp "ugt" %4, %1 : vector<2xi64>
    llvm.return %5 : vector<2xi1>
  }]

def udiv_icmp1_before := [llvmfunc|
  llvm.func @udiv_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.udiv %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

def udiv_icmp1_vec_before := [llvmfunc|
  llvm.func @udiv_icmp1_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.udiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def udiv_icmp2_before := [llvmfunc|
  llvm.func @udiv_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.udiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def udiv_icmp2_vec_before := [llvmfunc|
  llvm.func @udiv_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.udiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def sdiv_icmp1_before := [llvmfunc|
  llvm.func @sdiv_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def sdiv_icmp1_vec_before := [llvmfunc|
  llvm.func @sdiv_icmp1_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def sdiv_icmp2_before := [llvmfunc|
  llvm.func @sdiv_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def sdiv_icmp2_vec_before := [llvmfunc|
  llvm.func @sdiv_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def sdiv_icmp3_before := [llvmfunc|
  llvm.func @sdiv_icmp3(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def sdiv_icmp3_vec_before := [llvmfunc|
  llvm.func @sdiv_icmp3_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def sdiv_icmp4_before := [llvmfunc|
  llvm.func @sdiv_icmp4(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def sdiv_icmp4_vec_before := [llvmfunc|
  llvm.func @sdiv_icmp4_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def sdiv_icmp5_before := [llvmfunc|
  llvm.func @sdiv_icmp5(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def sdiv_icmp5_vec_before := [llvmfunc|
  llvm.func @sdiv_icmp5_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def sdiv_icmp6_before := [llvmfunc|
  llvm.func @sdiv_icmp6(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def sdiv_icmp6_vec_before := [llvmfunc|
  llvm.func @sdiv_icmp6_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def mul_of_udiv_before := [llvmfunc|
  llvm.func @mul_of_udiv(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

def mul_of_sdiv_before := [llvmfunc|
  llvm.func @mul_of_sdiv(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

def mul_of_sdiv_non_splat_before := [llvmfunc|
  llvm.func @mul_of_sdiv_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi8>
    %3 = llvm.mul %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def mul_of_sdiv_fail_missing_exact_before := [llvmfunc|
  llvm.func @mul_of_sdiv_fail_missing_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

def mul_of_udiv_fail_bad_remainder_before := [llvmfunc|
  llvm.func @mul_of_udiv_fail_bad_remainder(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(11 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

def mul_of_sdiv_fail_ub_before := [llvmfunc|
  llvm.func @mul_of_sdiv_fail_ub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

def mul_of_sdiv_fail_ub_non_splat_before := [llvmfunc|
  llvm.func @mul_of_sdiv_fail_ub_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-6, -12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi8>
    %3 = llvm.mul %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def sdiv1_combined := [llvmfunc|
  llvm.func @sdiv1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv1   : sdiv1_before  ⊑  sdiv1_combined := by
  unfold sdiv1_before sdiv1_combined
  simp_alive_peephole
  sorry
def sdiv2_combined := [llvmfunc|
  llvm.func @sdiv2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv2   : sdiv2_before  ⊑  sdiv2_combined := by
  unfold sdiv2_before sdiv2_combined
  simp_alive_peephole
  sorry
def sdiv2_vec_combined := [llvmfunc|
  llvm.func @sdiv2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_sdiv2_vec   : sdiv2_vec_before  ⊑  sdiv2_vec_combined := by
  unfold sdiv2_vec_before sdiv2_vec_combined
  simp_alive_peephole
  sorry
def sdiv3_combined := [llvmfunc|
  llvm.func @sdiv3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.freeze %arg0 : i32
    %2 = llvm.srem %1, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sdiv3   : sdiv3_before  ⊑  sdiv3_combined := by
  unfold sdiv3_before sdiv3_combined
  simp_alive_peephole
  sorry
def sdiv4_combined := [llvmfunc|
  llvm.func @sdiv4(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_sdiv4   : sdiv4_before  ⊑  sdiv4_combined := by
  unfold sdiv4_before sdiv4_combined
  simp_alive_peephole
  sorry
def sdiv5_combined := [llvmfunc|
  llvm.func @sdiv5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.freeze %arg0 : i32
    %2 = llvm.srem %1, %0  : i32
    %3 = llvm.sub %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sdiv5   : sdiv5_before  ⊑  sdiv5_combined := by
  unfold sdiv5_before sdiv5_combined
  simp_alive_peephole
  sorry
def sdiv6_combined := [llvmfunc|
  llvm.func @sdiv6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv6   : sdiv6_before  ⊑  sdiv6_combined := by
  unfold sdiv6_before sdiv6_combined
  simp_alive_peephole
  sorry
def udiv1_combined := [llvmfunc|
  llvm.func @udiv1(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_udiv1   : udiv1_before  ⊑  udiv1_combined := by
  unfold udiv1_before udiv1_combined
  simp_alive_peephole
  sorry
def udiv2_combined := [llvmfunc|
  llvm.func @udiv2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_udiv2   : udiv2_before  ⊑  udiv2_combined := by
  unfold udiv2_before udiv2_combined
  simp_alive_peephole
  sorry
def ashr1_combined := [llvmfunc|
  llvm.func @ashr1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.ashr %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_ashr1   : ashr1_before  ⊑  ashr1_combined := by
  unfold ashr1_before ashr1_combined
  simp_alive_peephole
  sorry
def ashr1_vec_combined := [llvmfunc|
  llvm.func @ashr1_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_ashr1_vec   : ashr1_vec_before  ⊑  ashr1_vec_combined := by
  unfold ashr1_vec_before ashr1_vec_combined
  simp_alive_peephole
  sorry
def ashr_icmp1_combined := [llvmfunc|
  llvm.func @ashr_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_icmp1   : ashr_icmp1_before  ⊑  ashr_icmp1_combined := by
  unfold ashr_icmp1_before ashr_icmp1_combined
  simp_alive_peephole
  sorry
def ashr_icmp2_combined := [llvmfunc|
  llvm.func @ashr_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_icmp2   : ashr_icmp2_before  ⊑  ashr_icmp2_combined := by
  unfold ashr_icmp2_before ashr_icmp2_combined
  simp_alive_peephole
  sorry
def ashr_icmp2_vec_combined := [llvmfunc|
  llvm.func @ashr_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ashr_icmp2_vec   : ashr_icmp2_vec_before  ⊑  ashr_icmp2_vec_combined := by
  unfold ashr_icmp2_vec_before ashr_icmp2_vec_combined
  simp_alive_peephole
  sorry
def pr9998_combined := [llvmfunc|
  llvm.func @pr9998(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_pr9998   : pr9998_before  ⊑  pr9998_combined := by
  unfold pr9998_before pr9998_combined
  simp_alive_peephole
  sorry
def pr9998vec_combined := [llvmfunc|
  llvm.func @pr9998vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<7297771788697658747> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.sub %2, %4 overflow<nsw>  : vector<2xi32>
    %6 = llvm.sext %5 : vector<2xi32> to vector<2xi64>
    %7 = llvm.icmp "ugt" %6, %3 : vector<2xi64>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_pr9998vec   : pr9998vec_before  ⊑  pr9998vec_combined := by
  unfold pr9998vec_before pr9998vec_combined
  simp_alive_peephole
  sorry
def udiv_icmp1_combined := [llvmfunc|
  llvm.func @udiv_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_udiv_icmp1   : udiv_icmp1_before  ⊑  udiv_icmp1_combined := by
  unfold udiv_icmp1_before udiv_icmp1_combined
  simp_alive_peephole
  sorry
def udiv_icmp1_vec_combined := [llvmfunc|
  llvm.func @udiv_icmp1_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_udiv_icmp1_vec   : udiv_icmp1_vec_before  ⊑  udiv_icmp1_vec_combined := by
  unfold udiv_icmp1_vec_before udiv_icmp1_vec_combined
  simp_alive_peephole
  sorry
def udiv_icmp2_combined := [llvmfunc|
  llvm.func @udiv_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_udiv_icmp2   : udiv_icmp2_before  ⊑  udiv_icmp2_combined := by
  unfold udiv_icmp2_before udiv_icmp2_combined
  simp_alive_peephole
  sorry
def udiv_icmp2_vec_combined := [llvmfunc|
  llvm.func @udiv_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_udiv_icmp2_vec   : udiv_icmp2_vec_before  ⊑  udiv_icmp2_vec_combined := by
  unfold udiv_icmp2_vec_before udiv_icmp2_vec_combined
  simp_alive_peephole
  sorry
def sdiv_icmp1_combined := [llvmfunc|
  llvm.func @sdiv_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_icmp1   : sdiv_icmp1_before  ⊑  sdiv_icmp1_combined := by
  unfold sdiv_icmp1_before sdiv_icmp1_combined
  simp_alive_peephole
  sorry
def sdiv_icmp1_vec_combined := [llvmfunc|
  llvm.func @sdiv_icmp1_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sdiv_icmp1_vec   : sdiv_icmp1_vec_before  ⊑  sdiv_icmp1_vec_combined := by
  unfold sdiv_icmp1_vec_before sdiv_icmp1_vec_combined
  simp_alive_peephole
  sorry
def sdiv_icmp2_combined := [llvmfunc|
  llvm.func @sdiv_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_icmp2   : sdiv_icmp2_before  ⊑  sdiv_icmp2_combined := by
  unfold sdiv_icmp2_before sdiv_icmp2_combined
  simp_alive_peephole
  sorry
def sdiv_icmp2_vec_combined := [llvmfunc|
  llvm.func @sdiv_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sdiv_icmp2_vec   : sdiv_icmp2_vec_before  ⊑  sdiv_icmp2_vec_combined := by
  unfold sdiv_icmp2_vec_before sdiv_icmp2_vec_combined
  simp_alive_peephole
  sorry
def sdiv_icmp3_combined := [llvmfunc|
  llvm.func @sdiv_icmp3(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_icmp3   : sdiv_icmp3_before  ⊑  sdiv_icmp3_combined := by
  unfold sdiv_icmp3_before sdiv_icmp3_combined
  simp_alive_peephole
  sorry
def sdiv_icmp3_vec_combined := [llvmfunc|
  llvm.func @sdiv_icmp3_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sdiv_icmp3_vec   : sdiv_icmp3_vec_before  ⊑  sdiv_icmp3_vec_combined := by
  unfold sdiv_icmp3_vec_before sdiv_icmp3_vec_combined
  simp_alive_peephole
  sorry
def sdiv_icmp4_combined := [llvmfunc|
  llvm.func @sdiv_icmp4(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_icmp4   : sdiv_icmp4_before  ⊑  sdiv_icmp4_combined := by
  unfold sdiv_icmp4_before sdiv_icmp4_combined
  simp_alive_peephole
  sorry
def sdiv_icmp4_vec_combined := [llvmfunc|
  llvm.func @sdiv_icmp4_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sdiv_icmp4_vec   : sdiv_icmp4_vec_before  ⊑  sdiv_icmp4_vec_combined := by
  unfold sdiv_icmp4_vec_before sdiv_icmp4_vec_combined
  simp_alive_peephole
  sorry
def sdiv_icmp5_combined := [llvmfunc|
  llvm.func @sdiv_icmp5(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_icmp5   : sdiv_icmp5_before  ⊑  sdiv_icmp5_combined := by
  unfold sdiv_icmp5_before sdiv_icmp5_combined
  simp_alive_peephole
  sorry
def sdiv_icmp5_vec_combined := [llvmfunc|
  llvm.func @sdiv_icmp5_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sdiv_icmp5_vec   : sdiv_icmp5_vec_before  ⊑  sdiv_icmp5_vec_combined := by
  unfold sdiv_icmp5_vec_before sdiv_icmp5_vec_combined
  simp_alive_peephole
  sorry
def sdiv_icmp6_combined := [llvmfunc|
  llvm.func @sdiv_icmp6(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_icmp6   : sdiv_icmp6_before  ⊑  sdiv_icmp6_combined := by
  unfold sdiv_icmp6_before sdiv_icmp6_combined
  simp_alive_peephole
  sorry
def sdiv_icmp6_vec_combined := [llvmfunc|
  llvm.func @sdiv_icmp6_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi64>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sdiv_icmp6_vec   : sdiv_icmp6_vec_before  ⊑  sdiv_icmp6_vec_combined := by
  unfold sdiv_icmp6_vec_before sdiv_icmp6_vec_combined
  simp_alive_peephole
  sorry
def mul_of_udiv_combined := [llvmfunc|
  llvm.func @mul_of_udiv(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_of_udiv   : mul_of_udiv_before  ⊑  mul_of_udiv_combined := by
  unfold mul_of_udiv_before mul_of_udiv_combined
  simp_alive_peephole
  sorry
def mul_of_sdiv_combined := [llvmfunc|
  llvm.func @mul_of_sdiv(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_of_sdiv   : mul_of_sdiv_before  ⊑  mul_of_sdiv_combined := by
  unfold mul_of_sdiv_before mul_of_sdiv_combined
  simp_alive_peephole
  sorry
def mul_of_sdiv_non_splat_combined := [llvmfunc|
  llvm.func @mul_of_sdiv_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi8>
    %3 = llvm.mul %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_mul_of_sdiv_non_splat   : mul_of_sdiv_non_splat_before  ⊑  mul_of_sdiv_non_splat_combined := by
  unfold mul_of_sdiv_non_splat_before mul_of_sdiv_non_splat_combined
  simp_alive_peephole
  sorry
def mul_of_sdiv_fail_missing_exact_combined := [llvmfunc|
  llvm.func @mul_of_sdiv_fail_missing_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_of_sdiv_fail_missing_exact   : mul_of_sdiv_fail_missing_exact_before  ⊑  mul_of_sdiv_fail_missing_exact_combined := by
  unfold mul_of_sdiv_fail_missing_exact_before mul_of_sdiv_fail_missing_exact_combined
  simp_alive_peephole
  sorry
def mul_of_udiv_fail_bad_remainder_combined := [llvmfunc|
  llvm.func @mul_of_udiv_fail_bad_remainder(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(11 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_of_udiv_fail_bad_remainder   : mul_of_udiv_fail_bad_remainder_before  ⊑  mul_of_udiv_fail_bad_remainder_combined := by
  unfold mul_of_udiv_fail_bad_remainder_before mul_of_udiv_fail_bad_remainder_combined
  simp_alive_peephole
  sorry
def mul_of_sdiv_fail_ub_combined := [llvmfunc|
  llvm.func @mul_of_sdiv_fail_ub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_mul_of_sdiv_fail_ub   : mul_of_sdiv_fail_ub_before  ⊑  mul_of_sdiv_fail_ub_combined := by
  unfold mul_of_sdiv_fail_ub_before mul_of_sdiv_fail_ub_combined
  simp_alive_peephole
  sorry
def mul_of_sdiv_fail_ub_non_splat_combined := [llvmfunc|
  llvm.func @mul_of_sdiv_fail_ub_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-6, -12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi8>
    %3 = llvm.mul %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_mul_of_sdiv_fail_ub_non_splat   : mul_of_sdiv_fail_ub_non_splat_before  ⊑  mul_of_sdiv_fail_ub_non_splat_combined := by
  unfold mul_of_sdiv_fail_ub_non_splat_before mul_of_sdiv_fail_ub_non_splat_combined
  simp_alive_peephole
  sorry

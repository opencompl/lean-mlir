import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select_meta
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shrink_select_before := [llvmfunc|
  llvm.func @shrink_select(%arg0: i1, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.select %arg0, %arg1, %0 : i1, i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

def min_max_bitcast_before := [llvmfunc|
  llvm.func @min_max_bitcast(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : vector<4xf32>
    %1 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %2 = llvm.bitcast %arg1 : vector<4xf32> to vector<4xi32>
    %3 = llvm.select %0, %1, %2 : vector<4xi1>, vector<4xi32>
    %4 = llvm.select %0, %2, %1 : vector<4xi1>, vector<4xi32>
    llvm.store %3, %arg2 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.store %4, %arg3 {alignment = 16 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.return
  }]

def test43_before := [llvmfunc|
  llvm.func @test43(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }]

def scalar_select_of_vectors_sext_before := [llvmfunc|
  llvm.func @scalar_select_of_vectors_sext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i16
    %4 = llvm.select %2, %3, %1 : i1, i16
    llvm.return %4 : i16
  }]

def abs_nabs_x01_before := [llvmfunc|
  llvm.func @abs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x01_vec_before := [llvmfunc|
  llvm.func @abs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.sub %2, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.select %3, %4, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %0 : vector<2xi32>
    %7 = llvm.sub %2, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def test30_before := [llvmfunc|
  llvm.func @test30(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }]

def test70_before := [llvmfunc|
  llvm.func @test70(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(75 : i32) : i32
    %1 = llvm.mlir.constant(36 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test72_before := [llvmfunc|
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(92 : i32) : i32
    %1 = llvm.mlir.constant(11 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def test74_before := [llvmfunc|
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mlir.constant(75 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

def smin1_before := [llvmfunc|
  llvm.func @smin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

def smin2_before := [llvmfunc|
  llvm.func @smin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def smax1_before := [llvmfunc|
  llvm.func @smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    llvm.return %4 : i32
  }]

def smax2_before := [llvmfunc|
  llvm.func @smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def umin1_before := [llvmfunc|
  llvm.func @umin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def umin2_before := [llvmfunc|
  llvm.func @umin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }]

def umax1_before := [llvmfunc|
  llvm.func @umax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def umax2_before := [llvmfunc|
  llvm.func @umax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }]

def not_cond_before := [llvmfunc|
  llvm.func @not_cond(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    llvm.return %2 : i32
  }]

def not_cond_vec_before := [llvmfunc|
  llvm.func @not_cond_vec(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.select %2, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_cond_vec_poison_before := [llvmfunc|
  llvm.func @not_cond_vec_poison(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.xor %arg0, %6  : vector<2xi1>
    %8 = llvm.select %7, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def select_add_before := [llvmfunc|
  llvm.func @select_add(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.add %arg1, %arg2  : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    llvm.return %1 : i64
  }]

def select_or_before := [llvmfunc|
  llvm.func @select_or(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.or %arg1, %arg2  : vector<2xi32>
    %1 = llvm.select %arg0, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def select_sub_before := [llvmfunc|
  llvm.func @select_sub(%arg0: i1, %arg1: i17, %arg2: i17) -> i17 {
    %0 = llvm.sub %arg1, %arg2  : i17
    %1 = llvm.select %arg0, %0, %arg1 : i1, i17
    llvm.return %1 : i17
  }]

def select_ashr_before := [llvmfunc|
  llvm.func @select_ashr(%arg0: i1, %arg1: i128, %arg2: i128) -> i128 {
    %0 = llvm.ashr %arg1, %arg2  : i128
    %1 = llvm.select %arg0, %0, %arg1 : i1, i128
    llvm.return %1 : i128
  }]

def select_fmul_before := [llvmfunc|
  llvm.func @select_fmul(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg2  : f64
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64]

    llvm.return %1 : f64
  }]

def select_fdiv_before := [llvmfunc|
  llvm.func @select_fdiv(%arg0: i1, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fdiv %arg1, %arg2  : vector<2xf32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def shrink_select_combined := [llvmfunc|
  llvm.func @shrink_select(%arg0: i1, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.select %arg0, %1, %0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shrink_select   : shrink_select_before  ⊑  shrink_select_combined := by
  unfold shrink_select_before shrink_select_combined
  simp_alive_peephole
  sorry
def min_max_bitcast_combined := [llvmfunc|
  llvm.func @min_max_bitcast(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : vector<4xf32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %2 = llvm.select %0, %arg1, %arg0 : vector<4xi1>, vector<4xf32>
    llvm.store %1, %arg2 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    llvm.store %2, %arg3 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_min_max_bitcast   : min_max_bitcast_before  ⊑  min_max_bitcast_combined := by
  unfold min_max_bitcast_before min_max_bitcast_combined
  simp_alive_peephole
  sorry
def test43_combined := [llvmfunc|
  llvm.func @test43(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test43   : test43_before  ⊑  test43_combined := by
  unfold test43_before test43_combined
  simp_alive_peephole
  sorry
def scalar_select_of_vectors_sext_combined := [llvmfunc|
  llvm.func @scalar_select_of_vectors_sext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg1, %arg0, %1 : i1, vector<2xi1>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_scalar_select_of_vectors_sext   : scalar_select_of_vectors_sext_before  ⊑  scalar_select_of_vectors_sext_combined := by
  unfold scalar_select_of_vectors_sext_before scalar_select_of_vectors_sext_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def abs_nabs_x01_combined := [llvmfunc|
  llvm.func @abs_nabs_x01(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x01   : abs_nabs_x01_before  ⊑  abs_nabs_x01_combined := by
  unfold abs_nabs_x01_before abs_nabs_x01_combined
  simp_alive_peephole
  sorry
def abs_nabs_x01_vec_combined := [llvmfunc|
  llvm.func @abs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_abs_nabs_x01_vec   : abs_nabs_x01_vec_before  ⊑  abs_nabs_x01_vec_combined := by
  unfold abs_nabs_x01_vec_before abs_nabs_x01_vec_combined
  simp_alive_peephole
  sorry
def test30_combined := [llvmfunc|
  llvm.func @test30(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test30   : test30_before  ⊑  test30_combined := by
  unfold test30_before test30_combined
  simp_alive_peephole
  sorry
def test70_combined := [llvmfunc|
  llvm.func @test70(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(75 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test70   : test70_before  ⊑  test70_combined := by
  unfold test70_before test70_combined
  simp_alive_peephole
  sorry
def test72_combined := [llvmfunc|
  llvm.func @test72(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test72   : test72_before  ⊑  test72_combined := by
  unfold test72_before test72_combined
  simp_alive_peephole
  sorry
def test74_combined := [llvmfunc|
  llvm.func @test74(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mlir.constant(75 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.umax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test74   : test74_before  ⊑  test74_combined := by
  unfold test74_before test74_combined
  simp_alive_peephole
  sorry
def smin1_combined := [llvmfunc|
  llvm.func @smin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smin1   : smin1_before  ⊑  smin1_combined := by
  unfold smin1_before smin1_combined
  simp_alive_peephole
  sorry
def smin2_combined := [llvmfunc|
  llvm.func @smin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smin2   : smin2_before  ⊑  smin2_combined := by
  unfold smin2_before smin2_combined
  simp_alive_peephole
  sorry
def smax1_combined := [llvmfunc|
  llvm.func @smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smax1   : smax1_before  ⊑  smax1_combined := by
  unfold smax1_before smax1_combined
  simp_alive_peephole
  sorry
def smax2_combined := [llvmfunc|
  llvm.func @smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smax2   : smax2_before  ⊑  smax2_combined := by
  unfold smax2_before smax2_combined
  simp_alive_peephole
  sorry
def umin1_combined := [llvmfunc|
  llvm.func @umin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umin1   : umin1_before  ⊑  umin1_combined := by
  unfold umin1_before umin1_combined
  simp_alive_peephole
  sorry
def umin2_combined := [llvmfunc|
  llvm.func @umin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umin2   : umin2_before  ⊑  umin2_combined := by
  unfold umin2_before umin2_combined
  simp_alive_peephole
  sorry
def umax1_combined := [llvmfunc|
  llvm.func @umax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umax1   : umax1_before  ⊑  umax1_combined := by
  unfold umax1_before umax1_combined
  simp_alive_peephole
  sorry
def umax2_combined := [llvmfunc|
  llvm.func @umax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_umax2   : umax2_before  ⊑  umax2_combined := by
  unfold umax2_before umax2_combined
  simp_alive_peephole
  sorry
def not_cond_combined := [llvmfunc|
  llvm.func @not_cond(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.select %arg0, %arg2, %arg1 : i1, i32
    llvm.return %0 : i32
  }]

theorem inst_combine_not_cond   : not_cond_before  ⊑  not_cond_combined := by
  unfold not_cond_before not_cond_combined
  simp_alive_peephole
  sorry
def not_cond_vec_combined := [llvmfunc|
  llvm.func @not_cond_vec(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.select %arg0, %arg2, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_not_cond_vec   : not_cond_vec_before  ⊑  not_cond_vec_combined := by
  unfold not_cond_vec_before not_cond_vec_combined
  simp_alive_peephole
  sorry
def not_cond_vec_poison_combined := [llvmfunc|
  llvm.func @not_cond_vec_poison(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.select %arg0, %arg2, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_not_cond_vec_poison   : not_cond_vec_poison_before  ⊑  not_cond_vec_poison_combined := by
  unfold not_cond_vec_poison_before not_cond_vec_poison_combined
  simp_alive_peephole
  sorry
def select_add_combined := [llvmfunc|
  llvm.func @select_add(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.select %arg0, %arg2, %0 : i1, i64
    %2 = llvm.add %1, %arg1  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_select_add   : select_add_before  ⊑  select_add_combined := by
  unfold select_add_before select_add_combined
  simp_alive_peephole
  sorry
def select_or_combined := [llvmfunc|
  llvm.func @select_or(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %arg2, %1 : vector<2xi1>, vector<2xi32>
    %3 = llvm.or %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_select_or   : select_or_before  ⊑  select_or_combined := by
  unfold select_or_before select_or_combined
  simp_alive_peephole
  sorry
def select_sub_combined := [llvmfunc|
  llvm.func @select_sub(%arg0: i1, %arg1: i17, %arg2: i17) -> i17 {
    %0 = llvm.mlir.constant(0 : i17) : i17
    %1 = llvm.select %arg0, %arg2, %0 : i1, i17
    %2 = llvm.sub %arg1, %1  : i17
    llvm.return %2 : i17
  }]

theorem inst_combine_select_sub   : select_sub_before  ⊑  select_sub_combined := by
  unfold select_sub_before select_sub_combined
  simp_alive_peephole
  sorry
def select_ashr_combined := [llvmfunc|
  llvm.func @select_ashr(%arg0: i1, %arg1: i128, %arg2: i128) -> i128 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.select %arg0, %arg2, %0 : i1, i128
    %2 = llvm.ashr %arg1, %1  : i128
    llvm.return %2 : i128
  }]

theorem inst_combine_select_ashr   : select_ashr_before  ⊑  select_ashr_combined := by
  unfold select_ashr_before select_ashr_combined
  simp_alive_peephole
  sorry
def select_fmul_combined := [llvmfunc|
  llvm.func @select_fmul(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    %2 = llvm.fmul %1, %arg1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_select_fmul   : select_fmul_before  ⊑  select_fmul_combined := by
  unfold select_fmul_before select_fmul_combined
  simp_alive_peephole
  sorry
def select_fdiv_combined := [llvmfunc|
  llvm.func @select_fdiv(%arg0: i1, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, vector<2xf32>
    %2 = llvm.fdiv %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_select_fdiv   : select_fdiv_before  ⊑  select_fdiv_combined := by
  unfold select_fdiv_before select_fdiv_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-add-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_C1_add_A_C2_i32_before := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_i32(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    llvm.return %4 : i32
  }]

def ashr_C1_add_A_C2_i32_before := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.ashr %2, %4  : i32
    llvm.return %5 : i32
  }]

def lshr_C1_add_A_C2_i32_before := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.shl %2, %4  : i32
    llvm.return %5 : i32
  }]

def shl_C1_add_A_C2_v4i32_before := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32(%arg0: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %3 = llvm.add %2, %0  : vector<4xi32>
    %4 = llvm.shl %1, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def ashr_C1_add_A_C2_v4i32_before := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.ashr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def lshr_C1_add_A_C2_v4i32_before := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.lshr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def shl_C1_add_A_C2_v4i32_splat_before := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.shl %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def ashr_C1_add_A_C2_v4i32_splat_before := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.ashr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def lshr_C1_add_A_C2_v4i32_splat_before := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.lshr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def shl_C1_add_A_C2_i32_combined := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_i32(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_C1_add_A_C2_i32   : shl_C1_add_A_C2_i32_before  ⊑  shl_C1_add_A_C2_i32_combined := by
  unfold shl_C1_add_A_C2_i32_before shl_C1_add_A_C2_i32_combined
  simp_alive_peephole
  sorry
def ashr_C1_add_A_C2_i32_combined := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_C1_add_A_C2_i32   : ashr_C1_add_A_C2_i32_before  ⊑  ashr_C1_add_A_C2_i32_combined := by
  unfold ashr_C1_add_A_C2_i32_before ashr_C1_add_A_C2_i32_combined
  simp_alive_peephole
  sorry
def lshr_C1_add_A_C2_i32_combined := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(192 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_C1_add_A_C2_i32   : lshr_C1_add_A_C2_i32_before  ⊑  lshr_C1_add_A_C2_i32_combined := by
  unfold lshr_C1_add_A_C2_i32_before lshr_C1_add_A_C2_i32_combined
  simp_alive_peephole
  sorry
def shl_C1_add_A_C2_v4i32_combined := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32(%arg0: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-458752 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %14 = llvm.shl %12, %13  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_shl_C1_add_A_C2_v4i32   : shl_C1_add_A_C2_v4i32_before  ⊑  shl_C1_add_A_C2_v4i32_combined := by
  unfold shl_C1_add_A_C2_v4i32_before shl_C1_add_A_C2_v4i32_combined
  simp_alive_peephole
  sorry
def ashr_C1_add_A_C2_v4i32_combined := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.undef : vector<4xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.and %arg0, %0  : vector<4xi32>
    %15 = llvm.ashr %13, %14  : vector<4xi32>
    llvm.return %15 : vector<4xi32>
  }]

theorem inst_combine_ashr_C1_add_A_C2_v4i32   : ashr_C1_add_A_C2_v4i32_before  ⊑  ashr_C1_add_A_C2_v4i32_combined := by
  unfold ashr_C1_add_A_C2_v4i32_before ashr_C1_add_A_C2_v4i32_combined
  simp_alive_peephole
  sorry
def lshr_C1_add_A_C2_v4i32_combined := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.undef : vector<4xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.and %arg0, %0  : vector<4xi32>
    %15 = llvm.lshr %13, %14  : vector<4xi32>
    llvm.return %15 : vector<4xi32>
  }]

theorem inst_combine_lshr_C1_add_A_C2_v4i32   : lshr_C1_add_A_C2_v4i32_before  ⊑  lshr_C1_add_A_C2_v4i32_combined := by
  unfold lshr_C1_add_A_C2_v4i32_before lshr_C1_add_A_C2_v4i32_combined
  simp_alive_peephole
  sorry
def shl_C1_add_A_C2_v4i32_splat_combined := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-458752 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %3, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.zext %arg0 : i16 to i32
    %16 = llvm.insertelement %15, %0[%1 : i64] : vector<4xi32>
    %17 = llvm.shufflevector %16, %0 [0, 0, 0, 0] : vector<4xi32> 
    %18 = llvm.shl %14, %17  : vector<4xi32>
    llvm.return %18 : vector<4xi32>
  }]

theorem inst_combine_shl_C1_add_A_C2_v4i32_splat   : shl_C1_add_A_C2_v4i32_splat_before  ⊑  shl_C1_add_A_C2_v4i32_splat_combined := by
  unfold shl_C1_add_A_C2_v4i32_splat_before shl_C1_add_A_C2_v4i32_splat_combined
  simp_alive_peephole
  sorry
def ashr_C1_add_A_C2_v4i32_splat_combined := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %3, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.zext %arg0 : i16 to i32
    %16 = llvm.insertelement %15, %0[%1 : i64] : vector<4xi32>
    %17 = llvm.shufflevector %16, %0 [0, 0, 0, 0] : vector<4xi32> 
    %18 = llvm.ashr %14, %17  : vector<4xi32>
    llvm.return %18 : vector<4xi32>
  }]

theorem inst_combine_ashr_C1_add_A_C2_v4i32_splat   : ashr_C1_add_A_C2_v4i32_splat_before  ⊑  ashr_C1_add_A_C2_v4i32_splat_combined := by
  unfold ashr_C1_add_A_C2_v4i32_splat_before ashr_C1_add_A_C2_v4i32_splat_combined
  simp_alive_peephole
  sorry
def lshr_C1_add_A_C2_v4i32_splat_combined := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %3, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.zext %arg0 : i16 to i32
    %16 = llvm.insertelement %15, %0[%1 : i64] : vector<4xi32>
    %17 = llvm.shufflevector %16, %0 [0, 0, 0, 0] : vector<4xi32> 
    %18 = llvm.lshr %14, %17  : vector<4xi32>
    llvm.return %18 : vector<4xi32>
  }]

theorem inst_combine_lshr_C1_add_A_C2_v4i32_splat   : lshr_C1_add_A_C2_v4i32_splat_before  ⊑  lshr_C1_add_A_C2_v4i32_splat_combined := by
  unfold lshr_C1_add_A_C2_v4i32_splat_before lshr_C1_add_A_C2_v4i32_splat_combined
  simp_alive_peephole
  sorry

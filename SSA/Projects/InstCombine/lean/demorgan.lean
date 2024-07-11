import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  demorgan
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def demorgan_or_apint1_before := [llvmfunc|
  llvm.func @demorgan_or_apint1(%arg0: i43, %arg1: i43) -> i43 {
    %0 = llvm.mlir.constant(-1 : i43) : i43
    %1 = llvm.xor %arg0, %0  : i43
    %2 = llvm.xor %arg1, %0  : i43
    %3 = llvm.or %1, %2  : i43
    llvm.return %3 : i43
  }]

def demorgan_or_apint2_before := [llvmfunc|
  llvm.func @demorgan_or_apint2(%arg0: i129, %arg1: i129) -> i129 {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.xor %arg0, %0  : i129
    %2 = llvm.xor %arg1, %0  : i129
    %3 = llvm.or %1, %2  : i129
    llvm.return %3 : i129
  }]

def demorgan_and_apint1_before := [llvmfunc|
  llvm.func @demorgan_and_apint1(%arg0: i477, %arg1: i477) -> i477 {
    %0 = llvm.mlir.constant(-1 : i477) : i477
    %1 = llvm.xor %arg0, %0  : i477
    %2 = llvm.xor %arg1, %0  : i477
    %3 = llvm.and %1, %2  : i477
    llvm.return %3 : i477
  }]

def demorgan_and_apint2_before := [llvmfunc|
  llvm.func @demorgan_and_apint2(%arg0: i129, %arg1: i129) -> i129 {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.xor %arg0, %0  : i129
    %2 = llvm.xor %arg1, %0  : i129
    %3 = llvm.and %1, %2  : i129
    llvm.return %3 : i129
  }]

def demorgan_and_apint3_before := [llvmfunc|
  llvm.func @demorgan_and_apint3(%arg0: i65, %arg1: i65) -> i65 {
    %0 = llvm.mlir.constant(-1 : i65) : i65
    %1 = llvm.xor %arg0, %0  : i65
    %2 = llvm.xor %0, %arg1  : i65
    %3 = llvm.and %1, %2  : i65
    llvm.return %3 : i65
  }]

def demorgan_and_apint4_before := [llvmfunc|
  llvm.func @demorgan_and_apint4(%arg0: i66, %arg1: i66) -> i66 {
    %0 = llvm.mlir.constant(-1 : i66) : i66
    %1 = llvm.xor %arg0, %0  : i66
    %2 = llvm.xor %arg1, %0  : i66
    %3 = llvm.and %1, %2  : i66
    llvm.return %3 : i66
  }]

def demorgan_and_apint5_before := [llvmfunc|
  llvm.func @demorgan_and_apint5(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-1 : i47) : i47
    %1 = llvm.xor %arg0, %0  : i47
    %2 = llvm.xor %arg1, %0  : i47
    %3 = llvm.and %1, %2  : i47
    llvm.return %3 : i47
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

def test3_apint_before := [llvmfunc|
  llvm.func @test3_apint(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-1 : i47) : i47
    %1 = llvm.xor %arg0, %0  : i47
    %2 = llvm.xor %arg1, %0  : i47
    %3 = llvm.and %1, %2  : i47
    %4 = llvm.xor %3, %0  : i47
    llvm.return %4 : i47
  }]

def test4_apint_before := [llvmfunc|
  llvm.func @test4_apint(%arg0: i61) -> i61 {
    %0 = llvm.mlir.constant(-1 : i61) : i61
    %1 = llvm.mlir.constant(5 : i61) : i61
    %2 = llvm.xor %arg0, %0  : i61
    %3 = llvm.and %2, %1  : i61
    %4 = llvm.xor %3, %0  : i61
    llvm.return %3 : i61
  }]

def test5_apint_before := [llvmfunc|
  llvm.func @test5_apint(%arg0: i71, %arg1: i71) -> i71 {
    %0 = llvm.mlir.constant(-1 : i71) : i71
    %1 = llvm.xor %arg0, %0  : i71
    %2 = llvm.xor %arg1, %0  : i71
    %3 = llvm.or %1, %2  : i71
    %4 = llvm.xor %3, %0  : i71
    llvm.return %4 : i71
  }]

def demorgan_nand_before := [llvmfunc|
  llvm.func @demorgan_nand(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def demorgan_nand_apint1_before := [llvmfunc|
  llvm.func @demorgan_nand_apint1(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.xor %arg0, %0  : i7
    %2 = llvm.and %1, %arg1  : i7
    %3 = llvm.xor %2, %0  : i7
    llvm.return %3 : i7
  }]

def demorgan_nand_apint2_before := [llvmfunc|
  llvm.func @demorgan_nand_apint2(%arg0: i117, %arg1: i117) -> i117 {
    %0 = llvm.mlir.constant(-1 : i117) : i117
    %1 = llvm.xor %arg0, %0  : i117
    %2 = llvm.and %1, %arg1  : i117
    %3 = llvm.xor %2, %0  : i117
    llvm.return %3 : i117
  }]

def demorgan_nor_before := [llvmfunc|
  llvm.func @demorgan_nor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.or %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def demorgan_nor_use2a_before := [llvmfunc|
  llvm.func @demorgan_nor_use2a(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    %4 = llvm.or %2, %arg1  : i8
    %5 = llvm.xor %4, %0  : i8
    %6 = llvm.sdiv %5, %3  : i8
    llvm.return %6 : i8
  }]

def demorgan_nor_use2b_before := [llvmfunc|
  llvm.func @demorgan_nor_use2b(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.sdiv %5, %2  : i8
    llvm.return %6 : i8
  }]

def demorgan_nor_use2c_before := [llvmfunc|
  llvm.func @demorgan_nor_use2c(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %arg1  : i8
    %4 = llvm.mul %3, %1  : i8
    %5 = llvm.xor %3, %0  : i8
    %6 = llvm.sdiv %5, %4  : i8
    llvm.return %6 : i8
  }]

def demorgan_nor_use2ab_before := [llvmfunc|
  llvm.func @demorgan_nor_use2ab(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(17 : i8) : i8
    %3 = llvm.mul %arg1, %0  : i8
    %4 = llvm.xor %arg0, %1  : i8
    %5 = llvm.mul %4, %2  : i8
    %6 = llvm.or %4, %arg1  : i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.sdiv %7, %3  : i8
    %9 = llvm.sdiv %8, %5  : i8
    llvm.return %9 : i8
  }]

def demorgan_nor_use2ac_before := [llvmfunc|
  llvm.func @demorgan_nor_use2ac(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    %2 = llvm.mlir.constant(23 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.mul %3, %1  : i8
    %5 = llvm.or %3, %arg1  : i8
    %6 = llvm.mul %5, %2  : i8
    %7 = llvm.xor %5, %0  : i8
    %8 = llvm.sdiv %7, %6  : i8
    %9 = llvm.sdiv %8, %4  : i8
    llvm.return %9 : i8
  }]

def demorgan_nor_use2bc_before := [llvmfunc|
  llvm.func @demorgan_nor_use2bc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.mul %4, %0  : i8
    %6 = llvm.xor %4, %1  : i8
    %7 = llvm.sdiv %6, %5  : i8
    %8 = llvm.sdiv %7, %2  : i8
    llvm.return %8 : i8
  }]

def demorganize_constant1_before := [llvmfunc|
  llvm.func @demorganize_constant1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def demorganize_constant2_before := [llvmfunc|
  llvm.func @demorganize_constant2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def demorgan_or_zext_before := [llvmfunc|
  llvm.func @demorgan_or_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

def demorgan_and_zext_before := [llvmfunc|
  llvm.func @demorgan_and_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

def demorgan_or_zext_vec_before := [llvmfunc|
  llvm.func @demorgan_or_zext_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.xor %1, %0  : vector<2xi32>
    %4 = llvm.xor %2, %0  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def demorgan_and_zext_vec_before := [llvmfunc|
  llvm.func @demorgan_and_zext_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.xor %1, %0  : vector<2xi32>
    %4 = llvm.xor %2, %0  : vector<2xi32>
    %5 = llvm.and %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def PR28476_before := [llvmfunc|
  llvm.func @PR28476(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

def PR28476_logical_before := [llvmfunc|
  llvm.func @PR28476_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg1, %0 : i32
    %5 = llvm.select %3, %4, %1 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.xor %6, %2  : i32
    llvm.return %7 : i32
  }]

def demorgan_plus_and_to_xor_before := [llvmfunc|
  llvm.func @demorgan_plus_and_to_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.or %3, %2  : i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

def demorgan_plus_and_to_xor_vec_before := [llvmfunc|
  llvm.func @demorgan_plus_and_to_xor_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.or %arg0, %arg1  : vector<4xi32>
    %2 = llvm.xor %1, %0  : vector<4xi32>
    %3 = llvm.and %arg0, %arg1  : vector<4xi32>
    %4 = llvm.or %3, %2  : vector<4xi32>
    %5 = llvm.xor %4, %0  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def PR45984_before := [llvmfunc|
  llvm.func @PR45984(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def demorgan_or_apint1_combined := [llvmfunc|
  llvm.func @demorgan_or_apint1(%arg0: i43, %arg1: i43) -> i43 {
    %0 = llvm.mlir.constant(-1 : i43) : i43
    %1 = llvm.and %arg0, %arg1  : i43
    %2 = llvm.xor %1, %0  : i43
    llvm.return %2 : i43
  }]

theorem inst_combine_demorgan_or_apint1   : demorgan_or_apint1_before  ⊑  demorgan_or_apint1_combined := by
  unfold demorgan_or_apint1_before demorgan_or_apint1_combined
  simp_alive_peephole
  sorry
def demorgan_or_apint2_combined := [llvmfunc|
  llvm.func @demorgan_or_apint2(%arg0: i129, %arg1: i129) -> i129 {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.and %arg0, %arg1  : i129
    %2 = llvm.xor %1, %0  : i129
    llvm.return %2 : i129
  }]

theorem inst_combine_demorgan_or_apint2   : demorgan_or_apint2_before  ⊑  demorgan_or_apint2_combined := by
  unfold demorgan_or_apint2_before demorgan_or_apint2_combined
  simp_alive_peephole
  sorry
def demorgan_and_apint1_combined := [llvmfunc|
  llvm.func @demorgan_and_apint1(%arg0: i477, %arg1: i477) -> i477 {
    %0 = llvm.mlir.constant(-1 : i477) : i477
    %1 = llvm.or %arg0, %arg1  : i477
    %2 = llvm.xor %1, %0  : i477
    llvm.return %2 : i477
  }]

theorem inst_combine_demorgan_and_apint1   : demorgan_and_apint1_before  ⊑  demorgan_and_apint1_combined := by
  unfold demorgan_and_apint1_before demorgan_and_apint1_combined
  simp_alive_peephole
  sorry
def demorgan_and_apint2_combined := [llvmfunc|
  llvm.func @demorgan_and_apint2(%arg0: i129, %arg1: i129) -> i129 {
    %0 = llvm.mlir.constant(-1 : i129) : i129
    %1 = llvm.or %arg0, %arg1  : i129
    %2 = llvm.xor %1, %0  : i129
    llvm.return %2 : i129
  }]

theorem inst_combine_demorgan_and_apint2   : demorgan_and_apint2_before  ⊑  demorgan_and_apint2_combined := by
  unfold demorgan_and_apint2_before demorgan_and_apint2_combined
  simp_alive_peephole
  sorry
def demorgan_and_apint3_combined := [llvmfunc|
  llvm.func @demorgan_and_apint3(%arg0: i65, %arg1: i65) -> i65 {
    %0 = llvm.mlir.constant(-1 : i65) : i65
    %1 = llvm.or %arg0, %arg1  : i65
    %2 = llvm.xor %1, %0  : i65
    llvm.return %2 : i65
  }]

theorem inst_combine_demorgan_and_apint3   : demorgan_and_apint3_before  ⊑  demorgan_and_apint3_combined := by
  unfold demorgan_and_apint3_before demorgan_and_apint3_combined
  simp_alive_peephole
  sorry
def demorgan_and_apint4_combined := [llvmfunc|
  llvm.func @demorgan_and_apint4(%arg0: i66, %arg1: i66) -> i66 {
    %0 = llvm.mlir.constant(-1 : i66) : i66
    %1 = llvm.or %arg0, %arg1  : i66
    %2 = llvm.xor %1, %0  : i66
    llvm.return %2 : i66
  }]

theorem inst_combine_demorgan_and_apint4   : demorgan_and_apint4_before  ⊑  demorgan_and_apint4_combined := by
  unfold demorgan_and_apint4_before demorgan_and_apint4_combined
  simp_alive_peephole
  sorry
def demorgan_and_apint5_combined := [llvmfunc|
  llvm.func @demorgan_and_apint5(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-1 : i47) : i47
    %1 = llvm.or %arg0, %arg1  : i47
    %2 = llvm.xor %1, %0  : i47
    llvm.return %2 : i47
  }]

theorem inst_combine_demorgan_and_apint5   : demorgan_and_apint5_before  ⊑  demorgan_and_apint5_combined := by
  unfold demorgan_and_apint5_before demorgan_and_apint5_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test3_apint_combined := [llvmfunc|
  llvm.func @test3_apint(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.or %arg0, %arg1  : i47
    llvm.return %0 : i47
  }]

theorem inst_combine_test3_apint   : test3_apint_before  ⊑  test3_apint_combined := by
  unfold test3_apint_before test3_apint_combined
  simp_alive_peephole
  sorry
def test4_apint_combined := [llvmfunc|
  llvm.func @test4_apint(%arg0: i61) -> i61 {
    %0 = llvm.mlir.constant(5 : i61) : i61
    %1 = llvm.and %arg0, %0  : i61
    %2 = llvm.xor %1, %0  : i61
    llvm.return %2 : i61
  }]

theorem inst_combine_test4_apint   : test4_apint_before  ⊑  test4_apint_combined := by
  unfold test4_apint_before test4_apint_combined
  simp_alive_peephole
  sorry
def test5_apint_combined := [llvmfunc|
  llvm.func @test5_apint(%arg0: i71, %arg1: i71) -> i71 {
    %0 = llvm.and %arg0, %arg1  : i71
    llvm.return %0 : i71
  }]

theorem inst_combine_test5_apint   : test5_apint_before  ⊑  test5_apint_combined := by
  unfold test5_apint_before test5_apint_combined
  simp_alive_peephole
  sorry
def demorgan_nand_combined := [llvmfunc|
  llvm.func @demorgan_nand(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_demorgan_nand   : demorgan_nand_before  ⊑  demorgan_nand_combined := by
  unfold demorgan_nand_before demorgan_nand_combined
  simp_alive_peephole
  sorry
def demorgan_nand_apint1_combined := [llvmfunc|
  llvm.func @demorgan_nand_apint1(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.xor %arg1, %0  : i7
    %2 = llvm.or %1, %arg0  : i7
    llvm.return %2 : i7
  }]

theorem inst_combine_demorgan_nand_apint1   : demorgan_nand_apint1_before  ⊑  demorgan_nand_apint1_combined := by
  unfold demorgan_nand_apint1_before demorgan_nand_apint1_combined
  simp_alive_peephole
  sorry
def demorgan_nand_apint2_combined := [llvmfunc|
  llvm.func @demorgan_nand_apint2(%arg0: i117, %arg1: i117) -> i117 {
    %0 = llvm.mlir.constant(-1 : i117) : i117
    %1 = llvm.xor %arg1, %0  : i117
    %2 = llvm.or %1, %arg0  : i117
    llvm.return %2 : i117
  }]

theorem inst_combine_demorgan_nand_apint2   : demorgan_nand_apint2_before  ⊑  demorgan_nand_apint2_combined := by
  unfold demorgan_nand_apint2_before demorgan_nand_apint2_combined
  simp_alive_peephole
  sorry
def demorgan_nor_combined := [llvmfunc|
  llvm.func @demorgan_nor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_demorgan_nor   : demorgan_nor_before  ⊑  demorgan_nor_combined := by
  unfold demorgan_nor_before demorgan_nor_combined
  simp_alive_peephole
  sorry
def demorgan_nor_use2a_combined := [llvmfunc|
  llvm.func @demorgan_nor_use2a(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    %4 = llvm.xor %arg1, %0  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.sdiv %5, %3  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_demorgan_nor_use2a   : demorgan_nor_use2a_before  ⊑  demorgan_nor_use2a_combined := by
  unfold demorgan_nor_use2a_before demorgan_nor_use2a_combined
  simp_alive_peephole
  sorry
def demorgan_nor_use2b_combined := [llvmfunc|
  llvm.func @demorgan_nor_use2b(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.sdiv %4, %2  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_demorgan_nor_use2b   : demorgan_nor_use2b_before  ⊑  demorgan_nor_use2b_combined := by
  unfold demorgan_nor_use2b_before demorgan_nor_use2b_combined
  simp_alive_peephole
  sorry
def demorgan_nor_use2c_combined := [llvmfunc|
  llvm.func @demorgan_nor_use2c(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %arg1  : i8
    %4 = llvm.mul %3, %1  : i8
    %5 = llvm.xor %3, %0  : i8
    %6 = llvm.sdiv %5, %4  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_demorgan_nor_use2c   : demorgan_nor_use2c_before  ⊑  demorgan_nor_use2c_combined := by
  unfold demorgan_nor_use2c_before demorgan_nor_use2c_combined
  simp_alive_peephole
  sorry
def demorgan_nor_use2ab_combined := [llvmfunc|
  llvm.func @demorgan_nor_use2ab(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(17 : i8) : i8
    %3 = llvm.mul %arg1, %0  : i8
    %4 = llvm.xor %arg0, %1  : i8
    %5 = llvm.mul %4, %2  : i8
    %6 = llvm.xor %arg1, %1  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.sdiv %7, %3  : i8
    %9 = llvm.sdiv %8, %5  : i8
    llvm.return %9 : i8
  }]

theorem inst_combine_demorgan_nor_use2ab   : demorgan_nor_use2ab_before  ⊑  demorgan_nor_use2ab_combined := by
  unfold demorgan_nor_use2ab_before demorgan_nor_use2ab_combined
  simp_alive_peephole
  sorry
def demorgan_nor_use2ac_combined := [llvmfunc|
  llvm.func @demorgan_nor_use2ac(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    %2 = llvm.mlir.constant(23 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.mul %3, %1  : i8
    %5 = llvm.or %3, %arg1  : i8
    %6 = llvm.mul %5, %2  : i8
    %7 = llvm.xor %5, %0  : i8
    %8 = llvm.sdiv %7, %6  : i8
    %9 = llvm.sdiv %8, %4  : i8
    llvm.return %9 : i8
  }]

theorem inst_combine_demorgan_nor_use2ac   : demorgan_nor_use2ac_before  ⊑  demorgan_nor_use2ac_combined := by
  unfold demorgan_nor_use2ac_before demorgan_nor_use2ac_combined
  simp_alive_peephole
  sorry
def demorgan_nor_use2bc_combined := [llvmfunc|
  llvm.func @demorgan_nor_use2bc(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.mul %4, %0  : i8
    %6 = llvm.xor %4, %1  : i8
    %7 = llvm.sdiv %6, %5  : i8
    %8 = llvm.sdiv %7, %2  : i8
    llvm.return %8 : i8
  }]

theorem inst_combine_demorgan_nor_use2bc   : demorgan_nor_use2bc_before  ⊑  demorgan_nor_use2bc_combined := by
  unfold demorgan_nor_use2bc_before demorgan_nor_use2bc_combined
  simp_alive_peephole
  sorry
def demorganize_constant1_combined := [llvmfunc|
  llvm.func @demorganize_constant1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_demorganize_constant1   : demorganize_constant1_before  ⊑  demorganize_constant1_combined := by
  unfold demorganize_constant1_before demorganize_constant1_combined
  simp_alive_peephole
  sorry
def demorganize_constant2_combined := [llvmfunc|
  llvm.func @demorganize_constant2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_demorganize_constant2   : demorganize_constant2_before  ⊑  demorganize_constant2_combined := by
  unfold demorganize_constant2_before demorganize_constant2_combined
  simp_alive_peephole
  sorry
def demorgan_or_zext_combined := [llvmfunc|
  llvm.func @demorgan_or_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_demorgan_or_zext   : demorgan_or_zext_before  ⊑  demorgan_or_zext_combined := by
  unfold demorgan_or_zext_before demorgan_or_zext_combined
  simp_alive_peephole
  sorry
def demorgan_and_zext_combined := [llvmfunc|
  llvm.func @demorgan_and_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_demorgan_and_zext   : demorgan_and_zext_before  ⊑  demorgan_and_zext_combined := by
  unfold demorgan_and_zext_before demorgan_and_zext_combined
  simp_alive_peephole
  sorry
def demorgan_or_zext_vec_combined := [llvmfunc|
  llvm.func @demorgan_or_zext_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.and %arg0, %arg1  : vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_demorgan_or_zext_vec   : demorgan_or_zext_vec_before  ⊑  demorgan_or_zext_vec_combined := by
  unfold demorgan_or_zext_vec_before demorgan_or_zext_vec_combined
  simp_alive_peephole
  sorry
def demorgan_and_zext_vec_combined := [llvmfunc|
  llvm.func @demorgan_and_zext_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.or %arg0, %arg1  : vector<2xi1>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_demorgan_and_zext_vec   : demorgan_and_zext_vec_before  ⊑  demorgan_and_zext_vec_combined := by
  unfold demorgan_and_zext_vec_before demorgan_and_zext_vec_combined
  simp_alive_peephole
  sorry
def PR28476_combined := [llvmfunc|
  llvm.func @PR28476(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "eq" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR28476   : PR28476_before  ⊑  PR28476_combined := by
  unfold PR28476_before PR28476_combined
  simp_alive_peephole
  sorry
def PR28476_logical_combined := [llvmfunc|
  llvm.func @PR28476_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_PR28476_logical   : PR28476_logical_before  ⊑  PR28476_logical_combined := by
  unfold PR28476_logical_before PR28476_logical_combined
  simp_alive_peephole
  sorry
def demorgan_plus_and_to_xor_combined := [llvmfunc|
  llvm.func @demorgan_plus_and_to_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_demorgan_plus_and_to_xor   : demorgan_plus_and_to_xor_before  ⊑  demorgan_plus_and_to_xor_combined := by
  unfold demorgan_plus_and_to_xor_before demorgan_plus_and_to_xor_combined
  simp_alive_peephole
  sorry
def demorgan_plus_and_to_xor_vec_combined := [llvmfunc|
  llvm.func @demorgan_plus_and_to_xor_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.xor %arg0, %arg1  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_demorgan_plus_and_to_xor_vec   : demorgan_plus_and_to_xor_vec_before  ⊑  demorgan_plus_and_to_xor_vec_combined := by
  unfold demorgan_plus_and_to_xor_vec_before demorgan_plus_and_to_xor_vec_combined
  simp_alive_peephole
  sorry
def PR45984_combined := [llvmfunc|
  llvm.func @PR45984(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_PR45984   : PR45984_before  ⊑  PR45984_combined := by
  unfold PR45984_before PR45984_combined
  simp_alive_peephole
  sorry

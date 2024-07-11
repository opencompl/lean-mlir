import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    "llvm.intr.assume"(%6) : (i1) -> ()
    %7 = llvm.and %arg0, %3  : i32
    llvm.return %7 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(-11 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    "llvm.intr.assume"(%6) : (i1) -> ()
    %7 = llvm.and %arg0, %3  : i32
    llvm.return %7 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.mlir.constant(63 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(252 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(252 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.mlir.constant(3072 : i32) : i32
    %2 = llvm.icmp "ule" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %2 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %2 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(257 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry

import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strlen(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @nullstring : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %4 : i1
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7() -> i1 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    llvm.return %4 : i1
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant("longer\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @longer : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @strlen(%4) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test_simplify10_inbounds_before := [llvmfunc|
  llvm.func @test_simplify10_inbounds(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_simplify10_no_inbounds_before := [llvmfunc|
  llvm.func @test_simplify10_no_inbounds(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_simplify11_before := [llvmfunc|
  llvm.func @test_simplify11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @strlen(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def test_no_simplify2_before := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_no_simplify2_no_null_opt_before := [llvmfunc|
  llvm.func @test_no_simplify2_no_null_opt(%arg0: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_no_simplify3_before := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

def test_no_simplify3_on_null_opt_before := [llvmfunc|
  llvm.func @test_no_simplify3_on_null_opt(%arg0: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

def strlen0_after_write_to_first_byte_global_before := [llvmfunc|
  llvm.func @strlen0_after_write_to_first_byte_global() -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %3 {alignment = 16 : i64} : i8, !llvm.ptr]

    %5 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    %6 = llvm.icmp "eq" %5, %4 : i32
    llvm.return %6 : i1
  }]

def strlen0_after_write_to_second_byte_global_before := [llvmfunc|
  llvm.func @strlen0_after_write_to_second_byte_global() -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    %7 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %6 {alignment = 16 : i64} : i8, !llvm.ptr]

    %8 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    %9 = llvm.icmp "eq" %8, %7 : i32
    llvm.return %9 : i1
  }]

def strlen0_after_write_to_first_byte_before := [llvmfunc|
  llvm.func @strlen0_after_write_to_first_byte(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    %2 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def strlen0_after_write_to_second_byte_before := [llvmfunc|
  llvm.func @strlen0_after_write_to_second_byte(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(49 : i8) : i8
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    %4 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_inbounds_combined := [llvmfunc|
  llvm.func @test_simplify10_inbounds(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify10_inbounds   : test_simplify10_inbounds_before  ⊑  test_simplify10_inbounds_combined := by
  unfold test_simplify10_inbounds_before test_simplify10_inbounds_combined
  simp_alive_peephole
  sorry
def test_simplify10_no_inbounds_combined := [llvmfunc|
  llvm.func @test_simplify10_no_inbounds(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify10_no_inbounds   : test_simplify10_no_inbounds_before  ⊑  test_simplify10_no_inbounds_combined := by
  unfold test_simplify10_no_inbounds_before test_simplify10_no_inbounds_combined
  simp_alive_peephole
  sorry
def test_simplify11_combined := [llvmfunc|
  llvm.func @test_simplify11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_simplify11   : test_simplify11_before  ⊑  test_simplify11_combined := by
  unfold test_simplify11_before test_simplify11_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @strlen(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_combined := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_no_simplify2   : test_no_simplify2_before  ⊑  test_no_simplify2_combined := by
  unfold test_no_simplify2_before test_no_simplify2_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_no_null_opt_combined := [llvmfunc|
  llvm.func @test_no_simplify2_no_null_opt(%arg0: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_no_simplify2_no_null_opt   : test_no_simplify2_no_null_opt_before  ⊑  test_no_simplify2_no_null_opt_combined := by
  unfold test_no_simplify2_no_null_opt_before test_no_simplify2_no_null_opt_combined
  simp_alive_peephole
  sorry
def test_no_simplify3_combined := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_no_simplify3   : test_no_simplify3_before  ⊑  test_no_simplify3_combined := by
  unfold test_no_simplify3_before test_no_simplify3_combined
  simp_alive_peephole
  sorry
def test_no_simplify3_on_null_opt_combined := [llvmfunc|
  llvm.func @test_no_simplify3_on_null_opt(%arg0: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_no_simplify3_on_null_opt   : test_no_simplify3_on_null_opt_before  ⊑  test_no_simplify3_on_null_opt_combined := by
  unfold test_no_simplify3_on_null_opt_before test_no_simplify3_on_null_opt_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def strlen0_after_write_to_first_byte_global_combined := [llvmfunc|
  llvm.func @strlen0_after_write_to_first_byte_global() -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.mlir.constant(false) : i1
    llvm.store %0, %3 {alignment = 16 : i64} : i8, !llvm.ptr]

theorem inst_combine_strlen0_after_write_to_first_byte_global   : strlen0_after_write_to_first_byte_global_before  ⊑  strlen0_after_write_to_first_byte_global_combined := by
  unfold strlen0_after_write_to_first_byte_global_before strlen0_after_write_to_first_byte_global_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i1
  }]

theorem inst_combine_strlen0_after_write_to_first_byte_global   : strlen0_after_write_to_first_byte_global_before  ⊑  strlen0_after_write_to_first_byte_global_combined := by
  unfold strlen0_after_write_to_first_byte_global_before strlen0_after_write_to_first_byte_global_combined
  simp_alive_peephole
  sorry
def strlen0_after_write_to_second_byte_global_combined := [llvmfunc|
  llvm.func @strlen0_after_write_to_second_byte_global() -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<32 x i8>
    llvm.store %0, %6 {alignment = 16 : i64} : i8, !llvm.ptr]

theorem inst_combine_strlen0_after_write_to_second_byte_global   : strlen0_after_write_to_second_byte_global_before  ⊑  strlen0_after_write_to_second_byte_global_combined := by
  unfold strlen0_after_write_to_second_byte_global_before strlen0_after_write_to_second_byte_global_combined
  simp_alive_peephole
  sorry
    %7 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_strlen0_after_write_to_second_byte_global   : strlen0_after_write_to_second_byte_global_before  ⊑  strlen0_after_write_to_second_byte_global_combined := by
  unfold strlen0_after_write_to_second_byte_global_before strlen0_after_write_to_second_byte_global_combined
  simp_alive_peephole
  sorry
    %8 = llvm.icmp "eq" %7, %3 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_strlen0_after_write_to_second_byte_global   : strlen0_after_write_to_second_byte_global_before  ⊑  strlen0_after_write_to_second_byte_global_combined := by
  unfold strlen0_after_write_to_second_byte_global_before strlen0_after_write_to_second_byte_global_combined
  simp_alive_peephole
  sorry
def strlen0_after_write_to_first_byte_combined := [llvmfunc|
  llvm.func @strlen0_after_write_to_first_byte(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_strlen0_after_write_to_first_byte   : strlen0_after_write_to_first_byte_before  ⊑  strlen0_after_write_to_first_byte_combined := by
  unfold strlen0_after_write_to_first_byte_before strlen0_after_write_to_first_byte_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_strlen0_after_write_to_first_byte   : strlen0_after_write_to_first_byte_before  ⊑  strlen0_after_write_to_first_byte_combined := by
  unfold strlen0_after_write_to_first_byte_before strlen0_after_write_to_first_byte_combined
  simp_alive_peephole
  sorry
def strlen0_after_write_to_second_byte_combined := [llvmfunc|
  llvm.func @strlen0_after_write_to_second_byte(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(49 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_strlen0_after_write_to_second_byte   : strlen0_after_write_to_second_byte_before  ⊑  strlen0_after_write_to_second_byte_combined := by
  unfold strlen0_after_write_to_second_byte_before strlen0_after_write_to_second_byte_combined
  simp_alive_peephole
  sorry
    %4 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_strlen0_after_write_to_second_byte   : strlen0_after_write_to_second_byte_before  ⊑  strlen0_after_write_to_second_byte_combined := by
  unfold strlen0_after_write_to_second_byte_before strlen0_after_write_to_second_byte_combined
  simp_alive_peephole
  sorry
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_strlen0_after_write_to_second_byte   : strlen0_after_write_to_second_byte_before  ⊑  strlen0_after_write_to_second_byte_combined := by
  unfold strlen0_after_write_to_second_byte_before strlen0_after_write_to_second_byte_combined
  simp_alive_peephole
  sorry

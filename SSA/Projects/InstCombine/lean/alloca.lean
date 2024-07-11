import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @int : !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.array<0 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%3) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %4 = llvm.alloca %1 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%4) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %5 = llvm.alloca %0 x !llvm.struct<()> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%5) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %7 = llvm.alloca %6 x !llvm.struct<(struct<()>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%7) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32)>
    llvm.store %2, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.return %0 : !llvm.ptr
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %5, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.store %1, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %5 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %3, %5 atomic release {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %4, %5 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.addrspacecast %7 : !llvm.ptr to !llvm.ptr<1>
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr<1>]

    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store volatile %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.call @f(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @opaque_global : !llvm.ptr
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.struct<"real_type", (struct<(i32, ptr)>)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%3, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.stacksave : !llvm.ptr
    %3 = llvm.alloca inalloca %0 x !llvm.struct<packed (struct<"struct_type", (i32, i32)>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%3, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.call @test9_aux(%3) : (!llvm.ptr) -> ()
    llvm.intr.stackrestore %2 : !llvm.ptr
    llvm.return
  }]

def test10_before := [llvmfunc|
  llvm.func @test10() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1 : i33) : i33
    %3 = llvm.alloca %0 x i1 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %1 x i1 {alignment = 8 : i64} : (i64) -> !llvm.ptr]

    %5 = llvm.alloca %2 x i1 {alignment = 8 : i64} : (i33) -> !llvm.ptr]

    llvm.call @use(%3, %4, %5) vararg(!llvm.func<void (...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test11_before := [llvmfunc|
  llvm.func @test11() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @int : !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @use(%2) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_inalloca_with_element_count_before := [llvmfunc|
  llvm.func @test_inalloca_with_element_count(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.alloca inalloca %0 x !llvm.struct<"struct_type", (i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @test9_aux(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<0 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() {
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() {
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() {
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @f(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() {
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<100 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca inalloca %0 x !llvm.struct<packed (struct<"struct_type", (i32, i32)>)> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.store %2, %1 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.call @test9_aux(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i1 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i1 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i1 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%1, %2, %3) vararg(!llvm.func<void (...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @int : !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%2) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test_inalloca_with_element_count_combined := [llvmfunc|
  llvm.func @test_inalloca_with_element_count(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca inalloca %0 x !llvm.array<10 x struct<"struct_type", (i32, i32)>> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @test9_aux(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_inalloca_with_element_count   : test_inalloca_with_element_count_before  ⊑  test_inalloca_with_element_count_combined := by
  unfold test_inalloca_with_element_count_before test_inalloca_with_element_count_combined
  simp_alive_peephole
  sorry

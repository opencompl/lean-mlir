import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    llvm.call @test1a(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test1_as1_illegal_before := [llvmfunc|
  llvm.func @test1_as1_illegal(%arg0: !llvm.ptr<1>) {
    %0 = llvm.mlir.addressof @test1a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr<1>) -> ()
    llvm.return
  }]

def test1_as1_before := [llvmfunc|
  llvm.func @test1_as1(%arg0: !llvm.ptr<1>) {
    llvm.call @test1a_as1(%arg0) : (!llvm.ptr<1>) -> ()
    llvm.return
  }]

def test2a_before := [llvmfunc|
  llvm.func @test2a(%arg0: i8) {
    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @test2a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (i32) -> ()
    llvm.return %arg0 : i32
  }]

def test3a_before := [llvmfunc|
  llvm.func @test3a(%arg0: i8, ...) {
    llvm.unreachable
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i8, %arg1: i8) {
    %0 = llvm.mlir.addressof @test3a : !llvm.ptr
    llvm.call %0(%arg0, %arg1) : !llvm.ptr, (i8, i8) -> ()
    llvm.return
  }]

def test4a_before := [llvmfunc|
  llvm.func @test4a() -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.addressof @test4a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() -> i32 {
    %0 = llvm.call @test5a() : () -> i32
    llvm.return %0 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6() -> i32 {
    %0 = llvm.mlir.addressof @test6a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }]

def test7a_before := [llvmfunc|
  llvm.func @test7a() {
    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.addressof @test7a : !llvm.ptr
    %1 = llvm.mlir.constant(5 : i32) : i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8() -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.invoke @test8a() to ^bb1 unwind ^bb2 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %1 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["noredzone", "nounwind", "ssp"]} {
    %0 = llvm.mlir.addressof @test9x : !llvm.ptr
    %1 = llvm.call %0(%arg0, %arg1) : !llvm.ptr, (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.vec<2 x ptr>) {
    llvm.call @test10a(%arg0) : (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }]

def test10_mixed_as_before := [llvmfunc|
  llvm.func @test10_mixed_as(%arg0: !llvm.vec<2 x ptr>) {
    %0 = llvm.mlir.addressof @test10a_mixed_as : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }]

def test11a_before := [llvmfunc|
  llvm.func @test11a() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test11_before := [llvmfunc|
  llvm.func @test11() -> !llvm.ptr {
    %0 = llvm.call @test11a() : () -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test11a_mixed_as_before := [llvmfunc|
  llvm.func @test11a_mixed_as() -> !llvm.ptr<1> {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    llvm.return %0 : !llvm.ptr<1>
  }]

def test11_mixed_as_before := [llvmfunc|
  llvm.func @test11_mixed_as() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @test11a_mixed_as : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test12a_before := [llvmfunc|
  llvm.func @test12a() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    llvm.return %5 : !llvm.vec<2 x ptr>
  }]

def test12_before := [llvmfunc|
  llvm.func @test12() -> !llvm.vec<2 x ptr> {
    %0 = llvm.call @test12a() : () -> !llvm.vec<2 x ptr>
    llvm.return %0 : !llvm.vec<2 x ptr>
  }]

def test12a_mixed_as_before := [llvmfunc|
  llvm.func @test12a_mixed_as() -> !llvm.vec<2 x ptr<1>> {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr<1>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr<1>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr<1>>
    llvm.return %5 : !llvm.vec<2 x ptr<1>>
  }]

def test12_mixed_as_before := [llvmfunc|
  llvm.func @test12_mixed_as() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.addressof @test12a_mixed_as : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.vec<2 x ptr>
    llvm.return %1 : !llvm.vec<2 x ptr>
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: !llvm.vec<2 x ptr>) {
    %0 = llvm.mlir.addressof @test13a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @test14a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (vector<2xi64>) -> ()
    llvm.return
  }]

def test15a_before := [llvmfunc|
  llvm.func @test15a() -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

def test15_before := [llvmfunc|
  llvm.func @test15() -> i32 {
    %0 = llvm.mlir.addressof @test15a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }]

def test16a_before := [llvmfunc|
  llvm.func @test16a() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16() -> vector<2xi16> {
    %0 = llvm.mlir.addressof @test16a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

def test17_before := [llvmfunc|
  llvm.func @test17() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @pr28655(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def non_vararg_before := [llvmfunc|
  llvm.func @non_vararg(%arg0: !llvm.ptr, %arg1: i32) {
    llvm.return
  }]

def test_cast_to_vararg_before := [llvmfunc|
  llvm.func @test_cast_to_vararg(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @non_vararg : !llvm.ptr
    %1 = llvm.mlir.constant(42 : i32) : i32
    llvm.call %0(%arg0, %1) vararg(!llvm.func<void (ptr, ...)>) : !llvm.ptr, (!llvm.ptr, i32) -> ()
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    llvm.call @test1a(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_as1_illegal_combined := [llvmfunc|
  llvm.func @test1_as1_illegal(%arg0: !llvm.ptr<1>) {
    %0 = llvm.mlir.addressof @test1a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr<1>) -> ()
    llvm.return
  }]

theorem inst_combine_test1_as1_illegal   : test1_as1_illegal_before  ⊑  test1_as1_illegal_combined := by
  unfold test1_as1_illegal_before test1_as1_illegal_combined
  simp_alive_peephole
  sorry
def test1_as1_combined := [llvmfunc|
  llvm.func @test1_as1(%arg0: !llvm.ptr<1>) {
    llvm.call @test1a_as1(%arg0) : (!llvm.ptr<1>) -> ()
    llvm.return
  }]

theorem inst_combine_test1_as1   : test1_as1_before  ⊑  test1_as1_combined := by
  unfold test1_as1_before test1_as1_combined
  simp_alive_peephole
  sorry
def test2a_combined := [llvmfunc|
  llvm.func @test2a(%arg0: i8) {
    llvm.return
  }]

theorem inst_combine_test2a   : test2a_before  ⊑  test2a_combined := by
  unfold test2a_before test2a_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @test2a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (i32) -> ()
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3a_combined := [llvmfunc|
  llvm.func @test3a(%arg0: i8, ...) {
    llvm.unreachable
  }]

theorem inst_combine_test3a   : test3a_before  ⊑  test3a_combined := by
  unfold test3a_before test3a_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i8, %arg1: i8) {
    %0 = llvm.zext %arg1 : i8 to i32
    llvm.call @test3a(%arg0, %0) vararg(!llvm.func<void (i8, ...)>) : (i8, i32) -> ()
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4a_combined := [llvmfunc|
  llvm.func @test4a() -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test4a   : test4a_before  ⊑  test4a_combined := by
  unfold test4a_before test4a_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.addressof @test4a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() -> i32 {
    %0 = llvm.call @test5a() : () -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @test6a(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7a_combined := [llvmfunc|
  llvm.func @test7a() {
    llvm.return
  }]

theorem inst_combine_test7a   : test7a_before  ⊑  test7a_combined := by
  unfold test7a_before test7a_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() {
    llvm.call @test7a() : () -> ()
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8() -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.invoke @test8a() to ^bb1 unwind ^bb2 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %1 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["noredzone", "nounwind", "ssp"]} {
    %0 = llvm.mlir.addressof @test9x : !llvm.ptr
    %1 = llvm.call %0(%arg0, %arg1) : !llvm.ptr, (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.vec<2 x ptr>) {
    llvm.call @test10a(%arg0) : (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_mixed_as_combined := [llvmfunc|
  llvm.func @test10_mixed_as(%arg0: !llvm.vec<2 x ptr>) {
    %0 = llvm.mlir.addressof @test10a_mixed_as : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }]

theorem inst_combine_test10_mixed_as   : test10_mixed_as_before  ⊑  test10_mixed_as_combined := by
  unfold test10_mixed_as_before test10_mixed_as_combined
  simp_alive_peephole
  sorry
def test11a_combined := [llvmfunc|
  llvm.func @test11a() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test11a   : test11a_before  ⊑  test11a_combined := by
  unfold test11a_before test11a_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11() -> !llvm.ptr {
    %0 = llvm.call @test11a() : () -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11a_mixed_as_combined := [llvmfunc|
  llvm.func @test11a_mixed_as() -> !llvm.ptr<1> {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    llvm.return %0 : !llvm.ptr<1>
  }]

theorem inst_combine_test11a_mixed_as   : test11a_mixed_as_before  ⊑  test11a_mixed_as_combined := by
  unfold test11a_mixed_as_before test11a_mixed_as_combined
  simp_alive_peephole
  sorry
def test11_mixed_as_combined := [llvmfunc|
  llvm.func @test11_mixed_as() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @test11a_mixed_as : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test11_mixed_as   : test11_mixed_as_before  ⊑  test11_mixed_as_combined := by
  unfold test11_mixed_as_before test11_mixed_as_combined
  simp_alive_peephole
  sorry
def test12a_combined := [llvmfunc|
  llvm.func @test12a() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    llvm.return %5 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_test12a   : test12a_before  ⊑  test12a_combined := by
  unfold test12a_before test12a_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12() -> !llvm.vec<2 x ptr> {
    %0 = llvm.call @test12a() : () -> !llvm.vec<2 x ptr>
    llvm.return %0 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12a_mixed_as_combined := [llvmfunc|
  llvm.func @test12a_mixed_as() -> !llvm.vec<2 x ptr<1>> {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr<1>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr<1>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr<1>>
    llvm.return %5 : !llvm.vec<2 x ptr<1>>
  }]

theorem inst_combine_test12a_mixed_as   : test12a_mixed_as_before  ⊑  test12a_mixed_as_combined := by
  unfold test12a_mixed_as_before test12a_mixed_as_combined
  simp_alive_peephole
  sorry
def test12_mixed_as_combined := [llvmfunc|
  llvm.func @test12_mixed_as() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.addressof @test12a_mixed_as : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.vec<2 x ptr>
    llvm.return %1 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_test12_mixed_as   : test12_mixed_as_before  ⊑  test12_mixed_as_combined := by
  unfold test12_mixed_as_before test12_mixed_as_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: !llvm.vec<2 x ptr>) {
    %0 = llvm.mlir.addressof @test13a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @test14a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (vector<2xi64>) -> ()
    llvm.return
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15a_combined := [llvmfunc|
  llvm.func @test15a() -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_test15a   : test15a_before  ⊑  test15a_combined := by
  unfold test15a_before test15a_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15() -> i32 {
    %0 = llvm.call @test15a() : () -> vector<2xi16>
    %1 = llvm.bitcast %0 : vector<2xi16> to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16a_combined := [llvmfunc|
  llvm.func @test16a() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test16a   : test16a_before  ⊑  test16a_combined := by
  unfold test16a_before test16a_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16() -> vector<2xi16> {
    %0 = llvm.call @test16a() : () -> i32
    %1 = llvm.bitcast %0 : i32 to vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @pr28655(%0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def non_vararg_combined := [llvmfunc|
  llvm.func @non_vararg(%arg0: !llvm.ptr, %arg1: i32) {
    llvm.return
  }]

theorem inst_combine_non_vararg   : non_vararg_before  ⊑  non_vararg_combined := by
  unfold non_vararg_before non_vararg_combined
  simp_alive_peephole
  sorry
def test_cast_to_vararg_combined := [llvmfunc|
  llvm.func @test_cast_to_vararg(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.call @non_vararg(%arg0, %0) : (!llvm.ptr, i32) -> ()
    llvm.return
  }]

theorem inst_combine_test_cast_to_vararg   : test_cast_to_vararg_before  ⊑  test_cast_to_vararg_combined := by
  unfold test_cast_to_vararg_before test_cast_to_vararg_combined
  simp_alive_peephole
  sorry

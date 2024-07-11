import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  simplify-libcalls-i16
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @G : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i16 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i16
    llvm.return
  }]

def test1_before := [llvmfunc|
  llvm.func @test1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("foog\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @str : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i16) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.constant(103 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("blahhh!\00") : !llvm.array<8 x i8>
    %3 = llvm.mlir.addressof @str1 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<8 x i8>
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("Ponk\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @str2 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.constant(80 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def PR2341_before := [llvmfunc|
  llvm.func @PR2341(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @_2E_str : !llvm.ptr
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    %4 = llvm.call @memcmp(%3, %0, %1) : (!llvm.ptr, !llvm.ptr, i16) -> i16
    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }]

def PR4284_before := [llvmfunc|
  llvm.func @PR4284() -> i16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.mlir.constant(-127 : i8) : i8
    %3 = llvm.mlir.constant(1 : i16) : i16
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %4 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %2, %5 {alignment = 1 : i64} : i8, !llvm.ptr]

    %6 = llvm.call @memcmp(%4, %5, %3) : (!llvm.ptr, !llvm.ptr, i16) -> i16
    llvm.return %6 : i16
  }]

def PR4641_before := [llvmfunc|
  llvm.func @PR4641(%arg0: i32, %arg1: !llvm.ptr, %arg2: i1, %arg3: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @".str13" : !llvm.ptr
    %2 = llvm.mlir.addressof @".str14" : !llvm.ptr
    llvm.call @exit(%0) : (i16) -> ()
    %3 = llvm.select %arg2, %1, %2 : i1, !llvm.ptr
    %4 = llvm.call @fopen(%arg3, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.unreachable
  }]

def PR4645_before := [llvmfunc|
  llvm.func @PR4645(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @exit(%0) : (i16) -> ()
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // pred: ^bb1
    llvm.unreachable
  }]

def MemCpy_before := [llvmfunc|
  llvm.func @MemCpy() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %2 = llvm.mlir.addressof @h : !llvm.ptr
    %3 = llvm.mlir.constant(2 : i16) : i16
    %4 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @hel : !llvm.ptr
    %6 = llvm.mlir.constant(4 : i16) : i16
    %7 = llvm.mlir.constant("hello_u\00") : !llvm.array<8 x i8>
    %8 = llvm.mlir.addressof @hello_u : !llvm.ptr
    %9 = llvm.mlir.constant(8 : i16) : i16
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%11, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i16) -> ()]

    "llvm.intr.memcpy"(%11, %5, %6) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i16) -> ()]

    "llvm.intr.memcpy"(%11, %8, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i16) -> ()]

    llvm.return %10 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr) {
    %0 = llvm.call @strcmp(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> i16
    llvm.return
  }]

def fake_isdigit_before := [llvmfunc|
  llvm.func @fake_isdigit(%arg0: i8) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }]

def fake_isascii_before := [llvmfunc|
  llvm.func @fake_isascii(%arg0: i8) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }]

def fake_toascii_before := [llvmfunc|
  llvm.func @fake_toascii(%arg0: i8) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }]

def fake_exp2_before := [llvmfunc|
  llvm.func @fake_exp2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def fake_ldexp_before := [llvmfunc|
  llvm.func @fake_ldexp(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def fake_ldexp_16_before := [llvmfunc|
  llvm.func @fake_ldexp_16(%arg0: i16) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def fake_snprintf_before := [llvmfunc|
  llvm.func @fake_snprintf(%arg0: i32, %arg1: f64, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i16 {
    %0 = llvm.call @snprintf(%arg3, %arg1, %arg2) : (!llvm.ptr, f64, !llvm.ptr) -> i16
    llvm.return %0 : i16
  }]

def strlen_before := [llvmfunc|
  llvm.func @strlen(%arg0: !llvm.ptr) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i4
    llvm.return %0 : i4
  }]

def emit_stpncpy() -> _before := [llvmfunc|
  llvm.func @emit_stpncpy() -> (i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(5 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.call @__stpncpy_chk(%2, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %7 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @G : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1, %arg1) vararg(!llvm.func<i16 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i16
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("foog\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @str : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.constant(103 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("blahhh!\00") : !llvm.array<8 x i8>
    %3 = llvm.mlir.addressof @str1 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<8 x i8>
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("Ponk\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @str2 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.constant(80 : i16) : i16
    %6 = llvm.call @strchr(%4, %5) : (!llvm.ptr, i16) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def PR2341_combined := [llvmfunc|
  llvm.func @PR2341(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @_2E_str : !llvm.ptr
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_PR2341   : PR2341_before  ⊑  PR2341_combined := by
  unfold PR2341_before PR2341_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @memcmp(%3, %0, %1) : (!llvm.ptr, !llvm.ptr, i16) -> i16
    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }]

theorem inst_combine_PR2341   : PR2341_before  ⊑  PR2341_combined := by
  unfold PR2341_before PR2341_combined
  simp_alive_peephole
  sorry
def PR4284_combined := [llvmfunc|
  llvm.func @PR4284() -> i16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.mlir.constant(-127 : i8) : i8
    %3 = llvm.mlir.constant(1 : i16) : i16
    %4 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_PR4284   : PR4284_before  ⊑  PR4284_combined := by
  unfold PR4284_before PR4284_combined
  simp_alive_peephole
  sorry
    %5 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_PR4284   : PR4284_before  ⊑  PR4284_combined := by
  unfold PR4284_before PR4284_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %4 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_PR4284   : PR4284_before  ⊑  PR4284_combined := by
  unfold PR4284_before PR4284_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %5 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_PR4284   : PR4284_before  ⊑  PR4284_combined := by
  unfold PR4284_before PR4284_combined
  simp_alive_peephole
  sorry
    %6 = llvm.call @memcmp(%4, %5, %3) : (!llvm.ptr, !llvm.ptr, i16) -> i16
    llvm.return %6 : i16
  }]

theorem inst_combine_PR4284   : PR4284_before  ⊑  PR4284_combined := by
  unfold PR4284_before PR4284_combined
  simp_alive_peephole
  sorry
def PR4641_combined := [llvmfunc|
  llvm.func @PR4641(%arg0: i32, %arg1: !llvm.ptr, %arg2: i1, %arg3: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @".str13" : !llvm.ptr
    %2 = llvm.mlir.addressof @".str14" : !llvm.ptr
    llvm.call @exit(%0) : (i16) -> ()
    %3 = llvm.select %arg2, %1, %2 : i1, !llvm.ptr
    %4 = llvm.call @fopen(%arg3, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.unreachable
  }]

theorem inst_combine_PR4641   : PR4641_before  ⊑  PR4641_combined := by
  unfold PR4641_before PR4641_combined
  simp_alive_peephole
  sorry
def PR4645_combined := [llvmfunc|
  llvm.func @PR4645(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @exit(%0) : (i16) -> ()
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.unreachable
  }]

theorem inst_combine_PR4645   : PR4645_before  ⊑  PR4645_combined := by
  unfold PR4645_before PR4645_combined
  simp_alive_peephole
  sorry
def MemCpy_combined := [llvmfunc|
  llvm.func @MemCpy() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_MemCpy   : MemCpy_before  ⊑  MemCpy_combined := by
  unfold MemCpy_before MemCpy_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr) {
    %0 = llvm.call @strcmp(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> i16
    llvm.return
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def fake_isdigit_combined := [llvmfunc|
  llvm.func @fake_isdigit(%arg0: i8) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fake_isdigit   : fake_isdigit_before  ⊑  fake_isdigit_combined := by
  unfold fake_isdigit_before fake_isdigit_combined
  simp_alive_peephole
  sorry
def fake_isascii_combined := [llvmfunc|
  llvm.func @fake_isascii(%arg0: i8) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fake_isascii   : fake_isascii_before  ⊑  fake_isascii_combined := by
  unfold fake_isascii_before fake_isascii_combined
  simp_alive_peephole
  sorry
def fake_toascii_combined := [llvmfunc|
  llvm.func @fake_toascii(%arg0: i8) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i8) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fake_toascii   : fake_toascii_before  ⊑  fake_toascii_combined := by
  unfold fake_toascii_before fake_toascii_combined
  simp_alive_peephole
  sorry
def fake_exp2_combined := [llvmfunc|
  llvm.func @fake_exp2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_fake_exp2   : fake_exp2_before  ⊑  fake_exp2_combined := by
  unfold fake_exp2_before fake_exp2_combined
  simp_alive_peephole
  sorry
def fake_ldexp_combined := [llvmfunc|
  llvm.func @fake_ldexp(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @ldexp(%0, %arg0) : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fake_ldexp   : fake_ldexp_before  ⊑  fake_ldexp_combined := by
  unfold fake_ldexp_before fake_ldexp_combined
  simp_alive_peephole
  sorry
def fake_ldexp_16_combined := [llvmfunc|
  llvm.func @fake_ldexp_16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fake_ldexp_16   : fake_ldexp_16_before  ⊑  fake_ldexp_16_combined := by
  unfold fake_ldexp_16_before fake_ldexp_16_combined
  simp_alive_peephole
  sorry
def fake_snprintf_combined := [llvmfunc|
  llvm.func @fake_snprintf(%arg0: i32, %arg1: f64, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i16 {
    %0 = llvm.call @snprintf(%arg3, %arg1, %arg2) : (!llvm.ptr, f64, !llvm.ptr) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_fake_snprintf   : fake_snprintf_before  ⊑  fake_snprintf_combined := by
  unfold fake_snprintf_before fake_snprintf_combined
  simp_alive_peephole
  sorry
def strlen_combined := [llvmfunc|
  llvm.func @strlen(%arg0: !llvm.ptr) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i4
    llvm.return %0 : i4
  }]

theorem inst_combine_strlen   : strlen_before  ⊑  strlen_combined := by
  unfold strlen_before strlen_combined
  simp_alive_peephole
  sorry
def emit_stpncpy() -> _combined := [llvmfunc|
  llvm.func @emit_stpncpy() -> (i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.call @stpncpy(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %6 : i32
  }]

theorem inst_combine_emit_stpncpy() ->    : emit_stpncpy() -> _before  ⊑  emit_stpncpy() -> _combined := by
  unfold emit_stpncpy() -> _before emit_stpncpy() -> _combined
  simp_alive_peephole
  sorry

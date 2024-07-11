import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  disable-simplify-libcalls
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: f64) -> f64 {
    %0 = llvm.call @ceil(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @copysign(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: f64) -> f64 {
    %0 = llvm.call @cos(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: f64) -> f64 {
    %0 = llvm.call @fabs(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: f64) -> f64 {
    %0 = llvm.call @floor(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcat(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @strncat(%arg0, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def t8_before := [llvmfunc|
  llvm.func @t8() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def t9_before := [llvmfunc|
  llvm.func @t9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def t10_before := [llvmfunc|
  llvm.func @t10() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bar\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def t11_before := [llvmfunc|
  llvm.func @t11() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bar\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }]

def t12_before := [llvmfunc|
  llvm.func @t12(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @strcpy(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def t13_before := [llvmfunc|
  llvm.func @t13(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @stpcpy(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def t14_before := [llvmfunc|
  llvm.func @t14(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def t15_before := [llvmfunc|
  llvm.func @t15() -> i64 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def t16_before := [llvmfunc|
  llvm.func @t16(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strpbrk(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def t17_before := [llvmfunc|
  llvm.func @t17(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strspn(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def t18_before := [llvmfunc|
  llvm.func @t18(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtod(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f64
    llvm.return %2 : f64
  }]

def t19_before := [llvmfunc|
  llvm.func @t19(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtof(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f32
    llvm.return %2 : f32
  }]

def t20_before := [llvmfunc|
  llvm.func @t20(%arg0: !llvm.ptr) -> f80 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtold(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f80
    llvm.return %2 : f80
  }]

def t21_before := [llvmfunc|
  llvm.func @t21(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def t22_before := [llvmfunc|
  llvm.func @t22(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoll(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def t23_before := [llvmfunc|
  llvm.func @t23(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoul(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def t24_before := [llvmfunc|
  llvm.func @t24(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoull(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def t25_before := [llvmfunc|
  llvm.func @t25(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcspn(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def t26_before := [llvmfunc|
  llvm.func @t26(%arg0: i32) -> i32 {
    %0 = llvm.call @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def t27_before := [llvmfunc|
  llvm.func @t27(%arg0: i32) -> i32 {
    %0 = llvm.call @ffs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def t28_before := [llvmfunc|
  llvm.func @t28(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsl(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

def t29_before := [llvmfunc|
  llvm.func @t29(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsll(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

def t30_before := [llvmfunc|
  llvm.func @t30() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %3 = llvm.call @fprintf(%0, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def t31_before := [llvmfunc|
  llvm.func @t31(%arg0: i32) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def t32_before := [llvmfunc|
  llvm.func @t32(%arg0: i32) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def t33_before := [llvmfunc|
  llvm.func @t33(%arg0: i32) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def t34_before := [llvmfunc|
  llvm.func @t34(%arg0: i64) -> i64 {
    %0 = llvm.call @labs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }]

def t35_before := [llvmfunc|
  llvm.func @t35(%arg0: i64) -> i64 {
    %0 = llvm.call @llabs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }]

def t36_before := [llvmfunc|
  llvm.func @t36() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @printf(%2) : (!llvm.ptr) -> i32
    llvm.return
  }]

def t37_before := [llvmfunc|
  llvm.func @t37(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: f64) -> f64 {
    %0 = llvm.call @ceil(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @copysign(%arg0, %arg1) : (f64, f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: f64) -> f64 {
    %0 = llvm.call @cos(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: f64) -> f64 {
    %0 = llvm.call @fabs(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: f64) -> f64 {
    %0 = llvm.call @floor(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcat(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @strncat(%arg0, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t10_combined := [llvmfunc|
  llvm.func @t10() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bar\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t10   : t10_before  ⊑  t10_combined := by
  unfold t10_before t10_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bar\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
def t12_combined := [llvmfunc|
  llvm.func @t12(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @strcpy(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_t12   : t12_before  ⊑  t12_combined := by
  unfold t12_before t12_combined
  simp_alive_peephole
  sorry
def t13_combined := [llvmfunc|
  llvm.func @t13(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @stpcpy(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_t13   : t13_before  ⊑  t13_combined := by
  unfold t13_before t13_combined
  simp_alive_peephole
  sorry
def t14_combined := [llvmfunc|
  llvm.func @t14(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_t14   : t14_before  ⊑  t14_combined := by
  unfold t14_before t14_combined
  simp_alive_peephole
  sorry
def t15_combined := [llvmfunc|
  llvm.func @t15() -> i64 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_t15   : t15_before  ⊑  t15_combined := by
  unfold t15_before t15_combined
  simp_alive_peephole
  sorry
def t16_combined := [llvmfunc|
  llvm.func @t16(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strpbrk(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_t16   : t16_before  ⊑  t16_combined := by
  unfold t16_before t16_combined
  simp_alive_peephole
  sorry
def t17_combined := [llvmfunc|
  llvm.func @t17(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strspn(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t17   : t17_before  ⊑  t17_combined := by
  unfold t17_before t17_combined
  simp_alive_peephole
  sorry
def t18_combined := [llvmfunc|
  llvm.func @t18(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtod(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_t18   : t18_before  ⊑  t18_combined := by
  unfold t18_before t18_combined
  simp_alive_peephole
  sorry
def t19_combined := [llvmfunc|
  llvm.func @t19(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtof(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_t19   : t19_before  ⊑  t19_combined := by
  unfold t19_before t19_combined
  simp_alive_peephole
  sorry
def t20_combined := [llvmfunc|
  llvm.func @t20(%arg0: !llvm.ptr) -> f80 {
    %0 = llvm.mlir.constant("123.4\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str4" : !llvm.ptr
    %2 = llvm.call @strtold(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> f80
    llvm.return %2 : f80
  }]

theorem inst_combine_t20   : t20_before  ⊑  t20_combined := by
  unfold t20_before t20_combined
  simp_alive_peephole
  sorry
def t21_combined := [llvmfunc|
  llvm.func @t21(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t21   : t21_before  ⊑  t21_combined := by
  unfold t21_before t21_combined
  simp_alive_peephole
  sorry
def t22_combined := [llvmfunc|
  llvm.func @t22(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoll(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t22   : t22_before  ⊑  t22_combined := by
  unfold t22_before t22_combined
  simp_alive_peephole
  sorry
def t23_combined := [llvmfunc|
  llvm.func @t23(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoul(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t23   : t23_before  ⊑  t23_combined := by
  unfold t23_before t23_combined
  simp_alive_peephole
  sorry
def t24_combined := [llvmfunc|
  llvm.func @t24(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @".str5" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtoull(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t24   : t24_before  ⊑  t24_combined := by
  unfold t24_before t24_combined
  simp_alive_peephole
  sorry
def t25_combined := [llvmfunc|
  llvm.func @t25(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcspn(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_t25   : t25_before  ⊑  t25_combined := by
  unfold t25_before t25_combined
  simp_alive_peephole
  sorry
def t26_combined := [llvmfunc|
  llvm.func @t26(%arg0: i32) -> i32 {
    %0 = llvm.call @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t26   : t26_before  ⊑  t26_combined := by
  unfold t26_before t26_combined
  simp_alive_peephole
  sorry
def t27_combined := [llvmfunc|
  llvm.func @t27(%arg0: i32) -> i32 {
    %0 = llvm.call @ffs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t27   : t27_before  ⊑  t27_combined := by
  unfold t27_before t27_combined
  simp_alive_peephole
  sorry
def t28_combined := [llvmfunc|
  llvm.func @t28(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsl(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t28   : t28_before  ⊑  t28_combined := by
  unfold t28_before t28_combined
  simp_alive_peephole
  sorry
def t29_combined := [llvmfunc|
  llvm.func @t29(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsll(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t29   : t29_before  ⊑  t29_combined := by
  unfold t29_before t29_combined
  simp_alive_peephole
  sorry
def t30_combined := [llvmfunc|
  llvm.func @t30() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %3 = llvm.call @fprintf(%0, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_t30   : t30_before  ⊑  t30_combined := by
  unfold t30_before t30_combined
  simp_alive_peephole
  sorry
def t31_combined := [llvmfunc|
  llvm.func @t31(%arg0: i32) -> i32 {
    %0 = llvm.call @isascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t31   : t31_before  ⊑  t31_combined := by
  unfold t31_before t31_combined
  simp_alive_peephole
  sorry
def t32_combined := [llvmfunc|
  llvm.func @t32(%arg0: i32) -> i32 {
    %0 = llvm.call @isdigit(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t32   : t32_before  ⊑  t32_combined := by
  unfold t32_before t32_combined
  simp_alive_peephole
  sorry
def t33_combined := [llvmfunc|
  llvm.func @t33(%arg0: i32) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t33   : t33_before  ⊑  t33_combined := by
  unfold t33_before t33_combined
  simp_alive_peephole
  sorry
def t34_combined := [llvmfunc|
  llvm.func @t34(%arg0: i64) -> i64 {
    %0 = llvm.call @labs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_t34   : t34_before  ⊑  t34_combined := by
  unfold t34_before t34_combined
  simp_alive_peephole
  sorry
def t35_combined := [llvmfunc|
  llvm.func @t35(%arg0: i64) -> i64 {
    %0 = llvm.call @llabs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_t35   : t35_before  ⊑  t35_combined := by
  unfold t35_before t35_combined
  simp_alive_peephole
  sorry
def t36_combined := [llvmfunc|
  llvm.func @t36() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @printf(%2) : (!llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_t36   : t36_before  ⊑  t36_combined := by
  unfold t36_before t36_combined
  simp_alive_peephole
  sorry
def t37_combined := [llvmfunc|
  llvm.func @t37(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello, world\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.call @sprintf(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_t37   : t37_before  ⊑  t37_combined := by
  unfold t37_before t37_combined
  simp_alive_peephole
  sorry

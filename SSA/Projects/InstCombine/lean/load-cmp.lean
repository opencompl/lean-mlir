import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-cmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test1_noinbounds_before := [llvmfunc|
  llvm.func @test1_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test1_noinbounds_i64_before := [llvmfunc|
  llvm.func @test1_noinbounds_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test1_noinbounds_as1_before := [llvmfunc|
  llvm.func @test1_noinbounds_as1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16_as1 : !llvm.ptr<1>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr<1>, i16, i32) -> !llvm.ptr<1>, !llvm.array<10 x i16>
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr<1> -> i16]

    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }]

def test1_noinbounds_as2_before := [llvmfunc|
  llvm.func @test1_noinbounds_as2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16_as2 : !llvm.ptr<2>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr<2>, i16, i64) -> !llvm.ptr<2>, !llvm.array<10 x i16>
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr<2> -> i16]

    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(85 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "slt" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) : !llvm.array<6 x f64>
    %1 = llvm.mlir.addressof @GD : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x f64>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %6 = llvm.fcmp "oeq" %5, %3 : f64
    llvm.return %6 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(73 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "sle" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test4_i16_before := [llvmfunc|
  llvm.func @test4_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(73 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i16) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "sle" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(69 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) : !llvm.array<6 x f64>
    %1 = llvm.mlir.addressof @GD : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x f64>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %6 = llvm.fcmp "ogt" %5, %3 : f64
    llvm.return %6 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) : !llvm.array<6 x f64>
    %1 = llvm.mlir.addressof @GD : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x f64>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %6 = llvm.fcmp "olt" %5, %3 : f64
    llvm.return %6 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i16) : i16
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %6 = llvm.load %5 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %7 = llvm.and %6, %3  : i16
    %8 = llvm.icmp "eq" %7, %4 : i16
    llvm.return %8 : i1
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(3 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i32, i32)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i32, i32)> 
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(i32, i32)> 
    %13 = llvm.insertvalue %5, %12[1] : !llvm.struct<(i32, i32)> 
    %14 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %15 = llvm.insertvalue %5, %14[0] : !llvm.struct<(i32, i32)> 
    %16 = llvm.insertvalue %0, %15[1] : !llvm.struct<(i32, i32)> 
    %17 = llvm.mlir.undef : !llvm.array<4 x struct<(i32, i32)>>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.array<4 x struct<(i32, i32)>> 
    %19 = llvm.insertvalue %13, %18[1] : !llvm.array<4 x struct<(i32, i32)>> 
    %20 = llvm.insertvalue %9, %19[2] : !llvm.array<4 x struct<(i32, i32)>> 
    %21 = llvm.insertvalue %4, %20[3] : !llvm.array<4 x struct<(i32, i32)>> 
    %22 = llvm.mlir.addressof @GA : !llvm.ptr
    %23 = llvm.getelementptr inbounds %22[%0, %arg0, 1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x struct<(i32, i32)>>
    %24 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %25 = llvm.icmp "eq" %24, %5 : i32
    llvm.return %25 : i1
  }]

def test10_struct_before := [llvmfunc|
  llvm.func @test10_struct(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.getelementptr inbounds %9[%arg0, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.icmp "eq" %12, %1 : i32
    llvm.return %13 : i1
  }]

def test10_struct_noinbounds_before := [llvmfunc|
  llvm.func @test10_struct_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.getelementptr %9[%arg0, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.icmp "eq" %12, %1 : i32
    llvm.return %13 : i1
  }]

def test10_struct_i16_before := [llvmfunc|
  llvm.func @test10_struct_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.getelementptr inbounds %9[%arg0, 0] : (!llvm.ptr, i16) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.icmp "eq" %12, %10 : i32
    llvm.return %13 : i1
  }]

def test10_struct_i64_before := [llvmfunc|
  llvm.func @test10_struct_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.getelementptr inbounds %9[%arg0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.icmp "eq" %12, %10 : i32
    llvm.return %13 : i1
  }]

def test10_struct_noinbounds_i16_before := [llvmfunc|
  llvm.func @test10_struct_noinbounds_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.getelementptr %9[%arg0, 0] : (!llvm.ptr, i16) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.icmp "eq" %12, %10 : i32
    llvm.return %13 : i1
  }]

def test10_struct_arr_before := [llvmfunc|
  llvm.func @test10_struct_arr(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.constant(20 : i32) : i32
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %14 = llvm.insertvalue %10, %13[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %15 = llvm.insertvalue %1, %14[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %16 = llvm.insertvalue %9, %15[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %17 = llvm.mlir.constant(11 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %20 = llvm.insertvalue %10, %19[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %22 = llvm.insertvalue %11, %21[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %23 = llvm.insertvalue %17, %22[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %24 = llvm.mlir.constant(14 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %28 = llvm.insertvalue %18, %27[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %29 = llvm.insertvalue %1, %28[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %30 = llvm.insertvalue %24, %29[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %31 = llvm.mlir.undef : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %33 = llvm.insertvalue %23, %32[1] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %34 = llvm.insertvalue %16, %33[2] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %35 = llvm.insertvalue %8, %34[3] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %36 = llvm.mlir.addressof @GStructArr : !llvm.ptr
    %37 = llvm.mlir.constant(0 : i32) : i32
    %38 = llvm.mlir.constant(2 : i32) : i32
    %39 = llvm.getelementptr inbounds %36[%37, %arg0, 2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }]

def test10_struct_arr_noinbounds_before := [llvmfunc|
  llvm.func @test10_struct_arr_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.constant(20 : i32) : i32
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %14 = llvm.insertvalue %10, %13[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %15 = llvm.insertvalue %1, %14[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %16 = llvm.insertvalue %9, %15[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %17 = llvm.mlir.constant(11 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %20 = llvm.insertvalue %10, %19[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %22 = llvm.insertvalue %11, %21[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %23 = llvm.insertvalue %17, %22[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %24 = llvm.mlir.constant(14 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %28 = llvm.insertvalue %18, %27[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %29 = llvm.insertvalue %1, %28[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %30 = llvm.insertvalue %24, %29[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %31 = llvm.mlir.undef : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %33 = llvm.insertvalue %23, %32[1] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %34 = llvm.insertvalue %16, %33[2] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %35 = llvm.insertvalue %8, %34[3] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %36 = llvm.mlir.addressof @GStructArr : !llvm.ptr
    %37 = llvm.mlir.constant(0 : i32) : i32
    %38 = llvm.mlir.constant(2 : i32) : i32
    %39 = llvm.getelementptr %36[%37, %arg0, 2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }]

def test10_struct_arr_i16_before := [llvmfunc|
  llvm.func @test10_struct_arr_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.constant(20 : i32) : i32
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %14 = llvm.insertvalue %10, %13[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %15 = llvm.insertvalue %1, %14[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %16 = llvm.insertvalue %9, %15[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %17 = llvm.mlir.constant(11 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %20 = llvm.insertvalue %10, %19[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %22 = llvm.insertvalue %11, %21[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %23 = llvm.insertvalue %17, %22[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %24 = llvm.mlir.constant(14 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %28 = llvm.insertvalue %18, %27[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %29 = llvm.insertvalue %1, %28[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %30 = llvm.insertvalue %24, %29[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %31 = llvm.mlir.undef : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %33 = llvm.insertvalue %23, %32[1] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %34 = llvm.insertvalue %16, %33[2] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %35 = llvm.insertvalue %8, %34[3] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %36 = llvm.mlir.addressof @GStructArr : !llvm.ptr
    %37 = llvm.mlir.constant(0 : i16) : i16
    %38 = llvm.mlir.constant(2 : i32) : i32
    %39 = llvm.getelementptr inbounds %36[%37, %arg0, 2] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }]

def test10_struct_arr_i64_before := [llvmfunc|
  llvm.func @test10_struct_arr_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.constant(20 : i32) : i32
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %14 = llvm.insertvalue %10, %13[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %15 = llvm.insertvalue %1, %14[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %16 = llvm.insertvalue %9, %15[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %17 = llvm.mlir.constant(11 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %20 = llvm.insertvalue %10, %19[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %22 = llvm.insertvalue %11, %21[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %23 = llvm.insertvalue %17, %22[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %24 = llvm.mlir.constant(14 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %28 = llvm.insertvalue %18, %27[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %29 = llvm.insertvalue %1, %28[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %30 = llvm.insertvalue %24, %29[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %31 = llvm.mlir.undef : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %33 = llvm.insertvalue %23, %32[1] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %34 = llvm.insertvalue %16, %33[2] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %35 = llvm.insertvalue %8, %34[3] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %36 = llvm.mlir.addressof @GStructArr : !llvm.ptr
    %37 = llvm.mlir.constant(0 : i64) : i64
    %38 = llvm.mlir.constant(2 : i32) : i32
    %39 = llvm.getelementptr inbounds %36[%37, %arg0, 2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }]

def test10_struct_arr_noinbounds_i16_before := [llvmfunc|
  llvm.func @test10_struct_arr_noinbounds_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.constant(20 : i32) : i32
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %14 = llvm.insertvalue %10, %13[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %15 = llvm.insertvalue %1, %14[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %16 = llvm.insertvalue %9, %15[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %17 = llvm.mlir.constant(11 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %20 = llvm.insertvalue %10, %19[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %22 = llvm.insertvalue %11, %21[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %23 = llvm.insertvalue %17, %22[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %24 = llvm.mlir.constant(14 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %28 = llvm.insertvalue %18, %27[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %29 = llvm.insertvalue %1, %28[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %30 = llvm.insertvalue %24, %29[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %31 = llvm.mlir.undef : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %33 = llvm.insertvalue %23, %32[1] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %34 = llvm.insertvalue %16, %33[2] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %35 = llvm.insertvalue %8, %34[3] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %36 = llvm.mlir.addressof @GStructArr : !llvm.ptr
    %37 = llvm.mlir.constant(0 : i32) : i32
    %38 = llvm.mlir.constant(2 : i32) : i32
    %39 = llvm.getelementptr %36[%37, %arg0, 2] : (!llvm.ptr, i32, i16) -> !llvm.ptr, !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }]

def test10_struct_arr_noinbounds_i64_before := [llvmfunc|
  llvm.func @test10_struct_arr_noinbounds_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(12 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.constant(20 : i32) : i32
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.insertvalue %11, %12[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %14 = llvm.insertvalue %10, %13[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %15 = llvm.insertvalue %1, %14[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %16 = llvm.insertvalue %9, %15[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %17 = llvm.mlir.constant(11 : i32) : i32
    %18 = llvm.mlir.constant(4 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %20 = llvm.insertvalue %10, %19[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %21 = llvm.insertvalue %18, %20[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %22 = llvm.insertvalue %11, %21[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %23 = llvm.insertvalue %17, %22[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %24 = llvm.mlir.constant(14 : i32) : i32
    %25 = llvm.mlir.constant(1 : i32) : i32
    %26 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %27 = llvm.insertvalue %25, %26[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %28 = llvm.insertvalue %18, %27[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %29 = llvm.insertvalue %1, %28[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %30 = llvm.insertvalue %24, %29[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %31 = llvm.mlir.undef : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %32 = llvm.insertvalue %30, %31[0] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %33 = llvm.insertvalue %23, %32[1] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %34 = llvm.insertvalue %16, %33[2] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %35 = llvm.insertvalue %8, %34[3] : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> 
    %36 = llvm.mlir.addressof @GStructArr : !llvm.ptr
    %37 = llvm.mlir.constant(0 : i32) : i32
    %38 = llvm.mlir.constant(2 : i32) : i32
    %39 = llvm.getelementptr %36[%37, %arg0, 2] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }]

def pr93017_before := [llvmfunc|
  llvm.func @pr93017(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.array<2 x ptr> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<2 x ptr> 
    %6 = llvm.mlir.addressof @table : !llvm.ptr
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.getelementptr inbounds %6[%7, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x ptr>
    %10 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %11 = llvm.icmp "ne" %10, %8 : !llvm.ptr
    llvm.return %11 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_noinbounds_combined := [llvmfunc|
  llvm.func @test1_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test1_noinbounds   : test1_noinbounds_before  ⊑  test1_noinbounds_combined := by
  unfold test1_noinbounds_before test1_noinbounds_combined
  simp_alive_peephole
  sorry
def test1_noinbounds_i64_combined := [llvmfunc|
  llvm.func @test1_noinbounds_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test1_noinbounds_i64   : test1_noinbounds_i64_before  ⊑  test1_noinbounds_i64_combined := by
  unfold test1_noinbounds_i64_before test1_noinbounds_i64_combined
  simp_alive_peephole
  sorry
def test1_noinbounds_as1_combined := [llvmfunc|
  llvm.func @test1_noinbounds_as1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test1_noinbounds_as1   : test1_noinbounds_as1_before  ⊑  test1_noinbounds_as1_combined := by
  unfold test1_noinbounds_as1_before test1_noinbounds_as1_combined
  simp_alive_peephole
  sorry
def test1_noinbounds_as2_combined := [llvmfunc|
  llvm.func @test1_noinbounds_as2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test1_noinbounds_as2   : test1_noinbounds_as2_before  ⊑  test1_noinbounds_as2_combined := by
  unfold test1_noinbounds_as2_before test1_noinbounds_as2_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(933 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4_i16_combined := [llvmfunc|
  llvm.func @test4_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(933 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.zext %arg0 : i16 to i32
    %4 = llvm.lshr %0, %3  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_test4_i16   : test4_i16_before  ⊑  test4_i16_combined := by
  unfold test4_i16_before test4_i16_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_struct_combined := [llvmfunc|
  llvm.func @test10_struct(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test10_struct   : test10_struct_before  ⊑  test10_struct_combined := by
  unfold test10_struct_before test10_struct_combined
  simp_alive_peephole
  sorry
def test10_struct_noinbounds_combined := [llvmfunc|
  llvm.func @test10_struct_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.getelementptr %9[%arg0, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test10_struct_noinbounds   : test10_struct_noinbounds_before  ⊑  test10_struct_noinbounds_combined := by
  unfold test10_struct_noinbounds_before test10_struct_noinbounds_combined
  simp_alive_peephole
  sorry
    %13 = llvm.icmp "eq" %12, %1 : i32
    llvm.return %13 : i1
  }]

theorem inst_combine_test10_struct_noinbounds   : test10_struct_noinbounds_before  ⊑  test10_struct_noinbounds_combined := by
  unfold test10_struct_noinbounds_before test10_struct_noinbounds_combined
  simp_alive_peephole
  sorry
def test10_struct_i16_combined := [llvmfunc|
  llvm.func @test10_struct_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test10_struct_i16   : test10_struct_i16_before  ⊑  test10_struct_i16_combined := by
  unfold test10_struct_i16_before test10_struct_i16_combined
  simp_alive_peephole
  sorry
def test10_struct_i64_combined := [llvmfunc|
  llvm.func @test10_struct_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test10_struct_i64   : test10_struct_i64_before  ⊑  test10_struct_i64_combined := by
  unfold test10_struct_i64_before test10_struct_i64_combined
  simp_alive_peephole
  sorry
def test10_struct_noinbounds_i16_combined := [llvmfunc|
  llvm.func @test10_struct_noinbounds_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %9 = llvm.mlir.addressof @GS : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.sext %arg0 : i16 to i32
    %12 = llvm.getelementptr %9[%11, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test10_struct_noinbounds_i16   : test10_struct_noinbounds_i16_before  ⊑  test10_struct_noinbounds_i16_combined := by
  unfold test10_struct_noinbounds_i16_before test10_struct_noinbounds_i16_combined
  simp_alive_peephole
  sorry
    %14 = llvm.icmp "eq" %13, %10 : i32
    llvm.return %14 : i1
  }]

theorem inst_combine_test10_struct_noinbounds_i16   : test10_struct_noinbounds_i16_before  ⊑  test10_struct_noinbounds_i16_combined := by
  unfold test10_struct_noinbounds_i16_before test10_struct_noinbounds_i16_combined
  simp_alive_peephole
  sorry
def test10_struct_arr_combined := [llvmfunc|
  llvm.func @test10_struct_arr(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test10_struct_arr   : test10_struct_arr_before  ⊑  test10_struct_arr_combined := by
  unfold test10_struct_arr_before test10_struct_arr_combined
  simp_alive_peephole
  sorry
def test10_struct_arr_noinbounds_combined := [llvmfunc|
  llvm.func @test10_struct_arr_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(268435455 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test10_struct_arr_noinbounds   : test10_struct_arr_noinbounds_before  ⊑  test10_struct_arr_noinbounds_combined := by
  unfold test10_struct_arr_noinbounds_before test10_struct_arr_noinbounds_combined
  simp_alive_peephole
  sorry
def test10_struct_arr_i16_combined := [llvmfunc|
  llvm.func @test10_struct_arr_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_test10_struct_arr_i16   : test10_struct_arr_i16_before  ⊑  test10_struct_arr_i16_combined := by
  unfold test10_struct_arr_i16_before test10_struct_arr_i16_combined
  simp_alive_peephole
  sorry
def test10_struct_arr_i64_combined := [llvmfunc|
  llvm.func @test10_struct_arr_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test10_struct_arr_i64   : test10_struct_arr_i64_before  ⊑  test10_struct_arr_i64_combined := by
  unfold test10_struct_arr_i64_before test10_struct_arr_i64_combined
  simp_alive_peephole
  sorry
def test10_struct_arr_noinbounds_i16_combined := [llvmfunc|
  llvm.func @test10_struct_arr_noinbounds_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(268435455 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sext %arg0 : i16 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_test10_struct_arr_noinbounds_i16   : test10_struct_arr_noinbounds_i16_before  ⊑  test10_struct_arr_noinbounds_i16_combined := by
  unfold test10_struct_arr_noinbounds_i16_before test10_struct_arr_noinbounds_i16_combined
  simp_alive_peephole
  sorry
def test10_struct_arr_noinbounds_i64_combined := [llvmfunc|
  llvm.func @test10_struct_arr_noinbounds_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(268435455 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test10_struct_arr_noinbounds_i64   : test10_struct_arr_noinbounds_i64_before  ⊑  test10_struct_arr_noinbounds_i64_combined := by
  unfold test10_struct_arr_noinbounds_i64_before test10_struct_arr_noinbounds_i64_combined
  simp_alive_peephole
  sorry
def pr93017_combined := [llvmfunc|
  llvm.func @pr93017(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.array<2 x ptr> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<2 x ptr> 
    %6 = llvm.mlir.addressof @table : !llvm.ptr
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.trunc %arg0 : i64 to i32
    %10 = llvm.getelementptr inbounds %6[%7, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x ptr>
    %11 = llvm.load %10 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_pr93017   : pr93017_before  ⊑  pr93017_combined := by
  unfold pr93017_before pr93017_combined
  simp_alive_peephole
  sorry
    %12 = llvm.icmp "ne" %11, %8 : !llvm.ptr
    llvm.return %12 : i1
  }]

theorem inst_combine_pr93017   : pr93017_before  ⊑  pr93017_combined := by
  unfold pr93017_before pr93017_combined
  simp_alive_peephole
  sorry

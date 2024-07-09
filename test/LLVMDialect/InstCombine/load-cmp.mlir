module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @G16(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) {addr_space = 0 : i32, dso_local} : !llvm.array<10 x i16>
  llvm.mlir.global internal constant @G16_as1(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) {addr_space = 1 : i32, dso_local} : !llvm.array<10 x i16>
  llvm.mlir.global internal constant @G16_as2(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) {addr_space = 2 : i32, dso_local} : !llvm.array<10 x i16>
  llvm.mlir.global internal constant @GD(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) {addr_space = 0 : i32, dso_local} : !llvm.array<6 x f64>
  llvm.mlir.global internal constant @GS() {addr_space = 0 : i32, dso_local} : !llvm.struct<"Foo", (i32, i32, i32, i32)> {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"Foo", (i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %0, %7[3] : !llvm.struct<"Foo", (i32, i32, i32, i32)> 
    llvm.return %8 : !llvm.struct<"Foo", (i32, i32, i32, i32)>
  }
  llvm.mlir.global internal constant @GStructArr() {addr_space = 0 : i32, dso_local} : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>> {
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
    llvm.return %35 : !llvm.array<4 x struct<"Foo", (i32, i32, i32, i32)>>
  }
  llvm.mlir.global internal constant @GA() {addr_space = 0 : i32, dso_local} : !llvm.array<4 x struct<(i32, i32)>> {
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
    llvm.return %21 : !llvm.array<4 x struct<(i32, i32)>>
  }
  llvm.mlir.global internal constant @table() {addr_space = 0 : i32, alignment = 16 : i64, dso_local} : !llvm.array<2 x ptr> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.array<2 x ptr> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<2 x ptr> 
    llvm.return %5 : !llvm.array<2 x ptr>
  }
  llvm.mlir.global external @g() {addr_space = 0 : i32} : !llvm.array<2 x i32>
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test1_noinbounds(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test1_noinbounds_i64(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test1_noinbounds_as1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16_as1 : !llvm.ptr<1>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr<1>, i16, i32) -> !llvm.ptr<1>, !llvm.array<10 x i16>
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr<1> -> i16
    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }
  llvm.func @test1_noinbounds_as2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16_as2 : !llvm.ptr<2>
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr<2>, i16, i64) -> !llvm.ptr<2>, !llvm.array<10 x i16>
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr<2> -> i16
    %5 = llvm.icmp "eq" %4, %2 : i16
    llvm.return %5 : i1
  }
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(85 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "slt" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) : !llvm.array<6 x f64>
    %1 = llvm.mlir.addressof @GD : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x f64>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> f64
    %6 = llvm.fcmp "oeq" %5, %3 : f64
    llvm.return %6 : i1
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(73 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "sle" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test4_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(73 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i16) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "sle" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(69 : i16) : i16
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %5 = llvm.load %4 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.icmp "eq" %5, %3 : i16
    llvm.return %6 : i1
  }
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) : !llvm.array<6 x f64>
    %1 = llvm.mlir.addressof @GD : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x f64>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> f64
    %6 = llvm.fcmp "ogt" %5, %3 : f64
    llvm.return %6 : i1
  }
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[-1.000000e+01, 1.000000e+00, 4.000000e+00, 2.000000e+00, -2.000000e+01, -4.000000e+01]> : tensor<6xf64>) : !llvm.array<6 x f64>
    %1 = llvm.mlir.addressof @GD : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x f64>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> f64
    %6 = llvm.fcmp "olt" %5, %3 : f64
    llvm.return %6 : i1
  }
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(dense<[35, 82, 69, 81, 85, 73, 82, 69, 68, 0]> : tensor<10xi16>) : !llvm.array<10 x i16>
    %1 = llvm.mlir.addressof @G16 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i16) : i16
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<10 x i16>
    %6 = llvm.load %5 {alignment = 2 : i64} : !llvm.ptr -> i16
    %7 = llvm.and %6, %3  : i16
    %8 = llvm.icmp "eq" %7, %4 : i16
    llvm.return %8 : i1
  }
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
    %24 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> i32
    %25 = llvm.icmp "eq" %24, %5 : i32
    llvm.return %25 : i1
  }
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
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.icmp "eq" %12, %1 : i32
    llvm.return %13 : i1
  }
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
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.icmp "eq" %12, %1 : i32
    llvm.return %13 : i1
  }
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
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.icmp "eq" %12, %10 : i32
    llvm.return %13 : i1
  }
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
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.icmp "eq" %12, %10 : i32
    llvm.return %13 : i1
  }
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
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.icmp "eq" %12, %10 : i32
    llvm.return %13 : i1
  }
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
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }
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
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }
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
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }
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
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }
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
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }
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
    %40 = llvm.load %39 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.icmp "eq" %40, %1 : i32
    llvm.return %41 : i1
  }
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
    %10 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %11 = llvm.icmp "ne" %10, %8 : !llvm.ptr
    llvm.return %11 : i1
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @t1() {addr_space = 0 : i32} : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    llvm.return %7 : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
  }
  llvm.mlir.global common @t2() {addr_space = 0 : i32} : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    llvm.return %7 : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
  }
  llvm.mlir.global common @t3() {addr_space = 0 : i32} : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    llvm.return %7 : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
  }
  llvm.func @test_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    %15 = llvm.call @__memmove_chk(%8, %13, %14, %14) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %15 : !llvm.ptr
  }
  llvm.func @test_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %11 = llvm.insertvalue %3, %10[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %12 = llvm.insertvalue %3, %11[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %13 = llvm.insertvalue %9, %12[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %14 = llvm.mlir.addressof @t3 : !llvm.ptr
    %15 = llvm.mlir.constant(1824 : i64) : i64
    %16 = llvm.mlir.constant(2848 : i64) : i64
    %17 = llvm.call @__memmove_chk(%8, %14, %15, %16) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %17 : !llvm.ptr
  }
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    %15 = llvm.call @__memmove_chk(%8, %13, %14, %14) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %15 : !llvm.ptr
  }
  llvm.func @test_no_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %8 = llvm.mlir.addressof @t3 : !llvm.ptr
    %9 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %11 = llvm.insertvalue %3, %10[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %3, %11[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.insertvalue %9, %12[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %14 = llvm.mlir.addressof @t1 : !llvm.ptr
    %15 = llvm.mlir.constant(2848 : i64) : i64
    %16 = llvm.mlir.constant(1824 : i64) : i64
    %17 = llvm.call @__memmove_chk(%8, %14, %15, %16) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %17 : !llvm.ptr
  }
  llvm.func @test_no_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1024 : i64) : i64
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.call @__memmove_chk(%8, %13, %14, %15) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %16 : !llvm.ptr
  }
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1824 : i64) : i64
    %1 = llvm.call @__memmove_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    %15 = llvm.call @__memmove_chk(%8, %13, %14, %14) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %15 : !llvm.ptr
  }
  llvm.func @__memmove_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
}

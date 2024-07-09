module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a() {addr_space = 0 : i32} : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    llvm.return %6 : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
  }
  llvm.mlir.global external constant @ai64(dense<[0, -1]> : tensor<2xi64>) {addr_space = 0 : i32} : !llvm.array<2 x i64>
  llvm.mlir.global external constant @u() {addr_space = 0 : i32} : !llvm.struct<"union.U", (array<2 x i32>)> {
    %0 = llvm.mlir.constant(dense<[286331153, 35791394]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %1 = llvm.mlir.undef : !llvm.struct<"union.U", (array<2 x i32>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"union.U", (array<2 x i32>)> 
    llvm.return %2 : !llvm.struct<"union.U", (array<2 x i32>)>
  }
  llvm.func @memchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @fold_memchr_A_pIb_cst_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(4 : i32) : i32
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.mlir.constant(3 : i32) : i32
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.mlir.constant(5 : i32) : i32
    %17 = llvm.mlir.constant(6 : i32) : i32
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.mlir.constant(7 : i32) : i32
    %20 = llvm.mlir.constant(8 : i32) : i32
    %21 = llvm.mlir.constant(9 : i32) : i32
    %22 = llvm.mlir.constant(5 : i64) : i64
    %23 = llvm.mlir.constant(10 : i32) : i32
    %24 = llvm.mlir.constant(6 : i64) : i64
    %25 = llvm.call @memchr(%7, %8, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %25, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %26 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %27 = llvm.call @memchr(%7, %10, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %27, %26 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %28 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %29 = llvm.call @memchr(%7, %12, %13) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %29, %28 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %30 = llvm.getelementptr %7[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %31 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %32 = llvm.call @memchr(%30, %8, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %32, %31 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %33 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %34 = llvm.call @memchr(%30, %8, %15) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %34, %33 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %35 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %36 = llvm.call @memchr(%30, %10, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %36, %35 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %37 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %38 = llvm.call @memchr(%30, %10, %18) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %38, %37 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %39 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %40 = llvm.call @memchr(%30, %14, %15) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %40, %39 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %41 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %42 = llvm.call @memchr(%30, %14, %13) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %42, %41 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %43 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %44 = llvm.call @memchr(%30, %14, %22) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %42, %41 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %45 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %46 = llvm.call @memchr(%30, %14, %24) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %46, %45 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memchr_A_pIb_cst_N(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.mlir.constant(7 : i32) : i32
    %16 = llvm.mlir.constant(8 : i32) : i32
    %17 = llvm.mlir.constant(9 : i32) : i32
    %18 = llvm.mlir.constant(10 : i32) : i32
    %19 = llvm.mlir.constant(11 : i32) : i32
    %20 = llvm.mlir.constant(12 : i32) : i32
    %21 = llvm.call @memchr(%7, %8, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %21, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %22 = llvm.getelementptr %arg1[%9] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %23 = llvm.call @memchr(%7, %9, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %23, %22 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %24 = llvm.getelementptr %arg1[%10] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %25 = llvm.call @memchr(%7, %11, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %25, %24 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %26 = llvm.getelementptr %7[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %27 = llvm.getelementptr %arg1[%12] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %28 = llvm.call @memchr(%26, %8, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %28, %27 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %29 = llvm.getelementptr %arg1[%11] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %30 = llvm.call @memchr(%26, %9, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %30, %29 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %31 = llvm.getelementptr %arg1[%13] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %32 = llvm.call @memchr(%26, %10, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %32, %31 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %33 = llvm.getelementptr %arg1[%14] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %34 = llvm.call @memchr(%26, %12, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %34, %33 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %35 = llvm.getelementptr %arg1[%15] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %36 = llvm.call @memchr(%26, %11, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %36, %35 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %37 = llvm.getelementptr %7[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %38 = llvm.getelementptr %arg1[%16] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %39 = llvm.call @memchr(%37, %8, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %39, %38 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %40 = llvm.getelementptr %arg1[%17] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %41 = llvm.call @memchr(%37, %9, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %41, %40 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %42 = llvm.getelementptr %arg1[%18] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %43 = llvm.call @memchr(%37, %10, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %43, %42 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %44 = llvm.getelementptr %arg1[%19] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %45 = llvm.call @memchr(%37, %12, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %45, %44 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %46 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %47 = llvm.call @memchr(%37, %11, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %47, %46 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @call_memchr_A_pIb_xs_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(2 : i64) : i64
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.mlir.constant(8 : i32) : i32
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.getelementptr %7[%8, %9] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %16 = llvm.call @memchr(%15, %10, %11) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %16, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %17 = llvm.getelementptr %15[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %18 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %19 = llvm.call @memchr(%15, %10, %11) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %19, %18 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %20 = llvm.getelementptr %7[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %21 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %22 = llvm.call @memchr(%20, %10, %11) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %22, %21 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memchr_gep_gep_gep() -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<[0, -1]> : tensor<2xi64>) : !llvm.array<2 x i64>
    %1 = llvm.mlir.addressof @ai64 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i64>
    %7 = llvm.getelementptr %6[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.getelementptr %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %9 = llvm.call @memchr(%8, %4, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %9 : !llvm.ptr
  }
  llvm.func @fold_memchr_union_member() -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<[286331153, 35791394]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %1 = llvm.mlir.undef : !llvm.struct<"union.U", (array<2 x i32>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"union.U", (array<2 x i32>)> 
    %3 = llvm.mlir.addressof @u : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(34 : i32) : i32
    %6 = llvm.mlir.constant(8 : i64) : i64
    %7 = llvm.getelementptr %3[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.call @memchr(%7, %5, %6) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %8 : !llvm.ptr
  }
}

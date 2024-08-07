module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a() {addr_space = 0 : i32} : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> {
    %0 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %2 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("123\00\00\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00\00") : !llvm.array<6 x i8>
    %9 = llvm.mlir.constant("1\00\00\00\00") : !llvm.array<5 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> 
    llvm.return %16 : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
  }
  llvm.mlir.global external constant @pcnt_s("%s\00") {addr_space = 0 : i32}
  llvm.func @snprintf(!llvm.ptr, i64, !llvm.ptr, ...) -> i32
  llvm.func @fold_snprintf_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %4 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %5 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %6 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %7 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %10 = llvm.insertvalue %4, %9[2] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %11 = llvm.mlir.constant("123\00\00\00\00") : !llvm.array<7 x i8>
    %12 = llvm.mlir.constant("12\00\00\00\00") : !llvm.array<6 x i8>
    %13 = llvm.mlir.constant("1\00\00\00\00") : !llvm.array<5 x i8>
    %14 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %16 = llvm.insertvalue %12, %15[1] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %17 = llvm.insertvalue %11, %16[2] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %18 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %19 = llvm.insertvalue %17, %18[0] : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> 
    %20 = llvm.insertvalue %10, %19[1] : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> 
    %21 = llvm.mlir.addressof @a : !llvm.ptr
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.mlir.constant(1 : i64) : i64
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.mlir.constant(3 : i32) : i32
    %27 = llvm.mlir.constant(2 : i64) : i64
    %28 = llvm.mlir.constant(4 : i32) : i32
    %29 = llvm.mlir.constant(5 : i32) : i32
    %30 = llvm.mlir.constant(6 : i32) : i32
    %31 = llvm.mlir.constant(7 : i32) : i32
    %32 = llvm.mlir.constant(8 : i32) : i32
    %33 = llvm.call @snprintf(%0, %1, %3, %21) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %33, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %34 = llvm.getelementptr %21[%1, %1, 0, %23] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %35 = llvm.call @snprintf(%0, %1, %3, %34) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %36 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %35, %36 {alignment = 4 : i64} : i32, !llvm.ptr
    %37 = llvm.getelementptr %21[%1, %1, 1, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %38 = llvm.call @snprintf(%0, %1, %3, %37) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %39 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %38, %39 {alignment = 4 : i64} : i32, !llvm.ptr
    %40 = llvm.getelementptr %21[%1, %1, 1, %23] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %41 = llvm.call @snprintf(%0, %1, %3, %40) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %42 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %41, %42 {alignment = 4 : i64} : i32, !llvm.ptr
    %43 = llvm.getelementptr %21[%1, %1, 1, %27] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %44 = llvm.call @snprintf(%0, %1, %3, %43) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %45 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %44, %45 {alignment = 4 : i64} : i32, !llvm.ptr
    %46 = llvm.getelementptr %21[%1, %1, 2, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %47 = llvm.call @snprintf(%0, %1, %3, %46) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %48 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %47, %48 {alignment = 4 : i64} : i32, !llvm.ptr
    %49 = llvm.getelementptr %21[%1, %23, 0, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %50 = llvm.call @snprintf(%0, %1, %3, %49) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %51 = llvm.getelementptr %arg0[%30] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %50, %51 {alignment = 4 : i64} : i32, !llvm.ptr
    %52 = llvm.getelementptr %21[%1, %23, 1, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %53 = llvm.call @snprintf(%0, %1, %3, %52) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %54 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %53, %54 {alignment = 4 : i64} : i32, !llvm.ptr
    %55 = llvm.getelementptr %21[%1, %23, 2, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %56 = llvm.call @snprintf(%0, %1, %3, %55) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %57 = llvm.getelementptr %arg0[%32] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %56, %57 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}

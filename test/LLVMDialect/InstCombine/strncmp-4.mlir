module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a() {addr_space = 0 : i32} : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> {
    %0 = llvm.mlir.constant("2345") : !llvm.array<4 x i8>
    %1 = llvm.mlir.constant("1231") : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    llvm.return %6 : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)>
  }
  llvm.func @strncmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @fold_strncmp_Aa_b(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("2345") : !llvm.array<4 x i8>
    %1 = llvm.mlir.constant("1231") : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.mlir.constant(4 : i64) : i64
    %15 = llvm.mlir.constant(5 : i64) : i64
    %16 = llvm.mlir.constant(6 : i64) : i64
    %17 = llvm.mlir.constant(7 : i64) : i64
    %18 = llvm.mlir.constant(8 : i64) : i64
    %19 = llvm.mlir.constant(9 : i64) : i64
    %20 = llvm.getelementptr %7[%8, 1, %8] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)>
    %21 = llvm.call @strncmp(%7, %20, %10) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %21, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %22 = llvm.call @strncmp(%7, %20, %11) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr
    %24 = llvm.call @strncmp(%7, %20, %12) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr
    %26 = llvm.call @strncmp(%7, %20, %13) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %27 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %26, %27 {alignment = 4 : i64} : i32, !llvm.ptr
    %28 = llvm.call @strncmp(%7, %20, %14) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %29 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %28, %29 {alignment = 4 : i64} : i32, !llvm.ptr
    %30 = llvm.call @strncmp(%7, %20, %15) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %31 = llvm.getelementptr %arg0[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %30, %31 {alignment = 4 : i64} : i32, !llvm.ptr
    %32 = llvm.call @strncmp(%7, %20, %16) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %33 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %32, %33 {alignment = 4 : i64} : i32, !llvm.ptr
    %34 = llvm.call @strncmp(%7, %20, %17) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %35 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %34, %35 {alignment = 4 : i64} : i32, !llvm.ptr
    %36 = llvm.call @strncmp(%7, %20, %18) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %37 = llvm.getelementptr %arg0[%18] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %36, %37 {alignment = 4 : i64} : i32, !llvm.ptr
    %38 = llvm.call @strncmp(%7, %20, %19) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %39 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %38, %39 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strncmp_Ab_a(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("2345") : !llvm.array<4 x i8>
    %1 = llvm.mlir.constant("1231") : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.mlir.constant(4 : i64) : i64
    %16 = llvm.mlir.constant(5 : i64) : i64
    %17 = llvm.getelementptr %7[%8, 1, %10] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A", (array<3 x i8>, array<4 x i8>, array<4 x i8>)>
    %18 = llvm.call @strncmp(%17, %7, %11) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %18, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %19 = llvm.call @strncmp(%17, %7, %12) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %20 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr
    %21 = llvm.call @strncmp(%17, %7, %13) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %22 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %21, %22 {alignment = 4 : i64} : i32, !llvm.ptr
    %23 = llvm.call @strncmp(%17, %7, %14) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %24 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %23, %24 {alignment = 4 : i64} : i32, !llvm.ptr
    %25 = llvm.call @strncmp(%17, %7, %15) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %26 = llvm.getelementptr %arg0[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %25, %26 {alignment = 4 : i64} : i32, !llvm.ptr
    %27 = llvm.call @strncmp(%17, %7, %16) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %28 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %27, %28 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}

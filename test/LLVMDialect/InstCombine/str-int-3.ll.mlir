module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a() {addr_space = 0 : i32} : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    llvm.return %16 : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
  }
  llvm.func @atoi(!llvm.ptr) -> i32
  llvm.func @atol(!llvm.ptr) -> i64
  llvm.func @atoll(!llvm.ptr) -> i64
  llvm.func @strtol(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @strtoll(!llvm.ptr, !llvm.ptr, i32) -> i64
  llvm.func @fold_atoi_member(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.constant(0 : i64) : i64
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.mlir.constant(2 : i32) : i32
    %23 = llvm.mlir.constant(3 : i32) : i32
    %24 = llvm.call @atoi(%17) : (!llvm.ptr) -> i32
    llvm.store %24, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %25 = llvm.getelementptr %17[%18, %18, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %26 = llvm.call @atoi(%25) : (!llvm.ptr) -> i32
    %27 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %26, %27 {alignment = 4 : i64} : i32, !llvm.ptr
    %28 = llvm.getelementptr %17[%18, %20, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %29 = llvm.call @atoi(%28) : (!llvm.ptr) -> i32
    %30 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %29, %30 {alignment = 4 : i64} : i32, !llvm.ptr
    %31 = llvm.getelementptr %17[%18, %20, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %32 = llvm.call @atoi(%31) : (!llvm.ptr) -> i32
    %33 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %32, %33 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_atoi_offset_out_of_bounds(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %6 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %8 = llvm.insertvalue %4, %7[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %9 = llvm.insertvalue %3, %8[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %10 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %11 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %12 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %13 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %15 = llvm.insertvalue %11, %14[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %16 = llvm.insertvalue %10, %15[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %17 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %19 = llvm.insertvalue %9, %18[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %20 = llvm.mlir.addressof @a : !llvm.ptr
    %21 = llvm.getelementptr inbounds %20[%2, %0, 0, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %22 = llvm.mlir.constant(33 : i64) : i64
    %23 = llvm.call @atoi(%21) : (!llvm.ptr) -> i32
    llvm.store %23, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %24 = llvm.getelementptr %20[%0, %0, 0, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %25 = llvm.call @atoi(%24) : (!llvm.ptr) -> i32
    llvm.store %25, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_atol_member(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.constant(0 : i64) : i64
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.constant(2 : i32) : i32
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.mlir.constant(3 : i32) : i32
    %24 = llvm.mlir.constant(4 : i32) : i32
    %25 = llvm.mlir.constant(5 : i32) : i32
    %26 = llvm.call @atol(%17) : (!llvm.ptr) -> i64
    llvm.store %26, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %27 = llvm.getelementptr %17[%18, %18, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %28 = llvm.call @atol(%27) : (!llvm.ptr) -> i64
    %29 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %28, %29 {alignment = 4 : i64} : i64, !llvm.ptr
    %30 = llvm.getelementptr %17[%18, %18, 2, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %31 = llvm.call @atol(%30) : (!llvm.ptr) -> i64
    %32 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %31, %32 {alignment = 4 : i64} : i64, !llvm.ptr
    %33 = llvm.getelementptr %17[%18, %21, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %34 = llvm.call @atol(%33) : (!llvm.ptr) -> i64
    %35 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %34, %35 {alignment = 4 : i64} : i64, !llvm.ptr
    %36 = llvm.getelementptr %17[%18, %21, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %37 = llvm.call @atol(%36) : (!llvm.ptr) -> i64
    %38 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %37, %38 {alignment = 4 : i64} : i64, !llvm.ptr
    %39 = llvm.getelementptr %17[%18, %21, 2, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %40 = llvm.call @atol(%39) : (!llvm.ptr) -> i64
    %41 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %40, %41 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_atoll_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.constant(0 : i64) : i64
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.mlir.constant(2 : i32) : i32
    %22 = llvm.mlir.constant(3 : i64) : i64
    %23 = llvm.mlir.constant(0 : i32) : i32
    %24 = llvm.mlir.constant(2 : i64) : i64
    %25 = llvm.mlir.constant(3 : i32) : i32
    %26 = llvm.mlir.constant(4 : i32) : i32
    %27 = llvm.mlir.constant(4 : i64) : i64
    %28 = llvm.mlir.constant(5 : i32) : i32
    %29 = llvm.call @atol(%17) : (!llvm.ptr) -> i64
    llvm.store %29, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %30 = llvm.getelementptr %17[%18, %18, 1, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %31 = llvm.call @atol(%30) : (!llvm.ptr) -> i64
    %32 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %31, %32 {alignment = 4 : i64} : i64, !llvm.ptr
    %33 = llvm.getelementptr %17[%18, %18, 2, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %34 = llvm.call @atol(%33) : (!llvm.ptr) -> i64
    %35 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %34, %35 {alignment = 4 : i64} : i64, !llvm.ptr
    %36 = llvm.getelementptr %17[%18, %20, 0, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %37 = llvm.call @atol(%36) : (!llvm.ptr) -> i64
    %38 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %37, %38 {alignment = 4 : i64} : i64, !llvm.ptr
    %39 = llvm.getelementptr %17[%18, %20, 1, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %40 = llvm.call @atol(%39) : (!llvm.ptr) -> i64
    %41 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %40, %41 {alignment = 4 : i64} : i64, !llvm.ptr
    %42 = llvm.getelementptr %17[%18, %20, 2, %27] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %43 = llvm.call @atol(%42) : (!llvm.ptr) -> i64
    %44 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %43, %44 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strtol_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.zero : !llvm.ptr
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.mlir.constant(1 : i64) : i64
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.mlir.constant(2 : i64) : i64
    %26 = llvm.mlir.constant(3 : i32) : i32
    %27 = llvm.mlir.constant(4 : i32) : i32
    %28 = llvm.mlir.constant(4 : i64) : i64
    %29 = llvm.mlir.constant(5 : i32) : i32
    %30 = llvm.call @strtol(%17, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %30, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %31 = llvm.getelementptr %17[%20, %20, 1, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %32 = llvm.call @strtol(%31, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %33 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr
    %34 = llvm.getelementptr %17[%20, %20, 2, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %35 = llvm.call @strtol(%34, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %36 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %35, %36 {alignment = 4 : i64} : i64, !llvm.ptr
    %37 = llvm.getelementptr %17[%20, %22, 0, %25] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %38 = llvm.call @strtol(%37, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %39 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %38, %39 {alignment = 4 : i64} : i64, !llvm.ptr
    %40 = llvm.getelementptr %17[%20, %22, 1, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %41 = llvm.call @strtol(%40, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %42 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %41, %42 {alignment = 4 : i64} : i64, !llvm.ptr
    %43 = llvm.getelementptr %17[%20, %22, 2, %28] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %44 = llvm.call @strtol(%43, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %45 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %44, %45 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strtoll_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.zero : !llvm.ptr
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.mlir.constant(1 : i64) : i64
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.mlir.constant(2 : i64) : i64
    %26 = llvm.mlir.constant(3 : i32) : i32
    %27 = llvm.mlir.constant(4 : i32) : i32
    %28 = llvm.mlir.constant(4 : i64) : i64
    %29 = llvm.mlir.constant(5 : i32) : i32
    %30 = llvm.call @strtoll(%17, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %30, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %31 = llvm.getelementptr %17[%20, %20, 1, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %32 = llvm.call @strtoll(%31, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %33 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr
    %34 = llvm.getelementptr %17[%20, %20, 2, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %35 = llvm.call @strtoll(%34, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %36 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %35, %36 {alignment = 4 : i64} : i64, !llvm.ptr
    %37 = llvm.getelementptr %17[%20, %22, 0, %25] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %38 = llvm.call @strtoll(%37, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %39 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %38, %39 {alignment = 4 : i64} : i64, !llvm.ptr
    %40 = llvm.getelementptr %17[%20, %22, 1, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %41 = llvm.call @strtoll(%40, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %42 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %41, %42 {alignment = 4 : i64} : i64, !llvm.ptr
    %43 = llvm.getelementptr %17[%20, %22, 2, %28] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %44 = llvm.call @strtoll(%43, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %45 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %44, %45 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
}

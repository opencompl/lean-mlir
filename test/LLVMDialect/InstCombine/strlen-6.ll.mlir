module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a_s3() {addr_space = 0 : i32} : !llvm.struct<"struct.A_a4", (array<4 x i8>)> {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.undef : !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.A_a4", (array<4 x i8>)> 
    llvm.return %2 : !llvm.struct<"struct.A_a4", (array<4 x i8>)>
  }
  llvm.mlir.global external constant @a_s3_s4() {addr_space = 0 : i32} : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    llvm.return %4 : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
  }
  llvm.mlir.global external constant @a_s3_i32_s4() {addr_space = 0 : i32} : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    llvm.return %6 : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
  }
  llvm.mlir.global external constant @ax_s3() {addr_space = 0 : i32} : !llvm.struct<(i8, array<4 x i8>)> {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : !llvm.struct<(i8, array<4 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i8, array<4 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i8, array<4 x i8>)> 
    llvm.return %4 : !llvm.struct<(i8, array<4 x i8>)>
  }
  llvm.mlir.global external constant @ax_s5() {addr_space = 0 : i32} : !llvm.struct<(i16, array<6 x i8>)> {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.undef : !llvm.struct<(i16, array<6 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i16, array<6 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i16, array<6 x i8>)> 
    llvm.return %4 : !llvm.struct<(i16, array<6 x i8>)>
  }
  llvm.mlir.global external constant @ax_s7() {addr_space = 0 : i32} : !llvm.struct<(i32, i32, array<8 x i8>)> {
    %0 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<(i32, i32, array<8 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i32, array<8 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i32, i32, array<8 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<(i32, i32, array<8 x i8>)> 
    llvm.return %6 : !llvm.struct<(i32, i32, array<8 x i8>)>
  }
  llvm.mlir.global external @ax() {addr_space = 0 : i32} : !llvm.array<0 x i64>
  llvm.func @strlen(!llvm.ptr) -> i64
  llvm.func @fold_strlen_a_S3_to_3() -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.undef : !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.A_a4", (array<4 x i8>)> 
    %3 = llvm.mlir.addressof @a_s3 : !llvm.ptr
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strlen_a_S3_p1_to_2() -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.undef : !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.A_a4", (array<4 x i8>)> 
    %3 = llvm.mlir.addressof @a_s3 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.getelementptr %3[%4, 0, %5] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @fold_strlen_a_S3_p2_to_1() -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.undef : !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.A_a4", (array<4 x i8>)> 
    %3 = llvm.mlir.addressof @a_s3 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.getelementptr %3[%4, 0, %5] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @fold_strlen_a_S3_p3_to_0() -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.undef : !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.A_a4", (array<4 x i8>)> 
    %3 = llvm.mlir.addressof @a_s3 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.getelementptr %3[%4, 0, %5] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4", (array<4 x i8>)>
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }
  llvm.func @fold_strlen_a_S3_s4_to_3() -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.addressof @a_s3_s4 : !llvm.ptr
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strlen_a_S3_p2_s4_to_1() -> i64 {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.addressof @a_s3_s4 : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.getelementptr %5[%6, 0, %7] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %9 = llvm.call @strlen(%8) : (!llvm.ptr) -> i64
    llvm.return %9 : i64
  }
  llvm.func @fold_strlen_a_s3_S4_to_4() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.addressof @a_s3_s4 : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(4 : i32) : i32
    %8 = llvm.mlir.addressof @ax : !llvm.ptr
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.getelementptr %5[%6, 0, %7] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %13 = llvm.call @strlen(%12) : (!llvm.ptr) -> i64
    llvm.store %13, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %14 = llvm.getelementptr %5[%6, 1, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    %16 = llvm.getelementptr inbounds %8[%10, %11] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %13, %16 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_a_s3_S4_p1_to_3() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.addressof @a_s3_s4 : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(5 : i32) : i32
    %8 = llvm.mlir.addressof @ax : !llvm.ptr
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.getelementptr %5[%6, 0, %7] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %13 = llvm.call @strlen(%12) : (!llvm.ptr) -> i64
    llvm.store %13, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %14 = llvm.getelementptr %5[%6, 1, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_a5", (array<4 x i8>, array<5 x i8>)>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    %16 = llvm.getelementptr inbounds %8[%10, %11] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %13, %16 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_a_s3_i32_S4_to_4() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %7 = llvm.mlir.addressof @a_s3_i32_s4 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(8 : i32) : i32
    %10 = llvm.mlir.addressof @ax : !llvm.ptr
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %7[%8, 0, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.store %15, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %16 = llvm.getelementptr %7[%8, 2, %8] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %17 = llvm.call @strlen(%16) : (!llvm.ptr) -> i64
    %18 = llvm.getelementptr inbounds %10[%12, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %15, %18 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_a_s3_i32_S4_p1_to_3() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %7 = llvm.mlir.addressof @a_s3_i32_s4 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(9 : i32) : i32
    %10 = llvm.mlir.addressof @ax : !llvm.ptr
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %7[%8, 0, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.store %15, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %16 = llvm.getelementptr %7[%8, 2, %8] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %17 = llvm.call @strlen(%16) : (!llvm.ptr) -> i64
    %18 = llvm.getelementptr inbounds %10[%12, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %15, %18 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_a_s3_i32_S4_p2_to_2() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %7 = llvm.mlir.addressof @a_s3_i32_s4 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(10 : i32) : i32
    %10 = llvm.mlir.addressof @ax : !llvm.ptr
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %7[%8, 0, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.store %15, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %16 = llvm.getelementptr %7[%8, 2, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %17 = llvm.call @strlen(%16) : (!llvm.ptr) -> i64
    %18 = llvm.getelementptr inbounds %10[%12, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %15, %18 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_a_s3_i32_S4_p3_to_1() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %7 = llvm.mlir.addressof @a_s3_i32_s4 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(11 : i32) : i32
    %10 = llvm.mlir.addressof @ax : !llvm.ptr
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.getelementptr %7[%8, 0, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.store %16, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %17 = llvm.getelementptr %7[%8, 2, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %18 = llvm.call @strlen(%17) : (!llvm.ptr) -> i64
    %19 = llvm.getelementptr inbounds %10[%13, %14] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %16, %19 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_a_s3_i32_S4_p4_to_0() {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)> 
    %7 = llvm.mlir.addressof @a_s3_i32_s4 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(12 : i32) : i32
    %10 = llvm.mlir.addressof @ax : !llvm.ptr
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(4 : i32) : i32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.getelementptr %7[%8, 0, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.store %16, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %17 = llvm.getelementptr %7[%8, 2, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.struct<"struct.A_a4_i32_a5", (array<4 x i8>, i32, array<5 x i8>)>
    %18 = llvm.call @strlen(%17) : (!llvm.ptr) -> i64
    %19 = llvm.getelementptr inbounds %10[%13, %14] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %16, %19 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_strlen_ax_s() {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.undef : !llvm.struct<(i8, array<4 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i8, array<4 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i8, array<4 x i8>)> 
    %5 = llvm.mlir.addressof @ax_s3 : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.addressof @ax : !llvm.ptr
    %9 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %10 = llvm.mlir.constant(5 : i16) : i16
    %11 = llvm.mlir.undef : !llvm.struct<(i16, array<6 x i8>)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(i16, array<6 x i8>)> 
    %13 = llvm.insertvalue %9, %12[1] : !llvm.struct<(i16, array<6 x i8>)> 
    %14 = llvm.mlir.addressof @ax_s5 : !llvm.ptr
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.mlir.constant(7 : i32) : i32
    %19 = llvm.mlir.undef : !llvm.struct<(i32, i32, array<8 x i8>)>
    %20 = llvm.insertvalue %18, %19[0] : !llvm.struct<(i32, i32, array<8 x i8>)> 
    %21 = llvm.insertvalue %17, %20[1] : !llvm.struct<(i32, i32, array<8 x i8>)> 
    %22 = llvm.insertvalue %16, %21[2] : !llvm.struct<(i32, i32, array<8 x i8>)> 
    %23 = llvm.mlir.addressof @ax_s7 : !llvm.ptr
    %24 = llvm.mlir.constant(2 : i32) : i32
    %25 = llvm.mlir.constant(2 : i64) : i64
    %26 = llvm.getelementptr %5[%6, 1, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<(i8, array<4 x i8>)>
    %27 = llvm.call @strlen(%26) : (!llvm.ptr) -> i64
    llvm.store %27, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %28 = llvm.getelementptr %14[%6, 1, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<(i16, array<6 x i8>)>
    %29 = llvm.call @strlen(%28) : (!llvm.ptr) -> i64
    %30 = llvm.getelementptr inbounds %8[%6, %15] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %29, %30 {alignment = 4 : i64} : i64, !llvm.ptr
    %31 = llvm.getelementptr %23[%6, 2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<(i32, i32, array<8 x i8>)>
    %32 = llvm.call @strlen(%31) : (!llvm.ptr) -> i64
    %33 = llvm.getelementptr inbounds %8[%6, %25] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i64>
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
}

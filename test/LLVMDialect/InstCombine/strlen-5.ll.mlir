module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5_4() {addr_space = 0 : i32} : !llvm.array<5 x array<4 x i8>> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    llvm.return %10 : !llvm.array<5 x array<4 x i8>>
  }
  llvm.func @strlen(!llvm.ptr) -> i64
  llvm.func @fold_a5_4_i0_to_3() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.call @strlen(%11) : (!llvm.ptr) -> i64
    llvm.return %12 : i64
  }
  llvm.func @fold_a5_4_i0_p1_to_2() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %12, %13] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i0_p2_to_1() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %12, %13] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i0_p3_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %12, %13] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i1_to_2() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i1_p1_to_1() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %13] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i1_p2_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i1_p3_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(1 : i64) : i64
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i2_to_1() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i2_p1_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i2_p2_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %13] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i2_p3_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i3_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i3_p1_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i3_p2_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_3_i4_p3_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %13] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i4_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.getelementptr %11[%12, %13, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    llvm.return %15 : i64
  }
  llvm.func @fold_a5_4_i4_p1_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i4_p2_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
  llvm.func @fold_a5_4_i4_p3_to_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %3, %6[1] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %2, %7[2] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[3] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.insertvalue %1, %9[4] : !llvm.array<5 x array<4 x i8>> 
    %11 = llvm.mlir.addressof @a5_4 : !llvm.ptr
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.getelementptr %11[%12, %13, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %16 = llvm.call @strlen(%15) : (!llvm.ptr) -> i64
    llvm.return %16 : i64
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5() {addr_space = 0 : i32} : !llvm.array<5 x array<4 x i8>> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    llvm.return %9 : !llvm.array<5 x array<4 x i8>>
  }
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @fold_strcmp_a5i0_a5i1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }
  llvm.func @call_strcmp_a5i0_a5iI(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr %10[%11, %arg0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %13 = llvm.call @strcmp(%10, %12) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %13 : i32
  }
  llvm.func @call_strcmp_a5iI_a5i0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr %10[%11, %arg0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %13 = llvm.call @strcmp(%12, %10) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %13 : i32
  }
  llvm.func @fold_strcmp_a5i0_a5i1_p1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }
  llvm.func @call_strcmp_a5i0_a5i1_pI(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }
  llvm.func @fold_strcmp_a5i0_p1_a5i1_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %11, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %15 = llvm.call @strcmp(%13, %14) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %15 : i32
  }
  llvm.func @fold_strcmp_a5i0_a5i2_to_0() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%10, %13) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }
  llvm.func @fold_strcmp_a5i2_a5i0_to_m1() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.constant("12\00\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.undef : !llvm.array<5 x array<4 x i8>>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.array<5 x array<4 x i8>> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.array<5 x array<4 x i8>> 
    %7 = llvm.insertvalue %2, %6[2] : !llvm.array<5 x array<4 x i8>> 
    %8 = llvm.insertvalue %1, %7[3] : !llvm.array<5 x array<4 x i8>> 
    %9 = llvm.insertvalue %1, %8[4] : !llvm.array<5 x array<4 x i8>> 
    %10 = llvm.mlir.addressof @a5 : !llvm.ptr
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.getelementptr %10[%11, %12, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<5 x array<4 x i8>>
    %14 = llvm.call @strcmp(%13, %10) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %14 : i32
  }
}

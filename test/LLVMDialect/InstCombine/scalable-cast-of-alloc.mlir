module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fixed_array16i32_to_scalable4i32(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<? x 4 x  i32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.alloca %0 x !llvm.array<16 x i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %10, %11 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr
    %12 = llvm.load volatile %11 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    llvm.store %12, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr
    llvm.return
  }
  llvm.func @scalable4i32_to_fixed16i32(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<16xi32>) : vector<16xi32>
    %3 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store %2, %3 {alignment = 16 : i64} : vector<16xi32>, !llvm.ptr
    %4 = llvm.load volatile %3 {alignment = 16 : i64} : !llvm.ptr -> vector<16xi32>
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<16xi32>, !llvm.ptr
    llvm.return
  }
  llvm.func @fixed16i32_to_scalable4i32(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<? x 4 x  i32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.alloca %0 x vector<16xi32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %10, %11 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr
    %12 = llvm.load volatile %11 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    llvm.store %12, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 4 x  i32>, !llvm.ptr
    llvm.return
  }
  llvm.func @scalable16i32_to_fixed16i32(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<16xi32>) : vector<16xi32>
    %3 = llvm.alloca %0 x !llvm.vec<? x 16 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %2, %3 {alignment = 16 : i64} : vector<16xi32>, !llvm.ptr
    %4 = llvm.load volatile %3 {alignment = 16 : i64} : !llvm.ptr -> vector<16xi32>
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<16xi32>, !llvm.ptr
    llvm.return
  }
  llvm.func @scalable32i32_to_scalable16i32(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.vec<? x 16 x  i32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<? x 16 x  i32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<? x 16 x  i32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : !llvm.vec<? x 16 x  i32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : !llvm.vec<? x 16 x  i32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : !llvm.vec<? x 16 x  i32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : !llvm.vec<? x 16 x  i32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : !llvm.vec<? x 16 x  i32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : !llvm.vec<? x 16 x  i32>
    %19 = llvm.mlir.constant(8 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : !llvm.vec<? x 16 x  i32>
    %21 = llvm.mlir.constant(9 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : !llvm.vec<? x 16 x  i32>
    %23 = llvm.mlir.constant(10 : i32) : i32
    %24 = llvm.insertelement %1, %22[%23 : i32] : !llvm.vec<? x 16 x  i32>
    %25 = llvm.mlir.constant(11 : i32) : i32
    %26 = llvm.insertelement %1, %24[%25 : i32] : !llvm.vec<? x 16 x  i32>
    %27 = llvm.mlir.constant(12 : i32) : i32
    %28 = llvm.insertelement %1, %26[%27 : i32] : !llvm.vec<? x 16 x  i32>
    %29 = llvm.mlir.constant(13 : i32) : i32
    %30 = llvm.insertelement %1, %28[%29 : i32] : !llvm.vec<? x 16 x  i32>
    %31 = llvm.mlir.constant(14 : i32) : i32
    %32 = llvm.insertelement %1, %30[%31 : i32] : !llvm.vec<? x 16 x  i32>
    %33 = llvm.mlir.constant(15 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : !llvm.vec<? x 16 x  i32>
    %35 = llvm.alloca %0 x !llvm.vec<? x 32 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %34, %35 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i32>, !llvm.ptr
    %36 = llvm.load volatile %35 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 16 x  i32>
    llvm.store %36, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i32>, !llvm.ptr
    llvm.return
  }
  llvm.func @scalable32i16_to_scalable16i32(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.vec<? x 16 x  i32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<? x 16 x  i32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<? x 16 x  i32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : !llvm.vec<? x 16 x  i32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : !llvm.vec<? x 16 x  i32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : !llvm.vec<? x 16 x  i32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : !llvm.vec<? x 16 x  i32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : !llvm.vec<? x 16 x  i32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : !llvm.vec<? x 16 x  i32>
    %19 = llvm.mlir.constant(8 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : !llvm.vec<? x 16 x  i32>
    %21 = llvm.mlir.constant(9 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : !llvm.vec<? x 16 x  i32>
    %23 = llvm.mlir.constant(10 : i32) : i32
    %24 = llvm.insertelement %1, %22[%23 : i32] : !llvm.vec<? x 16 x  i32>
    %25 = llvm.mlir.constant(11 : i32) : i32
    %26 = llvm.insertelement %1, %24[%25 : i32] : !llvm.vec<? x 16 x  i32>
    %27 = llvm.mlir.constant(12 : i32) : i32
    %28 = llvm.insertelement %1, %26[%27 : i32] : !llvm.vec<? x 16 x  i32>
    %29 = llvm.mlir.constant(13 : i32) : i32
    %30 = llvm.insertelement %1, %28[%29 : i32] : !llvm.vec<? x 16 x  i32>
    %31 = llvm.mlir.constant(14 : i32) : i32
    %32 = llvm.insertelement %1, %30[%31 : i32] : !llvm.vec<? x 16 x  i32>
    %33 = llvm.mlir.constant(15 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : !llvm.vec<? x 16 x  i32>
    %35 = llvm.alloca %0 x !llvm.vec<? x 32 x  i16> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %34, %35 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i32>, !llvm.ptr
    %36 = llvm.load volatile %35 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 16 x  i32>
    llvm.store %36, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i32>, !llvm.ptr
    llvm.return
  }
  llvm.func @scalable32i16_to_scalable16i32_multiuse(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.vec<? x 16 x  i32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<? x 16 x  i32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<? x 16 x  i32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : !llvm.vec<? x 16 x  i32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : !llvm.vec<? x 16 x  i32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : !llvm.vec<? x 16 x  i32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : !llvm.vec<? x 16 x  i32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : !llvm.vec<? x 16 x  i32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : !llvm.vec<? x 16 x  i32>
    %19 = llvm.mlir.constant(8 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : !llvm.vec<? x 16 x  i32>
    %21 = llvm.mlir.constant(9 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : !llvm.vec<? x 16 x  i32>
    %23 = llvm.mlir.constant(10 : i32) : i32
    %24 = llvm.insertelement %1, %22[%23 : i32] : !llvm.vec<? x 16 x  i32>
    %25 = llvm.mlir.constant(11 : i32) : i32
    %26 = llvm.insertelement %1, %24[%25 : i32] : !llvm.vec<? x 16 x  i32>
    %27 = llvm.mlir.constant(12 : i32) : i32
    %28 = llvm.insertelement %1, %26[%27 : i32] : !llvm.vec<? x 16 x  i32>
    %29 = llvm.mlir.constant(13 : i32) : i32
    %30 = llvm.insertelement %1, %28[%29 : i32] : !llvm.vec<? x 16 x  i32>
    %31 = llvm.mlir.constant(14 : i32) : i32
    %32 = llvm.insertelement %1, %30[%31 : i32] : !llvm.vec<? x 16 x  i32>
    %33 = llvm.mlir.constant(15 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : !llvm.vec<? x 16 x  i32>
    %35 = llvm.alloca %0 x !llvm.vec<? x 32 x  i16> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %34, %35 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i32>, !llvm.ptr
    %36 = llvm.load volatile %35 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 16 x  i32>
    llvm.store %36, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i32>, !llvm.ptr
    %37 = llvm.load volatile %35 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 32 x  i16>
    llvm.store %37, %arg1 {alignment = 16 : i64} : !llvm.vec<? x 32 x  i16>, !llvm.ptr
    llvm.return
  }
}

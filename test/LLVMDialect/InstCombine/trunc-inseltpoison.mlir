module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @use_vec(vector<2xi32>)
  llvm.func @test1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i64
  }
  llvm.func @test1_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test1_vec_nonuniform(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[15, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test1_vec_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.and %7, %6  : vector<2xi32>
    %9 = llvm.zext %8 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%7) : (vector<2xi32>) -> ()
    llvm.return %9 : vector<2xi64>
  }
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i64
  }
  llvm.func @test2_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test2_vec_nonuniform(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test2_vec_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.shl %7, %6  : vector<2xi32>
    %9 = llvm.ashr %8, %6  : vector<2xi32>
    %10 = llvm.sext %9 : vector<2xi32> to vector<2xi64>
    llvm.call @use_vec(%7) : (vector<2xi32>) -> ()
    llvm.return %10 : vector<2xi64>
  }
  llvm.func @test3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %3 : i64
  }
  llvm.func @test4(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %4 : i64
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }
  llvm.func @test6(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.zext %arg0 : i64 to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_mul_sign_bits(%arg0: i8, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.sext %arg1 : i8 to i32
    %3 = llvm.mul %1, %2  : i32
    %4 = llvm.ashr %3, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }
  llvm.func @ashr_mul(%arg0: i8, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i20) : i20
    %1 = llvm.sext %arg0 : i8 to i20
    %2 = llvm.sext %arg1 : i8 to i20
    %3 = llvm.mul %1, %2  : i20
    %4 = llvm.ashr %3, %0  : i20
    %5 = llvm.trunc %4 : i20 to i16
    llvm.return %5 : i16
  }
  llvm.func @trunc_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i36) : i36
    %1 = llvm.mlir.constant(8 : i36) : i36
    %2 = llvm.zext %arg0 : i32 to i36
    %3 = llvm.or %2, %0  : i36
    %4 = llvm.ashr %3, %1  : i36
    %5 = llvm.trunc %4 : i36 to i32
    llvm.return %5 : i32
  }
  llvm.func @trunc_ashr_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-2147483648 : i36) : i36
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi36>) : vector<2xi36>
    %2 = llvm.mlir.constant(8 : i36) : i36
    %3 = llvm.mlir.constant(dense<8> : vector<2xi36>) : vector<2xi36>
    %4 = llvm.zext %arg0 : vector<2xi32> to vector<2xi36>
    %5 = llvm.or %4, %1  : vector<2xi36>
    %6 = llvm.ashr %5, %3  : vector<2xi36>
    %7 = llvm.trunc %6 : vector<2xi36> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test7(%arg0: i64) -> i92 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.zext %arg0 : i64 to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i92
    llvm.return %3 : i92
  }
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.shl %2, %0  : i128
    %4 = llvm.or %3, %1  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }
  llvm.func @test8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.mlir.constant(dense<32> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.shl %3, %1  : vector<2xi128>
    %5 = llvm.or %4, %2  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @test8_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(48 : i128) : i128
    %1 = llvm.mlir.constant(32 : i128) : i128
    %2 = llvm.mlir.constant(dense<[32, 48]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.shl %4, %2  : vector<2xi128>
    %6 = llvm.or %5, %3  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test8_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(32 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.shl %8, %6  : vector<2xi128>
    %10 = llvm.or %9, %7  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }
  llvm.func @test9(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }
  llvm.func @test10(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.and %2, %0  : i128
    %4 = llvm.shl %1, %3  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }
  llvm.func @test11_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.mlir.constant(dense<31> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.and %3, %1  : vector<2xi128>
    %5 = llvm.shl %2, %4  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @test11_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(15 : i128) : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.and %4, %2  : vector<2xi128>
    %6 = llvm.shl %3, %5  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test11_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.and %8, %6  : vector<2xi128>
    %10 = llvm.shl %7, %9  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.zext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.and %2, %0  : i128
    %4 = llvm.lshr %1, %3  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }
  llvm.func @test12_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.mlir.constant(dense<31> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.and %3, %1  : vector<2xi128>
    %5 = llvm.lshr %2, %4  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @test12_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(15 : i128) : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.and %4, %2  : vector<2xi128>
    %6 = llvm.lshr %3, %5  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test12_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.zext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.and %8, %6  : vector<2xi128>
    %10 = llvm.lshr %7, %9  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.sext %arg0 : i32 to i128
    %2 = llvm.zext %arg1 : i32 to i128
    %3 = llvm.and %2, %0  : i128
    %4 = llvm.ashr %1, %3  : i128
    %5 = llvm.trunc %4 : i128 to i64
    llvm.return %5 : i64
  }
  llvm.func @test13_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(31 : i128) : i128
    %1 = llvm.mlir.constant(dense<31> : vector<2xi128>) : vector<2xi128>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi128>
    %3 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %4 = llvm.and %3, %1  : vector<2xi128>
    %5 = llvm.ashr %2, %4  : vector<2xi128>
    %6 = llvm.trunc %5 : vector<2xi128> to vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
  llvm.func @test13_vec_nonuniform(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(15 : i128) : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.constant(dense<[31, 15]> : vector<2xi128>) : vector<2xi128>
    %3 = llvm.sext %arg0 : vector<2xi32> to vector<2xi128>
    %4 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %5 = llvm.and %4, %2  : vector<2xi128>
    %6 = llvm.ashr %3, %5  : vector<2xi128>
    %7 = llvm.trunc %6 : vector<2xi128> to vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }
  llvm.func @test13_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i128
    %1 = llvm.mlir.constant(31 : i128) : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.sext %arg0 : vector<2xi32> to vector<2xi128>
    %8 = llvm.zext %arg1 : vector<2xi32> to vector<2xi128>
    %9 = llvm.and %8, %6  : vector<2xi128>
    %10 = llvm.ashr %7, %9  : vector<2xi128>
    %11 = llvm.trunc %10 : vector<2xi128> to vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }
  llvm.func @trunc_bitcast1(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.constant(32 : i128) : i128
    %1 = llvm.bitcast %arg0 : vector<4xi32> to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_bitcast2(%arg0: vector<2xi64>) -> i32 {
    %0 = llvm.mlir.constant(64 : i128) : i128
    %1 = llvm.bitcast %arg0 : vector<2xi64> to i128
    %2 = llvm.lshr %1, %0  : i128
    %3 = llvm.trunc %2 : i128 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_bitcast3(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to i128
    %1 = llvm.trunc %0 : i128 to i32
    llvm.return %1 : i32
  }
  llvm.func @trunc_shl_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_nsw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_nuw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_nsw_nuw_31_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_15_i16_i64(%arg0: i64) -> i16 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }
  llvm.func @trunc_shl_15_i16_i32(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }
  llvm.func @trunc_shl_7_i8_i64(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i8
    llvm.return %2 : i8
  }
  llvm.func @trunc_shl_1_i2_i64(%arg0: i64) -> i2 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i2
    llvm.return %2 : i2
  }
  llvm.func @trunc_shl_1_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_16_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_33_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_32_i32_i64(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }
  llvm.func @trunc_shl_16_v2i32_v2i64(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @trunc_shl_nosplat_v2i32_v2i64(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[15, 16]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @trunc_shl_31_i32_i64_multi_use(%arg0: i64, %arg1: !llvm.ptr<1>, %arg2: !llvm.ptr<1>) {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.store volatile %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    llvm.store volatile %1, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr<1>
    llvm.return
  }
  llvm.func @trunc_shl_lshr_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.shl %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }
  llvm.func @trunc_shl_v2i32_v2i64_uniform(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @trunc_shl_v2i32_v2i64_poison(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(31 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.shl %arg0, %6  : vector<2xi64>
    %8 = llvm.trunc %7 : vector<2xi64> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @trunc_shl_v2i32_v2i64_nonuniform(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 12]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @trunc_shl_v2i32_v2i64_outofrange(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 33]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @trunc_shl_ashr_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.shl %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }
  llvm.func @trunc_shl_shl_infloop(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.shl %2, %1  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }
  llvm.func @trunc_shl_lshr_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.lshr %arg0, %arg1  : i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_shl_ashr_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.ashr %arg0, %arg1  : i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_shl_shl_var(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.shl %arg0, %arg1  : i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_shl_v8i15_v8i32_15(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @trunc_shl_v8i16_v8i32_16(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @trunc_shl_v8i16_v8i32_17(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<17> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @trunc_shl_v8i16_v8i32_4(%arg0: vector<8xi32>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %0  : vector<8xi32>
    %2 = llvm.trunc %1 : vector<8xi32> to vector<8xi16>
    llvm.return %2 : vector<8xi16>
  }
  llvm.func @wide_shuf(%arg0: vector<4xi32>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[35, 3634, 90, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 5, 6, 2] : vector<4xi32> 
    %2 = llvm.trunc %1 : vector<4xi32> to vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @wide_splat1(%arg0: vector<4xi32>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xi32> 
    %2 = llvm.trunc %1 : vector<4xi32> to vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @wide_splat2(%arg0: vector<3xi33>) -> vector<3xi31> {
    %0 = llvm.mlir.poison : vector<3xi33>
    %1 = llvm.shufflevector %arg0, %0 [1, 1, 1] : vector<3xi33> 
    %2 = llvm.trunc %1 : vector<3xi33> to vector<3xi31>
    llvm.return %2 : vector<3xi31>
  }
  llvm.func @wide_splat3(%arg0: vector<3xi33>) -> vector<3xi31> {
    %0 = llvm.mlir.poison : vector<3xi33>
    %1 = llvm.shufflevector %arg0, %0 [-1, 1, 1] : vector<3xi33> 
    %2 = llvm.trunc %1 : vector<3xi33> to vector<3xi31>
    llvm.return %2 : vector<3xi31>
  }
  llvm.func @wide_lengthening_splat(%arg0: vector<4xi16>) -> vector<8xi8> {
    %0 = llvm.shufflevector %arg0, %arg0 [0, 0, 0, 0, 0, 0, 0, 0] : vector<4xi16> 
    %1 = llvm.trunc %0 : vector<8xi16> to vector<8xi8>
    llvm.return %1 : vector<8xi8>
  }
  llvm.func @narrow_add_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[256, -129]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @narrow_mul_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[256, -129]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @narrow_sub_vec_constant(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[256, -129]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @PR44545(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "eq" %arg1, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    %6 = llvm.trunc %5 : i32 to i16
    %7 = llvm.add %6, %2 overflow<nsw>  : i16
    llvm.return %7 : i16
  }
}

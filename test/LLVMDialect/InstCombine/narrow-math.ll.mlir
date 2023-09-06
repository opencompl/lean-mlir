module  {
  llvm.func @callee() -> i32
  llvm.func @use(i64)
  llvm.func @sext_sext_add(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @sext_zext_add_mismatched_exts(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.zext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @sext_sext_add_mismatched_types(%arg0: i16, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i16) : i16
    %2 = llvm.ashr %arg0, %1  : i16
    %3 = llvm.ashr %arg1, %0  : i32
    %4 = llvm.sext %2 : i16 to i64
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @sext_sext_add_extra_use1(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sext %2 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.sext %3 : i32 to i64
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @sext_sext_add_extra_use2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sext %2 : i32 to i64
    %5 = llvm.sext %3 : i32 to i64
    llvm.call @use(%5) : (i64) -> ()
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @sext_sext_add_extra_use3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sext %2 : i32 to i64
    llvm.call @use(%4) : (i64) -> ()
    %5 = llvm.sext %3 : i32 to i64
    llvm.call @use(%5) : (i64) -> ()
    %6 = llvm.add %4, %5  : i64
    llvm.return %6 : i64
  }
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test3(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test4(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.mul %0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1073741823 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.add %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @sext_add_constant_extra_use(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1073741823 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.call @use(%3) : (i64) -> ()
    %4 = llvm.add %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @test5_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test5_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1073741824 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.add %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @test6_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1073741824> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test6_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test6_vec2(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.add %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @test7_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test7_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.add %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test8(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(32767 : i64) : i64
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.mul %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @test8_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32767> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test8_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[32767, 16384]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test8_vec2(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[32767, -32767]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test9(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-32767 : i64) : i64
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.mul %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @test9_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-32767> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test9_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[-32767, -10]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test10(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(65535 : i64) : i64
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.mul %3, %0  : i64
    llvm.return %4 : i64
  }
  llvm.func @test10_splat(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test10_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[65535, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.mul %3, %0  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test11(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test12(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test13(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %0 : i32 to i64
    %3 = llvm.sext %1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test14(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.zext %0 : i32 to i64
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test15(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.sub %0, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test15vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.sext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.sub %0, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test16(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(4294967294 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.sub %0, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test16vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<4294967294> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.sub %0, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test17(%arg0: i32) -> i64 {
    %0 = llvm.call @callee() : () -> i32
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.zext %0 : i32 to i64
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.sub %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @test18(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2147481648 : i64) : i64
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sub %0, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @test19(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2147481648 : i64) : i64
    %1 = llvm.call @callee() : () -> i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.sub %0, %2  : i64
    llvm.return %3 : i64
  }
}

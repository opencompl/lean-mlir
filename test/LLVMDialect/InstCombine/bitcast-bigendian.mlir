module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.func @test2(%arg0: vector<2xf32>, %arg1: vector<2xi32>) -> f32 {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.bitcast %arg1 : vector<2xi32> to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.bitcast %4 : i32 to f32
    %6 = llvm.fadd %2, %5  : f32
    llvm.return %6 : f32
  }
  llvm.func @test3(%arg0: vector<2xf32>, %arg1: vector<2xi64>) -> f32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(64 : i128) : i128
    %2 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %3 = llvm.lshr %2, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.bitcast %4 : i32 to f32
    %6 = llvm.bitcast %arg1 : vector<2xi64> to i128
    %7 = llvm.lshr %6, %1  : i128
    %8 = llvm.trunc %7 : i128 to i32
    %9 = llvm.bitcast %8 : i32 to f32
    %10 = llvm.fadd %5, %9  : f32
    llvm.return %10 : f32
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> vector<2xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.or %3, %1  : i64
    %5 = llvm.bitcast %4 : i64 to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test5(%arg0: f32, %arg1: f32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %4, %0  : i64
    %6 = llvm.or %5, %2  : i64
    %7 = llvm.bitcast %6 : i64 to vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }
  llvm.func @test6(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1109917696 : i64) : i64
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.shl %3, %0  : i64
    %5 = llvm.or %4, %1  : i64
    %6 = llvm.bitcast %5 : i64 to vector<2xf32>
    llvm.return %6 : vector<2xf32>
  }
  llvm.func @xor_bitcast_vec_to_vec(%arg0: vector<1xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<1xi64> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @and_bitcast_vec_to_int(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xi32> to i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @or_bitcast_int_to_vec(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %2 = llvm.or %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
}

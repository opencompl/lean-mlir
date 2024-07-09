module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.mul %2, %1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i16
    llvm.return %6 : i16
  }
  llvm.func @test1_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.mul %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }
  llvm.func @test1_vec_nonuniform(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.mul %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }
  llvm.func @test1_vec_undef(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(5 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.lshr %13, %6  : vector<2xi32>
    %15 = llvm.mul %13, %12  : vector<2xi32>
    %16 = llvm.or %14, %15  : vector<2xi32>
    %17 = llvm.trunc %16 : vector<2xi32> to vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }
}

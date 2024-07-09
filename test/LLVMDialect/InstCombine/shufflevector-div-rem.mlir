module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_srem_orig(%arg0: i16, %arg1: i1) -> i16 {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [0, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %2, %6 : i1, vector<2xi16>
    %8 = llvm.srem %7, %3  : vector<2xi16>
    %9 = llvm.extractelement %8[%4 : i32] : vector<2xi16>
    llvm.return %9 : i16
  }
  llvm.func @test_srem(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.srem %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @test_urem(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.urem %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @test_sdiv(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.sdiv %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @test_udiv(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.udiv %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @test_fdiv(%arg0: f32, %arg1: f32, %arg2: i1) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(dense<[7.700000e+01, 9.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %12 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %13 = llvm.insertelement %9, %8[%10 : i32] : vector<2xf32>
    %14 = llvm.fdiv %12, %13  : vector<2xf32>
    %15 = llvm.shufflevector %14, %0 [-1, 0] : vector<2xf32> 
    %16 = llvm.select %arg2, %11, %15 : i1, vector<2xf32>
    llvm.return %16 : vector<2xf32>
  }
  llvm.func @test_frem(%arg0: f32, %arg1: f32, %arg2: i1) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(dense<[7.700000e+01, 9.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %12 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %13 = llvm.insertelement %9, %8[%10 : i32] : vector<2xf32>
    %14 = llvm.frem %12, %13  : vector<2xf32>
    %15 = llvm.shufflevector %14, %0 [-1, 0] : vector<2xf32> 
    %16 = llvm.select %arg2, %11, %15 : i1, vector<2xf32>
    llvm.return %16 : vector<2xf32>
  }
}

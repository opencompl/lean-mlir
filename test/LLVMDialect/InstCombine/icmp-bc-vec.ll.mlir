module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_i1_0(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi1>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi1> 
    %5 = llvm.bitcast %4 : vector<4xi1> to i4
    %6 = llvm.icmp "eq" %5, %2 : i4
    llvm.return %6 : i1
  }
  llvm.func @test_i1_0_2(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi1>
    %4 = llvm.shufflevector %3, %0 [2, 2, 2, 2] : vector<4xi1> 
    %5 = llvm.bitcast %4 : vector<4xi1> to i4
    %6 = llvm.icmp "eq" %5, %2 : i4
    llvm.return %6 : i1
  }
  llvm.func @test_i1_m1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i4) : i4
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi1>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi1> 
    %5 = llvm.bitcast %4 : vector<4xi1> to i4
    %6 = llvm.icmp "eq" %5, %2 : i4
    llvm.return %6 : i1
  }
  llvm.func @test_i8_pattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1212696648 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_i8_pattern_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1212696648 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [2, 2, 2, 2] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_i8_pattern_3(%arg0: vector<4xi8>) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(1212696648 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 0, 3, 2] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_i8_nopattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1212696647 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_i8_ult_pattern(%arg0: i8) -> i1 {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1212696648 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xi8> 
    %5 = llvm.bitcast %4 : vector<4xi8> to i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @extending_shuffle_with_weird_types(%arg0: vector<2xi9>) -> i1 {
    %0 = llvm.mlir.undef : vector<2xi9>
    %1 = llvm.mlir.constant(262657 : i27) : i27
    %2 = llvm.shufflevector %arg0, %0 [0, 0, 0] : vector<2xi9> 
    %3 = llvm.bitcast %2 : vector<3xi9> to i27
    %4 = llvm.icmp "slt" %3, %1 : i27
    llvm.return %4 : i1
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(vector<2xi8>)
  llvm.func @insert0_v2i8(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }
  llvm.func @insert1_v2i8(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }
  llvm.func @insert0_v4i8(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }
  llvm.func @insert0_v2half(%arg0: i32, %arg1: f16) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xf16>
    %3 = llvm.bitcast %2 : vector<2xf16> to i32
    llvm.return %3 : i32
  }
  llvm.func @insert0_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }
  llvm.func @insert1_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }
  llvm.func @insert3_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }
  llvm.func @insert0_v4i32(%arg0: i128, %arg1: i32) -> i128 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i128 to vector<4xi32>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi32>
    %3 = llvm.bitcast %2 : vector<4xi32> to i128
    llvm.return %3 : i128
  }
  llvm.func @insert0_v2i8_use1(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    llvm.call @use(%1) : (vector<2xi8>) -> ()
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }
  llvm.func @insert0_v2i8_use2(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    llvm.call @use(%2) : (vector<2xi8>) -> ()
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use_f32(f32)
  llvm.func @use_v4f32(vector<4xf32>)
  llvm.func @bitcast_inselt(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @bitcast_inselt_use1(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @bitcast_inselt_use2(%arg0: i32, %arg1: vector<4xi32>, %arg2: i32) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : i32 to f32
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    llvm.call @use_v4f32(%1) : (vector<4xf32>) -> ()
    %2 = llvm.insertelement %0, %1[%arg2 : i32] : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @bitcast_inselt_use3(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    llvm.call @use_v4f32(%2) : (vector<4xf32>) -> ()
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @bitcast_inselt_wrong_bitcast1(%arg0: i32, %arg1: i64) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.bitcast %arg1 : i64 to vector<2xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @bitcast_inselt_wrong_bitcast2(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to f32
    %2 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
}

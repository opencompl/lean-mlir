module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vtrn1(%arg0: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %1 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [0, 2] : vector<2xf32> 
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @vtrn2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [1, 3] : vector<2xf32> 
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @bc_shuf_lenchange(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @bc_shuf_nonvec(%arg0: i64, %arg1: i64) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %1 = llvm.bitcast %arg1 : i64 to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @bc_shuf_size(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf64> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<2xf64>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<2xf64>
    %2 = llvm.shufflevector %0, %1 [1, 3, 0, 2] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @bc_shuf_mismatch(%arg0: vector<4xi32>, %arg1: vector<2xi64>) -> vector<2xf64> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<2xf64>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<2xf64>
    %2 = llvm.shufflevector %0, %1 [1, 3] : vector<2xf64> 
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @bc_shuf_i8_float(%arg0: vector<8xi8>, %arg1: vector<8xi8>) -> vector<8xf16> {
    %0 = llvm.bitcast %arg0 : vector<8xi8> to vector<4xf16>
    %1 = llvm.bitcast %arg1 : vector<8xi8> to vector<4xf16>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0, 7, 6, 5, 4] : vector<4xf16> 
    llvm.return %2 : vector<8xf16>
  }
  llvm.func @bc_shuf_elemtype_mismatch(%arg0: vector<2xf16>, %arg1: vector<2xbf16>) -> vector<4xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xf16> to vector<2xi16>
    %1 = llvm.bitcast %arg1 : vector<2xbf16> to vector<2xi16>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xi16> 
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @bc_shuf_reuse(%arg0: vector<4xi32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.shufflevector %0, %0 [0, 4] : vector<4xf32> 
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @bc_shuf_y_hasoneuse(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %2 = llvm.shufflevector %0, %1 [0, 1, 4, 5] : vector<4xf32> 
    %3 = llvm.fadd %0, %2  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @bc_shuf_neither_hasoneuse(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %2 = llvm.shufflevector %0, %0 [0, 1, 4, 5] : vector<4xf32> 
    %3 = llvm.fadd %0, %1  : vector<4xf32>
    %4 = llvm.fadd %3, %2  : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
}

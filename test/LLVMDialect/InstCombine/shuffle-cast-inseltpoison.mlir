module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @trunc_little_endian(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @trunc_big_endian(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [1, 3, 5, 7] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @use_v8i16(vector<8xi16>)
  llvm.func @trunc_little_endian_extra_use(%arg0: vector<2xi64>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<2xi64> to vector<8xi16>
    llvm.call @use_v8i16(%1) : (vector<8xi16>) -> ()
    %2 = llvm.shufflevector %1, %0 [0, 4] : vector<8xi16> 
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @use_v12i11(vector<12xi11>)
  llvm.func @trunc_big_endian_extra_use(%arg0: vector<4xi33>) -> vector<4xi11> {
    %0 = llvm.mlir.poison : vector<12xi11>
    %1 = llvm.bitcast %arg0 : vector<4xi33> to vector<12xi11>
    llvm.call @use_v12i11(%1) : (vector<12xi11>) -> ()
    %2 = llvm.shufflevector %1, %0 [2, 5, 8, 11] : vector<12xi11> 
    llvm.return %2 : vector<4xi11>
  }
  llvm.func @wrong_cast1(%arg0: i128) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : i128 to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @wrong_cast2(%arg0: vector<4xf32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xf32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }
  llvm.func @wrong_cast3(%arg0: vector<4xi32>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<8xf16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xf16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xf16> 
    llvm.return %2 : vector<4xf16>
  }
  llvm.func @wrong_shuffle(%arg0: vector<4xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2] : vector<8xi16> 
    llvm.return %2 : vector<2xi16>
  }
}

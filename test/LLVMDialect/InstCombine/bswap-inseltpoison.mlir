module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shuf_4bytes(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
  llvm.func @shuf_load_4bytes(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [3, 2, -1, 0] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }
  llvm.func @shuf_bitcast_twice_4bytes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.shufflevector %1, %0 [-1, 2, 1, 0] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }
  llvm.func @use(vector<4xi8>)
  llvm.func @shuf_4bytes_extra_use(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi8> 
    llvm.call @use(%1) : (vector<4xi8>) -> ()
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
  llvm.func @shuf_16bytes(%arg0: vector<16xi8>) -> i128 {
    %0 = llvm.mlir.poison : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<16xi8> to i128
    llvm.return %2 : i128
  }
  llvm.func @shuf_2bytes_widening(%arg0: vector<2xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, -1, -1] : vector<2xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }
}

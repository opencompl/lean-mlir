module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @narrow_shuffle_of_select(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @narrow_shuffle_of_select_overspecified_extend(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 0, 1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @narrow_shuffle_of_select_undefs(%arg0: vector<3xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<3xi1>
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.shufflevector %arg0, %0 [-1, 1, 2, -1] : vector<3xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xf32>
    %4 = llvm.shufflevector %3, %1 [0, 1, -1] : vector<4xf32> 
    llvm.return %4 : vector<3xf32>
  }
  llvm.func @use(vector<4xi8>)
  llvm.func @use_cmp(vector<4xi1>)
  llvm.func @narrow_shuffle_of_select_use1(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    llvm.call @use(%3) : (vector<4xi8>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @narrow_shuffle_of_select_use2(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    llvm.call @use_cmp(%2) : (vector<4xi1>) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @narrow_shuffle_of_select_mismatch_types1(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<4xi8> 
    llvm.return %4 : vector<3xi8>
  }
  llvm.func @narrow_shuffle_of_select_mismatch_types2(%arg0: vector<4xi1>, %arg1: vector<6xi8>, %arg2: vector<6xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.mlir.poison : vector<6xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3, -1, -1] : vector<4xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<6xi1>, vector<6xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<6xi8> 
    llvm.return %4 : vector<3xi8>
  }
  llvm.func @narrow_shuffle_of_select_consts(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.constant(dense<[-1, -2, -3, -4]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.poison : vector<4xi8>
    %4 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %5 = llvm.select %4, %1, %2 : vector<4xi1>, vector<4xi8>
    %6 = llvm.shufflevector %5, %3 [0, 1] : vector<4xi8> 
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @narrow_shuffle_of_select_with_widened_ops(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.poison : vector<2xi1>
    %2 = llvm.mlir.poison : vector<4xi8>
    %3 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1] : vector<2xi8> 
    %4 = llvm.shufflevector %arg2, %0 [0, 1, -1, -1] : vector<2xi8> 
    %5 = llvm.shufflevector %arg0, %1 [0, 1, -1, -1] : vector<2xi1> 
    %6 = llvm.select %5, %3, %4 : vector<4xi1>, vector<4xi8>
    %7 = llvm.shufflevector %6, %2 [0, 1] : vector<4xi8> 
    llvm.return %7 : vector<2xi8>
  }
}

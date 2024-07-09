module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shuffle_op0_freeze_poison(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @shuffle_op1_freeze_poison(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @shuffle_op0_freeze_poison_use(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @shuffle_op1_freeze_poison_use(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @shuffle_op0_freeze_undef(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @shuffle_op1_freeze_undef(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }
  llvm.func @shuffle_bc1(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.freeze %0 : vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<2xf64>
    %3 = llvm.shufflevector %arg0, %2 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %3 : vector<4xf64>
  }
  llvm.func @shuffle_bc2(%arg0: vector<4xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.freeze %0 : vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<2xf64>
    llvm.call @use(%2) : (vector<2xf64>) -> ()
    %3 = llvm.bitcast %2 : vector<2xf64> to vector<4xf32>
    %4 = llvm.shufflevector %arg0, %3 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<8xf32>
  }
  llvm.func @use(vector<2xf64>)
}

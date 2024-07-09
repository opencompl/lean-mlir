module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @reduce_add(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.add"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_or(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %0, %arg0 [7, 6, 5, 4] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.or"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_and(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 2, 1, 3] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.and"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_xor(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %0, %arg0 [5, 6, 7, 4] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.xor"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_umax(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 1, 3, 0] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.umax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_umin(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 3, 0, 1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.umin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_smax(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.smax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_smin(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 3, 1, 2] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.smin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_fmax(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmax(%1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }
  llvm.func @reduce_fmin(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [0, 3, 1, 2] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }
  llvm.func @reduce_fadd(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.shufflevector %arg1, %arg1 [0, 3, 1, 2] : vector<4xf32> 
    %1 = "llvm.intr.vector.reduce.fadd"(%arg0, %0) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<4xf32>) -> f32
    llvm.return %1 : f32
  }
  llvm.func @reduce_fmul(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.shufflevector %arg1, %1 [0, 3, 1, 2] : vector<4xf32> 
    %3 = "llvm.intr.vector.reduce.fmul"(%arg0, %2) <{fastmathFlags = #llvm.fastmath<reassoc>}> : (f32, vector<4xf32>) -> f32
    llvm.return %3 : f32
  }
  llvm.func @reduce_add_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg0 [0, 1, 2, 4] : vector<4xi32> 
    %1 = "llvm.intr.vector.reduce.add"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }
  llvm.func @reduce_or_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [3, 2, 1, 4] : vector<4xi32> 
    %3 = "llvm.intr.vector.reduce.or"(%2) : (vector<4xi32>) -> i32
    llvm.return %3 : i32
  }
  llvm.func @reduce_and_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 2, 1, 0] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.and"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_xor_failed(%arg0: vector<4xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 2, 3, -1] : vector<4xi32> 
    %2 = "llvm.intr.vector.reduce.xor"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_umax_failed(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg1 [2, 1, 3, 0] : vector<2xi32> 
    %1 = "llvm.intr.vector.reduce.umax"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }
  llvm.func @reduce_umin_failed(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 3, 0, 1] : vector<2xi32> 
    %2 = "llvm.intr.vector.reduce.umin"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_smax_failed(%arg0: vector<8xi32>) -> i32 {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 0, 3, 1] : vector<8xi32> 
    %2 = "llvm.intr.vector.reduce.smax"(%1) : (vector<4xi32>) -> i32
    llvm.return %2 : i32
  }
  llvm.func @reduce_smin_failed(%arg0: vector<8xi32>) -> i32 {
    %0 = llvm.shufflevector %arg0, %arg0 [0, 3, 1, 2] : vector<8xi32> 
    %1 = "llvm.intr.vector.reduce.smin"(%0) : (vector<4xi32>) -> i32
    llvm.return %1 : i32
  }
  llvm.func @reduce_fmax_failed(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [2, 2, 3, 1] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }
  llvm.func @reduce_fmin_failed(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [-1, 3, 1, 2] : vector<4xf32> 
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf32>) -> f32
    llvm.return %2 : f32
  }
  llvm.func @reduce_fadd_failed(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 3, 1, 2] : vector<4xf32> 
    %2 = "llvm.intr.vector.reduce.fadd"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    llvm.return %2 : f32
  }
  llvm.func @reduce_fmul_failed(%arg0: f32, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 3, 1, 2] : vector<2xf32> 
    %2 = "llvm.intr.vector.reduce.fmul"(%arg0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    llvm.return %2 : f32
  }
}

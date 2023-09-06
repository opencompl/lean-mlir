module  {
  llvm.func internal @func_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    llvm.return %arg0 : vector<2xi32>
  }
  llvm.func internal @func_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    llvm.return %arg0 : vector<2xf32>
  }
  llvm.func internal @func_v4f32(%arg0: vector<4xf32>) -> vector<4xf32> {
    llvm.return %arg0 : vector<4xf32>
  }
  llvm.func internal @func_i32(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }
  llvm.func internal @func_i64(%arg0: i64) -> i64 {
    llvm.return %arg0 : i64
  }
  llvm.func internal @func_v2i64(%arg0: vector<2xi64>) -> vector<2xi64> {
    llvm.return %arg0 : vector<2xi64>
  }
  llvm.func internal @func_v2i32p(%arg0: !llvm.vec<2 x ptr<i32>>) -> !llvm.vec<2 x ptr<i32>> {
    llvm.return %arg0 : !llvm.vec<2 x ptr<i32>>
  }
  llvm.func @bitcast_scalar(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>) {
    %0 = llvm.mlir.addressof @func_i32 : !llvm.ptr<func<i32 (i32)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i32 (i32)>> to !llvm.ptr<func<f32 (f32)>>
    %2 = llvm.load %arg0 : !llvm.ptr<f32>
    %3 = llvm.call %1(%2) : (f32) -> f32
    llvm.store %3, %arg1 : !llvm.ptr<f32>
    llvm.return
  }
  llvm.func @bitcast_vector(%arg0: !llvm.ptr<vector<2xf32>>, %arg1: !llvm.ptr<vector<2xf32>>) {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr<func<vector<2xi32> (vector<2xi32>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vector<2xi32> (vector<2xi32>)>> to !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vector<2xf32>>
    %3 = llvm.call %1(%2) : (vector<2xf32>) -> vector<2xf32>
    llvm.store %3, %arg1 : !llvm.ptr<vector<2xf32>>
    llvm.return
  }
  llvm.func @bitcast_vector_scalar_same_size(%arg0: !llvm.ptr<vector<2xf32>>, %arg1: !llvm.ptr<vector<2xf32>>) {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr<func<i64 (i64)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i64 (i64)>> to !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vector<2xf32>>
    %3 = llvm.call %1(%2) : (vector<2xf32>) -> vector<2xf32>
    llvm.store %3, %arg1 : !llvm.ptr<vector<2xf32>>
    llvm.return
  }
  llvm.func @bitcast_scalar_vector_same_size(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.addressof @func_v2f32 : !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>> to !llvm.ptr<func<i64 (i64)>>
    %2 = llvm.load %arg0 : !llvm.ptr<i64>
    %3 = llvm.call %1(%2) : (i64) -> i64
    llvm.store %3, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @bitcast_vector_ptrs_same_size(%arg0: !llvm.ptr<vec<2 x ptr<i64>>>, %arg1: !llvm.ptr<vec<2 x ptr<i64>>>) {
    %0 = llvm.mlir.addressof @func_v2i32p : !llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>> to !llvm.ptr<func<vec<2 x ptr<i64>> (vec<2 x ptr<i64>>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vec<2 x ptr<i64>>>
    %3 = llvm.call %1(%2) : (!llvm.vec<2 x ptr<i64>>) -> !llvm.vec<2 x ptr<i64>>
    llvm.store %3, %arg1 : !llvm.ptr<vec<2 x ptr<i64>>>
    llvm.return
  }
  llvm.func @bitcast_mismatch_scalar_size(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>) {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr<func<i64 (i64)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i64 (i64)>> to !llvm.ptr<func<f32 (f32)>>
    %2 = llvm.load %arg0 : !llvm.ptr<f32>
    %3 = llvm.call %1(%2) : (f32) -> f32
    llvm.store %3, %arg1 : !llvm.ptr<f32>
    llvm.return
  }
  llvm.func @bitcast_mismatch_vector_element_and_bit_size(%arg0: !llvm.ptr<vector<2xf32>>, %arg1: !llvm.ptr<vector<2xf32>>) {
    %0 = llvm.mlir.addressof @func_v2i64 : !llvm.ptr<func<vector<2xi64> (vector<2xi64>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vector<2xi64> (vector<2xi64>)>> to !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vector<2xf32>>
    %3 = llvm.call %1(%2) : (vector<2xf32>) -> vector<2xf32>
    llvm.store %3, %arg1 : !llvm.ptr<vector<2xf32>>
    llvm.return
  }
  llvm.func @bitcast_vector_mismatched_number_elements(%arg0: !llvm.ptr<vector<4xf32>>, %arg1: !llvm.ptr<vector<4xf32>>) {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr<func<vector<2xi32> (vector<2xi32>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vector<2xi32> (vector<2xi32>)>> to !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vector<4xf32>>
    %3 = llvm.call %1(%2) : (vector<4xf32>) -> vector<4xf32>
    llvm.store %3, %arg1 : !llvm.ptr<vector<4xf32>>
    llvm.return
  }
  llvm.func @bitcast_vector_scalar_mismatched_bit_size(%arg0: !llvm.ptr<vector<4xf32>>, %arg1: !llvm.ptr<vector<4xf32>>) {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr<func<i64 (i64)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i64 (i64)>> to !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vector<4xf32>>
    %3 = llvm.call %1(%2) : (vector<4xf32>) -> vector<4xf32>
    llvm.store %3, %arg1 : !llvm.ptr<vector<4xf32>>
    llvm.return
  }
  llvm.func @bitcast_vector_ptrs_scalar_mismatched_bit_size(%arg0: !llvm.ptr<vec<4 x ptr<i32>>>, %arg1: !llvm.ptr<vec<4 x ptr<i32>>>) {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr<func<i64 (i64)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i64 (i64)>> to !llvm.ptr<func<vec<4 x ptr<i32>> (vec<4 x ptr<i32>>)>>
    %2 = llvm.load %arg0 : !llvm.ptr<vec<4 x ptr<i32>>>
    %3 = llvm.call %1(%2) : (!llvm.vec<4 x ptr<i32>>) -> !llvm.vec<4 x ptr<i32>>
    llvm.store %3, %arg1 : !llvm.ptr<vec<4 x ptr<i32>>>
    llvm.return
  }
  llvm.func @bitcast_scalar_vector_ptrs_same_size(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.addressof @func_v2i32p : !llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>> to !llvm.ptr<func<i64 (i64)>>
    %2 = llvm.load %arg0 : !llvm.ptr<i64>
    %3 = llvm.call %1(%2) : (i64) -> i64
    llvm.store %3, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @bitcast_scalar_vector_mismatched_bit_size(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.addressof @func_v4f32 : !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>> to !llvm.ptr<func<i64 (i64)>>
    %2 = llvm.load %arg0 : !llvm.ptr<i64>
    %3 = llvm.call %1(%2) : (i64) -> i64
    llvm.store %3, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
}

module  {
  llvm.func @matching_scalar(%arg0: !llvm.ptr<vector<4xf32>>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
  llvm.func @nonmatching_scalar(%arg0: !llvm.ptr<vector<4xf32>>) -> i32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<i32>
    %1 = llvm.load %0 : !llvm.ptr<i32>
    llvm.return %1 : i32
  }
  llvm.func @larger_scalar(%arg0: !llvm.ptr<vector<4xf32>>) -> i64 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<i64>
    %1 = llvm.load %0 : !llvm.ptr<i64>
    llvm.return %1 : i64
  }
  llvm.func @smaller_scalar(%arg0: !llvm.ptr<vector<4xf32>>) -> i8 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<i8>
    %1 = llvm.load %0 : !llvm.ptr<i8>
    llvm.return %1 : i8
  }
  llvm.func @smaller_scalar_less_aligned(%arg0: !llvm.ptr<vector<4xf32>>) -> i8 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<i8>
    %1 = llvm.load %0 : !llvm.ptr<i8>
    llvm.return %1 : i8
  }
  llvm.func @matching_scalar_small_deref(%arg0: !llvm.ptr<vector<4xf32>>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
  llvm.func @matching_scalar_smallest_deref(%arg0: !llvm.ptr<vector<4xf32>>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
  llvm.func @matching_scalar_smallest_deref_or_null(%arg0: !llvm.ptr<vector<4xf32>>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
  llvm.func @matching_scalar_smallest_deref_addrspace(%arg0: !llvm.ptr<vector<4xf32>, 4>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>, 4> to !llvm.ptr<f32, 4>
    %1 = llvm.load %0 : !llvm.ptr<f32, 4>
    llvm.return %1 : f32
  }
  llvm.func @matching_scalar_smallest_deref_or_null_addrspace(%arg0: !llvm.ptr<vector<4xf32>, 4>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>, 4> to !llvm.ptr<f32, 4>
    %1 = llvm.load %0 : !llvm.ptr<f32, 4>
    llvm.return %1 : f32
  }
  llvm.func @matching_scalar_volatile(%arg0: !llvm.ptr<vector<4xf32>>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<vector<4xf32>> to !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
  llvm.func @nonvector(%arg0: !llvm.ptr<f64>) -> f32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<f64> to !llvm.ptr<f32>
    %1 = llvm.load %0 : !llvm.ptr<f32>
    llvm.return %1 : f32
  }
}

module  {
  llvm.func @use_f32(f32)
  llvm.func @llvm.vector.reduce.add.v4i32(vector<4xi32>) -> i32
  llvm.func @llvm.vector.reduce.add.v8i32(vector<8xi32>) -> i32
  llvm.func @use_i32(i32)
  llvm.func @diff_of_sums_v4f32(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>) -> f32 {
    %0 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg0, %arg1) : (f32, vector<4xf32>) -> f32
    %1 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg2, %arg3) : (f32, vector<4xf32>) -> f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @diff_of_sums_v4f32_fmf(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>) -> f32 {
    %0 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg0, %arg1) : (f32, vector<4xf32>) -> f32
    %1 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg2, %arg3) : (f32, vector<4xf32>) -> f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @diff_of_sums_extra_use1(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>) -> f32 {
    %0 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg0, %arg1) : (f32, vector<4xf32>) -> f32
    llvm.call @use_f32(%0) : (f32) -> ()
    %1 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg2, %arg3) : (f32, vector<4xf32>) -> f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @diff_of_sums_extra_use2(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<4xf32>) -> f32 {
    %0 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg0, %arg1) : (f32, vector<4xf32>) -> f32
    %1 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg2, %arg3) : (f32, vector<4xf32>) -> f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @diff_of_sums_type_mismatch(%arg0: f32, %arg1: vector<4xf32>, %arg2: f32, %arg3: vector<8xf32>) -> f32 {
    %0 = llvm.call @llvm.vector.reduce.fadd.v4f32(%arg0, %arg1) : (f32, vector<4xf32>) -> f32
    %1 = llvm.call @llvm.vector.reduce.fadd.v8f32(%arg2, %arg3) : (f32, vector<8xf32>) -> f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @diff_of_sums_v4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> i32 {
    %0 = llvm.call @llvm.vector.reduce.add.v4i32(%arg0) : (vector<4xi32>) -> i32
    %1 = llvm.call @llvm.vector.reduce.add.v4i32(%arg1) : (vector<4xi32>) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @diff_of_sums_v4i32_extra_use1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> i32 {
    %0 = llvm.call @llvm.vector.reduce.add.v4i32(%arg0) : (vector<4xi32>) -> i32
    llvm.call @use_i32(%0) : (i32) -> ()
    %1 = llvm.call @llvm.vector.reduce.add.v4i32(%arg1) : (vector<4xi32>) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @diff_of_sums_v4i32_extra_use2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> i32 {
    %0 = llvm.call @llvm.vector.reduce.add.v4i32(%arg0) : (vector<4xi32>) -> i32
    %1 = llvm.call @llvm.vector.reduce.add.v4i32(%arg1) : (vector<4xi32>) -> i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @diff_of_sums_type_mismatch2(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> i32 {
    %0 = llvm.call @llvm.vector.reduce.add.v8i32(%arg0) : (vector<8xi32>) -> i32
    %1 = llvm.call @llvm.vector.reduce.add.v4i32(%arg1) : (vector<4xi32>) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @llvm.vector.reduce.fadd.v4f32(f32, vector<4xf32>) -> f32
  llvm.func @llvm.vector.reduce.fadd.v8f32(f32, vector<8xf32>) -> f32
}

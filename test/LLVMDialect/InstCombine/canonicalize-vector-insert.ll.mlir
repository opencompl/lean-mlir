module  {
  llvm.func @llvm.vector.insert.v8i32.v2i32(vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
  llvm.func @llvm.vector.insert.v8i32.v3i32(vector<8xi32>, vector<3xi32>, i64) -> vector<8xi32>
  llvm.func @llvm.vector.insert.v8i32.v4i32(vector<8xi32>, vector<4xi32>, i64) -> vector<8xi32>
  llvm.func @llvm.vector.insert.v8i32.v8i32(vector<8xi32>, vector<8xi32>, i64) -> vector<8xi32>
  llvm.func @llvm.vector.insert.nxv4i32.v4i32(!llvm.vec<? x 4 x i32>, vector<4xi32>, i64) -> !llvm.vec<? x 4 x i32>
  llvm.func @trivial_nop(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v8i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<8xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_a(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v2i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_b(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v2i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_c(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v2i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_d(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v2i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<2xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_e(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v4i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<4xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_f(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v4i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<4xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_g(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v3i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<3xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_insertion_h(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.v8i32.v3i32(%arg0, %arg1, %0) : (vector<8xi32>, vector<3xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @scalable_insert(%arg0: !llvm.vec<? x 4 x i32>, %arg1: vector<4xi32>) -> !llvm.vec<? x 4 x i32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.insert.nxv4i32.v4i32(%arg0, %arg1, %0) : (!llvm.vec<? x 4 x i32>, vector<4xi32>, i64) -> !llvm.vec<? x 4 x i32>
    llvm.return %1 : !llvm.vec<? x 4 x i32>
  }
}

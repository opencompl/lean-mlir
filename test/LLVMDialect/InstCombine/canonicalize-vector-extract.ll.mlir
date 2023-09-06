module  {
  llvm.func @llvm.vector.extract.v10i32.v8i32(vector<8xi32>, i64) -> vector<10xi32>
  llvm.func @llvm.vector.extract.v2i32.v4i32(vector<8xi32>, i64) -> vector<2xi32>
  llvm.func @llvm.vector.extract.v3i32.v8i32(vector<8xi32>, i64) -> vector<3xi32>
  llvm.func @llvm.vector.extract.v4i32.nxv4i32(!llvm.vec<? x 4 x i32>, i64) -> vector<4xi32>
  llvm.func @llvm.vector.extract.v4i32.v8i32(vector<8xi32>, i64) -> vector<4xi32>
  llvm.func @llvm.vector.extract.v8i32.v8i32(vector<8xi32>, i64) -> vector<8xi32>
  llvm.func @trivial_nop(%arg0: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v8i32.v8i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<8xi32>
    llvm.return %1 : vector<8xi32>
  }
  llvm.func @valid_extraction_a(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v2i32.v4i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @valid_extraction_b(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v2i32.v4i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @valid_extraction_c(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v2i32.v4i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @valid_extraction_d(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v2i32.v4i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @valid_extraction_e(%arg0: vector<8xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v4i32.v8i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @valid_extraction_f(%arg0: vector<8xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v4i32.v8i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @valid_extraction_g(%arg0: vector<8xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v3i32.v8i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<3xi32>
    llvm.return %1 : vector<3xi32>
  }
  llvm.func @valid_extraction_h(%arg0: vector<8xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v3i32.v8i32(%arg0, %0) : (vector<8xi32>, i64) -> vector<3xi32>
    llvm.return %1 : vector<3xi32>
  }
  llvm.func @scalable_extract(%arg0: !llvm.vec<? x 4 x i32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @llvm.vector.extract.v4i32.nxv4i32(%arg0, %0) : (!llvm.vec<? x 4 x i32>, i64) -> vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
}

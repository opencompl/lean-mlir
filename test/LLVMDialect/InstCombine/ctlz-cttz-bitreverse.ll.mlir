module  {
  llvm.func @ctlz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @llvm.bitreverse.i32(%arg0) : (i32) -> i32
    %2 = llvm.call @llvm.ctlz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @ctlz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @llvm.bitreverse.v2i64(%arg0) : (vector<2xi64>) -> vector<2xi64>
    %2 = llvm.call @llvm.ctlz.v2i64(%1, %0) : (vector<2xi64>, i1) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @ctlz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @llvm.bitreverse.i32(%arg0) : (i32) -> i32
    %2 = llvm.call @llvm.ctlz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @llvm.bitreverse.i32(%arg0) : (i32) -> i32
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @llvm.bitreverse.v2i64(%arg0) : (vector<2xi64>) -> vector<2xi64>
    %2 = llvm.call @llvm.cttz.v2i64(%1, %0) : (vector<2xi64>, i1) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @cttz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @llvm.bitreverse.i32(%arg0) : (i32) -> i32
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @llvm.bitreverse.i32(i32) -> i32
  llvm.func @llvm.bitreverse.v2i64(vector<2xi64>) -> vector<2xi64>
  llvm.func @llvm.ctlz.i32(i32, i1) -> i32
  llvm.func @llvm.cttz.i32(i32, i1) -> i32
  llvm.func @llvm.ctlz.v2i64(vector<2xi64>, i1) -> vector<2xi64>
  llvm.func @llvm.cttz.v2i64(vector<2xi64>, i1) -> vector<2xi64>
}

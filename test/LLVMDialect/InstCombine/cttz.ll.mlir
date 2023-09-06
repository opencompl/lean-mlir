module  {
  llvm.func @llvm.cttz.i32(i32, i1) -> i32
  llvm.func @llvm.cttz.v2i64(vector<2xi64>, i1) -> vector<2xi64>
  llvm.func @use(i32)
  llvm.func @cttz_zext_zero_undef(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_zext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_zext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.zext %arg0 : i16 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_zext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.call @llvm.cttz.v2i64(%1, %0) : (vector<2xi64>, i1) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @cttz_zext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.call @llvm.cttz.v2i64(%1, %0) : (vector<2xi64>, i1) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @cttz_sext_zero_undef(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_sext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_sext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.call @llvm.cttz.i32(%1, %0) : (i32, i1) -> i32
    llvm.return %2 : i32
  }
  llvm.func @cttz_sext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.call @llvm.cttz.v2i64(%1, %0) : (vector<2xi64>, i1) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @cttz_sext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.call @llvm.cttz.v2i64(%1, %0) : (vector<2xi64>, i1) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
}

module  {
  llvm.func @float_load(%arg0: !llvm.ptr<i32>) -> f32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }
  llvm.func @i32_load(%arg0: !llvm.ptr<f32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<f32>
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @double_load(%arg0: !llvm.ptr<i64>) -> f64 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.bitcast %0 : i64 to f64
    llvm.return %1 : f64
  }
  llvm.func @i64_load(%arg0: !llvm.ptr<f64>) -> i64 {
    %0 = llvm.load %arg0 : !llvm.ptr<f64>
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }
  llvm.func @ptr_load(%arg0: !llvm.ptr<i64>) -> !llvm.ptr<i8> {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
}

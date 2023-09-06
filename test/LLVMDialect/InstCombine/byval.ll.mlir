module  {
  llvm.func @add_byval_callee(!llvm.ptr<f64>)
  llvm.func @add_byval_callee_2(!llvm.ptr<f64>)
  llvm.func @add_byval(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.addressof @add_byval_callee : !llvm.ptr<func<void (ptr<f64>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (ptr<f64>)>> to !llvm.ptr<func<void (ptr<i64>)>>
    llvm.call %1(%arg0) : (!llvm.ptr<i64>) -> ()
    llvm.return
  }
  llvm.func @add_byval_2(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.addressof @add_byval_callee_2 : !llvm.ptr<func<void (ptr<f64>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (ptr<f64>)>> to !llvm.ptr<func<void (ptr<i64>)>>
    llvm.call %1(%arg0) : (!llvm.ptr<i64>) -> ()
    llvm.return
  }
  llvm.func @vararg_byval(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<struct<"t2", (i8)>>
    llvm.call @vararg_callee(%0, %1) : (i8, !llvm.ptr<struct<"t2", (i8)>>) -> ()
    llvm.return
  }
  llvm.func @vararg_callee(i8, ...)
}

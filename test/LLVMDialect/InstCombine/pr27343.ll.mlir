module  {
  llvm.func @__isnan(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x f32 : (i32) -> !llvm.ptr<f32>
    llvm.store %arg0, %2 : !llvm.ptr<f32>
    %3 = llvm.load %2 : !llvm.ptr<f32>
    %4 = llvm.bitcast %3 : f32 to i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.icmp "ugt" %5, %0 : i32
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @icmp_shl7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4608 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.shl %arg0, %1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }
}

module  {
  llvm.func @llvm.init.trampoline(!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>)
  llvm.func @llvm.adjust.trampoline(!llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @f(!llvm.ptr<i8>, i32) -> i32
  llvm.func @test0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    %1 = llvm.mlir.addressof @f : !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = llvm.bitcast %1 : !llvm.ptr<func<i32 (ptr<i8>, i32)>> to !llvm.ptr<i8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.array<10 x i8> : (i32) -> !llvm.ptr<array<10 x i8>>
    %6 = llvm.getelementptr %5[%3, %3] : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.init.trampoline(%6, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %7 = llvm.call @llvm.adjust.trampoline(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = llvm.bitcast %7 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %9 = llvm.call %8(%arg0) : (i32) -> i32
    llvm.return %9 : i32
  }
  llvm.func @test1(%arg0: i32, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    %1 = llvm.mlir.addressof @f : !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = llvm.bitcast %1 : !llvm.ptr<func<i32 (ptr<i8>, i32)>> to !llvm.ptr<i8>
    llvm.call @llvm.init.trampoline(%arg1, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @llvm.adjust.trampoline(%arg1) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %4 = llvm.bitcast %3 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %5 = llvm.call %4(%arg0) : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.call @llvm.adjust.trampoline(%arg1) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %1 = llvm.bitcast %0 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %2 = llvm.call %1(%arg0) : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    %1 = llvm.mlir.addressof @f : !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = llvm.bitcast %1 : !llvm.ptr<func<i32 (ptr<i8>, i32)>> to !llvm.ptr<i8>
    llvm.call @llvm.init.trampoline(%arg1, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = llvm.call @llvm.adjust.trampoline(%arg1) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %4 = llvm.bitcast %3 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %5 = llvm.call %4(%arg0) : (i32) -> i32
    %6 = llvm.call @llvm.adjust.trampoline(%arg1) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %7 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %8 = llvm.call %7(%arg0) : (i32) -> i32
    llvm.return %8 : i32
  }
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    %1 = llvm.mlir.addressof @f : !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = llvm.bitcast %1 : !llvm.ptr<func<i32 (ptr<i8>, i32)>> to !llvm.ptr<i8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.array<10 x i8> : (i32) -> !llvm.ptr<array<10 x i8>>
    %6 = llvm.getelementptr %5[%3, %3] : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.init.trampoline(%6, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %7 = llvm.call @llvm.adjust.trampoline(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = llvm.bitcast %7 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %9 = llvm.call %8(%arg0) : (i32) -> i32
    %10 = llvm.call @llvm.adjust.trampoline(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %11 = llvm.bitcast %7 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %12 = llvm.call %11(%arg0) : (i32) -> i32
    %13 = llvm.call @llvm.adjust.trampoline(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %14 = llvm.bitcast %13 : !llvm.ptr<i8> to !llvm.ptr<func<i32 (i32)>>
    %15 = llvm.call %14(%arg0) : (i32) -> i32
    llvm.return %15 : i32
  }
}

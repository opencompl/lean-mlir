module  {
  llvm.func @llvm.lifetime.start.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @llvm.lifetime.end.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @unknown()
  llvm.func @f(!llvm.ptr<i8>)
  llvm.func @f2(!llvm.ptr<i8>, !llvm.ptr<i8>)
  llvm.func @f3(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
  llvm.func @test_dead() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_lifetime() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.bitcast %2 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%0, %3) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @f(%3) : (!llvm.ptr<i8>) -> ()
    llvm.call @llvm.lifetime.end.p0i8(%0, %3) : (i64, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_lifetime2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.bitcast %2 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%0, %3) : (i64, !llvm.ptr<i8>) -> ()
    llvm.call @unknown() : () -> ()
    llvm.call @f(%3) : (!llvm.ptr<i8>) -> ()
    llvm.call @unknown() : () -> ()
    llvm.call @llvm.lifetime.end.p0i8(%0, %3) : (i64, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_dead_readwrite() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_neg_read_after() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f(%2) : (!llvm.ptr<i8>) -> ()
    %3 = llvm.load %1 : !llvm.ptr<i32>
    llvm.return %3 : i32
  }
  llvm.func @test_neg_infinite_loop() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_neg_throw() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_neg_extra_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_neg_unmodeled_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %4 = llvm.bitcast %2 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f2(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_neg_captured_by_call() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.alloca %0 x !llvm.ptr<i8> : (i32) -> !llvm.ptr<ptr<i8>>
    %3 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %4 = llvm.bitcast %2 : !llvm.ptr<ptr<i8>> to !llvm.ptr<i8>
    llvm.call @f2(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %5 = llvm.load %2 : !llvm.ptr<ptr<i8>>
    %6 = llvm.bitcast %5 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %7 = llvm.load %6 : !llvm.ptr<i32>
    llvm.return %7 : i32
  }
  llvm.func @test_neg_captured_before() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.alloca %0 x !llvm.ptr<i8> : (i32) -> !llvm.ptr<ptr<i8>>
    %3 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %4 = llvm.bitcast %2 : !llvm.ptr<ptr<i8>> to !llvm.ptr<i8>
    llvm.store %3, %2 : !llvm.ptr<ptr<i8>>
    llvm.call @f(%3) : (!llvm.ptr<i8>) -> ()
    %5 = llvm.load %2 : !llvm.ptr<ptr<i8>>
    %6 = llvm.bitcast %5 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %7 = llvm.load %6 : !llvm.ptr<i32>
    llvm.return %7 : i32
  }
  llvm.func @test_unreleated_read() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %4 = llvm.bitcast %2 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f2(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @test_unrelated_capture() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %4 = llvm.bitcast %2 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %5 = llvm.call @f3(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @test_neg_unrelated_capture_used_via_return() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %3 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %4 = llvm.bitcast %2 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %5 = llvm.call @f3(%3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
    %6 = llvm.load %5 : !llvm.ptr<i8>
    llvm.return %6 : i8
  }
  llvm.func @test_self_read() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @f2(%2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @removable_readnone()
  llvm.func @removable_ro()
  llvm.func @test_readnone() {
    llvm.call @removable_readnone() : () -> ()
    llvm.return
  }
  llvm.func @test_readnone_with_deopt() {
    llvm.call @removable_readnone() : () -> ()
    llvm.return
  }
  llvm.func @test_readonly() {
    llvm.call @removable_ro() : () -> ()
    llvm.return
  }
  llvm.func @test_readonly_with_deopt() {
    llvm.call @removable_ro() : () -> ()
    llvm.return
  }
}

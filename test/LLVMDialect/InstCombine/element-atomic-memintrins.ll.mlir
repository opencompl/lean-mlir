module  {
  llvm.mlir.global external constant @gconst("0123456789012345678901234567890\00")
  llvm.func @test_memset_zero_length(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i8) : i8
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %2, %1, %0) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memset_to_store(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i8) : i8
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %4, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %3, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %2, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %1, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %0, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memset_to_store_2(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i8) : i8
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %4, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %3, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %2, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %1, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %0, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memset_to_store_4(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i8) : i8
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %4, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %3, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %2, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %1, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %0, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memset_to_store_8(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i8) : i8
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %4, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %3, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %2, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %1, %1) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %0, %1) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memset_to_store_16(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i8) : i8
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %4, %4) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %3, %3) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %2, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %1, %1) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %5, %0, %0) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.return
  }
  llvm.func @llvm.memset.element.unordered.atomic.p0i8.i32(!llvm.ptr<i8>, i8, i32, i32)
  llvm.func @test_memmove_to_memcpy(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @gconst : !llvm.ptr<array<32 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<32 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_zero_length(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_removed(%arg0: !llvm.ptr<i8>, %arg1: i32) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_loadstore(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_loadstore_2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_loadstore_4(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_loadstore_8(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memmove_loadstore_16(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32)
  llvm.func @test_memcpy_zero_length(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %5, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memcpy_removed(%arg0: !llvm.ptr<i8>, %arg1: i32) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memcpy_loadstore(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memcpy_loadstore_2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memcpy_loadstore_4(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memcpy_loadstore_8(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_memcpy_loadstore_16(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %4, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %0, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
  llvm.func @test_undefined(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i1) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    llvm.cond_br %arg2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %3, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memmove.element.unordered.atomic.p0i8.p0i8.i32(%arg0, %arg1, %1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %0, %3, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.call @llvm.memset.element.unordered.atomic.p0i8.i32(%arg0, %0, %1, %2) : (!llvm.ptr<i8>, i8, i32, i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
  llvm.func @llvm.memcpy.element.unordered.atomic.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32)
}

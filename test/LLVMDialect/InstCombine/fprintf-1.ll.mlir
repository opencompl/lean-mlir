module  {
  llvm.mlir.global external constant @hello_world("hello world\0A\00")
  llvm.mlir.global external constant @percent_c("%c\00")
  llvm.mlir.global external constant @percent_d("%d\00")
  llvm.mlir.global external constant @percent_f("%f\00")
  llvm.mlir.global external constant @percent_s("%s\00")
  llvm.mlir.global external constant @percent_m("%m\00")
  llvm.func @fprintf(!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, ...) -> i32
  llvm.func @test_simplify1(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr<array<13 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    llvm.return
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.constant(104 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @percent_c : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @fprintf(%arg0, %3, %0) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, i8) -> i32
    llvm.return
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.addressof @hello_world : !llvm.ptr<array<13 x i8>>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @percent_s : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %0[%1, %1] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @fprintf(%arg0, %3, %4) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    llvm.return
  }
  llvm.func @test_simplify4(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.constant(187 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @percent_d : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @fprintf(%arg0, %3, %0) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, i32) -> i32
    llvm.return
  }
  llvm.func @test_simplify5(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr<array<13 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    llvm.return
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.constant(1.870000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @percent_f : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @fprintf(%arg0, %3, %0) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, f64) -> i32
    llvm.return
  }
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr<struct<"FILE", ()>>, %arg1: f64) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr<array<3 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2, %arg1) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, f64) -> i32
    llvm.return
  }
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr<struct<"FILE", ()>>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr<array<13 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_no_simplify4(%arg0: !llvm.ptr<struct<"FILE", ()>>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @percent_m : !llvm.ptr<array<3 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @fprintf(%arg0, %2) : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    llvm.return
  }
}

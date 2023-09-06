module  {
  llvm.mlir.global external constant @s1("\01\00")
  llvm.mlir.global external constant @s7f("\7F\00")
  llvm.mlir.global external constant @s80("\80\00")
  llvm.mlir.global external constant @sff("\FF\00")
  llvm.mlir.global external constant @pcnt_c("%c\00")
  llvm.mlir.global external constant @pcnt_s("%s\00")
  llvm.func @putchar(i16) -> i16
  llvm.func @puts(!llvm.ptr<i8>) -> i16
  llvm.func @printf(!llvm.ptr<i8>, ...) -> i16
  llvm.func @xform_printf(%arg0: i8, %arg1: i16) {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.addressof @sff : !llvm.ptr<array<2 x i8>>
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.addressof @s80 : !llvm.ptr<array<2 x i8>>
    %4 = llvm.mlir.constant(127 : i16) : i16
    %5 = llvm.mlir.addressof @s7f : !llvm.ptr<array<2 x i8>>
    %6 = llvm.mlir.constant(1 : i16) : i16
    %7 = llvm.mlir.addressof @s1 : !llvm.ptr<array<2 x i8>>
    %8 = llvm.mlir.addressof @pcnt_s : !llvm.ptr<array<3 x i8>>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.addressof @pcnt_c : !llvm.ptr<array<3 x i8>>
    %11 = llvm.getelementptr %10[%9, %9] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %12 = llvm.getelementptr %8[%9, %9] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %13 = llvm.getelementptr %7[%9, %9] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %14 = llvm.call @printf(%13) : (!llvm.ptr<i8>) -> i16
    %15 = llvm.call @printf(%11, %6) : (!llvm.ptr<i8>, i16) -> i16
    %16 = llvm.call @printf(%12, %13) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %17 = llvm.getelementptr %5[%9, %9] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %18 = llvm.call @printf(%17) : (!llvm.ptr<i8>) -> i16
    %19 = llvm.call @printf(%11, %4) : (!llvm.ptr<i8>, i16) -> i16
    %20 = llvm.call @printf(%12, %17) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %21 = llvm.getelementptr %3[%9, %9] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %22 = llvm.call @printf(%21) : (!llvm.ptr<i8>) -> i16
    %23 = llvm.call @printf(%11, %2) : (!llvm.ptr<i8>, i16) -> i16
    %24 = llvm.call @printf(%12, %21) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %25 = llvm.getelementptr %1[%9, %9] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %26 = llvm.call @printf(%25) : (!llvm.ptr<i8>) -> i16
    %27 = llvm.call @printf(%11, %0) : (!llvm.ptr<i8>, i16) -> i16
    %28 = llvm.call @printf(%12, %25) : (!llvm.ptr<i8>, !llvm.ptr<i8>) -> i16
    %29 = llvm.call @printf(%11, %arg0) : (!llvm.ptr<i8>, i8) -> i16
    %30 = llvm.call @printf(%11, %arg1) : (!llvm.ptr<i8>, i16) -> i16
    llvm.return
  }
}

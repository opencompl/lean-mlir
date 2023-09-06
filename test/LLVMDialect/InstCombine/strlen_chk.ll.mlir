module  {
  llvm.mlir.global external constant @hello("hello\00")
  llvm.mlir.global external constant @hello_no_nul("hello")
  llvm.func @__strlen_chk(!llvm.ptr<i8>, i32) -> i32
  llvm.func @unknown_str_known_object_size(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @known_str_known_object_size(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @__strlen_chk(%3, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @known_str_too_small_object_size(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @hello : !llvm.ptr<array<6 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @__strlen_chk(%3, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @known_str_no_nul(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @hello_no_nul : !llvm.ptr<array<5 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @__strlen_chk(%3, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @unknown_str_unknown_object_size(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @__strlen_chk(%arg0, %0) : (!llvm.ptr<i8>, i32) -> i32
    llvm.return %1 : i32
  }
}

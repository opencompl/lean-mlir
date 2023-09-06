module  {
  llvm.func @main2() -> i32
  llvm.func @ctime2(!llvm.ptr<i999>) -> !llvm.ptr<i7>
  llvm.func @ctime(%arg0: !llvm.ptr<i999>) -> !llvm.ptr<i7> {
    %0 = llvm.mlir.addressof @main2 : !llvm.ptr<func<i32 ()>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<i32 ()>> to !llvm.ptr<func<ptr<i7> ()>>
    %2 = llvm.call %1() : () -> !llvm.ptr<i7>
    llvm.return %2 : !llvm.ptr<i7>
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @ctime2 : !llvm.ptr<func<ptr<i7> (ptr<i999>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<ptr<i7> (ptr<i999>)>> to !llvm.ptr<func<i32 (ptr<i99>)>>
    %2 = llvm.mlir.null : !llvm.ptr<i99>
    %3 = llvm.call %1(%2) : (!llvm.ptr<i99>) -> i32
    llvm.return %3 : i32
  }
}

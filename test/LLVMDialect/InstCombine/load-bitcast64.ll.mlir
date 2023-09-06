module  {
  llvm.func @test1(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i64> {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %1 = llvm.load %0 : !llvm.ptr<i64>
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<i64>
    llvm.return %2 : !llvm.ptr<i64>
  }
  llvm.func @test2(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i32> {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %1 = llvm.load %0 : !llvm.ptr<i32>
    %2 = llvm.inttoptr %1 : i32 to !llvm.ptr<i32>
    llvm.return %2 : !llvm.ptr<i32>
  }
  llvm.func @test3(%arg0: !llvm.ptr<i8>) -> !llvm.ptr<i64> {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %1 = llvm.load %0 : !llvm.ptr<i32>
    %2 = llvm.inttoptr %1 : i32 to !llvm.ptr<i64>
    llvm.return %2 : !llvm.ptr<i64>
  }
  llvm.func @test4(%arg0: !llvm.ptr<i8>) -> i64 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<ptr<i64>>
    %1 = llvm.load %0 : !llvm.ptr<ptr<i64>>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i64> to i64
    llvm.return %2 : i64
  }
  llvm.func @test5(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<ptr<i32>>
    %1 = llvm.load %0 : !llvm.ptr<ptr<i32>>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i32> to i32
    llvm.return %2 : i32
  }
  llvm.func @test6(%arg0: !llvm.ptr<i8>) -> i64 {
    %0 = llvm.bitcast %arg0 : !llvm.ptr<i8> to !llvm.ptr<ptr<i32>>
    %1 = llvm.load %0 : !llvm.ptr<ptr<i32>>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i32> to i64
    llvm.return %2 : i64
  }
}

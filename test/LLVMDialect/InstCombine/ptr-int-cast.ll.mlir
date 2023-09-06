module  {
  llvm.func @test1(%arg0: !llvm.ptr<i32>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<i32> to i1
    llvm.return %0 : i1
  }
  llvm.func @test2(%arg0: i128) -> !llvm.ptr<i32> {
    %0 = llvm.inttoptr %arg0 : i128 to !llvm.ptr<i32>
    llvm.return %0 : !llvm.ptr<i32>
  }
  llvm.func @f0(%arg0: i32) -> i64 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr<i8>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<i8> to i64
    llvm.return %1 : i64
  }
  llvm.func @test4(%arg0: !llvm.vec<4 x ptr<i8>>) -> vector<4xi32> {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr<i8>> to vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }
  llvm.func @testvscale4(%arg0: !llvm.vec<? x 4 x ptr<i8>>) -> !llvm.vec<? x 4 x i32> {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<? x 4 x ptr<i8>> to !llvm.vec<? x 4 x i32>
    llvm.return %0 : !llvm.vec<? x 4 x i32>
  }
  llvm.func @test5(%arg0: !llvm.vec<4 x ptr<i8>>) -> vector<4xi128> {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr<i8>> to vector<4xi128>
    llvm.return %0 : vector<4xi128>
  }
  llvm.func @test6(%arg0: vector<4xi32>) -> !llvm.vec<4 x ptr<i8>> {
    %0 = llvm.inttoptr %arg0 : vector<4xi32> to !llvm.vec<4 x ptr<i8>>
    llvm.return %0 : !llvm.vec<4 x ptr<i8>>
  }
  llvm.func @test7(%arg0: vector<4xi128>) -> !llvm.vec<4 x ptr<i8>> {
    %0 = llvm.inttoptr %arg0 : vector<4xi128> to !llvm.vec<4 x ptr<i8>>
    llvm.return %0 : !llvm.vec<4 x ptr<i8>>
  }
}

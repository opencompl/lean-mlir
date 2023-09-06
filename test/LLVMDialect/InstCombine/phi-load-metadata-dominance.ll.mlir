module  {
  llvm.func @bar()
  llvm.func @baz()
  llvm.func @test_combine_metadata_dominance(%arg0: i1, %arg1: !llvm.ptr<ptr<i32>>, %arg2: !llvm.ptr<ptr<i32>>) -> !llvm.ptr<i32> {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    %0 = llvm.load %arg1 : !llvm.ptr<ptr<i32>>
    llvm.br ^bb3(%0 : !llvm.ptr<i32>)
  ^bb2:  // pred: ^bb0
    llvm.call @baz() : () -> ()
    %1 = llvm.load %arg2 : !llvm.ptr<ptr<i32>>
    llvm.br ^bb3(%1 : !llvm.ptr<i32>)
  ^bb3(%2: !llvm.ptr<i32>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.ptr<i32>
  }
}

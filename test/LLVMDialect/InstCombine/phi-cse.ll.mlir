module  {
  llvm.func @test0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    llvm.store %1, %arg4 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    llvm.store %1, %arg4 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @negative_test2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr<i32>, %arg5: !llvm.ptr<i32>) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 : !llvm.ptr<i32>
    llvm.store %1, %arg5 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @negative_test3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr<i32>, %arg5: !llvm.ptr<i32>) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 : !llvm.ptr<i32>
    llvm.store %1, %arg5 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @negative_test4(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    llvm.store %1, %arg4 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test5(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg4 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test6(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr<i32>, %arg4: !llvm.ptr<i32>) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test7(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i16>) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg2, %arg0, %arg0 : i16, i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg3, %arg1, %arg1 : i16, i32, i32)
  ^bb3(%0: i16, %1: i32, %2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg5 : !llvm.ptr<i32>
    llvm.store %2, %arg6 : !llvm.ptr<i32>
    llvm.store %0, %arg7 : !llvm.ptr<i16>
    llvm.return
  }
  llvm.func @test8(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i16>) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg2, %arg0 : i32, i16, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg3, %arg1 : i32, i16, i32)
  ^bb3(%0: i32, %1: i16, %2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 : !llvm.ptr<i32>
    llvm.store %2, %arg6 : !llvm.ptr<i32>
    llvm.store %1, %arg7 : !llvm.ptr<i16>
    llvm.return
  }
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr<i32>, %arg6: !llvm.ptr<i32>, %arg7: !llvm.ptr<i16>) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0, %arg2 : i32, i32, i16)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1, %arg3 : i32, i32, i16)
  ^bb3(%0: i32, %1: i32, %2: i16):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 : !llvm.ptr<i32>
    llvm.store %1, %arg6 : !llvm.ptr<i32>
    llvm.store %2, %arg7 : !llvm.ptr<i16>
    llvm.return
  }
}

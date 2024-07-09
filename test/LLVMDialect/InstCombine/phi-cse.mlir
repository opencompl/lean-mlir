module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @negative_test2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr, %arg5: !llvm.ptr) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @negative_test3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr, %arg5: !llvm.ptr) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @negative_test4(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test5(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test6(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test7(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg2, %arg0, %arg0 : i16, i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg3, %arg1, %arg1 : i16, i32, i32)
  ^bb3(%0: i16, %1: i32, %2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %2, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.return
  }
  llvm.func @test8(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg2, %arg0 : i32, i16, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg3, %arg1 : i32, i16, i32)
  ^bb3(%0: i32, %1: i16, %2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %2, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.return
  }
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0, %arg2 : i32, i32, i16)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1, %arg3 : i32, i32, i16)
  ^bb3(%0: i32, %1: i32, %2: i16):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %2, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.return
  }
}

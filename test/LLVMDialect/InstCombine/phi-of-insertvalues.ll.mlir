module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @usei32i32agg(!llvm.struct<(i32, i32)>)
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%1) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%1) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg3, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb3(%2: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>
  }
  llvm.func @test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb3(%2: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>
  }
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg3, ^bb4(%0 : !llvm.struct<(i32, i32)>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : !llvm.struct<(i32, i32)>)
  ^bb4(%2: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.cond_br %arg3, ^bb4(%0 : !llvm.struct<(i32, i32)>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : !llvm.struct<(i32, i32)>)
  ^bb4(%2: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
}

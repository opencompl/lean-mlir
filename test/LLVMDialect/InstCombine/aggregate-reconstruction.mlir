module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo()
  llvm.func @bar()
  llvm.func @baz()
  llvm.func @usei32(i32)
  llvm.func @usei32i32agg(!llvm.struct<(i32, i32)>)
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test1(%arg0: !llvm.array<2 x i32>) -> !llvm.array<2 x i32> {
    %0 = llvm.mlir.undef : !llvm.array<2 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<2 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<2 x i32> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.array<2 x i32> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.array<2 x i32> 
    llvm.return %4 : !llvm.array<2 x i32>
  }
  llvm.func @test2(%arg0: !llvm.array<3 x i32>) -> !llvm.array<3 x i32> {
    %0 = llvm.mlir.undef : !llvm.array<3 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<3 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<3 x i32> 
    %3 = llvm.extractvalue %arg0[2] : !llvm.array<3 x i32> 
    %4 = llvm.insertvalue %1, %0[0] : !llvm.array<3 x i32> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<3 x i32> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x i32> 
    llvm.return %6 : !llvm.array<3 x i32>
  }
  llvm.func @test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<(i32, i32)>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(struct<(i32, i32)>)>
    %1 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>)> 
    %2 = llvm.extractvalue %arg0[0, 1] : !llvm.struct<(struct<(i32, i32)>)> 
    %3 = llvm.insertvalue %1, %0[0, 0] : !llvm.struct<(struct<(i32, i32)>)> 
    %4 = llvm.insertvalue %2, %3[0, 1] : !llvm.struct<(struct<(i32, i32)>)> 
    llvm.return %4 : !llvm.struct<(struct<(i32, i32)>)>
  }
  llvm.func @test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<(i32)>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32)>)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, struct<(i32)>)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, struct<(i32)>)> 
    llvm.return %4 : !llvm.struct<(i32, struct<(i32)>)>
  }
  llvm.func @negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %arg1, %2[1] : !llvm.struct<(i32, i32)> 
    llvm.return %3 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %0, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %2[1] : !llvm.struct<(i32, i32)> 
    llvm.return %3 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%2) : (i32) -> ()
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%3) : (!llvm.struct<(i32, i32)>) -> ()
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(i32, i32)> 
    llvm.return %5 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %2 = llvm.extractvalue %arg0[1, 0] : !llvm.struct<(i32, struct<(i32)>)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }
  llvm.func @test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb2(%1: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.insertvalue %3, %4[1] : !llvm.struct<(i32, i32)> 
    llvm.return %5 : !llvm.struct<(i32, i32)>
  }
  llvm.func @poison_base(%arg0: !llvm.array<3 x i32>) -> !llvm.array<3 x i32> {
    %0 = llvm.mlir.poison : !llvm.array<3 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<3 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<3 x i32> 
    %3 = llvm.extractvalue %arg0[2] : !llvm.array<3 x i32> 
    %4 = llvm.insertvalue %1, %0[0] : !llvm.array<3 x i32> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<3 x i32> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x i32> 
    llvm.return %6 : !llvm.array<3 x i32>
  }
}

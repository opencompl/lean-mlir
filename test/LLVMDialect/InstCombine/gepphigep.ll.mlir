module  {
  llvm.mlir.global external constant @_ZTIi() : !llvm.ptr<i8>
  llvm.mlir.global external constant @".str.4"() : !llvm.array<100 x i8>
  llvm.func @test1(%arg0: !llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, %arg1: i1, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr %arg0[%2, %1] : (!llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, i64, i32) -> !llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>
    %4 = llvm.load %3 : !llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.getelementptr %4[%arg2] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %6 = llvm.getelementptr %5[%2, %1] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    llvm.store %1, %6 : !llvm.ptr<i32>
    llvm.br ^bb3(%5 : !llvm.ptr<struct<"struct2", (i32, i32)>>)
  ^bb2:  // pred: ^bb0
    %7 = llvm.getelementptr %4[%arg3] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %8 = llvm.getelementptr %7[%2, %1] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    llvm.store %1, %8 : !llvm.ptr<i32>
    llvm.br ^bb3(%7 : !llvm.ptr<struct<"struct2", (i32, i32)>>)
  ^bb3(%9: !llvm.ptr<struct<"struct2", (i32, i32)>>):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.getelementptr %9[%2, %0] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %11 = llvm.load %10 : !llvm.ptr<i32>
    llvm.return %11 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, %arg1: i1, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr %arg0[%2, %1] : (!llvm.ptr<struct<"struct1", (ptr<struct<"struct2", (i32, i32)>>, i32, i32, i32)>>, i64, i32) -> !llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>
    %4 = llvm.load %3 : !llvm.ptr<ptr<struct<"struct2", (i32, i32)>>>
    %5 = llvm.getelementptr %4[%arg2] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %6 = llvm.getelementptr %5[%2, %1] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    llvm.store %1, %6 : !llvm.ptr<i32>
    %7 = llvm.getelementptr %4[%arg3] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %8 = llvm.getelementptr %7[%2, %1] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    llvm.store %1, %8 : !llvm.ptr<i32>
    %9 = llvm.getelementptr %5[%2, %0] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %10 = llvm.load %9 : !llvm.ptr<i32>
    llvm.return %10 : i32
  }
  llvm.func @test3(%arg0: !llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, %arg1: i1, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i32 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.addressof @_ZTIi : !llvm.ptr<ptr<i8>>
    %1 = llvm.bitcast %0 : !llvm.ptr<ptr<i8>> to !llvm.ptr<i8>
    %2 = llvm.mlir.constant(11 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i64) -> !llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.getelementptr %6[%arg3, %4] : (!llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i64, i32) -> !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>
    %8 = llvm.getelementptr %7[%5, %3, %3] : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>, i64, i32, i32) -> !llvm.ptr<i32>
    llvm.store %3, %8 : !llvm.ptr<i32>
    llvm.br ^bb3(%7 : !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>)
  ^bb2:  // pred: ^bb0
    %9 = llvm.getelementptr %6[%arg4, %4] : (!llvm.ptr<struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>>, i64, i32) -> !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>
    %10 = llvm.getelementptr %9[%5, %3, %4] : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>, i64, i32, i32) -> !llvm.ptr<i32>
    llvm.store %3, %10 : !llvm.ptr<i32>
    llvm.br ^bb3(%9 : !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>)
  ^bb3(%11: !llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.invoke @foo1(%2) to ^bb4 unwind ^bb5 : (i32) -> i32
  ^bb4:  // pred: ^bb3
    llvm.return %3 : i32
  ^bb5:  // pred: ^bb3
    %13 = llvm.landingpad (catch %1 : !llvm.ptr<i8>) : !llvm.struct<(ptr<i8>, i32)>
    %14 = llvm.getelementptr %11[%arg5, %4] : (!llvm.ptr<struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>>, i64, i32) -> !llvm.ptr<struct<"struct2", (i32, i32)>>
    %15 = llvm.getelementptr %14[%5, %4] : (!llvm.ptr<struct<"struct2", (i32, i32)>>, i64, i32) -> !llvm.ptr<i32>
    %16 = llvm.load %15 : !llvm.ptr<i32>
    llvm.return %16 : i32
  }
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @foo1(i32) -> i32
  llvm.func @test4(%arg0: i32, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.getelementptr %arg1[%2] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    llvm.cond_br %4, ^bb1, ^bb4(%3 : !llvm.ptr<i8>)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3, %arg0 : !llvm.ptr<i8>, i32)
  ^bb2(%5: !llvm.ptr<i8>, %6: i32):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.lshr %6, %0  : i32
    %8 = llvm.getelementptr %5[%2] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %9 = llvm.icmp "ugt" %7, %1 : i32
    llvm.cond_br %9, ^bb2(%8, %7 : !llvm.ptr<i8>, i32), ^bb3(%8 : !llvm.ptr<i8>)
  ^bb3(%10: !llvm.ptr<i8>):  // pred: ^bb2
    llvm.br ^bb4(%10 : !llvm.ptr<i8>)
  ^bb4(%11: !llvm.ptr<i8>):  // 2 preds: ^bb0, ^bb3
    %12 = llvm.getelementptr %11[%2] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %12 : !llvm.ptr<i8>
  }
  llvm.func @test5(%arg0: !llvm.ptr<i16>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(2048 : i16) : i16
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(64 : i8) : i8
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @".str.4" : !llvm.ptr<array<100 x i8>>
    %6 = llvm.getelementptr %5[%4, %4] : (!llvm.ptr<array<100 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = llvm.mlir.constant(54 : i8) : i8
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.load %arg1 : !llvm.ptr<ptr<i8>>
    %10 = llvm.getelementptr %9[%8] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    %11 = llvm.load %10 : !llvm.ptr<i8>
    %12 = llvm.icmp "eq" %11, %7 : i8
    llvm.cond_br %12, ^bb2(%10 : !llvm.ptr<i8>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @g(%6) : (!llvm.ptr<i8>) -> ()
    llvm.br ^bb2(%10 : !llvm.ptr<i8>)
  ^bb2(%13: !llvm.ptr<i8>):  // 3 preds: ^bb0, ^bb1, ^bb3
    %14 = llvm.load %13 : !llvm.ptr<i8>
    %15 = llvm.and %14, %3  : i8
    %16 = llvm.icmp "eq" %15, %2 : i8
    llvm.cond_br %16, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %17 = llvm.getelementptr %13[%8] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.br ^bb2(%17 : !llvm.ptr<i8>)
  ^bb4:  // pred: ^bb2
    %18 = llvm.getelementptr %13[%8] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb4, ^bb5
    %19 = llvm.load %18 : !llvm.ptr<i8>
    %20 = llvm.zext %19 : i8 to i32
    %21 = llvm.getelementptr %arg0[%20] : (!llvm.ptr<i16>, i32) -> !llvm.ptr<i16>
    %22 = llvm.load %21 : !llvm.ptr<i16>
    %23 = llvm.and %22, %1  : i16
    %24 = llvm.icmp "eq" %23, %0 : i16
    llvm.cond_br %24, ^bb6, ^bb5
  ^bb6:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb6
  }
  llvm.func @g(!llvm.ptr<i8>)
}

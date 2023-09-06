module  {
  llvm.mlir.global external constant @Unknown() : i32
  llvm.func @store_of_undef(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.undef : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_of_poison(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.undef : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_into_undef(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.undef : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.store %1, %0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_into_null(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.null : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(124 : i32) : i32
    llvm.store %1, %0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<i32>
    %2 = llvm.add %1, %0  : i32
    llvm.store %2, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_at_gep_off_null_inbounds(%arg0: i64) {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<i32>
    %2 = llvm.getelementptr %1[%arg0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_at_gep_off_null_not_inbounds(%arg0: i64) {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<i32>
    %2 = llvm.getelementptr %1[%arg0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_at_gep_off_no_null_opt(%arg0: i64) {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<i32>
    %2 = llvm.getelementptr %1[%arg0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %0, %2 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(-987654321 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %3 : !llvm.ptr<i32>
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %3 : !llvm.ptr<i32>
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %4 = llvm.load %3 : !llvm.ptr<i32>
    llvm.return %4 : i32
  }
  llvm.func @test4(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-987654321 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i32 : (i32) -> !llvm.ptr<i32>
    llvm.store %1, %3 : !llvm.ptr<i32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %0, %3 : !llvm.ptr<i32>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.load %3 : !llvm.ptr<i32>
    llvm.return %4 : i32
  }
  llvm.func @test5(%arg0: i1, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(-987654321 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    llvm.store %1, %arg1 : !llvm.ptr<i32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %0, %arg1 : !llvm.ptr<i32>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
  llvm.func @test6(%arg0: i32, %arg1: !llvm.ptr<f32>, %arg2: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    llvm.store %3, %arg2 : !llvm.ptr<i32>
    llvm.br ^bb1(%2 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.load %arg2 : !llvm.ptr<i32>
    %6 = llvm.icmp "slt" %5, %arg0 : i32
    llvm.cond_br %6, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %7 = llvm.sext %5 : i32 to i64
    %8 = llvm.getelementptr %arg1[%7] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.store %1, %8 : !llvm.ptr<f32>
    %9 = llvm.load %arg2 : !llvm.ptr<i32>
    %10 = llvm.add %9, %0  : i32
    llvm.store %10, %arg2 : !llvm.ptr<i32>
    llvm.br ^bb1(%10 : i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @dse1(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @dse2(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @dse3(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @dse4(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @dse5(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back1(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back2(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back3(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back4(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back5(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back6(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @write_back7(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.store %0, %arg0 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @store_to_constant() {
    %0 = llvm.mlir.addressof @Unknown : !llvm.ptr<i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %1, %0 : !llvm.ptr<i32>
    llvm.return
  }
}

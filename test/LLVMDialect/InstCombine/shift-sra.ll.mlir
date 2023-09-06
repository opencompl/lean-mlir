module  {
  llvm.func @test1(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.ashr %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test3(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sext %arg0 : i1 to i64
    llvm.br ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb0
    %3 = llvm.ashr %arg1, %1  : i64
    llvm.br ^bb3(%3 : i64)
  ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.ashr %4, %0  : i64
    llvm.return %5 : i64
  }
  llvm.func @test4(%arg0: i1, %arg1: i64, %arg2: i1) -> i64 {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sext %arg0 : i1 to i64
    llvm.br ^bb3(%2 : i64)
  ^bb2:  // pred: ^bb0
    %3 = llvm.ashr %arg1, %1  : i64
    llvm.br ^bb3(%3 : i64)
  ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.shl %4, %0  : i64
    %6 = llvm.ashr %5, %0  : i64
    llvm.return %6 : i64
  }
  llvm.func @test5(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg2, ^bb2, ^bb4(%1 : i32)
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb4(%arg0 : i32), ^bb5
  ^bb4(%2: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  ^bb5:  // pred: ^bb3
    llvm.return %1 : i32
  }
  llvm.func @ashr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_overshift(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_ashr_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @ashr_overshift_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<17> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %1  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @hoist_ashr_ahead_of_sext_1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @hoist_ashr_ahead_of_sext_1_splat(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @hoist_ashr_ahead_of_sext_2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @hoist_ashr_ahead_of_sext_2_splat(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
}

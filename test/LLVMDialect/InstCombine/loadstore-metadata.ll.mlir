module  {
  llvm.func @test_load_cast_combine_tbaa(%arg0: !llvm.ptr<f32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<f32>
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_noalias(%arg0: !llvm.ptr<f32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<f32>
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_range(%arg0: !llvm.ptr<i32>) -> f32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_load_cast_combine_invariant(%arg0: !llvm.ptr<f32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<f32>
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_nontemporal(%arg0: !llvm.ptr<f32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<f32>
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_align(%arg0: !llvm.ptr<ptr<i32>>) -> !llvm.ptr<i8> {
    %0 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    %1 = llvm.bitcast %0 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @test_load_cast_combine_deref(%arg0: !llvm.ptr<ptr<i32>>) -> !llvm.ptr<i8> {
    %0 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    %1 = llvm.bitcast %0 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @test_load_cast_combine_deref_or_null(%arg0: !llvm.ptr<ptr<i32>>) -> !llvm.ptr<i8> {
    %0 = llvm.load %arg0 : !llvm.ptr<ptr<i32>>
    %1 = llvm.bitcast %0 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @test_load_cast_combine_loop(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<i32>, %arg2: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%1 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<f32>, i32) -> !llvm.ptr<f32>
    %4 = llvm.getelementptr %arg1[%2] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %5 = llvm.load %3 : !llvm.ptr<f32>
    %6 = llvm.bitcast %5 : f32 to i32
    llvm.store %6, %4 : !llvm.ptr<i32>
    %7 = llvm.add %2, %0  : i32
    %8 = llvm.icmp "slt" %7, %arg2 : i32
    llvm.cond_br %8, ^bb1(%7 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @test_load_cast_combine_nonnull(%arg0: !llvm.ptr<ptr<f32>>) {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.load %arg0 : !llvm.ptr<ptr<f32>>
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<ptr<f32>>, i32) -> !llvm.ptr<ptr<f32>>
    llvm.store %1, %2 : !llvm.ptr<ptr<f32>>
    llvm.return
  }
}

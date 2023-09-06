module  {
  llvm.func @foo(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr<i32>, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr<i8>, %arg8: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i64) : i64
    %4 = llvm.zext %arg1 : i32 to i64
    %5 = llvm.getelementptr %arg7[%4] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %6 = llvm.zext %arg2 : i32 to i64
    %7 = llvm.getelementptr %5[%6] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %8 = llvm.getelementptr %7[%3] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %9 = llvm.bitcast %8 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %10 = llvm.load %9 : !llvm.ptr<i32>
    %11 = llvm.icmp "eq" %10, %arg3 : i32
    llvm.cond_br %11, ^bb5(%2 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg6 : i32, i32)
  ^bb2(%12: i32, %13: i32):  // pred: ^bb4
    %14 = llvm.zext %13 : i32 to i64
    %15 = llvm.getelementptr %arg7[%14] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %16 = llvm.getelementptr %15[%6] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %17 = llvm.getelementptr %16[%3] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %18 = llvm.bitcast %17 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %19 = llvm.load %18 : !llvm.ptr<i32>
    %20 = llvm.icmp "eq" %19, %arg3 : i32
    llvm.cond_br %20, ^bb5(%2 : i32), ^bb3(%13, %12 : i32, i32)
  ^bb3(%21: i32, %22: i32):  // 2 preds: ^bb1, ^bb2
    %23 = llvm.and %21, %arg8  : i32
    %24 = llvm.zext %23 : i32 to i64
    %25 = llvm.getelementptr %arg4[%24] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %26 = llvm.load %25 : !llvm.ptr<i32>
    %27 = llvm.icmp "ugt" %26, %arg5 : i32
    llvm.cond_br %27, ^bb4, ^bb5(%1 : i32)
  ^bb4:  // pred: ^bb3
    %28 = llvm.add %22, %0  : i32
    %29 = llvm.icmp "eq" %28, %1 : i32
    llvm.cond_br %29, ^bb5(%1 : i32), ^bb2(%28, %26 : i32, i32)
  ^bb5(%30: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %30 : i32
  }
  llvm.func @blackhole(!llvm.vec<2 x ptr<i8>>)
  llvm.func @PR37005(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(80 : i64) : i64
    %1 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<21> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(6 : i64) : i64
    %6 = llvm.mlir.undef : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.getelementptr %arg1[%6] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %9 = llvm.bitcast %8 : !llvm.ptr<ptr<i8>> to !llvm.ptr<vec<2 x ptr<i8>>>
    %10 = llvm.getelementptr %9[%4, %4] : (!llvm.ptr<vec<2 x ptr<i8>>>, i64, i64) -> !llvm.ptr<ptr<i8>>
    %11 = llvm.getelementptr %10[%3] : (!llvm.ptr<ptr<i8>>, vector<2xi64>) -> !llvm.vec<2 x ptr<ptr<i8>>>
    %12 = llvm.ptrtoint %11 : !llvm.vec<2 x ptr<ptr<i8>>> to vector<2xi64>
    %13 = llvm.lshr %12, %2  : vector<2xi64>
    %14 = llvm.shl %13, %1  : vector<2xi64>
    %15 = llvm.getelementptr %arg0[%14] : (!llvm.ptr<i8>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    %16 = llvm.getelementptr %15[%0] : (!llvm.vec<2 x ptr<i8>>, i64) -> !llvm.vec<2 x ptr<i8>>
    llvm.call @blackhole(%16) : (!llvm.vec<2 x ptr<i8>>) -> ()
    llvm.br ^bb1
  }
  llvm.func @PR37005_2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(dense<[80, 60]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(21 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.undef : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr %arg1[%4] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %6 = llvm.getelementptr %5[%3] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %7 = llvm.ptrtoint %6 : !llvm.ptr<ptr<i8>> to i64
    %8 = llvm.lshr %7, %2  : i64
    %9 = llvm.shl %8, %1  : i64
    %10 = llvm.getelementptr %arg0[%9] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr<i8>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    llvm.call @blackhole(%11) : (!llvm.vec<2 x ptr<i8>>) -> ()
    llvm.br ^bb1
  }
  llvm.func @PR37005_3(%arg0: !llvm.vec<2 x ptr<i8>>, %arg1: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(80 : i64) : i64
    %1 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<21> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(6 : i64) : i64
    %6 = llvm.mlir.undef : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.getelementptr %arg1[%6] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
    %9 = llvm.bitcast %8 : !llvm.ptr<ptr<i8>> to !llvm.ptr<vec<2 x ptr<i8>>>
    %10 = llvm.getelementptr %9[%4, %4] : (!llvm.ptr<vec<2 x ptr<i8>>>, i64, i64) -> !llvm.ptr<ptr<i8>>
    %11 = llvm.getelementptr %10[%3] : (!llvm.ptr<ptr<i8>>, vector<2xi64>) -> !llvm.vec<2 x ptr<ptr<i8>>>
    %12 = llvm.ptrtoint %11 : !llvm.vec<2 x ptr<ptr<i8>>> to vector<2xi64>
    %13 = llvm.lshr %12, %2  : vector<2xi64>
    %14 = llvm.shl %13, %1  : vector<2xi64>
    %15 = llvm.getelementptr %arg0[%14] : (!llvm.vec<2 x ptr<i8>>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    %16 = llvm.getelementptr %15[%0] : (!llvm.vec<2 x ptr<i8>>, i64) -> !llvm.vec<2 x ptr<i8>>
    llvm.call @blackhole(%16) : (!llvm.vec<2 x ptr<i8>>) -> ()
    llvm.br ^bb1
  }
  llvm.func @PR51485(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(80 : i64) : i64
    %1 = llvm.mlir.addressof @PR51485 : !llvm.ptr<func<void (vector<2xi64>)>>
    %2 = llvm.bitcast %1 : !llvm.ptr<func<void (vector<2xi64>)>> to !llvm.ptr<i8>
    %3 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.shl %arg0, %3  : vector<2xi64>
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr<i8>, vector<2xi64>) -> !llvm.vec<2 x ptr<i8>>
    %6 = llvm.getelementptr %5[%0] : (!llvm.vec<2 x ptr<i8>>, i64) -> !llvm.vec<2 x ptr<i8>>
    llvm.call @blackhole(%6) : (!llvm.vec<2 x ptr<i8>>) -> ()
    llvm.br ^bb1
  }
  llvm.func @gep_cross_loop(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<f32>, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.load %arg0 : !llvm.ptr<i64>
    %5 = llvm.getelementptr %arg1[%4] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    llvm.br ^bb1(%3, %2 : i64, f32)
  ^bb1(%6: i64, %7: f32):  // 2 preds: ^bb0, ^bb3
    %8 = llvm.icmp "ule" %6, %1 : i64
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %7 : f32
  ^bb3:  // pred: ^bb1
    %9 = llvm.getelementptr %5[%6] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %10 = llvm.load %9 : !llvm.ptr<f32>
    %11 = llvm.fadd %7, %10  : f32
    %12 = llvm.add %6, %0  : i64
    llvm.br ^bb1(%12, %11 : i64, f32)
  }
  llvm.func @use(!llvm.ptr<i8>)
  llvm.func @only_one_inbounds(%arg0: !llvm.ptr<i8>, %arg1: i1, %arg2: i32, %arg3: i32) {
    %0 = llvm.zext %arg3 : i32 to i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @use(%3) : (!llvm.ptr<i8>) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @both_inbounds_one_neg(%arg0: !llvm.ptr<i8>, %arg1: i1, %arg2: i32) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @use(%3) : (!llvm.ptr<i8>) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @both_inbounds_pos(%arg0: !llvm.ptr<i8>, %arg1: i1, %arg2: i32) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @use(%3) : (!llvm.ptr<i8>) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.ptr {llvm.nocapture, llvm.readnone}, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg5: i32, %arg6: i32, %arg7: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg8: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.zext %arg1 : i32 to i64
    %5 = llvm.getelementptr inbounds %arg7[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.zext %arg2 : i32 to i64
    %7 = llvm.getelementptr inbounds %5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.getelementptr inbounds %7[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.icmp "eq" %9, %arg3 : i32
    llvm.cond_br %10, ^bb5(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg6 : i32, i32)
  ^bb2(%11: i32, %12: i32):  // pred: ^bb4
    %13 = llvm.zext %12 : i32 to i64
    %14 = llvm.getelementptr inbounds %arg7[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %15 = llvm.getelementptr inbounds %14[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %16 = llvm.getelementptr inbounds %15[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 4 : i64} : !llvm.ptr -> i32
    %18 = llvm.icmp "eq" %17, %arg3 : i32
    llvm.cond_br %18, ^bb5(%1 : i32), ^bb3(%12, %11 : i32, i32)
  ^bb3(%19: i32, %20: i32):  // 2 preds: ^bb1, ^bb2
    %21 = llvm.and %19, %arg8  : i32
    %22 = llvm.zext %21 : i32 to i64
    %23 = llvm.getelementptr inbounds %arg4[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %24 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> i32
    %25 = llvm.icmp "ugt" %24, %arg5 : i32
    llvm.cond_br %25, ^bb4, ^bb5(%2 : i32)
  ^bb4:  // pred: ^bb3
    %26 = llvm.add %20, %3  : i32
    %27 = llvm.icmp "eq" %26, %2 : i32
    llvm.cond_br %27, ^bb5(%2 : i32), ^bb2(%26, %24 : i32, i32)
  ^bb5(%28: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %28 : i32
  }
  llvm.func @blackhole(!llvm.vec<2 x ptr>)
  llvm.func @PR37005(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<21> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %5 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%2] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.vec<2 x ptr> to vector<2xi64>
    %10 = llvm.lshr %9, %3  : vector<2xi64>
    %11 = llvm.shl %10, %4 overflow<nsw, nuw>  : vector<2xi64>
    %12 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %13 = llvm.getelementptr inbounds %12[%5] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%13) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }
  llvm.func @PR37005_2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(21 : i64) : i64
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.mlir.constant(dense<[80, 60]> : vector<2xi64>) : vector<2xi64>
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.lshr %7, %2  : i64
    %9 = llvm.shl %8, %3 overflow<nsw, nuw>  : i64
    %10 = llvm.getelementptr inbounds %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.getelementptr inbounds %10[%4] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%11) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }
  llvm.func @PR37005_3(%arg0: !llvm.vec<2 x ptr>, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<21> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %5 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%2] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.vec<2 x ptr> to vector<2xi64>
    %10 = llvm.lshr %9, %3  : vector<2xi64>
    %11 = llvm.shl %10, %4 overflow<nsw, nuw>  : vector<2xi64>
    %12 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %13 = llvm.getelementptr inbounds %12[%5] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%13) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }
  llvm.func @PR51485(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.addressof @PR51485 : !llvm.ptr
    %2 = llvm.mlir.constant(80 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %3 = llvm.shl %arg0, %0 overflow<nsw, nuw>  : vector<2xi64>
    %4 = llvm.getelementptr inbounds %1[%3] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %5 = llvm.getelementptr inbounds %4[%2] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    llvm.call @blackhole(%5) : (!llvm.vec<2 x ptr>) -> ()
    llvm.br ^bb1
  }
  llvm.func @gep_cross_loop(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(16 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %5 = llvm.getelementptr inbounds %arg1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.br ^bb1(%0, %1 : i64, f32)
  ^bb1(%6: i64, %7: f32):  // 2 preds: ^bb0, ^bb3
    %8 = llvm.icmp "ule" %6, %2 : i64
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %7 : f32
  ^bb3:  // pred: ^bb1
    %9 = llvm.getelementptr inbounds %5[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.fadd %7, %10  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %12 = llvm.add %6, %3 overflow<nsw>  : i64
    llvm.br ^bb1(%12, %11 : i64, f32)
  }
  llvm.func @use(!llvm.ptr)
  llvm.func @only_one_inbounds(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}, %arg3: i32 {llvm.noundef}) {
    %0 = llvm.zext %arg3 : i32 to i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @both_inbounds_one_neg(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @both_inbounds_pos(%arg0: !llvm.ptr, %arg1: i1, %arg2: i32 {llvm.noundef}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %arg2 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%3) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
}

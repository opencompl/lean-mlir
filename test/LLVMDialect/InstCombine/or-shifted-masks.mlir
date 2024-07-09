module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @or_and_shifts1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(60 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.and %6, %3  : i32
    %8 = llvm.or %5, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @or_and_shifts2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(896 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.lshr %arg0, %2  : i32
    %7 = llvm.and %6, %3  : i32
    %8 = llvm.or %5, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @or_and_shift_shift_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(28 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.shl %4, %1  : i32
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.and %6, %3  : i32
    %8 = llvm.or %5, %7  : i32
    llvm.return %8 : i32
  }
  llvm.func @multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.shl %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.lshr %4, %3  : i32
    %8 = llvm.shl %5, %2 overflow<nsw, nuw>  : i32
    %9 = llvm.lshr %5, %3  : i32
    %10 = llvm.or %6, %8  : i32
    %11 = llvm.or %7, %9  : i32
    %12 = llvm.or %11, %10  : i32
    llvm.return %12 : i32
  }
  llvm.func @multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(24 : i32) : i32
    %4 = llvm.mlir.constant(96 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.shl %5, %1 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %5, %2 overflow<nsw, nuw>  : i32
    %8 = llvm.and %arg0, %3  : i32
    %9 = llvm.shl %8, %1 overflow<nsw, nuw>  : i32
    %10 = llvm.shl %8, %2 overflow<nsw, nuw>  : i32
    %11 = llvm.and %arg0, %4  : i32
    %12 = llvm.shl %11, %1 overflow<nsw, nuw>  : i32
    %13 = llvm.shl %11, %2 overflow<nsw, nuw>  : i32
    %14 = llvm.or %6, %9  : i32
    %15 = llvm.or %12, %14  : i32
    %16 = llvm.or %13, %10  : i32
    %17 = llvm.or %7, %16  : i32
    %18 = llvm.or %15, %17  : i32
    llvm.return %18 : i32
  }
  llvm.func @multiuse3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(96 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1920 : i32) : i32
    %4 = llvm.mlir.constant(15 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.shl %5, %1 overflow<nsw, nuw>  : i32
    %7 = llvm.lshr %5, %2  : i32
    %8 = llvm.shl %arg0, %1  : i32
    %9 = llvm.and %8, %3  : i32
    %10 = llvm.or %6, %9  : i32
    %11 = llvm.lshr %arg0, %2  : i32
    %12 = llvm.and %11, %4  : i32
    %13 = llvm.or %7, %12  : i32
    %14 = llvm.or %13, %10  : i32
    llvm.return %14 : i32
  }
  llvm.func local_unnamed_addr @multiuse4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100663296 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(17 : i32) : i32
    %3 = llvm.mlir.constant(15360 : i32) : i32
    %4 = llvm.mlir.constant(22 : i32) : i32
    %5 = llvm.mlir.constant(480 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %8 = llvm.lshr %6, %4  : i32
    %9 = llvm.lshr %arg0, %4  : i32
    %10 = llvm.and %9, %5  : i32
    %11 = llvm.or %10, %8  : i32
    llvm.br ^bb3(%11 : i32)
  ^bb2:  // pred: ^bb0
    %12 = llvm.lshr %6, %2  : i32
    %13 = llvm.lshr %arg0, %2  : i32
    %14 = llvm.and %13, %3  : i32
    %15 = llvm.or %14, %12  : i32
    llvm.br ^bb3(%15 : i32)
  ^bb3(%16: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %16 : i32
  }
  llvm.func local_unnamed_addr @multiuse5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(5570560 : i32) : i32
    %3 = llvm.mlir.constant(348160 : i32) : i32
    %4 = llvm.mlir.constant(21760 : i32) : i32
    %5 = llvm.mlir.constant(1360 : i32) : i32
    %6 = llvm.shl %arg0, %0  : i32
    %7 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %8 = llvm.and %6, %4  : i32
    %9 = llvm.and %arg0, %5  : i32
    %10 = llvm.shl %9, %0 overflow<nsw, nuw>  : i32
    %11 = llvm.or %10, %8  : i32
    llvm.br ^bb3(%11 : i32)
  ^bb2:  // pred: ^bb0
    %12 = llvm.and %6, %2  : i32
    %13 = llvm.and %arg0, %3  : i32
    %14 = llvm.shl %13, %0 overflow<nsw, nuw>  : i32
    %15 = llvm.or %14, %12  : i32
    llvm.br ^bb3(%15 : i32)
  ^bb3(%16: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %16 : i32
  }
  llvm.func @shl_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @shl_mask_wrong_shl_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @shl_mask_weird_type(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(255 : i37) : i37
    %1 = llvm.mlir.constant(8 : i37) : i37
    %2 = llvm.and %arg0, %0  : i37
    %3 = llvm.shl %2, %1  : i37
    %4 = llvm.or %2, %3  : i37
    llvm.return %4 : i37
  }
  llvm.func @shl_mask_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @shl_mul_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(65537 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.shl %3, %2  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @shl_mul_mask_wrong_mul_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.shl %3, %2  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }
}

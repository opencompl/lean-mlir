module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mul(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.mul %0, %1  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @select1(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.trunc %arg2 : i32 to i8
    %2 = llvm.trunc %arg3 : i32 to i8
    %3 = llvm.add %0, %1  : i8
    %4 = llvm.select %arg0, %2, %3 : i1, i8
    %5 = llvm.zext %4 : i8 to i32
    llvm.return %5 : i32
  }
  llvm.func @select2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.zext %arg2 : i8 to i32
    %2 = llvm.zext %arg3 : i8 to i32
    %3 = llvm.add %0, %1  : i32
    %4 = llvm.select %arg0, %2, %3 : i1, i32
    %5 = llvm.trunc %4 : i32 to i8
    llvm.return %5 : i8
  }
  llvm.func @eval_trunc_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.mul %2, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }
  llvm.func @eval_zext_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.and %1, %0  : i16
    %3 = llvm.mul %2, %2 overflow<nsw, nuw>  : i16
    %4 = llvm.zext %3 : i16 to i32
    llvm.return %4 : i32
  }
  llvm.func @eval_sext_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i16) : i16
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.and %2, %0  : i16
    %4 = llvm.mul %3, %3 overflow<nsw, nuw>  : i16
    %5 = llvm.or %4, %1  : i16
    %6 = llvm.sext %5 : i16 to i32
    llvm.return %6 : i32
  }
  llvm.func @PR36225(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: i3, %arg4: i3) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    llvm.cond_br %arg2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.switch %arg3 : i3, ^bb6 [
      0: ^bb4(%4 : i8),
      7: ^bb4(%4 : i8)
    ]
  ^bb3:  // pred: ^bb1
    llvm.switch %arg4 : i3, ^bb6 [
      0: ^bb4(%1 : i8),
      7: ^bb4(%1 : i8)
    ]
  ^bb4(%5: i8):  // 4 preds: ^bb2, ^bb2, ^bb3, ^bb3
    %6 = llvm.sext %5 : i8 to i32
    %7 = llvm.icmp "sgt" %arg0, %6 : i32
    llvm.cond_br %7, ^bb6, ^bb5
  ^bb5:  // pred: ^bb4
    llvm.unreachable
  ^bb6:  // 3 preds: ^bb2, ^bb3, ^bb4
    llvm.unreachable
  }
  llvm.func @foo(%arg0: i1 {llvm.zeroext}) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    llvm.return %arg0 : i1
  }
}

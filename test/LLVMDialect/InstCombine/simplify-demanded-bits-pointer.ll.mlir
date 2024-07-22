module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func fastcc @cse_insn(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i1, %arg4: i1, %arg5: i1, %arg6: i1, %arg7: i1, %arg8: i1, %arg9: i1, %arg10: i1, %arg11: i1) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(38 : i16) : i16
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg4, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.unreachable
  ^bb4:  // pred: ^bb2
    %3 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i16
    %4 = llvm.icmp "eq" %3, %0 : i16
    %5 = llvm.select %4, %1, %1 : i1, !llvm.ptr
    llvm.cond_br %arg5, ^bb7, ^bb5
  ^bb5:  // pred: ^bb4
    llvm.cond_br %arg6, ^bb7, ^bb6
  ^bb6:  // pred: ^bb5
    llvm.cond_br %arg7, ^bb8, ^bb9
  ^bb7:  // 2 preds: ^bb4, ^bb5
    llvm.unreachable
  ^bb8:  // pred: ^bb6
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb6, ^bb8
    llvm.cond_br %arg8, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    llvm.unreachable
  ^bb11:  // pred: ^bb9
    llvm.cond_br %arg9, ^bb12, ^bb15
  ^bb12:  // pred: ^bb11
    %6 = llvm.icmp "eq" %1, %1 : !llvm.ptr
    %7 = llvm.zext %6 : i1 to i8
    %8 = llvm.icmp "ne" %5, %1 : !llvm.ptr
    %9 = llvm.zext %8 : i1 to i8
    %10 = llvm.icmp "ne" %7, %2 : i8
    %11 = llvm.icmp "ne" %9, %2 : i8
    %12 = llvm.and %10, %11  : i1
    %13 = llvm.zext %12 : i1 to i8
    %14 = llvm.icmp "ne" %13, %2 : i8
    llvm.cond_br %14, ^bb13, ^bb15
  ^bb13:  // pred: ^bb12
    llvm.cond_br %arg10, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    llvm.br ^bb15
  ^bb15:  // 4 preds: ^bb11, ^bb12, ^bb13, ^bb14
    llvm.cond_br %arg11, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    llvm.unreachable
  ^bb17:  // pred: ^bb15
    llvm.unreachable
  }
}

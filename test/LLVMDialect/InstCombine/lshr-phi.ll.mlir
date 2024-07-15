module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @hash_string(%arg0: !llvm.ptr {llvm.nocapture}) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(14 : i32) : i32
    %5 = llvm.mlir.constant(16383 : i32) : i32
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %8 = llvm.icmp "eq" %7, %0 : i8
    llvm.cond_br %8, ^bb2(%1 : i32), ^bb1(%2, %1 : i64, i32)
  ^bb1(%9: i64, %10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.shl %10, %3  : i32
    %13 = llvm.lshr %10, %4  : i32
    %14 = llvm.add %12, %13  : i32
    %15 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8
    %16 = llvm.sext %15 : i8 to i32
    %17 = llvm.xor %16, %14  : i32
    %18 = llvm.and %17, %5  : i32
    %19 = llvm.add %9, %6  : i64
    %20 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %21 = llvm.load %20 {alignment = 1 : i64} : !llvm.ptr -> i8
    %22 = llvm.icmp "eq" %21, %0 : i8
    llvm.cond_br %22, ^bb2(%18 : i32), ^bb1(%19, %18 : i64, i32)
  ^bb2(%23: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %23 : i32
  }
}

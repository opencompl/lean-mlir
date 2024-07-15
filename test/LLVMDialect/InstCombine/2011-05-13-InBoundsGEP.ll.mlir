module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1879048192 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.add %arg0, %1  : i32
    %7 = llvm.alloca %2 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %9 = llvm.getelementptr %7[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %10 = llvm.icmp "ult" %8, %9 : !llvm.ptr
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }
}

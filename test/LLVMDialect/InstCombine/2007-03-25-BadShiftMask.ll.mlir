module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(21 : i32) : i32
    %4 = llvm.mlir.constant(2047 : i16) : i16
    %5 = llvm.mlir.constant(0 : i8) : i8
    %6 = llvm.alloca %0 x !llvm.struct<"struct..1anon", (f64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %6 {alignment = 8 : i64} : f64, !llvm.ptr
    %7 = llvm.getelementptr %6[%2, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct..0anon", (i32, i32)>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.shl %8, %0  : i32
    %10 = llvm.lshr %9, %3  : i32
    %11 = llvm.trunc %10 : i32 to i16
    %12 = llvm.icmp "ne" %11, %4 : i16
    %13 = llvm.zext %12 : i1 to i8
    %14 = llvm.icmp "ne" %13, %5 : i8
    llvm.cond_br %14, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global extern_weak @A() {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global extern_weak @B() {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @foo(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.addressof @A : !llvm.ptr
    %3 = llvm.mlir.addressof @B : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(2147483647 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %1, ^bb2(%0 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %8 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.br ^bb2(%8 : i1)
  ^bb2(%9: i1):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.select %9, %4, %5 : i1, i32
    %11 = llvm.mul %10, %6  : i32
    %12 = llvm.icmp "ule" %11, %7 : i32
    llvm.store %12, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %10 : i32
  }
}

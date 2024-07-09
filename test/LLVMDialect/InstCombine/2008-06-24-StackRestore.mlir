module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global weak @p() {addr_space = 0 : i32} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.addressof @p : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1000 : i32) : i32
    %6 = llvm.mlir.constant(999999 : i32) : i32
    %7 = llvm.intr.stacksave : !llvm.ptr
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store volatile %8, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.br ^bb2(%4, %7 : i32, !llvm.ptr)
  ^bb1:  // pred: ^bb2
    llvm.return %4 : i32
  ^bb2(%9: i32, %10: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    %11 = llvm.add %9, %0  : i32
    llvm.intr.stackrestore %10 : !llvm.ptr
    %12 = llvm.intr.stacksave : !llvm.ptr
    %13 = llvm.srem %11, %5  : i32
    %14 = llvm.add %13, %0  : i32
    %15 = llvm.alloca %14 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %0, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.getelementptr %15[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %1, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store volatile %15, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %17 = llvm.icmp "eq" %11, %6 : i32
    llvm.cond_br %17, ^bb1, ^bb2(%11, %12 : i32, !llvm.ptr)
  }
}

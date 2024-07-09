module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global weak @p() {addr_space = 0 : i32} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(32 : i64) : i64
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @p : !llvm.ptr
    %7 = llvm.mlir.constant(999999 : i32) : i32
    %8 = llvm.mlir.constant(0 : i8) : i8
    %9 = llvm.bitcast %0 : i32 to i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%10: i32):  // 2 preds: ^bb0, ^bb3
    %11 = llvm.intr.stacksave : !llvm.ptr
    %12 = llvm.srem %10, %1  : i32
    %13 = llvm.add %12, %2  : i32
    %14 = llvm.sub %13, %2  : i32
    %15 = llvm.zext %13 : i32 to i64
    %16 = llvm.mul %15, %3  : i64
    %17 = llvm.mul %13, %4  : i32
    %18 = llvm.zext %13 : i32 to i64
    %19 = llvm.mul %18, %3  : i64
    %20 = llvm.mul %13, %4  : i32
    %21 = llvm.alloca %20 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %2, %22 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store volatile %21, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %23 = llvm.add %10, %2  : i32
    %24 = llvm.icmp "sle" %23, %7 : i32
    %25 = llvm.zext %24 : i1 to i8
    %26 = llvm.icmp "ne" %25, %8 : i8
    llvm.cond_br %26, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.intr.stackrestore %11 : !llvm.ptr
    llvm.return %0 : i32
  ^bb3:  // pred: ^bb1
    llvm.intr.stackrestore %11 : !llvm.ptr
    llvm.br ^bb1(%23 : i32)
  }
}

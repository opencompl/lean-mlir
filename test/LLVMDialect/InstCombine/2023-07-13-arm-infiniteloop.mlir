module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.zext %arg1 : i32 to i64
    %6 = llvm.lshr %5, %0  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = "llvm.intr.is.constant"(%7) : (i32) -> i1
    llvm.cond_br %8, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %1 {alignment = 2147483648 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%9 : i32)
  ^bb2:  // pred: ^bb0
    %10 = llvm.intr.fshl(%7, %2, %3)  : (i32, i32, i32) -> i32
    llvm.br ^bb3(%10 : i32)
  ^bb3(%11: i32):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.lshr %11, %4  : i32
    llvm.store %12, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}

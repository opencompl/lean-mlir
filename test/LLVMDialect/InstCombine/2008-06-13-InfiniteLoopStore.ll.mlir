module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g_139(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @func_56(%arg0: i32) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g_139 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.zext %4 : i1 to i8
    %6 = llvm.icmp "ne" %5, %3 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}

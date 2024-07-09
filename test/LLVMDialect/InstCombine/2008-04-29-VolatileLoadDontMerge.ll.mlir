module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal @g_1(0 : i32) {addr_space = 0 : i32, dso_local} : i32
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.addressof @g_1 : !llvm.ptr
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.icmp "slt" %0, %1 : i32
    %6 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb1(%0, %6 : i32, i32)
  ^bb1(%7: i32, %8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.add %8, %3  : i32
    llvm.store volatile %9, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.add %7, %4  : i32
    %11 = llvm.icmp "slt" %10, %1 : i32
    %12 = llvm.load volatile %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.cond_br %11, ^bb1(%10, %12 : i32, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %0 : i32
  }
}

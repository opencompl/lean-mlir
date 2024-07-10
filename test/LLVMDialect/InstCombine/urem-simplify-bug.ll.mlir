module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @".str"("foo\0A\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global internal constant @".str1"("bar\0A\00") {addr_space = 0 : i32, dso_local}
  llvm.func @main() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(251 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(95 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant("foo\0A\00") : !llvm.array<5 x i8>
    %6 = llvm.mlir.addressof @".str" : !llvm.ptr
    %7 = llvm.mlir.constant("bar\0A\00") : !llvm.array<5 x i8>
    %8 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %9 = llvm.call @func_11() : () -> i32
    %10 = llvm.or %9, %0  : i32
    %11 = llvm.urem %1, %10  : i32
    %12 = llvm.icmp "ne" %11, %2 : i32
    %13 = llvm.zext %12 : i1 to i32
    %14 = llvm.urem %13, %3  : i32
    %15 = llvm.and %14, %4  : i32
    %16 = llvm.icmp "eq" %15, %2 : i32
    llvm.cond_br %16, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%6 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%8 : !llvm.ptr)
  ^bb3(%17: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %18 = llvm.call @printf(%17) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @func_11() -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32 attributes {passthrough = ["nounwind"]}
}

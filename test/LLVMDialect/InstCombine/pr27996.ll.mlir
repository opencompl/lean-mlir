module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @i(1 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global external constant @f(1.100000e+00 : f32) {addr_space = 0 : i32, alignment = 4 : i64} : f32
  llvm.mlir.global common @cmp(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global common @resf() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.mlir.global common @resi() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @cmp : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.addressof @resf : !llvm.ptr
    %5 = llvm.mlir.addressof @resi : !llvm.ptr
    %6 = llvm.mlir.constant(1.100000e+00 : f32) : f32
    %7 = llvm.mlir.addressof @f : !llvm.ptr
    %8 = llvm.mlir.addressof @i : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%9: !llvm.ptr):  // 3 preds: ^bb0, ^bb3, ^bb4
    %10 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.ashr %10, %3  : i32
    llvm.store %11, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.icmp "ne" %11, %1 : i32
    llvm.cond_br %12, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %13 = llvm.and %11, %3  : i32
    %14 = llvm.icmp "ne" %13, %1 : i32
    llvm.cond_br %14, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb1(%8 : !llvm.ptr)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%7 : !llvm.ptr)
  ^bb5:  // pred: ^bb1
    llvm.store %9, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %9, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %1 : i32
  }
}

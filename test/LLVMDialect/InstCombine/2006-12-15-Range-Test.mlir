module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @r() {addr_space = 0 : i32} : !llvm.array<17 x i32>
  llvm.func @print_pgm_cond_true(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @r : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-31 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    llvm.br ^bb3
  ^bb1:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i1
  ^bb3:  // pred: ^bb0
    %6 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<17 x i32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.icmp "slt" %7, %2 : i32
    %9 = llvm.icmp "sgt" %7, %3 : i32
    %10 = llvm.or %8, %9  : i1
    llvm.cond_br %10, ^bb1, ^bb2
  }
  llvm.func @print_pgm_cond_true_logical(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @r : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-31 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(false) : i1
    llvm.br ^bb3
  ^bb1:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %5 : i1
  ^bb3:  // pred: ^bb0
    %6 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<17 x i32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.icmp "slt" %7, %2 : i32
    %9 = llvm.icmp "sgt" %7, %3 : i32
    %10 = llvm.select %8, %4, %9 : i1, i1
    llvm.cond_br %10, ^bb1, ^bb2
  }
}

module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.undef : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%2 : i1)
  ^bb2:  // pred: ^bb0
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.br ^bb3(%5 : i1)
  ^bb3(%6: i1):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.xor %4, %3  : i1
    %8 = llvm.and %6, %7  : i1
    llvm.return %8 : i1
  }
  llvm.func @foo_logical(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.undef : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%2 : i1)
  ^bb2:  // pred: ^bb0
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.br ^bb3(%6 : i1)
  ^bb3(%7: i1):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.xor %5, %3  : i1
    %9 = llvm.select %7, %8, %4 : i1, i1
    llvm.return %9 : i1
  }
  llvm.func @bar()
}

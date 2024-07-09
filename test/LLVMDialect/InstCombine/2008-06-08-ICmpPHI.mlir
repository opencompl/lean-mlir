module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(37 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i32)
  ^bb1(%4: i32, %5: i32):  // 2 preds: ^bb0, ^bb6
    %6 = llvm.call @bork() vararg(!llvm.func<i32 (...)>) : () -> i32
    %7 = llvm.call @bork() vararg(!llvm.func<i32 (...)>) : () -> i32
    %8 = llvm.call @bork() vararg(!llvm.func<i32 (...)>) : () -> i32
    %9 = llvm.icmp "eq" %8, %0 : i32
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %10 = llvm.call @bork() vararg(!llvm.func<i32 (...)>) : () -> i32
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %11 = llvm.call @bork() vararg(!llvm.func<i32 (...)>) : () -> i32
    %12 = llvm.call @bork() vararg(!llvm.func<i32 (...)>) : () -> i32
    %13 = llvm.icmp "eq" %5, %1 : i32
    llvm.cond_br %13, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %14 = llvm.call @bar() vararg(!llvm.func<i32 (...)>) : () -> i32
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %15 = llvm.call @zap() vararg(!llvm.func<i32 (...)>) : () -> i32
    %16 = llvm.add %4, %2  : i32
    %17 = llvm.icmp "eq" %16, %3 : i32
    llvm.cond_br %17, ^bb7, ^bb6
  ^bb6:  // pred: ^bb5
    llvm.br ^bb1(%16, %15 : i32, i32)
  ^bb7:  // pred: ^bb5
    llvm.return
  }
  llvm.func @bork(...) -> i32
  llvm.func @bar(...) -> i32
  llvm.func @zap(...) -> i32
}

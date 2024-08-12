module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(i32)
  llvm.func @bar(i32) -> i32
  llvm.func @test1(%arg0: i32) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.call @foo(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @bar(%arg0) : (i32) -> i32
    %5 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %5, ^bb1, ^bb3(%4 : i32)
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "ult" %4, %1 : i32
    %7 = llvm.select %6, %arg0, %2 : i1, i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    llvm.cond_br %8, ^bb2, ^bb3(%7 : i32)
  ^bb2:  // pred: ^bb1
    llvm.call @foo(%arg0) : (i32) -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb3(%9: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @foo(%9) : (i32) -> ()
    llvm.return
  }
}

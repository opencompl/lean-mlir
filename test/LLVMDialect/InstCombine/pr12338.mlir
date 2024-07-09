module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @entry() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.mlir.constant(dense<92> : vector<1xi32>) : vector<1xi32>
    llvm.br ^bb1(%1 : vector<1xi32>)
  ^bb1(%3: vector<1xi32>):  // 2 preds: ^bb0, ^bb3
    %4 = llvm.sub %1, %3  : vector<1xi32>
    llvm.br ^bb2(%4 : vector<1xi32>)
  ^bb2(%5: vector<1xi32>):  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %6 = llvm.add %5, %2  : vector<1xi32>
    %7 = llvm.sub %1, %6  : vector<1xi32>
    llvm.br ^bb1(%7 : vector<1xi32>)
  }
}

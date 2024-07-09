module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @f(i32)
  llvm.func @test(%arg0: i32) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i32
    %5 = llvm.icmp "ult" %1, %4 : i32
    llvm.cond_br %5, ^bb1(%1 : i32), ^bb2
  ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.call @f(%4) : (i32) -> ()
    %7 = llvm.add %6, %2  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    llvm.cond_br %8, ^bb1(%7 : i32), ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
}

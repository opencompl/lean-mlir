module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @olt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ole_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ole" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ogt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ogt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @oge_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ult_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ult" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ule_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ule" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ugt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @uge_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @olt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ole_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ole" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ogt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ogt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @oge_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ult_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ult" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ule_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ule" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ugt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @uge_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @olt_pinf_fmf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    llvm.return %1 : i1
  }
  llvm.func @oge_pinf_fmf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f16
    llvm.return %1 : i1
  }
  llvm.func @olt_pinf_vec(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "olt" %arg0, %0 : vector<2xf16>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @oge_ninf_vec(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0xFC00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "oge" %arg0, %0 : vector<2xf16>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @ord_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @uno_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @true_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "_true" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @false_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "_false" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @ord_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @uno_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @true_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "_true" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @false_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "_false" %arg0, %0 : f16
    llvm.return %1 : i1
  }
  llvm.func @olt_one(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }
}

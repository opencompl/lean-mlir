module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fcmp_ord_and_uno(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ugt(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_uge(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ult(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ule(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_une(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "une" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_true(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "_true" %arg0, %0 : f16
    %2 = llvm.fcmp "une" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf16>
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : vector<2xf16>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @fcmp_ord_and_ueq_different_value0(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg2, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq_different_value1(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg1, %arg2 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @foo() -> f16
  llvm.func @fcmp_ord_and_ueq_commute0() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.fcmp "ord" %1, %0 : f16
    %4 = llvm.fcmp "ueq" %1, %2 : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @fcmp_ord_and_ueq_commute1() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.fcmp "ord" %1, %0 : f16
    %4 = llvm.fcmp "ueq" %1, %2 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @fcmp_oeq_x_x_and_ult(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg0 : f16
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f16
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ord_and_ueq_preserve_flags(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq_preserve_subset_flags0(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq_preserve_subset_flags1(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq_flags_lhs(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_ueq_flags_rhs(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @fcmp_ord_and_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_fabs_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_and_fabs_ueq_commute0() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.intr.fabs(%1)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %1, %0 : f16
    %5 = llvm.fcmp "ueq" %2, %3 : f16
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @fcmp_ord_and_fabs_ueq_commute1() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.call @foo() : () -> f16
    %2 = llvm.call @foo() : () -> f16
    %3 = llvm.intr.fabs(%1)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %1, %0 : f16
    %5 = llvm.fcmp "ueq" %2, %3 : f16
    %6 = llvm.and %5, %4  : i1
    llvm.return %6 : i1
  }
  llvm.func @fcmp_ord_and_fabs_ueq_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %3 = llvm.fcmp "ord" %arg0, %1 : vector<2xf16>
    %4 = llvm.fcmp "ueq" %2, %arg1 : vector<2xf16>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @fcmp_ord_fabs_and_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_and_fneg_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_fneg_and_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_fneg_and_fneg_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_and_fneg_fabs_ueq(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fneg %1  : f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @fcmp_ord_and_copysign_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %1, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_copysign_ord_and_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %1, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %arg1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_and_copysign_ueq_commute(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %arg1, %1 : f16
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_and_copysign_fneg_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fneg %arg0  : f16
    %2 = llvm.intr.copysign(%1, %arg2)  : (f16, f16) -> f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @fcmp_ord_and_fneg_copysign_ueq(%arg0: f16, %arg1: f16, %arg2: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%arg0, %arg2)  : (f16, f16) -> f16
    %2 = llvm.fneg %1  : f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %arg1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
}

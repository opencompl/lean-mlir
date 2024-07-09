module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @select_noFMF_nfabs_lt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_lt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_lt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_ole(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_ole(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_ule(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_ule(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_noFMF_nfabs_gt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_gt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_gt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_ogt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_ogt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_ugt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ugt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_ugt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ugt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_oge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_oge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nfabs_uge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_nnan_nfabs_uge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_noFMF_fsubfabs_le(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_noFMF_fsubfabs_olt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_noFMF_fsubfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_fnegfabs_olt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @select_nsz_fnegfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }
}

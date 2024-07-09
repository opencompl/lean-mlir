module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @lshrugt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrugt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrugt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrugt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrult_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrult_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrult_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_00_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrsgt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrsgt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrsgt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrslt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrslt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrslt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrugt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrugt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrugt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrugt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_eq_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ne_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_uge_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ule_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_sgt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_sge_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_slt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_sle_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_eq_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ne_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ugt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_uge_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ule_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_sgt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_sge_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_slt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_sle_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_00_00_ashr_extra_use(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @ashr_00_00_vec(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<10> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.ashr %arg0, %0  : vector<4xi8>
    %3 = llvm.icmp "ule" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }
  llvm.func @ashr_sgt_overflow(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrult_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrult_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @lshrult_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @lshrult_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrsgt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrsgt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrsgt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrsgt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrslt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrslt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }
  llvm.func @ashrslt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashrslt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }
  llvm.func @ashr_slt_exact_near_pow2_cmpval(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ashr_ult_exact_near_pow2_cmpval(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @negtest_near_pow2_cmpval_ashr_slt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @negtest_near_pow2_cmpval_ashr_wrong_cmp_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @negtest_near_pow2_cmpval_isnt_close_to_pow2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @negtest_near_pow2_cmpval_would_overflow_into_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(33 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
}

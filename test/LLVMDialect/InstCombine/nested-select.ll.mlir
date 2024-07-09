module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i1(i1)
  llvm.func @use.i8(i8)
  llvm.func @andcond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @orcond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @andcond.extrause0(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @orcond.extrause0(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @andcond.extrause1(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @orcond.extrause1(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @andcond.extrause2(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @orcond.extrause2(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @andcond.different.inner.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg2, %0 : i1, i1
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %arg5, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @orcond.different.inner.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %2, %arg5 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @andcond.different.inner.cond.both.inverted(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %4, %arg4, %1 : i1, i1
    %6 = llvm.select %3, %arg5, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @orcond.different.inner.cond.both.inverted(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %3, %0, %arg3 : i1, i1
    %5 = llvm.select %2, %4, %arg5 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @andcond.different.inner.cond.inverted.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.select %arg1, %arg4, %1 : i1, i1
    %5 = llvm.select %3, %arg5, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orcond.different.inner.cond.inverted.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg1, %0, %arg3 : i1, i1
    %4 = llvm.select %2, %3, %arg5 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @andcond.different.inner.cond.inverted.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg2, %0 : i1, i1
    %3 = llvm.xor %arg1, %1  : i1
    %4 = llvm.select %3, %arg4, %0 : i1, i1
    %5 = llvm.select %2, %arg5, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orcond.different.inner.cond.inverted.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %0, %arg3 : i1, i1
    %4 = llvm.select %1, %3, %arg5 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @D139275_c4001580(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.xor %arg0, %arg1  : i1
    %1 = llvm.and %arg2, %arg1  : i1
    %2 = llvm.select %0, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %arg5, %2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @andcond.001.inv.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    %4 = llvm.xor %2, %1  : i1
    %5 = llvm.select %4, %3, %0 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orcond.001.inv.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    %3 = llvm.xor %1, %0  : i1
    %4 = llvm.select %3, %0, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @andcond.010.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.select %3, %arg3, %0 : i1, i1
    %5 = llvm.select %2, %arg4, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orcond.010.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    %4 = llvm.select %1, %3, %arg4 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @andcond.100.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %5 = llvm.select %3, %arg4, %4 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @orcond.100.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %4 = llvm.select %2, %3, %arg4 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.select %3, %1, %arg3 : i1, i1
    %5 = llvm.xor %2, %1  : i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %6 = llvm.select %5, %4, %0 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %arg2, %1 : i1, i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.xor %2, %0  : i1
    %6 = llvm.select %5, %0, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.xor %3, %0  : i1
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %4, %0, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %arg3, %1 : i1, i1
    %6 = llvm.select %3, %arg4, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg2 : i1, i1
    %5 = llvm.select %2, %4, %arg4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @andcond.111.inv.all.conds(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %arg3, %1 : i1, i1
    llvm.call @use.i1(%5) : (i1) -> ()
    %6 = llvm.xor %3, %0  : i1
    %7 = llvm.select %6, %5, %1 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @orcond.111.inv.all.conds(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg2 : i1, i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.xor %2, %0  : i1
    %6 = llvm.select %5, %0, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_implied_true(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @test_implied_true_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %7 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %6, %7, %4 : vector<2xi1>, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @test_implied_true_falseval(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "sgt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %3, %6 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @test_implied_false(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "sgt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @test_imply_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }
  llvm.func @test_imply_type_mismatch(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg1, %1 : i8
    %7 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %6, %7, %4 : i1, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @test_dont_crash(%arg0: i1, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.select %arg0, %arg1, %1 : i1, vector<4xi1>
    %3 = llvm.and %2, %arg2  : vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }
}

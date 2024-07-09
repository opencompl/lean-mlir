module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @cmpxchg_0(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 seq_cst seq_cst {alignment = 8 : i64} : !llvm.ptr, i64
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @cmpxchg_1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 seq_cst seq_cst {alignment = 8 : i64} : !llvm.ptr, i64
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    llvm.return %3 : i64
  }
  llvm.func @cmpxchg_2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 acq_rel monotonic {alignment = 8 : i64} : !llvm.ptr, i64
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    llvm.return %4 : i64
  }
}

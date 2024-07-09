module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @t0_vec(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @t1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @t2(%arg0: i8, %arg1: i1, %arg2: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg2 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @t3(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.sext %arg1 : i2 to i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @t3_vec(%arg0: vector<2xi8>, %arg1: vector<2xi2>) -> vector<2xi8> {
    %0 = llvm.sext %arg1 : vector<2xi2> to vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @xor.commuted(%arg0: i1) -> i8 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.call @gen.i8() : () -> i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause01_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @extrause10_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @extrause11_v1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @extrause001_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause010_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause011_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause100_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause101_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause110_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @extrause111_v2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.sext %arg1 : i1 to i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.add %0, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @use.i8(i8)
  llvm.func @gen.i8() -> i8
}

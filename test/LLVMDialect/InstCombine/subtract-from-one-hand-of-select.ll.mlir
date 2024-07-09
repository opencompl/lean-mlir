module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_sub_from_trueval(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_sub_from_falseval(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg2, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @t2_vec(%arg0: i1, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, vector<2xi8>
    %1 = llvm.sub %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @use8(i8)
  llvm.func @n3_extrause(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @n4_wrong_hands(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg3, %0  : i8
    llvm.return %1 : i8
  }
}

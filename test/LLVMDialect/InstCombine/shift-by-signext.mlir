module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @t1_lshr(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @t2_ashr(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @t3_vec_shl(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @t4_vec_lshr(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @t5_vec_ashr(%arg0: vector<2xi32>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @t6_twoshifts(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i32
  }
  llvm.func @n7_fshl(%arg0: i7, %arg1: i7, %arg2: i6) -> i7 {
    %0 = llvm.sext %arg2 : i6 to i7
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i7, i7, i7) -> i7
    llvm.return %1 : i7
  }
  llvm.func @n8_fshr(%arg0: i7, %arg1: i7, %arg2: i6) -> i7 {
    %0 = llvm.sext %arg2 : i6 to i7
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i7, i7, i7) -> i7
    llvm.return %1 : i7
  }
  llvm.func @t9_fshl(%arg0: i8, %arg1: i8, %arg2: i6) -> i8 {
    %0 = llvm.sext %arg2 : i6 to i8
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }
  llvm.func @t10_fshr(%arg0: i8, %arg1: i8, %arg2: i6) -> i8 {
    %0 = llvm.sext %arg2 : i6 to i8
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }
  llvm.func @use32(i32)
  llvm.func @n11_extrause(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @n12_twoshifts_and_extrause(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.sext %arg1 : i8 to i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @use32(%0) : (i32) -> ()
    llvm.return %2 : i32
  }
}

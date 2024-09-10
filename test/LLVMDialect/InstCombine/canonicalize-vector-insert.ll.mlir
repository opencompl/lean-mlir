module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @trivial_nop(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<8xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_a(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_b(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[2] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_c(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[4] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_d(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[6] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_e(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<4xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_f(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[4] : vector<4xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_g(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<3xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @valid_insertion_h(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[3] : vector<3xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }
  llvm.func @scalable_insert(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: vector<4xi32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<4xi32> into !llvm.vec<? x 4 x  i32>
    llvm.return %0 : !llvm.vec<? x 4 x  i32>
  }
}

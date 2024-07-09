module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @usevec(vector<2xi32>)
  llvm.func @fpext_fpext(%arg0: vector<2xf16>, %arg1: f16, %arg2: i32) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @sext_sext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_zext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi12> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi12>
    %1 = llvm.zext %arg1 : i8 to i12
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi12>
    llvm.return %2 : vector<2xi12>
  }
  llvm.func @fpext_fpext_types(%arg0: vector<2xf16>, %arg1: f32, %arg2: i32) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @sext_sext_types(%arg0: vector<2xi16>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @sext_zext(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi12> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi12>
    %1 = llvm.zext %arg1 : i8 to i12
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi12>
    llvm.return %2 : vector<2xi12>
  }
  llvm.func @sext_sext_use1(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @usevec(%0) : (vector<2xi32>) -> ()
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_zext_use2(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_zext_use3(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @usevec(%0) : (vector<2xi32>) -> ()
    %1 = llvm.zext %arg1 : i8 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.insertelement %1, %0[%arg2 : i32] : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
}

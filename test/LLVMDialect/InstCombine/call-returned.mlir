module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @GV(dense<0> : vector<2xi32>) {addr_space = 0 : i32} : vector<2xi32>
  llvm.func @passthru_i32(i32 {llvm.returned}) -> i32
  llvm.func @passthru_p8(!llvm.ptr {llvm.returned}) -> !llvm.ptr
  llvm.func @passthru_p8_from_p32(!llvm.ptr {llvm.returned}) -> !llvm.ptr
  llvm.func @passthru_8i8v_from_2i32v(vector<2xi32> {llvm.returned}) -> vector<8xi8>
  llvm.func @returned_const_int_arg() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @passthru_i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @returned_const_ptr_arg() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @passthru_p8(%0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @returned_const_ptr_arg_casted() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @passthru_p8_from_p32(%0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @returned_ptr_arg_casted(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @passthru_p8_from_p32(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @returned_const_vec_arg_casted() -> vector<8xi8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @GV : !llvm.ptr
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> vector<2xi32>
    %4 = llvm.call @passthru_8i8v_from_2i32v(%3) : (vector<2xi32>) -> vector<8xi8>
    llvm.return %4 : vector<8xi8>
  }
  llvm.func @returned_vec_arg_casted(%arg0: vector<2xi32>) -> vector<8xi8> {
    %0 = llvm.call @passthru_8i8v_from_2i32v(%arg0) : (vector<2xi32>) -> vector<8xi8>
    llvm.return %0 : vector<8xi8>
  }
  llvm.func @returned_var_arg(%arg0: i32) -> i32 {
    %0 = llvm.call @passthru_i32(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @returned_const_int_arg_musttail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @passthru_i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @returned_var_arg_musttail(%arg0: i32) -> i32 {
    %0 = llvm.call @passthru_i32(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
}

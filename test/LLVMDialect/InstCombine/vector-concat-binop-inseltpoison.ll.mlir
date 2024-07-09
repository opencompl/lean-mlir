module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @add(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.and %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @sub(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.sub %0, %1 overflow<nsw>  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @mul(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.mul %0, %1 overflow<nuw>  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @and(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.and %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @or(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, 2, 3] : vector<2xi8> 
    %2 = llvm.or %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @xor(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.xor %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @shl(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, -1, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.shl %0, %1 overflow<nuw>  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @lshr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, -1, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, -1, 3] : vector<2xi8> 
    %2 = llvm.lshr %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @use(vector<4xi8>)
  llvm.func @ashr(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    llvm.call @use(%0) : (vector<4xi8>) -> ()
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.ashr %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @sdiv(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, -1, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xi8> 
    %2 = llvm.sdiv %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @srem(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.srem %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @udiv(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.udiv %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @urem(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 3] : vector<2xi8> 
    %1 = llvm.shufflevector %arg2, %arg3 [-1, 1, 2, 3] : vector<2xi8> 
    %2 = llvm.urem %0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @fadd(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xf32> 
    %2 = llvm.fadd %0, %1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @fsub(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, -1, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, -1, 3] : vector<2xf32> 
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @use2(vector<4xf32>)
  llvm.func @fmul(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [-1, 1, -1, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [-1, 1, -1, 3] : vector<2xf32> 
    llvm.call @use2(%1) : (vector<4xf32>) -> ()
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @fdiv(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3] : vector<2xf32> 
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @frem(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 3] : vector<2xf32> 
    %1 = llvm.shufflevector %arg2, %arg3 [0, -1, 2, 3] : vector<2xf32> 
    %2 = llvm.frem %0, %1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @PR33026(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>, %arg3: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi32> 
    %2 = llvm.shufflevector %arg2, %arg3 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xi32> 
    %3 = llvm.and %1, %2  : vector<8xi32>
    %4 = llvm.shufflevector %3, %0 [0, 1, 2, 3] : vector<8xi32> 
    %5 = llvm.shufflevector %3, %0 [4, 5, 6, 7] : vector<8xi32> 
    %6 = llvm.sub %4, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }
}

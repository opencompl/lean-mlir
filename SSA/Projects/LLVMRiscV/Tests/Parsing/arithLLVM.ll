; LLVM IR file containing various arithmetic operations used to test wether we can parse the
; generic MLIR dialect form of this in Lean-MLIR

; run : mlir-translate -import-llvm arithLLVM.ll | mlir-opt --mlir-print-op-generic > arithLLVM.mlir
; to the nrun the opt tool run: ( cd ../../../../../ && lake exe opt SSA/Projects/LLVMRiscV/tests/Parsing/arithbb0.mlir )


;copy paste your mlir basic block and run lake exe opt SSA/Projects/LLVMRiscV/tests/Parsing/arithbb0.mlir
; from the root folder.

;cd SSA/Projects/LLVMRiscV/tests/Parsing 
define i64 @add(i64 %a, i64 %b) {
entry:
  %0 = add i64 %a, %b
  %1 = add nuw i64 %a, %b
  %2 = add nsw i64 %a, %b
  %3 = add nuw nsw i64 %a, %b
  %res = add i64 %0, %1
  %res1 = add i64 %2, %3
  ret i64 %res1
}

define i64 @sub(i64 %a, i64 %b) {
entry:
  %0 = sub i64 %a, %b
  %1 = sub nuw i64 %a, %b
  %2 = sub nsw i64 %a, %b
  %3 =  sub nuw nsw i64 %a, %b
  %res = sub i64 %0, %1
  %res1 = sub i64 %2, %3
  ret i64 %res1
}

define i64 @mul(i64 %a, i64 %b) {
entry:
  %0 = mul i64 %a, %b
  %1 = mul nuw i64 %a, %b
  %2 = mul nsw i64 %a, %b
  %3 =  mul nuw nsw i64 %a, %b
  %res = mul i64 %0, %1
  %res1 = mul i64 %2, %3
  ret i64 %res1
}

define i64 @udiv(i64 %a, i64 %b) {
entry:
  %0 = udiv i64 %a, %b
  %1 = udiv exact i64 %a, %b
  %res = mul i64 %0, %1
  ret i64 %res
}

define i64 @sdiv(i64 %a, i64 %b) {
entry:
  %0 = sdiv i64 %a, %b
  %1 = sdiv exact i64 %a, %b
  %res = mul i64 %0, %1
  ret i64 %res
}

define i64 @urem(i64 %a, i64 %b) {
entry:
  %0 = urem i64 %a, %b
  ret i64 %0
}

define i64 @srem(i64 %a, i64 %b) {
entry:
  %0 = srem i64 %a, %b
  ret i64 %0
}

define i64 @shl(i64 %a, i64 %b) {
entry:
  %0 = shl i64 %a, %b
  %1 = shl nuw i64 %a, %b
  %2 = shl nsw i64 %a, %b
  %3 = shl nuw nsw i64 %a, %b
  %res = shl i64 %0, %1
  %res1 = shl i64 %2, %3
  ret i64 %res1
}

define i64 @lshr(i64 %a, i64 %b) {
entry:
  %0 = lshr i64 %a, %b
  %1 = lshr exact i64 %a, %b
  %res = lshr i64 %0, %1
  ret i64 %res
}

define i64 @ashr(i64 %a, i64 %b) {
entry:
  %0 = ashr i64 %a, %b
  %1 = ashr exact i64 %a, %b
  %res = ashr i64 %0, %1
  ret i64 %res
}

define i64 @and(i64 %a, i64 %b) {
entry:
  %0 = and i64 %a, %b
  ret i64 %0
}

define i64 @or(i64 %a, i64 %b) {
entry:
  %0 = or i64 %a, %b
  ret i64 %0
}

define i64 @xor(i64 %a, i64 %b) {
entry:
  %0 = xor i64 %a, %b
  ret i64 %0
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @add(i64 %arg0, i64 %arg1)
  %out1 = call i64 @sub(i64 %arg0, i64 %arg1)
  %out2 = call i64 @mul(i64 %arg0, i64 %arg1)
  %out3 = call i64 @udiv(i64 %arg0, i64 %arg1)
  %out4 = call i64 @sdiv(i64 %arg0, i64 %arg1)
  %out5 = call i64 @urem(i64 %arg0, i64 %arg1)
  %out6 = call i64 @srem(i64 %arg0, i64 %arg1)
  %ou7 = call i64 @ashr(i64 %arg0, i64 %arg1)
  %out8 = call i64 @and(i64 %arg0, i64 %arg1)
  %out9 = call i64 @or(i64 %arg0, i64 %arg1)
  %out10 = call i64 @xor(i64 %arg0, i64 %arg1)
  %out11 = call i64 @xor(i64 %arg0, i64 %arg1)
  ret i64 %out11
}
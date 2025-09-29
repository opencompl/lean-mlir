; LLVM IR file containing various arithmetic operations used to test wether we can parse the
; generic MLIR dialect form of this in Lean-MLIR

; run : mlir-translate -import-llvm conversionLLVM.ll | mlir-opt --mlir-print-op-generic > conversionLLVM.mlir
; to the nrun the opt tool run: cd ../../../../ && lake exe opt SSA/Projects/LLVMRiscV/tests/Parsing/arithbb0.mlir 

;copy paste your mlir basic block and run lake exe opt SSA/Projects/LLVMRiscV/tests/Parsing/arithbb0.mlir
; from the root folder.
define i32 @trunc64to32(i64 %a) {
entry:
 %0 = trunc i64 %a to i32  
 %1 = trunc nsw i64 %a to i32   
 %2 = trunc nuw i64 %a to i32 
 %3 = trunc nuw nsw i64 %a to i32   
 %res = add i32 %0, %1
 %res1 = add i32 %2, %3
 ret i32 %res1
}

define i8 @trunc32to8(i32 %a) {
entry:
 %0 = trunc i32 %a to i8
 %1 = trunc nsw i32 %a to i8
 %2 = trunc nuw i32 %a to i8
 %3 = trunc nuw nsw i32 %a to i8  
 %res = add i8 %0, %1
 %res1 = add i8 %2, %3
 ret i8 %res1
}

define i16 @trunc32to16(i32 %a) {
entry:
 %0 = trunc i32 %a to i16
 %1 = trunc nsw i32 %a to i16
 %2 = trunc nuw i32 %a to i16
 %3 = trunc nuw nsw i32 %a to i16 
 %res = add i16 %0, %1
 %res1 = add i16 %2, %3
 ret i16 %res1
}

define i64 @zext1(i1 %a) {
entry:
 %0 = zext i1 %a to i8
 %1 = zext i1 %a to i16
 %2 = zext i1 %a to i32
 %3 = zext i1 %a to i64
 ret i64 %3
}
define i64 @zext8(i8 %a) {
entry:
 %1 = zext i8 %a to i16
 %2 = zext i8 %a to i32
 %3 = zext i8 %a to i64
 ret i64 %3
}

define i64 @zext16(i16 %a) {
entry:
 %2 = zext i16 %a to i32
 %3 = zext i16 %a to i64
 ret i64 %3
}

define i64 @sext1(i1 %a) {
entry:
 %0 = sext i1 %a to i8
 %1 = sext i1 %a to i16
 %2 = sext i1 %a to i32
 %3 = sext i1 %a to i64
 ret i64 %3
}
define i64 @sext8(i8 %a) {
entry:
 %1 = sext i8 %a to i16
 %2 = sext i8 %a to i32
 %3 = sext i8 %a to i64
 ret i64 %3
}

define i64 @sext16(i16 %a) {
entry:
 %2 = sext i16 %a to i32
 %3 = sext i16 %a to i64
 ret i64 %3
}

 define i32 @main(i64 %arg0, i32 %arg1, i1 %arg2, i8 %arg3 , i16 %arg4) {
  %out = call i32 @trunc64to32(i64 %arg0)
  %out1 = call i8 @trunc32to8(i32 %arg1)
  %out2 = call i16 @trunc32to16(i32 %arg1)
  %out3 = call i64 @zext1(i1 %arg2)
  %out4 = call i64 @zext8(i8 %arg3)
  %out5 = call i64 @zext16(i16 %arg4)
  %out6 = call i64 @sext1(i1 %arg2)
  %out7 = call i64 @sext8(i8 %arg3)
  %out8 = call i64 @sext16(i16 %arg4)
  ret i32 %out
}
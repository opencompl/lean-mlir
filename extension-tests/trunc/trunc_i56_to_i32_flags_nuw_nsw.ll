
define i32 @main(i56 %0) {
  %2 = trunc nuw nsw i56 %0 to i32
  ret i32 %2
}

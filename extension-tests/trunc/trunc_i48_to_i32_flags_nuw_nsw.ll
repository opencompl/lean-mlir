
define i32 @main(i48 %0) {
  %2 = trunc nuw nsw i48 %0 to i32
  ret i32 %2
}

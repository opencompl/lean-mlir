
define i8 @main(i52 %0) {
  %2 = trunc nuw nsw i52 %0 to i8
  ret i8 %2
}

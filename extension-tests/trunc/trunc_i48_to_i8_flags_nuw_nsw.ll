
define i8 @main(i48 %0) {
  %2 = trunc nuw nsw i48 %0 to i8
  ret i8 %2
}

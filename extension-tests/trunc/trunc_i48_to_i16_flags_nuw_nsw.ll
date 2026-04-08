
define i16 @main(i48 %0) {
  %2 = trunc nuw nsw i48 %0 to i16
  ret i16 %2
}

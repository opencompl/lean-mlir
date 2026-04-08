
define i1 @main(i16 %0) {
  %2 = trunc nuw nsw i16 %0 to i1
  ret i1 %2
}

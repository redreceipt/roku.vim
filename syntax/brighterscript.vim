if exists("b:current_syntax")
  finish
endif

syntax keyword bsKeyword class const enum function import namespace sub
syntax keyword bsConditional if else elseif then endif
syntax keyword bsLoop for each while end for
syntax keyword bsOperator and or not
syntax keyword bsSpecial @logOnException()

syntax match bsString /".*"/
syntax match bsComment /'.*$/

highlight link bsKeyword Keyword
highlight link bsConditional Conditional
highlight link bsLoop Repeat
highlight link bsOperator Operator
highlight link bsString String
highlight link bsComment Comment
highlight link bsSpecial Special

let b:current_syntax = "brighterscript"

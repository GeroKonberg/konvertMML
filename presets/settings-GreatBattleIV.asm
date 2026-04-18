;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $3BF0
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readV132.asm"
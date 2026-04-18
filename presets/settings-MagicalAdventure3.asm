;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $2BFE
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readV132.asm"
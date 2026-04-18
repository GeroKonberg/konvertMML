;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $2500
!OutAddr = $7000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readV132.asm"
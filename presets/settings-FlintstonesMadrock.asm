;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $2350
!OutAddr = $8000
!ProgAddr = $F000

!ReadIndex = $02

incsrc "asm/readV132.asm"
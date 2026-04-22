;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $BB00
!OutAddr = $0200
!ProgAddr = $AB00

!ReadIndex = $02

incsrc "asm/readV120.asm"
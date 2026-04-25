;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $DD30
!OutAddr = $0200
!ProgAddr = $B000

!ReadIndex = $02

incsrc "asm/readV120.asm"
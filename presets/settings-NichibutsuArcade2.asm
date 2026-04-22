;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $B800
!OutAddr = $0200
!ProgAddr = $A800

!ReadIndex = $02

incsrc "asm/readV120.asm"
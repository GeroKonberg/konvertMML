;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $D2DC
!OutAddr = $0200
!ProgAddr = $B000

!ReadIndex = $02

incsrc "asm/readV120.asm"
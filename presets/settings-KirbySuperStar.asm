;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $3900
!OutAddr = $8000
!ProgAddr = $F000

!ReadIndex = $73

incsrc "asm/readV120.asm"
;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $19EC
!OutAddr = $0200
!ProgAddr = $C000

!ReadIndex = $01

incsrc "asm/readVACC.asm"
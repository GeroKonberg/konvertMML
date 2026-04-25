;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $E080
!OutAddr = $0200
!ProgAddr = $C000

!ReadIndex = $01

incsrc "asm/readVACC.asm"
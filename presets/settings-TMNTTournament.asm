;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0A0D
!OutAddr = $6000
!ProgAddr = $F000

!ReadIndex = $01

incsrc "asm/readVKon2b6.asm"
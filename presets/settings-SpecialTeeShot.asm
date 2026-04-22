;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $25E0
!OutAddr = $2600
!ProgAddr = $1500

!ReadIndex = $01

incsrc "asm/readV120.asm"
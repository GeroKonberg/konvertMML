;konvertMML settings
!ReadFile = "input.spc"

!ReadAddr = $0690
!OutAddr = $1000
!ProgAddr = $C000

!ReadIndex = $16

incsrc "asm/readVCube.asm"
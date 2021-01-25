{$if defined(samd21e18a) }
  type
    TUARTTXPins = (
      NONE_USART = TNativePin.None
      ,PA8_USART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      ,PA16_USART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      ,PA22_USART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      ,PA10_USART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      ,PA14_USART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      ,PA18_USART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      ,PA24_USART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      ,PA0_USART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      ,PA4_USART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      ,PA8_USART2_PAD0 = MuxD or PAD0 or TNativePin.PA8
      ,PA16_USART3_PAD0 = MuxD or PAD0 or TNativePin.PA16
      ,PA6_USART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      ,PA10_USART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      ,PA18_USART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      ,PA30_USART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
    );
    TUARTRXPins = (
      NONE_USART = TNativePin.None
      ,PA8_USART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      ,PA16_USART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      ,PA22_USART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      ,PA9_USART0_PAD1 = MuxC or PAD1 or TNativePin.PA9
      ,PA17_USART1_PAD1 = MuxC or PAD1 or TNativePin.PA17
      ,PA23_USART3_PAD1 = MuxC or PAD1 or TNativePin.PA23
      ,PA10_USART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      ,PA14_USART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      ,PA18_USART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      ,PA24_USART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      ,PA11_USART0_PAD3 = MuxC or PAD3 or TNativePin.PA11
      ,PA15_USART2_PAD3 = MuxC or PAD3 or TNativePin.PA15
      ,PA19_USART1_PAD3 = MuxC or PAD3 or TNativePin.PA19
      ,PA25_USART3_PAD3 = MuxC or PAD3 or TNativePin.PA25
      ,PA0_USART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      ,PA4_USART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      ,PA8_USART2_PAD0 = MuxD or PAD0 or TNativePin.PA8
      ,PA16_USART3_PAD0 = MuxD or PAD0 or TNativePin.PA16
      ,PA1_USART1_PAD1 = MuxD or PAD1 or TNativePin.PA1
      ,PA5_USART0_PAD1 = MuxD or PAD1 or TNativePin.PA5
      ,PA9_USART2_PAD1 = MuxD or PAD1 or TNativePin.PA9
      ,PA17_USART3_PAD1 = MuxD or PAD1 or TNativePin.PA17
      ,PA6_USART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      ,PA10_USART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      ,PA18_USART3_PAD2 = MuxD or PAD2 or TNativePin.PA18
      ,PA30_USART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      ,PA7_USART0_PAD3 = MuxD or PAD3 or TNativePin.PA7
      ,PA11_USART2_PAD3 = MuxD or PAD3 or TNativePin.PA11
      ,PA19_USART3_PAD3 = MuxD or PAD3 or TNativePin.PA19
      ,PA31_USART1_PAD3 = MuxD or PAD3 or TNativePin.PA31
    );
{$endif}
{$if defined(samd21g18a) }
  type
    TUARTTXPins = (
      NONE_USART = TNativePin.None
      ,PA8_USART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      ,PA12_USART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      ,PA16_USART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      ,PA22_USART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      ,PA10_USART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      ,PA14_USART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      ,PA18_USART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      ,PA20_USART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      ,PA24_USART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      ,PA0_USART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      ,PA4_USART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      ,PA8_USART2_PAD0 = MuxD or PAD0 or TNativePin.PA8
      ,PA16_USART3_PAD0 = MuxD or PAD0 or TNativePin.PA16
      ,PB2_USART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      ,PB8_USART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      ,PA6_USART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      ,PA10_USART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      ,PA20_USART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      ,PA30_USART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      ,PB10_USART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      ,PB22_USART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
    );
    TUARTRXPins = (
      NONE_USART = TNativePin.None
      ,PA8_USART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      ,PA12_USART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      ,PA16_USART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      ,PA22_USART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      ,PA9_USART0_PAD1 = MuxC or PAD1 or TNativePin.PA9
      ,PA13_USART2_PAD1 = MuxC or PAD1 or TNativePin.PA13
      ,PA17_USART1_PAD1 = MuxC or PAD1 or TNativePin.PA17
      ,PA23_USART3_PAD1 = MuxC or PAD1 or TNativePin.PA23
      ,PA10_USART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      ,PA14_USART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      ,PA18_USART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      ,PA20_USART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      ,PA24_USART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      ,PA11_USART0_PAD3 = MuxC or PAD3 or TNativePin.PA11
      ,PA15_USART2_PAD3 = MuxC or PAD3 or TNativePin.PA15
      ,PA19_USART1_PAD3 = MuxC or PAD3 or TNativePin.PA19
      ,PA21_USART5_PAD3 = MuxC or PAD3 or TNativePin.PA21
      ,PA25_USART3_PAD3 = MuxC or PAD3 or TNativePin.PA25
      ,PA0_USART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      ,PA4_USART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      ,PA8_USART2_PAD0 = MuxD or PAD0 or TNativePin.PA8
      ,PA16_USART3_PAD0 = MuxD or PAD0 or TNativePin.PA16
      ,PB2_USART5_PAD0 = MuxD or PAD0 or TNativePin.PB2
      ,PB8_USART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      ,PA1_USART1_PAD1 = MuxD or PAD1 or TNativePin.PA1
      ,PA5_USART0_PAD1 = MuxD or PAD1 or TNativePin.PA5
      ,PA9_USART2_PAD1 = MuxD or PAD1 or TNativePin.PA9
      ,PA17_USART3_PAD1 = MuxD or PAD1 or TNativePin.PA17
      ,PB3_USART5_PAD1 = MuxD or PAD1 or TNativePin.PB3
      ,PB9_USART4_PAD1 = MuxD or PAD1 or TNativePin.PB9
      ,PA6_USART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      ,PA10_USART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      ,PA20_USART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      ,PA30_USART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      ,PB10_USART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      ,PB22_USART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
      ,PA7_USART0_PAD3 = MuxD or PAD3 or TNativePin.PA7
      ,PA11_USART2_PAD3 = MuxD or PAD3 or TNativePin.PA11
      ,PA21_USART3_PAD3 = MuxD or PAD3 or TNativePin.PA21
      ,PA31_USART1_PAD3 = MuxD or PAD3 or TNativePin.PA31
      ,PB11_USART4_PAD3 = MuxD or PAD3 or TNativePin.PB11
      ,PB23_USART5_PAD3 = MuxD or PAD3 or TNativePin.PB23
    );
{$endif}
{$if defined(samd21j18a) }
  type
    TUARTTXPins = (
      NONE_USART = TNativePin.None
      ,PA8_USART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      ,PA12_USART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      ,PA16_USART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      ,PA22_USART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      ,PB12_USART4_PAD0 = MuxC or PAD0 or TNativePin.PB12
      ,PB16_USART5_PAD0 = MuxC or PAD0 or TNativePin.PB16
      ,PA10_USART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      ,PA14_USART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      ,PA18_USART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      ,PA20_USART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      ,PA24_USART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      ,PB14_USART4_PAD2 = MuxC or PAD2 or TNativePin.PB14
      ,PA0_USART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      ,PA4_USART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      ,PA8_USART2_PAD0 = MuxD or PAD0 or TNativePin.PA8
      ,PA16_USART3_PAD0 = MuxD or PAD0 or TNativePin.PA16
      ,PB8_USART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      ,PB30_USART5_PAD0 = MuxD or PAD0 or TNativePin.PB30
      ,PA6_USART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      ,PA10_USART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      ,PA20_USART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      ,PA30_USART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      ,PB10_USART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      ,PB22_USART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
    );
    TUARTRXPins = (
      NONE_USART = TNativePin.None
      ,PA8_USART0_PAD0 = MuxC or PAD0 or TNativePin.PA8
      ,PA12_USART2_PAD0 = MuxC or PAD0 or TNativePin.PA12
      ,PA16_USART1_PAD0 = MuxC or PAD0 or TNativePin.PA16
      ,PA22_USART3_PAD0 = MuxC or PAD0 or TNativePin.PA22
      ,PB12_USART4_PAD0 = MuxC or PAD0 or TNativePin.PB12
      ,PB16_USART5_PAD0 = MuxC or PAD0 or TNativePin.PB16
      ,PA9_USART0_PAD1 = MuxC or PAD1 or TNativePin.PA9
      ,PA13_USART2_PAD1 = MuxC or PAD1 or TNativePin.PA13
      ,PA17_USART1_PAD1 = MuxC or PAD1 or TNativePin.PA17
      ,PA23_USART3_PAD1 = MuxC or PAD1 or TNativePin.PA23
      ,PB13_USART4_PAD1 = MuxC or PAD1 or TNativePin.PB13
      ,PB17_USART5_PAD1 = MuxC or PAD1 or TNativePin.PB17
      ,PA10_USART0_PAD2 = MuxC or PAD2 or TNativePin.PA10
      ,PA14_USART2_PAD2 = MuxC or PAD2 or TNativePin.PA14
      ,PA18_USART1_PAD2 = MuxC or PAD2 or TNativePin.PA18
      ,PA20_USART5_PAD2 = MuxC or PAD2 or TNativePin.PA20
      ,PA24_USART3_PAD2 = MuxC or PAD2 or TNativePin.PA24
      ,PB14_USART4_PAD2 = MuxC or PAD2 or TNativePin.PB14
      ,PA11_USART0_PAD3 = MuxC or PAD3 or TNativePin.PA11
      ,PA15_USART2_PAD3 = MuxC or PAD3 or TNativePin.PA15
      ,PA19_USART1_PAD3 = MuxC or PAD3 or TNativePin.PA19
      ,PA21_USART5_PAD3 = MuxC or PAD3 or TNativePin.PA21
      ,PA25_USART3_PAD3 = MuxC or PAD3 or TNativePin.PA25
      ,PB15_USART4_PAD3 = MuxC or PAD3 or TNativePin.PB15
      ,PA0_USART1_PAD0 = MuxD or PAD0 or TNativePin.PA0
      ,PA4_USART0_PAD0 = MuxD or PAD0 or TNativePin.PA4
      ,PA8_USART2_PAD0 = MuxD or PAD0 or TNativePin.PA8
      ,PA16_USART3_PAD0 = MuxD or PAD0 or TNativePin.PA16
      ,PB8_USART4_PAD0 = MuxD or PAD0 or TNativePin.PB8
      ,PB30_USART5_PAD0 = MuxD or PAD0 or TNativePin.PB30
      ,PA1_USART1_PAD1 = MuxD or PAD1 or TNativePin.PA1
      ,PA5_USART0_PAD1 = MuxD or PAD1 or TNativePin.PA5
      ,PA9_USART2_PAD1 = MuxD or PAD1 or TNativePin.PA9
      ,PA17_USART3_PAD1 = MuxD or PAD1 or TNativePin.PA17
      ,PB9_USART4_PAD1 = MuxD or PAD1 or TNativePin.PB9
      ,PB31_USART5_PAD1 = MuxD or PAD1 or TNativePin.PB31
      ,PA6_USART0_PAD2 = MuxD or PAD2 or TNativePin.PA6
      ,PA10_USART2_PAD2 = MuxD or PAD2 or TNativePin.PA10
      ,PA20_USART3_PAD2 = MuxD or PAD2 or TNativePin.PA20
      ,PA30_USART1_PAD2 = MuxD or PAD2 or TNativePin.PA30
      ,PB10_USART4_PAD2 = MuxD or PAD2 or TNativePin.PB10
      ,PB22_USART5_PAD2 = MuxD or PAD2 or TNativePin.PB22
      ,PA7_USART0_PAD3 = MuxD or PAD3 or TNativePin.PA7
      ,PA11_USART2_PAD3 = MuxD or PAD3 or TNativePin.PA11
      ,PA21_USART3_PAD3 = MuxD or PAD3 or TNativePin.PA21
      ,PA31_USART1_PAD3 = MuxD or PAD3 or TNativePin.PA31
      ,PB11_USART4_PAD3 = MuxD or PAD3 or TNativePin.PB11
      ,PB23_USART5_PAD3 = MuxD or PAD3 or TNativePin.PB23
    );
{$endif}
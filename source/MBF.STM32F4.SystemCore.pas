unit MBF.STM32F4.SystemCore;
{
  This file is part of Pascal Microcontroller Board Framework (MBF)
  Copyright (c) 2015 -  Michael Ring
  based on Pascal eXtended Library (PXL)
  Copyright (c) 2000 - 2015  Yuriy Kotsarenko

  This program is free software: you can redistribute it and/or modify it under the terms of the FPC modified GNU
  Library General Public License for more

  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the FPC modified GNU Library General Public
  License for more details.
}
{
  Related Reference Manuals

  STM32F405415, STM32F407417, STM32F427437 and STM32F429439 advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00031020.pdf

  STM32F401xBC and STM32F401xDE advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00096844.pdf

  STM32F411xCE advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00119316.pdf

  STM32F446xx advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00135183.pdf

  STM32F469xx and STM32F479xx advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00127514.pdf

  STM32F410 advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00180366.pdf

  STM32F412 advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00180369.pdf

  STM32F413423 advanced Arm
  http://www.st.com/resource/en/reference_manual/DM00305666.pdf
}

interface

{$INCLUDE MBF.Config.inc}

{$DEFINE INTERFACE}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF INTERFACE}

{$if defined(STM32F401)}
const
  MaxCPUFrequency=84000000;
  APB1MaxFrequency=MaxCPUFrequency div 2;
  APB2MaxFrequency=MaxCPUFrequency;
  PLLVCOMinFrequency=192000000;
  PLLVCOMaxFrequency=432000000;
  PLLINMinFrequency=1000000;
  PLLINMaxFrequency=2000000;
  PLLNMIN=192;
  PLLNMAX=432;
{$elseif defined(STM32F410) or defined(STM32F411) or defined(STM32F412) or defined(STM32F413) or defined(STM32F423)}
const
  MaxCPUFrequency=100000000;
  APB1MaxFrequency=MaxCPUFrequency div 2;
  APB2MaxFrequency=MaxCPUFrequency;
  PLLVCOMinFrequency=192000000;
  PLLVCOMaxFrequency=432000000;
  PLLINMinFrequency=1000000;
  PLLINMaxFrequency=2000000;
  PLLNMIN=50;
  PLLNMAX=432;
{$elseif defined(STM32F405_415) or defined(STM32F407_417)}
const
  MaxCPUFrequency=168000000;
  APB1MaxFrequency=MaxCPUFrequency div 2;
  APB2MaxFrequency=MaxCPUFrequency;
  PLLVCOMinFrequency=192000000;
  PLLVCOMaxFrequency=432000000;
  PLLINMinFrequency=1000000;
  PLLINMaxFrequency=2000000;
  PLLNMIN=50;
  PLLNMAX=432;
{$elseif defined(STM32F427_437) or defined(STM32F429_439)
      or defined(STM32F446) or defined(STM32F469_479)}
const
  MaxCPUFrequency=180000000;
  APB1MaxFrequency=MaxCPUFrequency div 2;
  APB2MaxFrequency=MaxCPUFrequency;
  PLLVCOMinFrequency=192000000;
  PLLVCOMaxFrequency=432000000;
  PLLINMinFrequency=1000000;
  PLLINMaxFrequency=2000000;
  PLLNMIN=100;
  PLLNMAX=432;
{$else}
  {$error Unknown Chip series, please define maximum CPU Frequency}
{$endif}

const
  HSIClockFrequency = 16000000;
  LSIClockFreq = 32768;

var
  HSEClockFrequency : longWord = 0;
  XTALRTCFreq : longword = 32768;

type
  TClockType = (HSI,HSE,PLLHSI,PLLHSE);

type
  TOSCParameters = record
    FREQUENCY : longWord;
    PLLM : byte;
    PLLN : word;
    PLLP : byte;
    PLLQ : byte;
    PLLR : byte;
    AHBPRE : byte;
    APB1PRE : byte;
    APB2PRE : byte;
  end;

type
  TSTM32SystemCore = record helper for TSystemCore
  private
    procedure ConfigureSystem;
    function GetFrequencyParameters(aHCLKFrequency : longWord;aClockType : TClockType):TOSCParameters;
    function GetSysTickClockFrequency : longWord;
    function GetHCLKFrequency : longWord;
  public
    procedure Initialize;
    function GetSYSCLKFrequency: longWord;
    function GetAPB1PeripheralClockFrequency : longWord;
    function GetAPB1TimerClockFrequency : longWord;
    function GetAPB2PeripheralClockFrequency : longWord;
    function GetAPB2TimerClockFrequency : longWord;
    procedure SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.PLLHSI);
    procedure SetCPUFrequency(const Params: TOscParameters; aClockType : TClockType = TClockType.PLLHSI);
    function GetCPUFrequency: longWord;
    function getMaxCPUFrequency : longWord;
  end;

var
  SystemCore : TSystemCore;
  //This var is needed to communicate CPU Speed to FreeRTOS
  SystemCoreClock : uint32; cvar;

implementation

uses
  FreeRTOS,
  MBF.BitHelpers;

{$DEFINE IMPLEMENTATION}
{$INCLUDE MBF.ARM.SystemCore.inc}
{$UNDEF IMPLEMENTATION}

{$REGION 'TSystemCore'}

const
  AHBDividers : array[0..15] of word =(1,1,1,1,1,1,1,1,2,4,8,16,64,128,256,512);
  APBDividers : array[0..7] of byte = (1,1,1,1,2,4,8,16);

function TSTM32SystemCore.GetSYSCLKFrequency : longWord;
begin
  case GetCrumb(RCC.CFGR,2) of
    0:  //HSI used as system clock
        Result := HSIClockFrequency;
    1:  //HSE used as system clock
        Result := HSEClockFrequency;
    2:  //PLL used as system clock;
        begin
          case GetBit(RCC.PLLCFGR,22) of
            0: Result := HSIClockFrequency;
            1: Result := HSEClockFrequency;
          end;
          Result := Result div getBitsMasked(RCC.PLLCFGR,%111111 shl 0,0); //PLLM
          Result := Result * getBitsMasked(RCC.PLLCFGR,%111111111 shl 6,6);//PLLN;
          Result := Result div ((getCrumb(RCC.PLLCFGR,16) shl 1)+2);
        end;
    else
      Result := 0;
  end;
end;

function TSTM32SystemCore.GetHCLKFrequency : longWord;
begin
  Result := getSYSCLKFrequency div AHBDividers[getNibble(RCC.CFGR,4)];
end;

function TSTM32SystemCore.GetSysTickClockFrequency : longWord; [public, alias: 'MBF_GetSysTickClockFrequency'];
begin
  Result := GetHCLKFrequency;
  if GetBit(SysTick.CTRL,2) = 0 then
    Result := Result div 8;
end;

function TSTM32SystemCore.GetAPB1PeripheralClockFrequency : longWord;
begin
  Result := GetHCLKFrequency div APBDividers[getBitsMasked(RCC.CFGR,%111 shl 10,10)];
end;

function TSTM32SystemCore.GetAPB1TimerClockFrequency : longWord;
begin
  Result := GetHCLKFrequency div APBDividers[getBitsMasked(RCC.CFGR,%111 shl 10,10)];
  if APBDividers[getBitsMasked(RCC.CFGR,%111 shl 10,10)] >1 then
    Result := Result shl 1;

  if getBit(RCC.DCKCFGR,24)  = 0 then
  begin
    if APBDividers[getBitsMasked(RCC.CFGR,%111 shl 10,10)] = 1 then
      Result := GetAPB1PeripheralClockFrequency
    else
      Result := GetAPB1PeripheralClockFrequency*2;
  end
  else
    if APBDividers[getBitsMasked(RCC.CFGR,%111 shl 10,10)] <= 2 then
      Result := GetAPB1PeripheralClockFrequency
    else
      Result := GetAPB1PeripheralClockFrequency*4;
end;

function TSTM32SystemCore.GetAPB2PeripheralClockFrequency : longWord;
begin
  Result := GetHCLKFrequency div APBDividers[getBitsMasked(RCC.CFGR,%111 shl 13,13)];
end;

function TSTM32SystemCore.GetAPB2TimerClockFrequency : longWord;
begin
  Result := GetHCLKFrequency div APBDividers[getBitsMasked(RCC.CFGR,%111 shl 13,13)];
  if APBDividers[getBitsMasked(RCC.CFGR,%111 shl 13,13)] >1 then
    Result := Result shl 1;

  if getBit(RCC.DCKCFGR,24)  = 0 then
  begin
    if APBDividers[getBitsMasked(RCC.CFGR,%111 shl 13,13)] = 1 then
      Result := GetAPB2PeripheralClockFrequency
    else
      Result := GetAPB2PeripheralClockFrequency*2;
  end
  else
    if APBDividers[getBitsMasked(RCC.CFGR,%111 shl 13,13)] <= 2 then
      Result := GetAPB2PeripheralClockFrequency
    else
      Result := GetAPB2PeripheralClockFrequency*4;
end;

procedure TSTM32SystemCore.Initialize;
begin
  ConfigureSystem;
  ConfigureTimer;
end;

procedure TSTM32SystemCore.ConfigureSystem;
begin
  //PWR Enable PWR Subsystem Clock
  setBit(RCC.APB1ENR,28);
  //Read back value for a short delay
  getBit(RCC.APB1ENR,28);

  //Set Regulator to full power
  setCrumb(PWR.CR,%10,14);
  //Read back value for a short delay
  repeat
  until getCrumb(PWR.CR,14) = %10;
end;

function TSTM32SystemCore.getFrequencyParameters(aHCLKFrequency : longWord;aClockType : TClockType):TOSCParameters;
var
  AHBPRE : byte;
  PLLM : byte;
  PLLN : word;
  PLLP : byte;
  LastError : longWord;
  PLLOutFrequency : longWord;
  PLLInFrequency,SysClockFrequency,HCLKFrequency : longWord;
begin
  FillChar(Result,sizeof(Result),0);

  if aHCLKFrequency > MaxCPUFrequency then
    aHCLKFrequency := MaxCPUFrequency;

  LastError := aHCLKFrequency;

  case aClockType of
    TClockType.HSI:
    begin
      SysClockFrequency := HSIClockFrequency;
      Result.AHBPRE := 15;
      for AHBPRE := 7 to 15 do
      begin
        HCLKFrequency := SysClockFrequency div AHBDividers[AHBPRE];
        if HCLKFrequency <= aHCLKFrequency then
        begin
          Result.AHBPRE := AHBPRE;
          break;
        end;
      end;
      Result.Frequency := SysClockFrequency div AHBDividers[AHBPRE];
    end;
    TClockType.HSE:
    begin
      Result.AHBPRE := 15;
      for AHBPRE := 7 to 15 do
      begin
        SysClockFrequency := HSEClockFrequency;
        HCLKFrequency := SysClockFrequency div AHBDividers[AHBPRE];
        if HCLKFrequency <= aHCLKFrequency then
        begin
          Result.AHBPRE := AHBPRE;
          break;
        end;
      end;
      Result.Frequency := SysClockFrequency div AHBDividers[AHBPRE];
    end
  else
    begin
      if aClockType = TClockType.PLLHSI then
        SysClockFrequency := HSIClockFrequency
      else
        SysClockFrequency := HSEClockFrequency;

      for PLLM := 2 to 63 do
      begin
        PLLInFrequency := SysClockFrequency div PLLM;
        if (PLLInFrequency >=PLLINMinFrequency) and (PLLInFrequency <=PLLInMaxFrequency) then
        begin
          for PLLN := PLLNMIN to PLLNMAX do
          begin
            PLLOUTFrequency := PLLInFrequency * PLLN;
            if (PLLOUTFrequency < PLLVCOMinFrequency) or (PLLOUTFrequency > PLLVCOMaxFrequency) then
              continue;
            for PLLP := 0 to 3 do
            begin
              for AHBPRE := 0 to 7 do
              begin
                HCLKFrequency := PLLOutFrequency div ((PLLP shl 1)+2) div AHBDividers[AHBPRE];
                if HCLKFrequency > MaxCPUFrequency then
                  continue;
                // Only replace Parameters when Results are actually better to make sure in VCO In-Frequency is as high as possible
                if LastError > Abs(aHCLKFrequency-HCLKFrequency) then
                begin
                  LastError := Abs(aHCLKFrequency-HCLKFrequency);
                  Result.Frequency := HCLKFrequency;
                  Result.AHBPRE := AHBPRE;
                  Result.PLLM := PLLM;
                  Result.PLLN := PLLN;
                  Result.PLLP := PLLP; //Main
                  Result.PLLQ := 2; //USB
                  Result.PLLR := 2; //I2S
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  if Result.AHBPRE = 7 then
    Result.AHBPRE := 0;
  Result.APB1PRE := 0;
  if (Result.Frequency div 2) > APB1MaxFrequency then
    Result.APB1PRE:=5;
  if Result.Frequency > APB1MaxFrequency then
    Result.APB1PRE:=4;

  if Result.Frequency > APB2MaxFrequency then
    Result.APB2PRE:=4
  else
    Result.APB2PRE:=0;
end;

procedure TSTM32SystemCore.SetCPUFrequency(const Value: longWord; aClockType : TClockType = TClockType.PLLHSI);
begin
  SetCPUFrequency(getFrequencyParameters(Value,aClockType),aClockType);
end;

procedure TSTM32SystemCore.SetCPUFrequency(const Params: TOscParameters; aClockType : TClockType = TClockType.PLLHSI);
var
  WaitStates : byte;
begin
  //Make sure that HSI Clock is enabled
  if GetBit(RCC.CR,0) = 0 then
    SetBit(RCC.CR,0);

  //Wait for HSI Clock to be stable
  WaitBitIsSet(RCC.CR,1);

  // Switch to HSI Clock
  if GetCrumb(RCC.CFGR,2) <> byte(TClockType.HSI) then
    SetCrumb(RCC.CFGR,byte(TClockType.HSI),0);

  //Wait until HSI Clock is activated
  repeat
  until getCrumb(RCC.CFGR,2) = byte(TClockType.HSI);

  //PLLON Disable PLL if active
  if GetBit(RCC.CR,24) = 1 then
  begin
    clearBit(RCC.CR,24);
    //PLLRDY Wait for PLL to shut down
    WaitBitIsCleared(RCC.CR,25);
  end;

  //Set Flash Waitstates
  if Params.Frequency >= 150000000 then
    WaitStates := 5
  else if Params.Frequency >= 120000000 then
    WaitStates := 4
  else if Params.Frequency >= 90000000 then
    WaitStates := 3
  else if Params.Frequency >= 60000000 then
    WaitStates := 2
  else if Params.Frequency >= 30000000 then
    WaitStates := 1
  else
    WaitStates := 0;

  SetNibble(FLASH.ACR,WaitStates,0);
  // Wait until Waitstates are set
  repeat
  until getNibble(FLASH.ACR,0) = WaitStates;

  // Set AHB Prescaler
  SetNibble(RCC.CFGR,Params.AHBPRE,4);
  repeat
  until GetNibble(RCC.CFGR,4) = Params.AHBPRE;

  SetBitsMasked(RCC.CFGR,Params.APB1PRE,%111 shl 10,10);
  repeat
  until GetBitsMasked(RCC.CFGR,%111 shl 10,10) = Params.APB1PRE;

  SetBitsMasked(RCC.CFGR,Params.APB2PRE,%111 shl 13,13);
  repeat
  until GetBitsMasked(RCC.CFGR,%111 shl 13,13) = Params.APB2PRE;

  case aClockType of
    TClockType.HSI :
    begin
      SetCrumb(RCC.CFGR,byte(TClockType.HSI),0);
      repeat
      until GetCrumb(RCC.CFGR,2) = byte(TClockType.HSI);
    end;
    TClockType.HSE :
    begin
      // Turn on HSE
      setBit(RCC.CR,16);
      WaitBitIsSet(RCC.CR,17);
      // Switch to HSE
      SetCrumb(RCC.CFGR,byte(TClockType.HSE),0);
      repeat
      until GetCrumb(RCC.CFGR,2) = byte(TClockType.HSE);
    end;
    TClockType.PLLHSI,TClockType.PLLHSE:
    begin
      if aClockType = TClockType.PLLHSI then
        ClearBit(RCC.PLLCFGR,22)
      else
      begin
        // Turn on HSE
        setBit(RCC.CR,16);
        WaitBitIsSet(RCC.CR,17);
        SetBit(RCC.PLLCFGR,22);
      end;

      // PLLM
      SetBitsMasked(RCC.PLLCFGR,Params.PLLM,%111111,0);
      // PLLN
      SetBitsMasked(RCC.PLLCFGR,Params.PLLN,%111111111 shl 6,6);
      // TODO Handle Case when PLLN = 0
      // PLLP
      SetCrumb(RCC.PLLCFGR,Params.PLLP,16);
      // PLLQ
      SetNibble(RCC.PLLCFGR,Params.PLLQ,24);
      // PLLR
      SetBitsMasked(RCC.PLLCFGR,Params.PLLR,%111 shl 28,28);
      SetBit(RCC.PLLCFGR,24);

      //PLLON Enable PLL
      setBit(RCC.CR,24);

      //PLLRDY Wait for PLL to lock
      WaitBitIsSet(RCC.CR,25);

      //Enable PLL
      setCrumb(RCC.CFGR,byte(TClockType.PLLHSI),0);

      //Wait for PLL Switch
      repeat
      until getCrumb(RCC.CFGR,2) = byte(TClockType.PLLHSI);
    end;
  end;
  SystemCoreClock := getHCLKFrequency;
  ConfigureTimer;
end;

function TSTM32SystemCore.GetCPUFrequency : longWord;
begin
  Result := getHCLKFrequency;
end;

function TSTM32SystemCore.GetMaxCPUFrequency : longWord;
begin
  Result := MaxCPUFrequency;
end;

{$ENDREGION}

begin
  SystemCoreClock := HSIClockFrequency;
end.

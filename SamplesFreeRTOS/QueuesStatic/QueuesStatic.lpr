program QueuesStatic;
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

{$INCLUDE MBF.Config.inc}

uses
  MBF.Types,
  MBF.__CONTROLLERTYPE__.SystemCore,
  freertos,
  SeggerRTT;

var
  Queue1Handle : TQueueHandle;

procedure Task1({%H-}pvParameters:pointer);
var
  ByteToSend : byte;
  i : integer;
begin
  ByteToSend := 32;
  SEGGER_RTT_WriteString(0,'Task 1 running'#13#10);
  SEGGER_RTT_WriteString(0,'Filling up Queue'#13#10);
  for i := 1 to 10 do
    xQueueSend(Queue1Handle,@ByteToSend,10);
  SEGGER_RTT_WriteString(0,'Now trying to write to full queue'#13#10);
  for i := 1 to 10 do
  begin
    SEGGER_RTT_WriteString(0,'Writing char to queue'#13#10);
    xQueueSend(Queue1Handle,@ByteToSend,2000);
  end;
  SEGGER_RTT_WriteString(0,'Work done, deleting task'#13#10);
  vTaskDelete(nil);
end;

procedure Task2({%H-}pvParameters:pointer);
var
  ByteToReceive : byte;
begin
  while true do
  begin
    SEGGER_RTT_WriteString(0,'Task 2 running'#13#10);
    SEGGER_RTT_WriteString(0,'Task 2 sleeping for a second'#13#10);
    SystemCore.Delay(1000);
    while xQueueReceive(Queue1Handle,@ByteToReceive,1000)=pdTrue do
      SEGGER_RTT_WriteString(0,'Successfully received char'#13#10);
    SEGGER_RTT_WriteString(0,'Receive Queue timed out'#13#10);
  end;
  //In case we ever break out the while loop the task must end itself
  vTaskDelete(nil);
end;

var
  Task1Handle : TTaskHandle;
  Task1Stack : array[1..configMINIMAL_STACK_SIZE] of TStackType;
  Task1TCB : TStaticTask;
  Task2Handle : TTaskHandle;
  Task2Stack : array[1..configMINIMAL_STACK_SIZE] of TStackType;
  Task2TCB : TStaticTask;
  Queue1Data : array[1..10] of byte;
  StaticQueue1 : TStaticQueue;
begin
  SystemCore.Initialize;
  SystemCore.SetCPUFrequency(SystemCore.getMaxCPUFrequency);
  SEGGER_RTT_WriteString(0,'System initialized');

  Task1Handle :=  xTaskCreateStatic(@Task1,
                                         'Task1',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         {%H-}@Task1Stack,
                                         {%H-}Task1TCB);
  Task2Handle :=  xTaskCreateStatic(@Task2,
                                         'Task2',
                                         configMINIMAL_STACK_SIZE,
                                         nil,
                                         tskIDLE_PRIORITY+1,
                                         {%H-}@Task2Stack,
                                         {%H-}Task2TCB);

  Queue1Handle := xQueueCreateStatic(length(Queue1Data),
                                     sizeOf(Queue1Data[1]),
                                     @Queue1Data,
                                     {%H-}StaticQueue1);
  if (Task1Handle <> nil) and (Task2Handle <> nil) and (Queue1Handle <> nil) then
  begin
    vTaskStartScheduler;
  end;

  SEGGER_RTT_WriteString(0,'Code after vTaskStartScheduler');
  while true do
  begin
  end;
end.

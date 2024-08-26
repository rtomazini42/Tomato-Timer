unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, System.Skia, FMX.Menus,
  FMX.Skia, FMX.ListBox;

type
  TTomatoTimer = class(TForm)
    Circle1: TCircle;
    Label1: TLabel;
    Layout1: TLayout;
    Reset: TRectangle;
    Play: TRectangle;
    Stop: TRectangle;
    Temporizador: TTimer;
    SkSvg1: TSkSvg;
    SkSvg2: TSkSvg;
    SkSvg3: TSkSvg;
    Rectangle1: TRectangle;
    ComboBoxSprintTime: TComboBox;
    Layout2: TLayout;
    Label2: TLabel;
    Layout3: TLayout;
    ComboBoxLongBreakTime: TComboBox;
    Label3: TLabel;
    Layout4: TLayout;
    ComboBoxBreakTime: TComboBox;
    Label4: TLabel;
    Layout5: TLayout;
    ComboBoxSprintsMult: TComboBox;
    Label5: TLabel;
    Pie1: TPie;
    Label6: TLabel;
    procedure TemporizadorTimer(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure PlayClick(Sender: TObject);
    procedure ResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SprintTime();
    procedure BreakTime();
    procedure LongBreakTime();
    procedure NextStep();
  public
    { Public declarations }
  end;

var
  TomatoTimer: TTomatoTimer;
  Segundos: Int32;
  SprintTime: Int32;
  BreakTime: Int32;
  LongBreakTime: Int32;
  timeLimit: int32;
  bloco:int32;
  blocoLimit:int32;
  started: boolean;


implementation

{$R *.fmx}





procedure TTomatoTimer.Circle1Click(Sender: TObject);
begin
    if started= false then
    begin
      Layout1.Visible := True;
      started := true;
      blocoLimit :=  StrToInt(ComboBoxSprintsMult.Items[ComboBoxSprintTime.ItemIndex]) * 6;
      BreakTime();
    end;

end;

procedure TTomatoTimer.FormCreate(Sender: TObject);
begin
  Temporizador.Enabled := False;
  Pie1.EndAngle := 0;
  bloco := 0;
  Segundos := 0;
  started:= False;
end;




procedure TTomatoTimer.PlayClick(Sender: TObject);
begin
  Temporizador.Enabled := True;
  started:= True;
end;

procedure TTomatoTimer.ResetClick(Sender: TObject);
begin
     Segundos := 0;
     Pie1.EndAngle := 0;
     Label1.Text := '00' + ':' +  '00';
end;


procedure TTomatoTimer.StopClick(Sender: TObject);
begin
  Stop.Fill.Kind := TBrushKind.Solid;
  Play.Fill.Kind := TBrushKind.Gradient;
  Temporizador.Enabled := False;

end;


procedure TTomatoTimer.TemporizadorTimer(Sender: TObject);
var
  SegundosTimer : Int32;
  MinutesTimer: Int32;
  SegundosString: String;
  MinutosString: String;
  CompltPrct: Float64;
begin
    Play.Fill.Kind := TBrushKind.Solid;
    Stop.Fill.Kind := TBrushKind.Gradient;
    Segundos := Segundos + 1;
    MinutesTimer :=  Segundos div 60;
    SegundosTimer := Segundos mod 60;
    CompltPrct := Double(Segundos)  / Double(timeLimit);
   // Label6.Text  := CompltPrct.ToString;
   Pie1.EndAngle := 360*CompltPrct;
    if SegundosTimer < 10 then
      begin
          SegundosString := '0' + SegundosTimer.ToString ;
      end
    else
        SegundosString := SegundosTimer.ToString;

    if MinutesTimer < 10 then
      begin
          MinutosString := '0' + MinutesTimer.ToString;
      end
    else
        MinutosString := MinutesTimer.ToString;

    if True then
      Label1.Text := MinutosString + ':' +  SegundosString;

    if timeLimit < Segundos then
      begin
        NextStep();
      end;

end;


procedure TTomatoTimer.BreakTime;
begin
  timeLimit := StrToInt(ComboBoxBreakTime.Items[ComboBoxBreakTime.ItemIndex]) * 60;
  label6.Text := 'Break';
  Temporizador.Enabled := True;
end;

procedure TTomatoTimer.LongBreakTime;
begin
  timeLimit := StrToInt(ComboBoxLongBreakTime.Items[ComboBoxLongBreakTime.ItemIndex]) * 60;
  label6.Text := 'Long break';
  Temporizador.Enabled := True;
end;



procedure TTomatoTimer.SprintTime;
begin
  timeLimit := StrToInt(ComboBoxSprintTime.Items[ComboBoxSprintTime.ItemIndex]) * 60;
  label6.Text := 'Sprint';
  Temporizador.Enabled := True;

end;

procedure TTomatoTimer.NextStep;
begin
     bloco := bloco + 1;
     segundos := 0;
     if bloco > blocoLimit then
      begin
        Temporizador.Enabled := False;
        ShowMessage('Hora do intervalo Longo!');
        bloco := 0;
        LongBreakTime()
      end
     else if bloco mod 2 = 0 then
       begin
        Temporizador.Enabled := False;
         ShowMessage('Hora do intervalo!');
         BreakTime();
       end
     else if bloco mod 2 = 1 then
     begin
        Temporizador.Enabled := False;
        ShowMessage('Hora da sprint!');
        SprintTime();
     end;


end;

end.

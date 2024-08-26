program ProjectTomatoPlayer;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {TomatoTimer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTomatoTimer, TomatoTimer);
  Application.Run;
end.

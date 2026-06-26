unit uLog;

interface

type
  /// <summary>Tipo do callback de saida de log (atribuivel pela UI).</summary>
  TLogProc = reference to procedure(const pTexto: string);

var
  LogProc: TLogProc;

/// <summary>Metodo para emitir uma linha de log no destino atual.</summary>
procedure Log(const pTexto: string);

implementation

procedure Log(const pTexto: string);
begin
  if Assigned(LogProc) then
    LogProc(pTexto)
  else
    Writeln(pTexto);
end;

end.

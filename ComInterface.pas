unit ComInterface;

// COM TInterfacedObject: variavel do tipo IRelatorio gerencia o tempo de vida.
// Ao sair de escopo, o destrutor e chamado automaticamente — sem Free, sem try/finally.

interface

uses
  System.SysUtils;

type
  IRelatorio = interface
    ['{2837B5F0-9908-4235-BFF5-3BD841313B4A}']
    /// <summary>Metodo para gerar o relatorio.</summary>
    procedure Gerar;
  end;

  TRelatorio = class(TInterfacedObject, IRelatorio)
  strict private
    FNome: string;
  public
    /// <summary>Metodo para criar instancia com nome do relatorio.</summary>
    constructor Create(const pNome: string);
    /// <summary>Destrutor — visivel no console para provar liberacao automatica.</summary>
    destructor Destroy; override;
    /// <summary>Metodo para gerar o relatorio.</summary>
    procedure Gerar;
  end;

implementation

uses
  uLog;

{ TRelatorio }

constructor TRelatorio.Create(const pNome: string);
begin
  inherited Create;
  FNome := pNome;
  Log(Format('  [TRelatorio.Create] "%s" criado', [FNome]));
end;

destructor TRelatorio.Destroy;
begin
  Log(Format('  [TRelatorio.Destroy] "%s" destruido AUTOMATICAMENTE', [FNome]));
  inherited;
end;

procedure TRelatorio.Gerar;
begin
  Log(Format('  [TRelatorio.Gerar] gerando relatorio "%s"', [FNome]));
end;

end.

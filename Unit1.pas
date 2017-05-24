unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZSqlUpdate, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, ExtCtrls, DBCtrls, Grids, DBGrids, IniFiles,
  StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    ZUpdateSQL2: TZUpdateSQL;
    ZConnection2: TZConnection;
    ZQuery2: TZQuery;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TxtTotalLocal: TLabel;
    txtTotalInserido: TLabel;
    ZConnection3: TZConnection;
    ZQuery3: TZQuery;
    ZUpdateSQL3: TZUpdateSQL;
    DataSource3: TDataSource;
    Button1: TButton;
    TxtTabela: TEdit;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
  private
    { Private declarations }
  public
   procedure Criar;
    { Public declarations }
  end;

var
  Form1: TForm1;
codigo:integer;
implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var
itotal, Tamanho:integer;
 i: Integer;
 AuxSTR, NomeCampo, TipoCampo: String;

begin
  ZQuery2.close;
  ZQuery2.sql.Clear;
  ZQuery2.sql.Add('select * from '+Trim(TxtTabela.Text));
  ZQuery2.open;
  
 ZQuery1.Close;
 ZQuery1.Open;

      txtTotalInserido.Caption:='';
      TxtTotalLocal.Caption:='';

itotal:=0;

    while not ZQuery1.eof do
    begin
     ZQuery2.Insert;

            for i := 0 to ZQuery1.Fields.Count - 1 do
            begin
            NomeCampo := UpperCase(ZQuery1.Fields.Fields[i].FieldName);
            TipoCampo := FieldTypeNames[ZQuery1.Fields.Fields[i].DataType];
            Tamanho:= ZQuery1.Fields.Fields[i].Size;
            
   if NomeCampo<>'xx' then
   begin

    //    txttipocampo.Caption:=NomeCampo;
   // ShowMessage(TipoCampo);

            if TipoCampo = 'String' then
             ZQuery2.FieldByName(NomeCampo).AsString:=ZQuery1.FieldByName(NomeCampo).AsString;

             if TipoCampo = 'ftMemo' then
             ZQuery2.FieldByName(NomeCampo).AsString:=ZQuery1.FieldByName(NomeCampo).AsString;

             if TipoCampo = 'Integer' then
             ZQuery2.FieldByName(NomeCampo).AsInteger:=ZQuery1.FieldByName(NomeCampo).AsInteger;

             if TipoCampo = 'Float' then
             ZQuery2.FieldByName(NomeCampo).AsFloat:=ZQuery1.FieldByName(NomeCampo).AsFloat;

             if TipoCampo = 'Numeric' then
             ZQuery2.FieldByName(NomeCampo).AsFloat:=ZQuery1.FieldByName(NomeCampo).AsFloat;
             if TipoCampo = 'Decimal' then
             ZQuery2.FieldByName(NomeCampo).AsFloat:=ZQuery1.FieldByName(NomeCampo).AsFloat;
             if TipoCampo = 'Currency' then
              ZQuery2.FieldByName(NomeCampo).AsCurrency:=ZQuery1.FieldByName(NomeCampo).AsCurrency;

             if TipoCampo = 'Date' then
             ZQuery2.FieldByName(NomeCampo).AsDateTime:=StrTodate(FormatDateTime('dd/mm/yyyy', ZQuery1.FieldByName(NomeCampo).AsDateTime));
             if TipoCampo = 'DateTime' then
            ZQuery2.FieldByName(NomeCampo).AsDateTime:= ZQuery1.FieldByName(NomeCampo).AsDateTime;
             if TipoCampo = 'Time' then
             ZQuery2.FieldByName(NomeCampo).AsDateTime:=StrTodate(FormatDateTime('dd/mm/yyyy', ZQuery1.FieldByName(NomeCampo).AsDateTime));
            end;

    end;
    itotal:=itotal+1;
    txtTotalInserido.Caption:='Inseridos: '+InttoStr(itotal) ;
    txtTotalInserido.Refresh;
      ZQuery2.Post;
      ZQuery1.Next;
  end;


end;

procedure TForm1.Criar;
var campo:string;
itotal, Tamanho:integer;
 i: Integer;
  NomeDoLog: string;
  Arquivo: TextFile;
 AuxSTR, NomeCampo, TipoCampo: String;
begin

 ZQuery1.Close;
 ZQuery1.Open;
      campo:='';

            if codigo=2 then
            begin
             NomeDoLog := ExtractFilePath(Application.ExeName)+'TabelasExportadas.SQL';
              AssignFile(Arquivo, NomeDoLog);
              if FileExists(NomeDoLog) then
                    Append(arquivo) { se existir, apenas adiciona linhas }
              else
                    ReWrite(arquivo); { cria um novo se não existir }
              try
                   WriteLn(arquivo, '');
                    WriteLn(arquivo, '');
                    WriteLn(arquivo, 'DROP TABLE '+trim(TxtTabela.Text)+';');
                   WriteLn(arquivo, '');
                    WriteLn(arquivo, 'CREATE TABLE '+trim(TxtTabela.Text)+' ( ');
              EXCEPT
              END;
           end;

            for i := 0 to ZQuery1.Fields.Count - 1 do
            begin
            NomeCampo := UpperCase(ZQuery1.Fields.Fields[i].FieldName);
            TipoCampo := FieldTypeNames[ZQuery1.Fields.Fields[i].DataType];
            Tamanho:= ZQuery1.Fields.Fields[i].Size;


            if TipoCampo = 'String' then
            BEGIN
             campo:=campo+NomeCampo+' '+'VARCHAR('+iNTtOsTR(Tamanho)+'), ';
             if codigo=2 then WriteLn(arquivo, NomeCampo+' '+'VARCHAR('+iNTtOsTR(Tamanho)+'), ');
            END;
            
             if TipoCampo = 'Integer' then
             BEGIN
                IF NomeCampo='ID'THEN campo:=campo+NomeCampo+'  '+'INTEGER , '
                ELSE campo:=campo+NomeCampo+'  '+'INTEGER, ';
               if codigo=2 then WriteLn(arquivo, NomeCampo+'  '+'INTEGER, ');
             END;

             if TipoCampo = 'Float' then
             BEGIN
             campo:=campo+NomeCampo+'  '+'NUMERC(15,2), ';
             if codigo=2 then WriteLn(arquivo, NomeCampo+'  '+'NUMERC(15,2), ');
              END;

             if (TipoCampo = 'Numeric') OR (TipoCampo = 'Decimal') OR (TipoCampo = 'Currency') then
             BEGIN
             campo:=campo+NomeCampo+'  '+'NUMERC(15,2), ';
             if codigo=2 then WriteLn(arquivo, NomeCampo+'  '+'NUMERC(15,2), ');
             END;


             if TipoCampo = 'Date' then
             BEGIN
             campo:=campo+NomeCampo+'  '+'DATE, ';
             if codigo=2 then WriteLn(arquivo, NomeCampo+'  '+'DATE, ');
             END;

             if TipoCampo = 'DateTime' then
             BEGIN
             campo:=campo+NomeCampo+'  '+'TIMESTAMP, ';
             if codigo=2 then WriteLn(arquivo, NomeCampo+'  '+'TIMESTAMP, ');
             END;

             if TipoCampo = 'Time' then
             BEGIN
             campo:=campo+NomeCampo+'  '+'TIME, ';
             if codigo=2 then WriteLn(arquivo, NomeCampo+'  '+'TIME, ');
             END;
           end;

            if codigo = 1 then
            BEGIN
            ZQuery3.close;
            ZQuery3.sql.Clear;
            ZQuery3.sql.Add('DROP  TABLE '+trim(TxtTabela.Text)+'; ');
            ZQuery3.sql.Add('CREATE  TABLE '+trim(TxtTabela.Text)+'( '+campo+' OUTRAS_INFORMACOES VARCHAR(50) ); ');
            ZQuery3.ExecSQL;
            codigo:=0;
            END;

            if codigo=2  then
            BEGIN
             TRY //continua
              WriteLn(arquivo, ' OUTRAS_INFORMACOES VARCHAR(50) ); ');
              WriteLn(arquivo, '');
             FINALLY
             CloseFile(arquivo);
            END;
             codigo:=0;
            END;

  ShowMessage('ACABOU !');
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  ZQuery1.close;
  ZQuery1.sql.Clear;
  ZQuery1.sql.Add('select * from '+Trim(TxtTabela.Text));
  ZQuery1.open;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  ZQuery2.close;
  ZQuery2.sql.Clear;
  ZQuery2.sql.Add('select * from '+Trim(TxtTabela.Text));
  ZQuery2.open;

  TxtTotalLocal.Caption:='Total no banco local: '+InttoStr(ZQuery2.RecordCount) ;
  TxtTotalLocal.Refresh;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
ZQuery2.close;
  ZQuery2.sql.Clear;
  ZQuery2.sql.Add('delete from '+Trim(TxtTabela.Text));
  ZQuery2.ExecSQL;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
CODIGO:=1;
Criar;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
CODIGO:=2;
Criar;
end;

end.

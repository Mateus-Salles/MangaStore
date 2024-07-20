unit U_confirmarCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmConfCompra = class(TForm)
    lbVT: TLabel;
    lbTotal: TLabel;
    btnFinCompra: TPanel;
    btnCancel: TPanel;
    Panel1: TPanel;
    img1: TImage;
    pnlNome: TPanel;
    Label1: TLabel;
    lbAut: TLabel;
    lbPre: TLabel;
    lbQuant: TLabel;
    txtQuant: TEdit;
    Panel2: TPanel;
    procedure FormShow(Sender: TObject);
    procedure txtQuantChange(Sender: TObject);
    procedure txtQuantExit(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnFinCompraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfCompra: TfrmConfCompra;
  estoq: integer;

implementation

{$R *.dfm}

uses U_compra, U_func, U_home, U_DM;

procedure TfrmConfCompra.btnCancelClick(Sender: TObject);
begin
  frmCompra.Show;
  frmConfCompra.Close;
end;

procedure TfrmConfCompra.btnFinCompraClick(Sender: TObject);
begin
  with DM.sqlPedido do
  begin
    SQL.Text := 'INSERT INTO pedido(cod_manga, cod_cliente, data_pedido, quant)';
    SQL.Add('VALUES (:cod_manga, :cod_cliente, :data, :quant)');
    ParamByName('cod_manga').AsInteger := StrToInt(frmCompra.id);
    ParamByName('cod_cliente').AsInteger := frmHome.idUsua;
    ParamByName('data').AsDate := Now;
    ParamByName('quant').AsInteger := StrToInt(txtQuant.Text);
    ExecSQL;

    SQL.Text := 'SELECT * FROM pedido';
    Open;
  end;

  with DM.sqlManga do
  begin
    SQL.Text := 'UPDATE mangas SET estoque=:est WHERE id_manga=:id';
    ParamByName('est').AsInteger := estoq - StrToInt(txtQuant.Text);
    ParamByName('id').AsInteger := StrToInt(frmCompra.id);
    ExecSQL;

    SQL.Text := 'SELECT * FROM mangas';
    Open;
  end;

  frmConfCompra.Close;
end;

procedure TfrmConfCompra.FormShow(Sender: TObject);
begin
  with frmCompra do
  begin
    label1.Caption := nomeImg;
    lbAut.Caption := 'Por '+autor;
    lbPre.Caption := Format('R$%.2f', [StrToFloat(preco)]);
    img1.Picture.LoadFromFile(GetDiretorio() + '\imagens\manga\' + id + nomi + '.jpg');
  end;

  with DM.sqlManga do
  begin
    SQL.Text := 'SELECT * FROM mangas WHERE id_manga = :id';
    ParamByName('id').AsInteger := StrToInt(frmCompra.id);
    Open;

    estoq := FieldByName('estoque').AsInteger;

    lbTotal.Caption := Format('R$%.2f', [FieldByName('preco').AsFloat * StrToFloat(txtQuant.Text)]);
  end;
end;

procedure TfrmConfCompra.txtQuantChange(Sender: TObject);
begin
  if StrToInt(txtQuant.Text) = 0 then
  begin
    txtQuant.Text := '1';
    txtQuant.SelStart := 1;
  end;

  with DM.sqlManga do
  begin
    if FieldByName('estoque').AsInteger < StrToInt(txtQuant.Text) then
    begin
      txtQuant.Text := FieldByName('estoque').AsString;
    end;

    if not (txtQuant.Text = '') then
    begin
      lbTotal.Caption := Format('R$%.2f', [FieldByName('preco').AsFloat * StrToFloat(txtQuant.Text)]);
    end
    else
    begin
      lbTotal.Caption := 'R$0,00';
    end;
  end;
end;

procedure TfrmConfCompra.txtQuantExit(Sender: TObject);
var
  test: integer;
begin
  test := StrToInt(txtQuant.Text);

  if IntToStr(test) = '' then
  begin
    txtQuant.Text := '1';
  end;
end;

end.

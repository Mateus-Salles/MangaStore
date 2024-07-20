unit U_clienteEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  TfrmEditCliente = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    btnEditar: TPanel;
    btnVoltar: TPanel;
    Panel2: TPanel;
    opendialo: TOpenDialog;
    txtId: TEdit;
    txtNome: TEdit;
    txtEndereco: TEdit;
    txtEmail: TEdit;
    txtSenha: TEdit;
    txtTel: TMaskEdit;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditCliente: TfrmEditCliente;
  hash: string;

implementation

{$R *.dfm}

uses U_home, U_func, U_DM, U_log;

procedure TfrmEditCliente.btnEditarClick(Sender: TObject);
begin
  with DM.sqlCliente do
  begin
    SQL.Text := 'UPDATE cliente SET nome=:nome, endereco=:end, telefone=:tel, email=:email, senha=:senha WHERE id_cliente=:id';
    ParamByName('id').AsInteger := frmHome.idUsua;
    ParamByName('nome').AsString := txtNome.Text;
    ParamByName('tel').AsString := txtTel.Text;
    ParamByName('email').AsString := txtEmail.Text;
    ParamByName('end').AsString := txtEndereco.Text;
    ParamByName('senha').AsString := txtSenha.Text;
    ExecSQL;
  end;

  with frmHome do
  begin
    logado := false;
  end;
  frmLogin.Show;
  frmEditCliente.Close;
end;

procedure TfrmEditCliente.btnVoltarClick(Sender: TObject);
begin
  frmEditCliente.Close;
end;

procedure TfrmEditCliente.FormShow(Sender: TObject);
begin
  DM.sqlCliente.SQL.Text := 'SELECT * FROM cliente WHERE id_cliente = :id';
  DM.sqlCliente.ParamByName('id').AsInteger := frmHome.idUsua;
  DM.sqlCliente.Open;

  Image1.Picture.LoadFromFile(frmHome.diret);

  txtId.Text := DM.sqlCliente.FieldByName('id_cliente').AsString;
  txtNome.Text := DM.sqlCliente.FieldByName('nome').AsString;
  txtEndereco.Text := DM.sqlCliente.FieldByName('endereco').AsString;
  txtEmail.Text := DM.sqlCliente.FieldByName('email').AsString;
  txtSenha.Text := DM.sqlCliente.FieldByName('senha').AsString;
  txtTel.Text := DM.sqlCliente.FieldByName('telefone').AsString;
end;

end.

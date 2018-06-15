// requires  Windows 7, Windows Server 2003 Service Pack 1, Windows Server 2003 Service Pack 2, Windows Server 2008, Windows Vista, Windows XP Service Pack 2, Windows XP Service Pack 3
// WARNING: express setup (downloads and installs the components depending on your OS) if you want to deploy it on cd or network download the full bootsrapper on website below
// http://www.microsoft.com/en-us/download/details.aspx?id=35

[CustomMessages]
directx_title=Latest Direct X

directx_size=300 KB - 90+ MB


[Code]
const
	directx_url = 'http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe';
    //'http://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe';


procedure DecodeVersion( verstr: String; var verint: array of Integer );
var
  i,p: Integer; s: string;
begin
  // initialize array
  verint := [0,0,0,0];
  i := 0;
  while ( (Length(verstr) > 0) and (i < 4) ) do
  begin
  	p := pos('.', verstr);
  	if p > 0 then
  	begin
      if p = 1 then s:= '0' else s:= Copy( verstr, 1, p - 1 );
  	  verint[i] := StrToInt(s);
  	  i := i + 1;
  	  verstr := Copy( verstr, p+1, Length(verstr));
  	end
  	else
  	begin
  	  verint[i] := StrToInt( verstr );
  	  verstr := '';
  	end;
  end;

end;

// DirectX version is stored in registry as 4.majorversion.minorversion
// DirectX 8.0 is 4.8.0
// DirectX 8.1 is 4.8.1
// DirectX 9.0 is 4.9.0

function GetDirectXVersion(): String;
var
  sVersion:  String;
begin
  sVersion := '';

  RegQueryStringValue( HKLM, 'SOFTWARE\Microsoft\DirectX', 'Version', sVersion );

  Result := sVersion;
end;

function checkDirectX(): boolean;
begin
  // in this case program needs at least directx 9.0
  if CompareVersion( GetDirectXVersion(), '4.9.0') < 0 then
  begin
       Result := true;
  end
  else
  begin
    Result := false;
   end;

end;

procedure directx();
begin
  if CompareVersion( GetDirectXVersion(), '4.9.0') < 0 then
  begin
  AddProduct('directx_Jun2010_redist.exe',
			'/t:' + ExpandConstant('{tmp}\DirectX') + ' /q /c',
			CustomMessage('directx_title'),
			CustomMessage('directx_size'),
			directx_url,
			false, false);
  end
end;
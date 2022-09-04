Stop-Service -Name "Duplo.AuthService"
Start-Sleep -Seconds 3
gci Cert:\LocalMachine\My -Recurse | where{$_.Thumbprint -eq '3a149f350d62c25c3bb0a717917d35f0b383af16'} | Remove-Item -Force -Verbose
Start-Sleep -Seconds 3
Invoke-WebRequest -Uri 'https://duplo-release-binaries.s3.us-west-2.amazonaws.com/duplo_2022-2023.pfx' -OutFile 'duplo_2022-2023.pfx'
Start-Sleep -Seconds 3
Import-PfxCertificate -FilePath ./duplo_2022-2023.pfx -CertStoreLocation Cert:\LocalMachine\My -Exportable -Password (ConvertTo-SecureString -String 'DuploAA007' -AsPlainText -Force)
Start-Sleep -Seconds 3
certutil -repairstore my "55143e36bbacd76c8cec2c8b27e00844bfa77dac"
Start-Sleep -Seconds 3
netsh http delete sslcert ipport=0.0.0.0:60020
Start-Sleep -Seconds 3
netsh http add sslcert ipport=0.0.0.0:60020 certhash=55143e36bbacd76c8cec2c8b27e00844bfa77dac appid='{00112233-4455-6677-8899-AABBCCDDEEFF}'
Start-Sleep -Seconds 50
Start-Service -Name "Duplo.AuthService"
Remove-Item ./duplo_2022-2023.pfx